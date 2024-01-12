import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/db_controller.dart';
import '../component/quote_tile.dart';

class DwonloadPage extends StatelessWidget {
  const DwonloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Downloaded Quotes',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0, -1.0),
                end: Alignment(0, 5),
                colors: [
              Color(0xFF273447),
              Color(0xFFB5A69F),
            ])),
        child: Consumer<DbController>(builder: (context, pro, child) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
            ),
            itemCount: pro.dwonlods.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: QuotesTile(
                    index: index,
                    quote: pro.dwonlods[index].quote,
                    author: pro.dwonlods[index].author,
                    image: '${pro.dwonlods[index].image}'),
              );
            },
          );
        }),
      ),
    );
  }
}
