import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_mobile/model/contact.dart';
import 'package:on_mobile/model/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AbaContatos extends StatefulWidget {
  const AbaContatos({Key? key}) : super(key: key);

  @override
  State<AbaContatos> createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  List<Chat> listChat = [
    Chat("Espadachim", "Me perdi",
        "https://firebasestorage.googleapis.com/v0/b/on-mobile-tcc.appspot.com/o/perfil%2Fzoro.jpg?alt=media&token=2e0c6cab-3ec3-4466-a92a-d23ee2844411"),
    Chat("Cozinheiro", "Sai de perto da comida",
        "https://firebasestorage.googleapis.com/v0/b/on-mobile-tcc.appspot.com/o/perfil%2Fsanji.jpg?alt=media&token=36f62f70-a79a-4f49-89cf-7acc22c80654"),
    Chat("Tiozao", "Ta monstro em, so voa mlk",
        "https://firebasestorage.googleapis.com/v0/b/on-mobile-tcc.appspot.com/o/perfil%2Fshanks.jpg?alt=media&token=1d719d61-3bc8-4bb6-9509-992a8c28e24b"),
    Chat("Navegadora", "Quero replay",
        "https://firebasestorage.googleapis.com/v0/b/on-mobile-tcc.appspot.com/o/perfil%2Fnami.jpg?alt=media&token=03a53deb-798d-4580-8750-9c15fc12cc2b"),
    Chat("GOD", "APRENDEU COM O MONSTRO",
        "https://firebasestorage.googleapis.com/v0/b/on-mobile-tcc.appspot.com/o/perfil%2Fusopp.jpg?alt=media&token=f36c4518-3486-430f-8d83-14417c0c2a31")
  ];

  Future<List<Contact>> _getContacts() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db.collection("users").get();

    List<Contact> listContact = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      var data = item.data() as Map<String, dynamic>;
      Contact contact = Contact();
      if (data["id"] != FirebaseAuth.instance.currentUser?.uid) {
        contact.id = item.id;
        contact.name = data["name"] as String;
        contact.urlImage = data["urlImage"];
        contact.phone = data["phone"];
        contact.email = data["email"];
      }

      listContact.add(contact);
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
              return const Center(
                child: Text("Erro ao carregar contatos"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (_, index) {
                List<Contact>? listItens = snapshot.data;

                Contact contact = listItens![index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contact.urlImage),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.email),
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
