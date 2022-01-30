import 'package:flutter/material.dart';
import 'package:gearup/pages/navpages/main_page.dart';
import 'package:gearup/pages/sign_in/AppSignIn.dart';
import 'package:gearup/pages/sign_in/AppSignUp.dart';
import 'package:gearup/pages/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GearUp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: '/',
      routes: {
        '/wel': (context) => WelcomePage(),
        '/': (context) => AppSignIn(),
        '/signUp': (context) => AppSingUp(),
      },
      // home:MainPage()
    );
  }
}
