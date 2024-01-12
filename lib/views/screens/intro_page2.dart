import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quetter/helper/fb_auth_helper.dart';
import 'package:quetter/views/screens/intro_page3.dart';

import '../../controller/user_controller.dart';

class SIntroPage extends StatelessWidget {
  SIntroPage({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0, -1.0),
                end: Alignment(0, 5),
                colors: [
              Color(0xFF273447),
              Color(0xFFB5A69F),
            ])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.050),
                Image.asset(
                  'assets/images/qutter_logo.png',
                  height: 70,
                ),
                SizedBox(height: size.height * 0.060),
                const Text(
                  'Navigate Your Narrative What Shall We Call You?',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.040),
                Text(
                  'Enter the Digital Canvas of Your Narrative: Every Tap, Every Answer Paints the Portrait of Your Journey. As We Navigate This Virtual Tapestry, What Name Shall We Engrave, What Chapter Shall We Unveil in Your Digital Saga?',
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.050),
                Consumer<UserController>(builder: (context, pro, child) {
                  return Form(
                    key: formKey,
                    child: Column(children: [
                      Container(
                        height: 40,
                        width: size.width * 0.9,
                        child: TextFormField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              fontSize: 18),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            hintText: 'Name',
                            hintStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.020),
                      Container(
                        height: 40,
                        width: size.width * 0.9,
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              fontSize: 18),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.020),
                      Container(
                        height: 40,
                        width: size.width * 0.9,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !pro.isPasswordVisible,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              fontSize: 18),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5),
                            suffixIcon: IconButton(
                              icon: Icon(
                                pro.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                pro.togglePasswordVisibility();
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  );
                }),
                SizedBox(height: size.height * 0.050),
                Visibility(
                  visible: nameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty,
                  child: GestureDetector(
                    onTap: () async {
                      await FBAuthHelper.fbAuthHelper
                          .registerWithEmailAndPassword(emailController.text,
                              passwordController.text, nameController.text);
                      await FBAuthHelper.fbAuthHelper
                          .signInWithEmailAndPassword(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                      );
                      Navigator.of(context).pushReplacement(PageTransition(
                        child: const TintroPage(),
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
                ),
                SizedBox(height: size.height * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.35,
                      height: 1,
                      color: Colors.grey,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        ' OR ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: size.width * 0.35,
                      height: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.025),
                GestureDetector(
                  onTap: () async {
                    await FBAuthHelper.fbAuthHelper.signInWithGoogle();
                    Logger().t(FBAuthHelper
                        .fbAuthHelper.auth.currentUser?.displayName);
                    Navigator.of(context).pushReplacement(PageTransition(
                      child: const TintroPage(),
                      childCurrent: this,
                      type: PageTransitionType.rightToLeftJoined,
                      duration: const Duration(seconds: 1),
                    ));
                  },
                  child: Container(
                    width: size.width * 0.54,
                    height: size.height * 0.05,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              width: 40,
                            ),
                            SizedBox(height: size.height * 0.010),
                            const Text(
                              'Continue with Google',
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF36455A),
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
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
