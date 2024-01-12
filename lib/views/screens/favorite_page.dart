import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quetter/helper/fb_store_helper.dart';

import '../component/quote_tile.dart';
import '../modal/quate_modal.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Favorites',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0, -1.0),
                end: Alignment(0, 5),
                colors: [
              Color(0xFF273447),
              Color(0xFFB5A69F),
            ])),
        child: StreamBuilder(
          stream: FbStoreHelper.fbStoreHelper.fetchFavorites(),
          builder: (context, snapshot) {
            QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> myData =
                data?.docs ?? [];

            List<QuoteModal> quotes =
                myData.map((e) => QuoteModal.fromMAp(quote: e.data())).toList();

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
              ),
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                QuoteModal favorite = quotes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/QoutePreview', arguments: favorite);
                  },
                  child: QuotesTile(
                    index: index,
                    quote: favorite.quote,
                    author: favorite.author,
                    image: favorite.image,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
