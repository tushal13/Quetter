import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quetter/views/screens/intro_page2.dart';

class FintroPage extends StatelessWidget {
  const FintroPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/fiimage.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: size.height * 0.77,
            left: size.width * 0.2,
            right: size.width * 0.15,
            bottom: 0,
            child: const Text(
              'Motivate Your Moments',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Positioned(
            top: size.height * 0.825,
            left: size.width * 0.1,
            right: size.width * 0.1,
            bottom: 0,
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  "Motivate Your Moments. Transform each instant into inspiration, fueling your journey with motivation tailored just for you",
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              totalRepeatCount: 1,
            ),
          ),
          Positioned(
            top: size.height * 0.92,
            left: size.width * 0.1,
            right: size.width * 0.1,
            bottom: size.height * 0.02,
            child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pushReplacement(
                  PageTransition(
                    child: SIntroPage(),
                    type: PageTransitionType.fade,
                    curve: Curves.linear,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-1.4, -1.0),
                      end: Alignment(1.0, 1.0),
                      colors: [
                        Color(0xFF273447),
                        Color(0xFF36455A),
                        Color(0xFF7C8290),
                        Color(0xFFB5A69F),
                      ],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.90, 0.0),
                        blurRadius: 1.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Spark Motivation',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1D1D25),
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
