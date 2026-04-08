import 'package:flutter/material.dart';
import 'package:new_assignment/home.dart';
import 'package:new_assignment/login/login_screen.dart';
import 'package:new_assignment/onboard/onboard_screen.dart';
import 'package:new_assignment/signup/sign_up1screen.dart';
import 'package:new_assignment/splash_screen.dart';

void main() {
  runApp(SoftwareLab_Assign());
}

class SoftwareLab_Assign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFD56B55)),
      title: 'Software Lab Assignment',

      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboard': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen1(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
