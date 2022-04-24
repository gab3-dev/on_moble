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

  List<String> menuItem = {"Configuracoes", "Deslogar"} as List<String>;

  @override
  void initState() {
    super.initState();
//    _recuperarDadosUsuario();
    _tabController = TabController(length: 2, vsync: this);
  }

  _chooseMenuItem(String itemChoosed) {
    switch (itemChoosed) {
      case "Configuracoes":
        Navigator.pushNamed(context, '/configuration');
        break;
      case "Deslogar":
        _logOutUser();
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
        title: const Text("On Mobile"),
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const <Widget>[AbaConversas(), AbaContatos()], //Widget
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _chooseMenuItem,
            itemBuilder: (context) {
              return menuItem.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
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
