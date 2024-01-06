import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quetter/helper/fbs_helper.dart';
import 'package:quetter/views/screens/home_page.dart';

import '../../controller/pixa_controller.dart';
import '../../helper/fb_store_helper.dart';
import '../component/background_tile.dart';

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Background",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }),
          backgroundColor: Colors.transparent,
          actions: [
            Consumer<PixaController>(builder: (context, pro, child) {
              return Container(
                padding:
                    const EdgeInsets.only(left: 8, top: 5, bottom: 5, right: 8),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FbStoreHelper.fbStoreHelper.fetchCoins(),
                    builder: (context, snapshot) {
                      int coinsValue = snapshot.data?.data()?['Coins'] ?? 0;
                      return Row(
                        children: [
                          Image.asset(
                            'assets/images/coin.png',
                            height: 24,
                          ),
                          SizedBox(width: size.width * 0.010),
                          Text(
                            '$coinsValue',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      );
                    }),
              );
            }),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                    stream: FBSHelper.fbsHelper.fetchPurchesed(),
                    builder: (context, snapshot) {
                      List background = snapshot.data?.data()?['images'] ?? [];
                      return background.isEmpty
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Recently Purchased',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: background.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              right: 10, top: 10, bottom: 10),
                                          width: size.width * 0.35,
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (background.contains(
                                                  background[index])) {
                                                await FBSHelper.fbsHelper
                                                    .addBackground(
                                                        image:
                                                            background[index]);
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()));
                                              }
                                            },
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        placeholder:
                                                            'assets/images/background.png',
                                                        placeholderFit:
                                                            BoxFit.cover,
                                                        image:
                                                            'https://firebasestorage.googleapis.com/v0/b/qutter-eeb9f.appspot.com/o/${Uri.encodeComponent(background[index])}?alt=media',
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                (background.contains(
                                                        background[index]))
                                                    ? Positioned(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                        ),
                                                      )
                                                    : Positioned(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.4),
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            );
                    }),
                Consumer<PixaController>(builder: (context, pixa, child) {
                  return Column(children: [
                    BackgroundTile(name: 'Minimalism', list: pixa.minimalism),
                    BackgroundTile(name: 'Aesthetic', list: pixa.aesthetic),
                    BackgroundTile(
                        name: 'Black & White', list: pixa.blackwhite),
                    BackgroundTile(
                        name: 'Illustration', list: pixa.illustration),
                    BackgroundTile(name: 'Love', list: pixa.love),
                    BackgroundTile(name: 'Nature', list: pixa.nature),
                    BackgroundTile(name: 'People', list: pixa.people),
                    BackgroundTile(name: 'Sunrise', list: pixa.sunrise),
                  ]);
                }),
              ],
            ),
          ),
        ));
  }
}
