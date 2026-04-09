import 'package:flutter/material.dart';
import 'package:new_assignment/services/auth_service.dart';
import 'dart:convert';

import 'package:new_assignment/signup/signup_model.dart';

class BusinessHours extends StatefulWidget {
  final SignupData data;
  const BusinessHours({super.key, required this.data});

  @override
  State<BusinessHours> createState() => _BusinessHoursScreenState();
}

class _BusinessHoursScreenState extends State<BusinessHours> {
  int selectedDayIndex = 2;

  List<String> days = ["M", "T", "W", "Th", "F", "S", "Su"];
  List<String> apiDays = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];

  List<String> timeSlots = [
    "8:00am - 10:00am",
    "10:00am - 1:00pm",
    "1:00pm - 4:00pm",
    "4:00pm - 7:00pm",
    "7:00pm - 10:00pm",
  ];

  List<bool> selectedSlots = [];

  Map<String, List<String>> businessHours = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    businessHours = {
      "mon": ["8:00am - 10:00am", "10:00am - 1:00pm"],
      "tue": ["8:00am - 10:00am", "10:00am - 1:00pm"],
      "wed": ["8:00am - 10:00am", "10:00am - 1:00pm", "1:00pm - 4:00pm"],
      "thu": ["8:00am - 10:00am", "10:00am - 1:00pm", "1:00pm - 4:00pm"],
      "fri": ["8:00am - 10:00am", "10:00am - 1:00pm"],
      "sat": ["8:00am - 10:00am", "10:00am - 1:00pm"],
      "sun": ["8:00am - 10:00am"],
    };

    List<String> savedSlots = businessHours[apiDays[selectedDayIndex]] ?? [];

    selectedSlots = List.generate(
      timeSlots.length,
      (i) => savedSlots.contains(timeSlots[i]),
    );
  }

  void _onDaySelected(int index) {
    List<String> selectedTimes = [];

    for (int i = 0; i < timeSlots.length; i++) {
      if (selectedSlots[i]) {
        selectedTimes.add(timeSlots[i]);
      }
    }

    businessHours[apiDays[selectedDayIndex]] = selectedTimes;

    setState(() {
      selectedDayIndex = index;

      List<String> savedSlots = businessHours[apiDays[index]] ?? [];

      selectedSlots = List.generate(
        timeSlots.length,
        (i) => savedSlots.contains(timeSlots[i]),
      );
    });
  }

  void _handleBack() {
    List<String> selectedTimes = [];

    for (int i = 0; i < timeSlots.length; i++) {
      if (selectedSlots[i]) {
        selectedTimes.add(timeSlots[i]);
      }
    }

    businessHours[apiDays[selectedDayIndex]] = selectedTimes;

    Navigator.pop(context, businessHours);
  }

  void _handleSignupAndContinue() async {
    List<String> selectedTimes = [];

    for (int i = 0; i < timeSlots.length; i++) {
      if (selectedSlots[i]) {
        selectedTimes.add(timeSlots[i]);
      }
    }

    businessHours[apiDays[selectedDayIndex]] = selectedTimes;

    bool isEmpty = businessHours.values.every((list) => list.isEmpty);

    if (isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select at least one time slot")),
      );
      return;
    }

    widget.data.businessHours = businessHours;

    setState(() {
      isLoading = true;
    });

    print(" Signup API called");
    print(" Data: ${jsonEncode(widget.data.businessHours)}");

    try {
      await Future.delayed(const Duration(seconds: 2));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Signup successful")));

      await Future.delayed(const Duration(seconds: 2));

      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      print(" ERROR: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }

    setState(() {
      isLoading = false;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFF3ECEA),
          body: Center(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.75,
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("FarmerEats"),

                  const SizedBox(height: 30),

                  const Text(
                    "Signup 4 of 4",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Business Hours",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Choose the hours your farm is open for pickups.",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(days.length, (index) {
                      return GestureDetector(
                        onTap: () => _onDaySelected(index),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                selectedDayIndex == index
                                    ? const Color(0xFFD56B55)
                                    : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            days[index],
                            style: TextStyle(
                              color:
                                  selectedDayIndex == index
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(timeSlots.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSlots[index] = !selectedSlots[index];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                selectedSlots[index]
                                    ? const Color(0xFFD56B55)
                                    : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            timeSlots[index],
                            style: TextStyle(
                              color:
                                  selectedSlots[index]
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      IconButton(
                        onPressed: _handleBack,
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD56B55),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _handleSignupAndContinue,
                        child: const Text(
                          "Signup",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
