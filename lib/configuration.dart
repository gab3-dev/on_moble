import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class Configuration extends StatefulWidget {
  const Configuration({Key? key}) : super(key: key);
  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  final TextEditingController _controllerName = TextEditingController();
  late File _image;
  late String _idUserLogged;
  late String _urlImageRetrieved;

  bool _uploadingImage = false;

  _retrieveImage(String originImage) async {
    late File imageSelected;
    switch (originImage) {
      case "camera":
        imageSelected = (await ImagePicker.platform.getImage(
          source: ImageSource.camera,
          maxWidth: null,
          maxHeight: null,
          imageQuality: null,
          preferredCameraDevice: CameraDevice.rear,
        )) as File;
        break;
      case "galeria":
        imageSelected = (await ImagePicker.platform.getImage(
          source: ImageSource.gallery,
          maxWidth: null,
          maxHeight: null,
          imageQuality: null,
          preferredCameraDevice: CameraDevice.rear,
        )) as File;
        break;
    }
    setState(() {
      _image = imageSelected;
      if (_image != null) {
        _uploadingImage = true;
        _uploadImage();
      }
    });
  }

  Future _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference dirRoot = storage.ref();
    Reference arquivo = dirRoot.child("perfil").child(_idUserLogged + ".jpg");

    UploadTask task = arquivo.putFile(_image);

    _updateUrlImageFirestore(String url) async {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentReference ref = db.collection("users").doc(_idUserLogged);
      await ref.update({'urlImage': url});
    }

    Future _retrieveUrlImage(TaskSnapshot taskSnapshot) async {
      String url = await taskSnapshot.ref.getDownloadURL();
      _updateUrlImageFirestore(url);
      setState(() {
        _urlImageRetrieved = url;
      });
    }

    task.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      if (taskSnapshot.state == TaskState.running) {
        setState(() {
          _uploadingImage = true;
        });
      } else if (taskSnapshot.state == TaskState.success) {
        _retrieveUrlImage(taskSnapshot);
        setState(() {
          _uploadingImage = false;
        });
      }
    });

    _retrieveDataUser() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User userLogged = auth.currentUser!;
      _idUserLogged = userLogged.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configuracoes")),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
              child: Column(
            children: [
              _uploadingImage ? const CircularProgressIndicator() : Container(),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                backgroundImage: _urlImageRetrieved != null
                    ? NetworkImage(_urlImageRetrieved)
                    : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: const Text("Galeria"),
                    onPressed: () {
                      _retrieveImage("galeria");
                    },
                  ),
                  TextButton(
                    child: const Text("Camera"),
                    onPressed: () {
                      _retrieveImage("camera");
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                    controller: _controllerName,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: 'Nome',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32)))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 10),
                child: ElevatedButton(
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent[700],
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32))),
                    onPressed: () {}),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
