import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:quetter/controller/pixa_controller.dart';
import 'package:quetter/helper/fbs_helper.dart';

import '../../controller/quet_controller.dart';
import '../../helper/fb_store_helper.dart';
import 'background_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // QuoteModal quoteModal = QuoteModal.init();
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PixaController pixa = Provider.of(context, listen: false);
    int tindex = 0;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FBSHelper.fbsHelper.fetchBackground(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    String background = snap.data?.data()?['images'] ?? '';
                    pixa.updateDominantColor(
                      'https://firebasestorage.googleapis.com/v0/b/qutter-eeb9f.appspot.com/o/${Uri.encodeComponent(background)}?alt=media',
                    );
                    return Container(
                      height: size.height,
                      width: size.width,
                      child: Stack(
                        children: [
                          Container(
                            height: size.height,
                            width: size.width,
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/background.png',
                              placeholderFit: BoxFit.cover,
                              image:
                                  'https://firebasestorage.googleapis.com/v0/b/qutter-eeb9f.appspot.com/o/${Uri.encodeComponent(background)}?alt=media',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: size.height,
                            width: size.width,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snap.hasError) {
                    return CircularProgressIndicator();
                  }

                  return Container();
                }),
            Center(
              child: Container(
                height: size.height * 0.7,
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FbStoreHelper.fbStoreHelper.fetchPrefrance(),
                    builder: (context, snapshot) {
                      List top = snapshot.data?.data()?['Prefrance'] ?? [];
                      // Logger().i(top);
                      Provider.of<QuoteCntroller>(context, listen: false)
                          .Prefrace(tags: top);
                      return Consumer<QuoteCntroller>(
                          builder: (context, pro, child) {
                        return pro.preferredQuotes.isNotEmpty
                            ? CarouselSlider.builder(
                                itemCount: pro.preferredQuotes.length,
                                itemBuilder: (context, index, child) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 26),
                                        child: Text(
                                          pro.preferredQuotes[index]['content'],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12.0,
                                        ),
                                        child: Text(
                                          '~${pro.preferredQuotes[index]['author']}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                options: CarouselOptions(
                                    scrollDirection: Axis.vertical,
                                    pageSnapping: true,
                                    initialPage: 0,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, value) {
                                      // log('${windex}');
                                    }),
                              )
                            : CarouselSlider.builder(
                                itemCount: pro.quotes.length,
                                itemBuilder: (context, index, child) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 26),
                                        child: Text(
                                          pro.quotes[index]['content'],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12.0,
                                        ),
                                        child: Text(
                                          '~${pro.quotes[index]['author']}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                options: CarouselOptions(
                                    scrollDirection: Axis.vertical,
                                    pageSnapping: true,
                                    initialPage: 0,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, value) {
                                      // log('${windex}');
                                    }),
                              );
                      });
                    }),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: const Alignment(0, -0.9),
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Bounceable(
                    duration: const Duration(milliseconds: 100),
                    scaleFactor: 0.5,
                    curve: Curves.decelerate,
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BackgroundPage()));
                    },
                    child: Container(
                      width: size.width * 0.14,
                      height: size.height * 0.07,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: pixa.dominantColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(FluentIcons.squares_nested_20_regular,
                          size: 30, color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          width: size.width * 0.14,
                          height: size.height * 0.07,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Provider.of<PixaController>(context)
                                .dominantColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                '/CategoryPage',
                              );
                            },
                            icon: const Icon(
                              FluentIcons.grid_20_regular,
                              size: 30,
                              color: Colors.white,
                            ),
                          )),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Container(
                          width: size.width * 0.14,
                          height: size.height * 0.07,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Provider.of<PixaController>(context)
                                .dominantColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                '/SettingPage',
                              );
                            },
                            icon: const Icon(
                              FluentIcons.person_24_regular,
                              size: 30,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
