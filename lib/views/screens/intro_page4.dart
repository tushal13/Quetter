import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quetter/controller/quet_controller.dart';
import 'package:quetter/views/screens/home_page.dart';

import '../../controller/user_controller.dart';
import '../../helper/fb_auth_helper.dart';
import '../../helper/fb_store_helper.dart';
import '../component/category_tile.dart';
import '../modal/topic_modal.dart';
import '../modal/user_modal.dart';
import '../utility/topics.dart';

class FointroPage extends StatelessWidget {
  const FointroPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModal userModal = UserModal.init();
    userModal.name = 'Tushal';
    userModal.email = 'tushalgopani3@gmail.com';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFF273447),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: size.height * 0.050),
            Image.asset(
              'assets/images/qutter_logo.png',
              height: 50,
            ),
            SizedBox(height: size.height * 0.020),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Hey, ${FBAuthHelper.fbAuthHelper.auth.currentUser?.displayName} \n Pick the representation that feels right for you ? ',
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
            SizedBox(height: size.height * 0.020),
            Text(
              'This information will be \n used to customize some quotes.',
              style: TextStyle(
                color: Colors.grey.withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: 13,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FbStoreHelper.fbStoreHelper.fetchPrefrance(),
                  builder: (context, snapshot) {
                    List pref = snapshot.data?.data()?['Prefrance'] ?? [];
                    return Consumer<QuoteCntroller>(
                        builder: (context, pro, child) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: topics.length,
                                itemBuilder: (context, index) {
                                  TopicModal topic = topics[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      pro.selectedPrefFunc(pref, topic.name);
                                      userModal.prefs = pref;
                                    },
                                    child: CategoryTile(
                                      category: topic.name,
                                      icon: topic.icon,
                                      isSelected: pref.contains(topic.name),
                                    ),
                                  );
                                }),
                          ),
                          Consumer<UserController>(
                              builder: (context, pro, child) {
                            return Visibility(
                              visible: pref.isNotEmpty,
                              child: GestureDetector(
                                onTap: () async {
                                  await FbStoreHelper.fbStoreHelper
                                      .addPrefrance(
                                    user: userModal,
                                  );
                                  Navigator.of(context)
                                      .pushReplacement(PageTransition(
                                    child: HomePage(),
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
                            );
                          }),
                        ],
                      );
                    });
                  }),
            ),
            SizedBox(height: size.height * 0.010),
          ],
        ),
      ),
    );
  }
}
