import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quetter/controller/index_controller.dart';
import 'package:quetter/controller/user_controller.dart';
import 'package:quetter/views/screens/home_page.dart';
import 'package:quetter/views/screens/intro_page1.dart';
import 'package:quetter/views/screens/qoute_priview.dart';

import 'controller/db_controller.dart';
import 'controller/pixa_controller.dart';
import 'controller/quet_controller.dart';
import 'firebase_options.dart';
import 'helper/ad_helper.dart';
import 'helper/db_helper.dart';
import 'helper/fb_auth_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AdHelper.adHelper.initializeAd();
  await DBHelper.dbHelper.initDb();

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
          create: (context) => DbController(),
        ),
        ChangeNotifierProvider(
          create: (context) => IndexController(),
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
      title: 'Quetter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          background: const Color(0xFF273447),
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white),
        textTheme: GoogleFonts.cabinCondensedTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          // titleTextStyle: TextStyle(
          //     color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        useMaterial3: true,
      ),
      initialRoute: FBAuthHelper.fbAuthHelper.auth.currentUser != null
          ? '/'
          : '/FirstPage',
      routes: {
        '/': (context) => HomePage(),
        '/FirstPage': (context) => FintroPage(),
        '/QoutePreview': (context) => QoutePreview(),
      },
    );
  }
}
