import 'package:flutter/material.dart';
import 'package:new_assignment/login/loginverifyotp.dart';
import 'package:new_assignment/services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final phoneController = TextEditingController();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("FarmerEats"),

              const SizedBox(height: 60),

              const Text(
                "Forgot Password?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

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

              const SizedBox(height: 60),

              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone),
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

                  onPressed: () async {
                    String phone = phoneController.text;

                    if (phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter phone number")),
                      );
                      return;
                    }

                    bool success = await AuthService.sendOtp(phone);

                    if (success) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VerifyOtpScreen(phone: phone),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to send OTP")),
                      );
                    }
                  },

                  child: const Text(
                    "Send Code",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
