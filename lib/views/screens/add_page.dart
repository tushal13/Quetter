import 'package:flutter/material.dart';
import 'package:quetter/helper/fb_store_helper.dart';

class AddQuotePage extends StatelessWidget {
  AddQuotePage({super.key});

  TextEditingController quoteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Quote",
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Dreams are whispers that the heart hears when it listens.',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF5E6C85),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.010),
              Container(
                height: 40,
                width: size.width * 0.9,
                child: TextFormField(
                  controller: quoteController,
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      fontSize: 18),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    hintText: 'Add Your Quote',
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  await FbStoreHelper.fbStoreHelper.addQuote(
                    quote: quoteController.text,
                  );
                  quoteController.clear();
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: size.width * 0.5,
                  height: size.height * 0.05,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Save',
                        style: TextStyle(
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF36455A),
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.010),
            ],
          ),
        ),
      ),
    );
  }
}
