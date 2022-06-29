import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_mobile/model/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AbaContatos extends StatefulWidget {
  const AbaContatos({Key? key}) : super(key: key);

  @override
  State<AbaContatos> createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  Future<List<Contact>> _getContacts() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db.collection("users").get();

    List<Contact> listContact = [];

    for (DocumentSnapshot doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      if (data["id"] != FirebaseAuth.instance.currentUser?.uid) {
        listContact.add(Contact(
          name: data["name"],
          urlImage: data["urlImage"],
          email: data["email"],
        ));
      }
    }
    return listContact;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contact>>(
      future: _getContacts(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  Text("Carregando contatos...")
                ],
              ),
            );
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(
                child: Text("Erro ao carregar contatos"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                List<Contact>? listItens = snapshot.data;

                Contact contact = listItens![index];

                return ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    backgroundImage: NetworkImage(contact.urlImage),
                  ),
                  title: Text(contact.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: Text(
                    contact.email,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/chat",
                        arguments: snapshot.data![index]);
                  },
                );
              },
            );
        }
      },
    );
  }
}
