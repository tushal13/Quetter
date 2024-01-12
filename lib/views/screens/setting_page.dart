import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quetter/views/screens/dwonload_page.dart';
import 'package:quetter/views/screens/favorite_page.dart';
import 'package:quetter/views/screens/past_page.dart';
import 'package:quetter/views/screens/prefrence_page.dart';
import 'package:quetter/views/screens/your_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helper/ad_helper.dart';
import '../../helper/fb_store_helper.dart';
import 'add_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
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
                        Navigator.of(context).push(PageTransition(
                            child: PrefPage(), type: PageTransitionType.fade));
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
                        FluentIcons.note_add_24_regular,
                        size: 20,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Add Your Own Quote",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.of(context).push(PageTransition(
                            child: AddQuotePage(),
                            type: PageTransitionType.fade));
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
                          onTap: () async {
                            AdHelper.adHelper.rewardedAd.show(
                                onUserEarnedReward: (ad, reward) async {
                              if (coinsValue < 10) {
                                await FbStoreHelper.fbStoreHelper
                                    .addCoins(
                                  coins: reward.amount.toInt(),
                                )
                                    .then((value) async {
                                  await AdHelper.adHelper.initializeAd();
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text(
                                              'Congratulations'.toUpperCase(),
                                              textAlign: TextAlign.center,
                                            ),
                                            titleTextStyle: const TextStyle(
                                                color: Colors.amber,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            backgroundColor: Colors.white,
                                            content: SizedBox(
                                              height: 90,
                                              child: Stack(children: [
                                                Positioned(
                                                  left: 0,
                                                  right: 30,
                                                  child: Image.asset(
                                                    'assets/images/coin.png',
                                                    height: 50,
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 10,
                                                  right: 0,
                                                  child: Image.asset(
                                                    'assets/images/coin.png',
                                                    height: 50,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 8,
                                                  left: -10,
                                                  right: 0,
                                                  child: Image.asset(
                                                    'assets/images/coin.png',
                                                    height: 50,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 70,
                                                  left: 70,
                                                  right: 1,
                                                  bottom: 1,
                                                  child: Text(
                                                    "+10 Coins".toUpperCase(),
                                                    style: const TextStyle(
                                                        color: Colors.amber,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ]),
                                            ));
                                      });
                                });
                              } else {
                                await FbStoreHelper.fbStoreHelper
                                    .upadateCoins(
                                  coins: reward.amount.toInt(),
                                )
                                    .then((value) async {
                                  await AdHelper.adHelper.initializeAd();
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text(
                                              'Congratulations'.toUpperCase(),
                                              textAlign: TextAlign.center,
                                            ),
                                            titleTextStyle: const TextStyle(
                                                color: Colors.amber,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            backgroundColor: Colors.white,
                                            content: SizedBox(
                                              height: 90,
                                              child: Stack(children: [
                                                Positioned(
                                                  left: 0,
                                                  right: 30,
                                                  child: Image.asset(
                                                    'assets/images/coin.png',
                                                    height: 50,
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 10,
                                                  right: 0,
                                                  child: Image.asset(
                                                    'assets/images/coin.png',
                                                    height: 50,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 8,
                                                  left: -10,
                                                  right: 0,
                                                  child: Image.asset(
                                                    'assets/images/coin.png',
                                                    height: 50,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 70,
                                                  left: 70,
                                                  right: 1,
                                                  bottom: 1,
                                                  child: Text(
                                                    "+10 Coins".toUpperCase(),
                                                    style: const TextStyle(
                                                        color: Colors.amber,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ]),
                                            ));
                                      });
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
                        Navigator.of(context).push(PageTransition(
                            child: PastQuote(), type: PageTransitionType.fade));
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
                        Navigator.of(context).push(PageTransition(
                            child: FavoritesScreen(),
                            type: PageTransitionType.fade));
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
                        Navigator.of(context).push(PageTransition(
                            child: const YourQuotes(),
                            type: PageTransitionType.fade));
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
                        FluentIcons.arrow_download_24_regular,
                        size: 30,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.of(context).push(PageTransition(
                            child: const DwonloadPage(),
                            type: PageTransitionType.fade));
                      },
                      title: const Text(
                        "Dwonload Quotes",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: const Icon(
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
                width: size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFF354760),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(
                        FluentIcons.shield_checkmark_48_regular,
                        size: 30,
                        color: Colors.white,
                      ),
                      onTap: () async {
                        const String url =
                            'https://qutterprivacypolicy.blogspot.com/p/privacy-policy.html';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
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
                      onTap: () async {
                        const String url =
                            'https://termsandconditionsqutter.blogspot.com/p/last-updated-10-1.html';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
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
