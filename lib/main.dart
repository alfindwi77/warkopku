import 'package:flutter/material.dart';

import 'screens/table_qr_page.dart';

void main() {
  runApp(const WarkopKuApp());
}

class WarkopKuApp extends StatelessWidget {
  const WarkopKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WarkopKu',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF8F0),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6F4E37)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6F4E37),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const TableQrPage(),
    );
  }
}
