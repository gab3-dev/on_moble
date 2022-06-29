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
        title: const Text("On Mobile"),
        bottom: TabBar(
          labelColor: Theme.of(context).primaryColorLight,
          indicatorWeight: 4,
          labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).secondaryHeaderColor),
          controller: _tabController,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: const [Text("Conversas"), Text("Contatos")], //Widget
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: PopupMenuButton<String>(
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
