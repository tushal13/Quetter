import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quetter/helper/fbs_helper.dart';

import '../../helper/fb_store_helper.dart';

class BackgroundTile extends StatelessWidget {
  final String? name;
  final List? list;

  BackgroundTile({
    required this.name,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('$name',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20))),
        list!.isNotEmpty
            ? Container(
                height: size.height * 0.35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: list!.length,
                    itemBuilder: (context, index) {
                      int random = Random().nextInt(list!.length);
                      return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FBSHelper.fbsHelper.fetchPurchesed(),
                          builder: (context, snap) {
                            List background =
                                snap.data?.data()?['images'] ?? [];
                            return Container(
                              margin: const EdgeInsets.only(
                                  right: 10, top: 10, bottom: 10),
                              width: size.width * 0.35,
                              child: StreamBuilder<
                                      DocumentSnapshot<Map<String, dynamic>>>(
                                  stream:
                                      FbStoreHelper.fbStoreHelper.fetchCoins(),
                                  builder: (context, snapshot) {
                                    int coins =
                                        snapshot.data?.data()?['Coins'] ?? 0;
                                    return GestureDetector(
                                      onLongPress: () async {
                                        if (coins >= 10) {
                                          if (background.length == 0) {
                                            await FBSHelper.fbsHelper
                                                .addPurchased(
                                                    imageUrl: list![random]
                                                        ['largeImageURL']);
                                            await FbStoreHelper.fbStoreHelper
                                                .decrementCoins(coins: 10);
                                          }
                                          await FBSHelper.fbsHelper
                                              .updatePurchesed(
                                                  imageUrl: list![random]
                                                      ['largeImageURL']);

                                          await FbStoreHelper.fbStoreHelper
                                              .decrementCoins(coins: 10);
                                          AwesomeDialog(
                                            context: context,
                                            autoHide:
                                                const Duration(seconds: 2),
                                            dialogType: DialogType.success,
                                            animType: AnimType.scale,
                                            title: 'Success',
                                            body: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: Container(
                                                      width: size.width * 0.35,
                                                      child: Image.network(
                                                        '${list![random]['largeImageURL']}',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  const Text(
                                                      'Background Added'),
                                                ],
                                              ),
                                            ),
                                          ).show();
                                        } else if (coins <= 10) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                              'You need 10 coins to unlock this image',
                                            ),
                                          ));
                                        }
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/background.png',
                                          placeholderFit: BoxFit.cover,
                                          image: list![random]['largeImageURL'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          });
                    }))
            : Container(),
      ],
    );
  }
}
