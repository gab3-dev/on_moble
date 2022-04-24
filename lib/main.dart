import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:on_mobile/signin_screen.dart';
import 'package:on_mobile/routeconfig.dart';

final ThemeData theme = ThemeData();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Login(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xff6E0C00),
        secondary: const Color(0xfff9a3c1),
      ),
    ),
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
