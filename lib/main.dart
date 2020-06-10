import 'package:ceria/ceria_core.dart';
import 'package:ceria/routes.dart';
import 'package:flutter/material.dart';

import 'login/screen/welcome_screen.dart';

void main() {
  CeriaCore.init(CeriaCore());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.build(context),
      home: Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}
