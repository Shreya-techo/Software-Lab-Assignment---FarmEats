import 'package:flutter/material.dart';
import 'package:new_assignment/signup/signup2screen.dart';
import 'package:new_assignment/signup/signup_model.dart';

class SignUpScreen1 extends StatefulWidget {
  const SignUpScreen1({super.key});

  @override
  State<SignUpScreen1> createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  final _formKey = GlobalKey<FormState>();
  bool isSubmitted = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  // Validators
  String? validateName(String? value) {
    if (!isSubmitted) return null;
    if (value == null || value.isEmpty) return "Name is required";
    if (value.length < 3) return "Enter valid name";
    return null;
  }

  String? validateEmail(String? value) {
    if (!isSubmitted) return null;
    if (value == null || value.isEmpty) return "Enter email";
    if (!value.contains("@")) return "Invalid email";
    return null;
  }

  String? validatePhone(String? value) {
    if (!isSubmitted) return null;
    if (value == null || value.isEmpty) return "Phone is required";
    if (value.length != 10) return "Enter valid phone number";
    return null;
  }

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
                  const Text("FarmerEats"),

                  const SizedBox(height: 30),

                  const Text(
                    "Signup 1 of 4",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Welcome!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      socialButton("images/google.png"),
                      socialButton("images/apple.png"),
                      socialButton("images/facebook1.png"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Center(
                    child: Text(
                      "or signup with",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextFormField(
                    controller: nameController,
                    validator: validateName,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  TextFormField(
                    controller: emailController,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
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

                  const SizedBox(height: 25),

                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    validator: validatePhone,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      prefixIcon: const Icon(Icons.phone_outlined),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  TextFormField(
                    controller: passwordController,
                    validator: validatePassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  TextFormField(
                    controller: confirmpasswordController,
                    validator: validateConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Re-enter Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      const Spacer(),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSubmitted = true;
                          });

                          if (_formKey.currentState!.validate()) {
                            SignupData data = SignupData();

                            data.name = nameController.text;
                            data.email = emailController.text;
                            data.phone = phoneController.text;
                            data.password = passwordController.text;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SignUpScreen2(data: data),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 180,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD56B55),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
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
