import 'package:ceria/login/screen/welcome_screen.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static build(BuildContext context) {
    return {
      WelcomeScreen.routeName: (context) => WelcomeScreen(),
    };
  }
}
