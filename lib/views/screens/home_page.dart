import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quetter/controller/pixa_controller.dart';
import 'package:quetter/helper/fbs_helper.dart';
import 'package:quetter/views/screens/setting_page.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';

import '../../controller/index_controller.dart';
import '../../controller/quet_controller.dart';
import '../../helper/db_helper.dart';
import '../../helper/fb_store_helper.dart';
import '../modal/quate_modal.dart';
import 'background_page.dart';
import 'favorite_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  QuoteModal quoteModal = QuoteModal.init();
  FlutterTts flutterTts = FlutterTts();
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FBSHelper.fbsHelper.fetchBackground(),
          builder: (context, snap) {
            String background = snap.data?.data()?['images'] ?? '';
            Provider.of<PixaController>(context, listen: false)
                .updateDominantColor(
              'https://firebasestorage.googleapis.com/v0/b/qutter-eeb9f.appspot.com/o/${Uri.encodeComponent(background)}?alt=media',
            );
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  image: background != ''
                      ? DecorationImage(
                          image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/qutter-eeb9f.appspot.com/o/${Uri.encodeComponent(background)}?alt=media',
                          ),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Consumer<PixaController>(
                        builder: (context, pro, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BackgroundPage()));
                              },
                              child: Container(
                                width: size.width * 0.14,
                                height: size.height * 0.07,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: pro.dominantColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  FluentIcons.squares_nested_20_regular,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingPage()));
                              },
                              child: Container(
                                width: size.width * 0.14,
                                height: size.height * 0.07,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: pro.dominantColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  FluentIcons.person_24_regular,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: size.height,
                      child: Consumer3<QuoteCntroller, IndexController,
                              PixaController>(
                          builder: (context, pro, ind, pixa, child) {
                        return CarouselSlider.builder(
                          itemCount: pro.quotes.length,
                          itemBuilder: (context, index, child) {
                            print(pixa.dominantColor);
                            return pro.quotes.isNotEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Image.asset(
                                        'assets/images/qutter_logo.png',
                                        height: 30,
                                        color: pixa.textcolor,
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 26),
                                        child: Text(pro.quotes[index]['text'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: pixa.textcolor,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12.0,
                                        ),
                                        child: Text(
                                          '~${pro.quotes[index]['author']}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: pixa.textcolor),
                                        ),
                                      ),
                                      const Spacer(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )
                                : const Center(
                                    child: CircularProgressIndicator());
                          },
                          options: CarouselOptions(
                            scrollDirection: Axis.vertical,
                            pageSnapping: true,
                            initialPage: 0,
                            enlargeCenterPage: true,
                            onScrolled: (value) {},
                            onPageChanged: (index, value) async {
                              quoteModal.id = pro.quotes[index]['_id'];
                              quoteModal.quote = pro.quotes[index]['text'];
                              quoteModal.author = pro.quotes[index]['author'];
                              quoteModal.category = pro.quotes[index]['tags'];
                              quoteModal.image = background;
                              await FbStoreHelper.fbStoreHelper
                                  .addHistory(quote: quoteModal);
                              ind.setIndex(val: index);
                              Logger().i(ind.index);
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(16),
                      child: Consumer2<QuoteCntroller, IndexController>(
                          builder: (context, pro, ind, child) {
                        {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  quoteModal.id = pro.quotes[ind.index]['_id'];
                                  quoteModal.quote =
                                      pro.quotes[ind.index]['text'];
                                  quoteModal.author =
                                      pro.quotes[ind.index]['author'];
                                  quoteModal.category =
                                      pro.quotes[ind.index]['tags'];

                                  await DBHelper.dbHelper
                                      .insertDwonload(quote: quoteModal);
                                  await DBHelper.dbHelper.getDwonload();
                                },
                                icon: const Icon(
                                  FluentIcons.arrow_download_32_regular,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await flutterTts.setLanguage('en-US');
                                  await flutterTts.setPitch(1.0);
                                  await flutterTts
                                      .speak(pro.quotes[ind.index]['text']);
                                },
                                icon: const Icon(
                                  FluentIcons.phone_speaker_24_regular,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    quoteModal.id =
                                        pro.quotes[ind.index]['_id'];
                                    quoteModal.quote =
                                        pro.quotes[ind.index]['text'];
                                    quoteModal.author =
                                        pro.quotes[ind.index]['author'];
                                    quoteModal.category =
                                        pro.quotes[ind.index]['tags'];
                                    quoteModal.image = background;
                                    await FbStoreHelper.fbStoreHelper
                                        .addFavorite(quote: quoteModal)
                                        .then((value) => ScaffoldMessenger.of(
                                                context)
                                            .showSnackBar(SnackBar(
                                                content: const Text(
                                                  'Favorite added ❤️',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                dismissDirection:
                                                    DismissDirection.startToEnd,
                                                elevation: 2,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                duration:
                                                    const Duration(seconds: 1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                                width: size.width * 0.8,
                                                backgroundColor: Colors.black,
                                                action: SnackBarAction(
                                                  label: 'view',
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        PageTransition(
                                                            child:
                                                                FavoritesScreen(),
                                                            type:
                                                                PageTransitionType
                                                                    .fade));
                                                  },
                                                ))));
                                  },
                                  icon: const Icon(
                                    FluentIcons.heart_28_regular,
                                    size: 30,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                onPressed: () {
                                  String t = pro.quotes[ind.index]['text'];

                                  Clipboard.setData(ClipboardData(text: t));
                                },
                                icon: const Icon(
                                  FluentIcons.copy_select_24_regular,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  print(background);
                                  screenshotController
                                      .captureFromWidget(Container(
                                    height: size.height * 0.245,
                                    width: size.width * 0.5,
                                    decoration: BoxDecoration(
                                      color: Provider.of<PixaController>(
                                                  context,
                                                  listen: false)
                                              .dominantColor
                                              ?.withOpacity(0.5) ??
                                          const Color(0xFF273447),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/qutter-eeb9f.appspot.com/o/${Uri.encodeComponent(background)}?alt=media',
                                          ),
                                          fit: BoxFit.fill),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: const Alignment(0, -0.7),
                                          child: Image.asset(
                                            'assets/images/qutter_logo.png',
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(24),
                                            child: Text(
                                              pro.quotes[ind.index]['text'],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 8,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            child: Text(
                                              pro.quotes[ind.index]['author'],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                                      .then((capturedImage) async {
                                    print(capturedImage);
                                    final tempDir =
                                        await getTemporaryDirectory();
                                    final file = File(
                                        '${tempDir.path}/captured_image.png');
                                    await file.writeAsBytes(capturedImage);
                                    await ShareExtend.share(file.path, "image");
                                  });
                                },
                                icon: const Icon(
                                  FluentIcons.share_28_regular,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

//
// Container(
// height: size.height,
// width: size.width,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage(
// 'https://firebasestorage.googleapis.com/v0/b/qutter-eeb9f.appspot.com/o/${Uri.encodeComponent(background)}?alt=media',
// ),
// fit: BoxFit.fill,
// ),
// ),
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.center,
// crossAxisAlignment:
// CrossAxisAlignment.center,
// children: [
// const SizedBox(
// height: 100,
// ),
// Image.asset(
// 'assets/images/qutter_logo.png',
// height: 60),
// const SizedBox(
// height: 200,
// ),
// Padding(
// padding: const EdgeInsets
//     .symmetric(
// horizontal: 26),
// child: Text(
// pro.quotes[ind.index]
// ['text'],
// textAlign:
// TextAlign.center,
// style: const TextStyle(
// fontWeight:
// FontWeight.bold,
// fontSize: 18,
// color: Colors.white,
// )),
// ),
// Padding(
// padding:
// const EdgeInsets.only(
// top: 12.0,
// ),
// child: Text(
// '~${pro.quotes[ind.index]['author']}',
// textAlign: TextAlign.center,
// style: const TextStyle(
// fontWeight:
// FontWeight.w400,
// fontSize: 14,
// color: Colors.white),
// ),
// ),
// const Spacer(),
// ]))
