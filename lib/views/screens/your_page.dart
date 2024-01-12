import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quetter/views/modal/yquate_modal.dart';
import 'package:share_extend/share_extend.dart';

import '../../helper/fb_store_helper.dart';

class YourQuotes extends StatelessWidget {
  const YourQuotes({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Quotes",
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
          child: StreamBuilder(
              stream: FbStoreHelper.fbStoreHelper.fetchyourQuotes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> myData =
                      data?.docs ?? [];

                  List<YourModal> quotes = myData
                      .map((e) => YourModal.fromMap(quote: e.data()))
                      .toList();

                  return ListView.builder(
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: size.height * 0.25,
                          width: size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: const Alignment(-1, 0.0),
                                end: Alignment(0, -5 + index * 0.3),
                                colors: const [
                                  Color(0xFF536C8F),
                                  Color(0xFFAB806B),
                                ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Image.asset(
                                'assets/images/qutter_logo.png',
                                height: size.height * 0.05,
                              ),
                              const Spacer(),
                              Text(
                                quotes[index].quote ?? "",
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
                              Row(children: [
                                Text('~ ${quotes[index].author ?? ""}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    )),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    String t = '${quotes[index].quote ?? ""}';

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
                                        '${quotes[index].quote ?? ""} \n by\n ~ ${quotes[index].author ?? "" ?? ''}';

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
                              ])
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
