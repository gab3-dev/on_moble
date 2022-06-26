import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'model/user.dart' as us;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String value = "";
  // Create a text controller and use it to retrieve the current value
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();

  String _error = "";
  String _success = "";

  _authInputs(String name, String email, String password, String phone) {
    String name = _controllerName.text;
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;
    String phone = _controllerPhone.text;
    if (name.isEmpty) {
      setState(() {
        _error = "Preencha o campo nome";
        _success = "";
      });
    } else if (email.isEmpty || email.contains("@") == false) {
      setState(() {
        _error = "Preencha o campo email";
        _success = "";
      });
    } else if (password.isEmpty ||
        password.length < 8 ||
        password.contains(" ") == true) {
      setState(() {
        _error =
            "Preencha o campo senha, ele não pode conter espaços e ter menos de 8 caracteres";
        _success = "";
      });
    } else if (phone.isEmpty ||
        phone.length < 11 ||
        phone.contains(" ") == true) {
      setState(() {
        _error = "Preencha o campo numero";
        _success = "";
      });
    } else {
      us.User user = us.User();
      user.name = name;
      user.email = email;
      user.password = password;
      user.phone = phone;

      _signUpState(user);

      setState(() {
        _error = "";
      });
    }
  }

  _signUpState(user) async {
    String name = _controllerName.text;
    String email = _controllerEmail.text;
    String phone = _controllerPhone.text;
    Map<String, dynamic> toMap() {
      final Map<String, dynamic> map = <String, dynamic>{
        'name': name,
        'email': email,
        'phone': phone,
      };
      return map;
    }

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    )
        .then((user) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.user?.uid)
          .set(toMap());
      setState(() {
        _error = "";
        _success = "Usuário criado com sucesso";
        Navigator.pushNamed(context, '/home');
      });
    }).catchError((error) {
      setState(() {
        _error = "Erro ao criar usuário";
        _success = "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff6E0C00)),
        padding: const EdgeInsets.all(16),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('./images/logo.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
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
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: 'E-mail',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerPassword,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: 'Senha',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  )),
              TextField(
                controller: _controllerPhone,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: 'Numero de celular',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32))),
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
                    onPressed: () {
                      _authInputs(_controllerName.text, _controllerEmail.text,
                          _controllerPassword.text, _controllerPhone.text);
                    }),
              ),
              Center(
                child: GestureDetector(
                  child: const Text(
                    "Ja tem conta ? Entre aqui!",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                  },
                ),
              ),
              Center(
                  child: Text(
                _error,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              )),
              Center(
                child: Text(
                  _success,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
