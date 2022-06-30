import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:on_mobile/signin_screen.dart';
import 'package:on_mobile/routeconfig.dart';
import 'firebase_options.dart';

final ThemeData theme = ThemeData();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Login(),
    theme: ThemeData(
      indicatorColor: const Color(0xff6E0C00),
      primarySwatch: Colors.amber,
      tabBarTheme: const TabBarTheme(
        labelColor: Color(0xff6E0C00),
        unselectedLabelColor: Colors.grey,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff6E0C00), brightness: Brightness.dark),
      secondaryHeaderColor: const Color(0xff6E0C00),
      primaryColorDark: const Color(0xff6E0C00),
      primaryColorLight: Colors.white,
    ),
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
