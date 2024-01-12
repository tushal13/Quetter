import 'package:flutter/material.dart';
import 'package:quetter/views/modal/quate_modal.dart';

class QoutePreview extends StatelessWidget {
  QoutePreview({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    QuoteModal quoteModal =
        ModalRoute.of(context)!.settings.arguments as QuoteModal;
    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/qutter-eeb9f.appspot.com/o/${Uri.encodeComponent(quoteModal.image ?? '')}?alt=media',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset('assets/images/qutter_logo.png', height: 60),
                const SizedBox(
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Text(quoteModal.quote ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                  ),
                  child: Text(
                    '~${quoteModal.author ?? ''}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
                const Spacer(),
              ])),
    );
  }
}
