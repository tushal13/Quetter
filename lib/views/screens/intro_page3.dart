import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quetter/views/screens/intro_page4.dart';

import '../../helper/fb_auth_helper.dart';

class TintroPage extends StatelessWidget {
  const TintroPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0, -1.0),
                end: Alignment(0, 5),
                colors: [
              Color(0xFF273447),
              Color(0xFFB5A69F),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF36455A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/qutter_logo.png',
                    height: 50,
                  ),
                  SizedBox(height: size.height * 0.020),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Welcome, ${FBAuthHelper.fbAuthHelper.auth.currentUser?.displayName} ! Dive into the world of wisdom and let the journey of inspiration begin. Remember, every quote is a new perspective. Enjoy your journey in our Quote App',
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.of(context).pushReplacement(PageTransition(
                  child: const FointroPage(),
                  childCurrent: this,
                  type: PageTransitionType.rightToLeftJoined,
                  duration: const Duration(seconds: 1),
                ));
              },
              child: Container(
                width: size.width * 0.5,
                height: size.height * 0.05,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Continue',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF36455A),
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.025),
          ],
        ),
      )),
    );
  }
}
