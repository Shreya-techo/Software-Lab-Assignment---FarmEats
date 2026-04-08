import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Quality",
      "desc":
          "Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain",
      "image": "images/sceenary.jpg",
    },
    {
      "title": "Convenient",
      "desc":
          "Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to our customers",
      "image": "images/birdhouse.jpg",
    },
    {
      "title": "Local",
      "desc":
          "We love the earth and know you do too! Join us in reducing our local carbon footprints one order at a time.",
      "image": "images/house.jpg",
    },
  ];

  void nextPage() {
    if (currentIndex < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        //physics: PageScrollPhysics(),
        physics: BouncingScrollPhysics(),

        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  onboardingData[index]["image"]!,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        onboardingData[index]["title"]!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        onboardingData[index]["desc"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (i) {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            width: currentIndex == i ? 12 : 8,
                            height: currentIndex == i ? 12 : 8,
                            decoration: BoxDecoration(
                              color:
                                  currentIndex == i
                                      ? Colors.black
                                      : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: nextPage,
                        child: TextButton(
                          onPressed: () {},
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD56B55),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                "Join the movement",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
