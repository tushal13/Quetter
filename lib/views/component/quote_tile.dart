import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quetter/controller/pixa_controller.dart';

class QuotesTile extends StatelessWidget {
  int index = 0;
  final String? quote;
  final String? author;
  final String? image;
  final double? pading;

  QuotesTile(
      {required this.index,
      required this.quote,
      required this.image,
      required this.author,
      this.pading});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pading ?? 16.0),
      child: Container(
        height: size.height * 0.245,
        width: size.width * 0.5,
        decoration: BoxDecoration(
          color: Provider.of<PixaController>(context, listen: false)
                  .dominantColor
                  ?.withOpacity(0.5) ??
              const Color(0xFF273447),
          image: DecorationImage(
              image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/qutter-eeb9f.appspot.com/o/${Uri.encodeComponent(image ?? '')}?alt=media',
              ),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(24),
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
                  quote ?? '',
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
                  author ?? '',
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
      ),
    );
  }
}
