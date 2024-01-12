import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quetter/helper/fb_store_helper.dart';
import 'package:share_extend/share_extend.dart';

import '../modal/quate_modal.dart';

class PastQuote extends StatelessWidget {
  PastQuote({super.key});
  QuoteModal quoteModal = QuoteModal.init();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recent Quotes",
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
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FbStoreHelper.fbStoreHelper.fetchHistory(),
              builder: (context, snapshot) {
                QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
                List<QueryDocumentSnapshot<Map<String, dynamic>>> myData =
                    data?.docs ?? [];

                List<QuoteModal> past = myData
                    .map((e) => QuoteModal.fromMAp(quote: e.data()))
                    .toList();

                return ListView.builder(
                  itemCount: past.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: size.height * 0.3,
                        width: size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment(-1 + index * 0.3, 0.0),
                              end: const Alignment(0, -5),
                              colors: [
                                const Color(0xFF536C8F),
                                const Color(0xFFAB806B),
                              ]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Spacer(),
                            Image.asset(
                              'assets/images/qutter_logo.png',
                              height: size.height * 0.05,
                            ),
                            const Spacer(),
                            Text(
                              past[index].quote ?? '',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Divider(
                              color: Color(0xFF273447),
                              thickness: 2,
                            ),
                            Container(
                              child: Row(children: [
                                Flexible(
                                  child: Text('~ ${past[index].author}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      )),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    String t = '${past[index].quote ?? ''}';

                                    Clipboard.setData(ClipboardData(text: t));
                                  },
                                  icon: const Icon(
                                    FluentIcons.copy_select_24_regular,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    String t =
                                        '${past[index].quote ?? ''} \n by\n ~ ${past[index].author ?? ''}';

                                    ShareExtend.share(
                                      t,
                                      "text",
                                    );
                                  },
                                  icon: const Icon(
                                    FluentIcons.share_28_regular,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                StreamBuilder(
                                    stream: FbStoreHelper.fbStoreHelper
                                        .fetchFavorites(),
                                    builder: (context, snap) {
                                      QuerySnapshot<Map<String, dynamic>>?
                                          data = snap.data;
                                      List<
                                              QueryDocumentSnapshot<
                                                  Map<String, dynamic>>>
                                          myData = data?.docs ?? [];

                                      List<QuoteModal> preferredQuotes = myData
                                          .map((e) => QuoteModal.fromMAp(
                                              quote: e.data()))
                                          .toList();
                                      return IconButton(
                                          onPressed: () async {
                                            quoteModal.id = past[index].id;

                                            quoteModal.quote =
                                                past[index].quote;

                                            quoteModal.author =
                                                past[index].author;

                                            quoteModal.category =
                                                past[index].category;

                                            quoteModal.image =
                                                past[index].image;

                                            await FbStoreHelper.fbStoreHelper
                                                .addFavorite(quote: quoteModal)
                                                .then((value) => ScaffoldMessenger
                                                        .of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: const Text(
                                                          'Favorite added ❤️',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        dismissDirection:
                                                            DismissDirection
                                                                .startToEnd,
                                                        elevation: 2,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        duration:
                                                            const Duration(
                                                                seconds: 1),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                        width: size.width * 0.8,
                                                        backgroundColor:
                                                            Colors.black,
                                                        action: SnackBarAction(
                                                          label: 'view',
                                                          onPressed: () {},
                                                        ))));
                                          },
                                          icon: const Icon(
                                            FluentIcons.heart_28_regular,
                                            size: 25,
                                            color: Colors.white,
                                          ));
                                    }),
                              ]),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
