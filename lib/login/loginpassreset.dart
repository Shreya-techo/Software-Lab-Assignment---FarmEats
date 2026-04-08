import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String mobile;
  final String otp;
  const ResetPasswordScreen({
    super.key,
    required this.mobile,
    required this.otp,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isSubmitted = false;

  String? validatePassword(String? value) {
    if (!isSubmitted) return null;
    if (value == null || value.isEmpty) return "Enter password";
    if (value.length < 6) return "Password must be minimum 6 characters";
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (!isSubmitted) return null;
    if (value == null || value.isEmpty) return "Confirm your password";
    if (value != passwordController.text) return "Passwords do not match";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3ECEA),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("FarmerEats"),

                const SizedBox(height: 80),

                const Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    const Text(
                      "Remember your password? ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Color(0xFFD56B55)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                TextFormField(
                  controller: passwordController,
                  validator: validatePassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "New Password",
                    prefixIcon: const Icon(Icons.lock_outline),
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
                  controller: confirmpasswordController,
                  validator: validateConfirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm New Password",
                    prefixIcon: const Icon(Icons.lock_outlined),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD56B55),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isSubmitted = true;
                      });

                      if (_formKey.currentState!.validate()) {
                        print("Form is valid");
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
