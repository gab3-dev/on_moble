import 'package:flutter/material.dart';
import 'package:on_mobile/model/chat.dart';

class AbaConversas extends StatefulWidget {
  const AbaConversas({Key? key}) : super(key: key);

  @override
  State<AbaConversas> createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listChat.length,
        itemBuilder: (context, index) {
          Chat chat = listChat[index];

          return ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            leading: CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(chat.urlphoto),
            ),
            title: Text(
              chat.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(chat.message,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          );
        });
  }
}
