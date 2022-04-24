import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:on_mobile/model/contact.dart';

class ShowContacts extends StatefulWidget {
  const ShowContacts({Key? key}) : super(key: key);

  @override
  _ShowContactsState createState() => _ShowContactsState();
}

class _ShowContactsState extends State<ShowContacts> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  String search = "";

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  _getContacts() async {
    Iterable<Contact> _contacts = await ContactsService.getContacts();
    setState(() {
      contacts = _contacts.toList();
      contactsFiltered = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchContacts(contactsFiltered),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contactsFiltered.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contactsFiltered[index].displayName.toString()),
            subtitle: Text(contactsFiltered[index].phones.toString()),
          );
        },
      ),
    );
  }
}

SearchContacts(List<Contact> contactsFiltered) {}

class AbaContatos extends StatefulWidget {
  const AbaContatos({Key? key}) : super(key: key);

  @override
  State<AbaContatos> createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Tab(text: "Contatos"),
    );
  }
}
