import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quetter/controller/user_controller.dart';
import 'package:quetter/helper/ad_helper.dart';
import 'package:quetter/views/screens/background_page.dart';
import 'package:quetter/views/screens/home_page.dart';

import 'controller/button_controller.dart';
import 'controller/pixa_controller.dart';
import 'controller/quet_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AdHelper.adHelper.initializeAd();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuoteCntroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => PixaController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ButtonController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'quetter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          background: const Color(0xFF273447),
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/bg': (context) => const BackgroundPage(),
      },
    );
  }
}
