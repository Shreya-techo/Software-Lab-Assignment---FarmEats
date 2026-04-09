import 'package:flutter/material.dart';
import 'package:new_assignment/signup/signup3screen.dart';
import 'package:new_assignment/signup/signup_model.dart';

class SignUpScreen2 extends StatefulWidget {
  final SignupData data;

  SignUpScreen2({super.key, required this.data});

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();

  final List<String> indianStates = [
    "New York",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
  ];
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  String? selectedState;
  final businessController = TextEditingController();
  final informalController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isSubmitted = false;

  String? validateName(String? value) {
    if (!isSubmitted) return null;
    if (value == null || value.isEmpty) {
      return "Business name is required";
    }
    return null;
  }

  String? validateinformal(String? value) {
    if (!isSubmitted) return null;
    if (value == null || value.isEmpty) {
      return "name is required";
    }
    return null;
  }

  String? validateaddress(String? value) {
    if (!isSubmitted) return null;
    if (value == null || value.isEmpty) {
      return "address is required";
    }
    return null;
  }

  String? validatecity(String? value) {
    if (!isSubmitted) return null;
    if (value == null || value.isEmpty) {
      return "city is required";
    }
    return null;
  }

  String? validateZipCode(String? value) {
    if (!isSubmitted) return null;
    if (value == null || value.isEmpty) {
      return "Enter zipcode";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    businessController.text = widget.data.businessName ?? "";
    informalController.text = widget.data.informalName ?? "";
    addressController.text = widget.data.address ?? "";
    cityController.text = widget.data.city ?? "";
    zipController.text = widget.data.zipcode ?? "";
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

                  const Text("Signup 2 of 4"),

                  const SizedBox(height: 20),

                  const Text(
                    "Farm Info",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),

                  TextFormField(
                    controller: businessController,
                    validator: validateName,
                    decoration: InputDecoration(
                      hintText: "Business Name",
                      prefixIcon: const Icon(Icons.add_business_outlined),
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
                    controller: informalController,
                    validator: validateinformal,
                    decoration: InputDecoration(
                      hintText: "Informal Name",
                      prefixIcon: const Icon(Icons.face),
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
                    controller: addressController,
                    validator: validateaddress,
                    decoration: InputDecoration(
                      hintText: "Street Address",
                      prefixIcon: const Icon(Icons.home_outlined),
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
                    controller: cityController,
                    validator: validatecity,
                    decoration: InputDecoration(
                      hintText: "City",
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: selectedState,
                          hint: const Text("State"),
                          items:
                              widget.indianStates.map((state) {
                                return DropdownMenuItem(
                                  value: state,
                                  child: Text(state),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedState = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: zipController,
                          validator: validateZipCode,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Zipcode",
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 200),

                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          widget.data.businessName = businessController.text;
                          widget.data.informalName = informalController.text;
                          widget.data.address = addressController.text;
                          widget.data.city = cityController.text;
                          widget.data.zipcode = zipController.text;

                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),

                      const Spacer(),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSubmitted = true;
                          });

                          if (_formKey.currentState!.validate()) {
                            widget.data.businessName = businessController.text;
                            widget.data.informalName = informalController.text;
                            widget.data.address = addressController.text;
                            widget.data.city = cityController.text;
                            widget.data.zipcode = zipController.text;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        VerificationScreen(data: widget.data),
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
}
