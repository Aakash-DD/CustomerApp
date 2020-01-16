/*
import 'package:flutter/material.dart';

import 'chat.dart';
import 'list_profile.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "WhatsApp h bc",
      theme: new ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor : new Color(0xff25D366),
      ),//ThemeData
      debugShowCheckedModeBanner: false,
      home: new listProfile(),
    );
  }
}
*/

import 'package:car1/regestration/ui/screens/forgot_password.dart';
import 'package:car1/regestration/ui/screens/home.dart';
import 'package:car1/regestration/ui/screens/sign_in.dart';
import 'package:car1/regestration/ui/screens/sign_up.dart';
import 'package:car1/regestration/ui/theme.dart';
import 'package:car1/regestration/util/state_widget.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp() {
    //Navigation.initPaths();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp Title',
      theme: buildTheme(),
      //onGenerateRoute: Navigation.router.generator,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
      },
    );

  }
}

void main() {
  StateWidget stateWidget = new StateWidget(
    child: new MyApp(),
  );
  runApp(stateWidget);
}
