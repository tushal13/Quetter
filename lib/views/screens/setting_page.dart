import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../helper/ad_helper.dart';
import '../../helper/fb_store_helper.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
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
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 8),
                child: Text(
                  'Your Quotes',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 500,
                width: size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFF354760),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(
                        FluentIcons.book_default_28_regular,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Content Preferences",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/PrefPage');
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF273447),
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(
                        FluentIcons.note_add_24_regular,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Add Your Own Quote",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/AddQuotePage');
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF273447),
                      thickness: 1,
                    ),
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FbStoreHelper.fbStoreHelper.fetchCoins(),
                      builder: (context, snapshot) {
                        int coinsValue = snapshot.data?.data()?['Coins'] ?? 0;
                        return ListTile(
                          leading: const Icon(
                            FluentIcons.play_48_regular,
                            size: 30,
                            color: Colors.white,
                          ),
                          onTap: () {
                            AdHelper.adHelper.rewardedAd.show(
                                onUserEarnedReward: (ad, reward) async {
                              if (coinsValue < 10) {
                                await FbStoreHelper.fbStoreHelper
                                    .addCoins(
                                  coins: reward.amount.toInt(),
                                )
                                    .then((value) async {
                                  await AdHelper.adHelper.initializeAd();
                                });
                              } else {
                                await FbStoreHelper.fbStoreHelper
                                    .upadateCoins(
                                  coins: reward.amount.toInt(),
                                )
                                    .then((value) async {
                                  await AdHelper.adHelper.initializeAd();
                                });
                              }
                            });
                          },
                          title: const Text(
                            "Earn Coins",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          trailing: const Icon(
                            FluentIcons.play_circle_48_regular,
                            size: 30,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    const Divider(
                      color: Color(0xFF273447),
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(
                        FluentIcons.history_28_regular,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Past Quotes",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/PastQuote');
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF273447),
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(
                        FluentIcons.heart_28_regular,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Favourites",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/FavoritesScreen');
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF273447),
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(
                        FluentIcons.chat_48_regular,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Your Quotes",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/YourQuotes');
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF273447),
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Icon(
                        FluentIcons.arrow_download_24_regular,
                        size: 30,
                        color: Colors.white,
                      ),
                      onTap: () {
                        // Navigator.of(context).push(
                        //
                        // );
                      },
                      title: Text(
                        "Dwonload Quotes",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 8),
                child: Text(
                  'Other',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: size.height * 0.15,
                width: size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFF354760),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        FluentIcons.shield_checkmark_48_regular,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Privacy Policy",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Color(0xFF273447),
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Icon(
                        FluentIcons.document_48_regular,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Terms and Conditions",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
