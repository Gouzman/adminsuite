import 'landing_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const AdminsuiteLandingApp());
}

class AdminsuiteLandingApp extends StatelessWidget {
  const AdminsuiteLandingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseDark = ThemeData.dark();
    return MaterialApp(
      title: 'Adminsuite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.interTextTheme(baseDark.textTheme),
        scaffoldBackgroundColor: const Color(0xFF0B0D10),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
