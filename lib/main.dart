import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/theme/manga_theme.dart';
import 'presentation/pages/home_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  await Hive.openBox("favorites");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "Manga Reader",

      theme: MangaTheme.darkTheme.copyWith(

        /// ⭐ FIX ICON Flutter Web
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        /// ⭐ สำคัญมาก
        // ignore: deprecated_member_use
        useMaterial3: false,

      ),

      home: const HomePage(),
    );
  }
}