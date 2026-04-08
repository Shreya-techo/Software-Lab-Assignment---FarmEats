import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Icon(Icons.arrow_back_sharp),
          ),
          Center(
            child: Text("Login Successful", style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
