import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/onboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FittedBox(
          child: Text(
            "Welcome to Software Lab",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
