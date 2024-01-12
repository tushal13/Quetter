import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quetter/controller/quet_controller.dart';

import '../../helper/fb_auth_helper.dart';
import '../../helper/fb_store_helper.dart';
import '../modal/user_modal.dart';
import '../utility/preferred_lists.dart';

class PrefPage extends StatelessWidget {
  PrefPage({super.key});
  UserModal userModal = UserModal.init();
  @override
  Widget build(BuildContext context) {
    userModal.name = FBAuthHelper.fbAuthHelper.auth.currentUser?.displayName;
    userModal.email = FBAuthHelper.fbAuthHelper.auth.currentUser?.email;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Preferences",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
        ),
        backgroundColor: const Color(0xFF273447),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0, -1.0),
              end: Alignment(0, 5),
              colors: [
                Color(0xFF273447),
                Color(0xFFB5A69F),
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Select your preferred contant type',
                  style: TextStyle(
                    color: Color(0xFF5E6C85),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FbStoreHelper.fbStoreHelper.fetchPrefrance(),
                    builder: (context, snapshot) {
                      {
                        return Consumer<QuoteCntroller>(
                            builder: (context, pro, child) {
                          return GridView.builder(
                            itemCount: pref.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 70,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              List top =
                                  snapshot.data?.data()?['Prefrance'] ?? [];

                              return GestureDetector(
                                onTap: () async {
                                  pro.selectedPrefFunc(top, pref[index]);
                                  userModal.prefs = top;
                                  top.isNotEmpty
                                      ? await FbStoreHelper.fbStoreHelper
                                          .addPrefrance(
                                          user: userModal,
                                        )
                                      : await FbStoreHelper.fbStoreHelper
                                          .addPrefrance(
                                          user: userModal,
                                        );
                                  pro.Prefrace(tags: top);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: top.contains(pref[index])
                                        ? Colors.white.withOpacity(0.1)
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: top.contains(pref[index])
                                            ? Colors.white.withOpacity(0.8)
                                            : Color(0xFF5E6C85),
                                        width:
                                            top.contains(pref[index]) ? 2 : 1),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(pref[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: top.contains(pref[index])
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                        fontFamily: 'Cormorant',
                                      )),
                                ),
                              );
                            },
                          );
                        });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
