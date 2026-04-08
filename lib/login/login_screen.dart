import 'package:flutter/material.dart';
import 'package:new_assignment/login/loginforgotpass.dart';
import 'package:new_assignment/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isSubmitted = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? validateEmail(String? value) {
    if (!isSubmitted) return null;

    if (value == null || value.isEmpty) {
      return "Enter email";
    } else if (!value.contains("@")) {
      return "Invalid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (!isSubmitted) return null;

    if (value == null || value.isEmpty) {
      return "Enter password";
    } else if (value.length < 6) {
      return "Password must be minimum 6 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3ECEA),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "FarmerEats",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),

                  const SizedBox(height: 50),

                  const Text(
                    "Welcome back!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Text(
                        "New here? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          "Create account",
                          style: TextStyle(color: Color(0xFFD56B55)),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 75),
                  TextFormField(
                    validator: validateEmail,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      prefixIcon: const Icon(Icons.alternate_email),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    validator: validatePassword,
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),

                      // ✅ Replace suffixText with this
                      suffixIcon: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "Forgot?",
                            style: TextStyle(
                              color: Color(0xFFD56B55),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isSubmitted = true;
                      });

                      if (_formKey.currentState!.validate()) {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        print("EMAIL: $email");
                        print("PASSWORD: $password");

                        String? token = await AuthService.login(
                          email,
                          password,
                        );

                        if (token != null) {
                          print("Login success: $token");

                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Login failed.Using demo access"),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD56B55),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      "or login with",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      socialButton("images/google.png"),
                      socialButton("images/apple.png"),
                      socialButton("images/facebook1.png"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Social Button Widget
  Widget socialButton(String imagePath) {
    return Container(
      height: 45,
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextButton(
        onPressed: () {},
        child: Center(
          child: Image.asset(
            imagePath,
            height: 50,
            width: 40,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
