import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_mobile/screen/AbaContatos.dart';
import 'package:on_mobile/screen/AbaConversas.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> menuItem = ['Configuração', 'Deslogar'];

  @override
  void initState() {
    super.initState();
    //_recuperarDadosUsuario();
    _tabController = TabController(length: 2, vsync: this);
  }

  _chooseMenuItem(String itemChoosed) {
    switch (itemChoosed) {
      case "Configuração":
        Navigator.pushNamed(context, '/configuration');
        break;
      case "Deslogar":
        _logOutUser();
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        break;
    }
  }

  _logOutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "On Mobile",
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
        bottom: TabBar(
          labelPadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontSize: 18),
          controller: _tabController,
          tabs: const [Text("Conversas"), Text("Contatos")], //Widget
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: _chooseMenuItem,
              itemBuilder: (BuildContext context) {
                return menuItem.map((String item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          AbaConversas(),
          AbaContatos(),
        ],
      ),
    );
  }
}
