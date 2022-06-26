import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_mobile/model/user.dart' as us;

String enter = "Entrar";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String _error = "";

  _authInputs(String email, String password) {
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    if (email.isEmpty || email.contains("@") == false) {
      setState(() {
        _error = "Preencha o campo email";
      });
    } else if (password.isEmpty || password.length < 8) {
      setState(() {
        _error =
            "Preencha o campo senha, ele não pode conter menos de 8 caracteres";
      });
    } else {
      us.User user = us.User();
      user.email = email;
      user.password = password;
      _loginState(user);
    }
  }

  _loginState(user) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user.email, password: user.password)
        .then((user) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    }).catchError((e) {
      setState(() {
        _error = e.message;
      });
    });
  }

  Future _verifyLoginState() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User userFirebase = auth.currentUser!;
    // ignore: unnecessary_null_comparison
    if (userFirebase != null) {
      Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        _error = "Usuário não está logado";
      });
    }
  }

  @override
  void initState() {
    _verifyLoginState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  width: 250,
                  height: 230,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('./images/usuario.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
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
                            borderRadius: BorderRadius.circular(32)))),
              ),
              TextField(
                  controller: _controllerPassword,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: 'Senha',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32)))),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 10),
                child: ElevatedButton(
                    child: const Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent[700],
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32))),
                    onPressed: () {
                      _authInputs(
                          _controllerEmail.text, _controllerPassword.text);
                    }),
              ),
              Center(
                child: GestureDetector(
                  child: const Text(
                    "Nao tem conta ? Cadastre-se!",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/signup');
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
            ],
          ),
        )),
      ),
    );
  }
}
