import 'package:flutter/material.dart';
import 'model/User.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

// class _MessagesState extends State<Messages> {
//   @override
//   Widget build(BuildContext context) {}
// }

class _MessagesState extends State<Messages> {
  List<String> listaMensagens = [
    "Olá amigo",
    "Bom dia!",
    "No momento não estou disponível",
    "Falo somente via On"
  ];

  final TextEditingController _controllerMensagem = TextEditingController();

  _enviarMensagem() {}

  _enviarFoto() {}

  @override
  Widget build(BuildContext context) {
    var caixaMensagem = Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextField(
                controller: _controllerMensagem,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                  hintText: "Digite uma mensagem...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: _enviarFoto,
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: const Color(0xff6E0C00),
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            mini: true,
            onPressed: _enviarMensagem,
          )
        ],
      ),
    );

    var listView = Expanded(
      child: ListView.builder(
        itemCount: listaMensagens.length,
        itemBuilder: (context, indice) {
          double larguraContainer = MediaQuery.of(context).size.width * 0.8;

          //Define cores e alinhamentos
          Alignment alinhamento = Alignment.centerRight;
          Color cor = const Color(0xffd2ffa5);
          if (indice % 2 == 0) {
            //par
            alinhamento = Alignment.centerLeft;
            cor = Colors.white;
          }

          return Align(
            alignment: alinhamento,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                width: larguraContainer,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: cor,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Text(
                  listaMensagens[indice],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Provisorio"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.jpg"), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                //listaMensagens,
                caixaMensagem,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
