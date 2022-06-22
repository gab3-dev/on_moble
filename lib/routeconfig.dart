import 'package:flutter/material.dart';
import 'package:on_mobile/configuration.dart';
import 'package:on_mobile/mensagens.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';
import 'home.dart';
import 'configuration.dart';
import 'mensagens.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUp());
      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/configuration':
        return MaterialPageRoute(builder: (_) => const Configuration());
      case '/messages':
        return MaterialPageRoute(builder: (_) => const Messages());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text('No route defined for ${settings.name}'),
                  ),
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
