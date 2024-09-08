import 'package:flutter/material.dart';

import 'navigation/bottom_nav.dart';
import 'screens/login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediScanAI',
      initialRoute: '/login', // L'écran de connexion est le premier affiché
      routes: {
        '/login': (context) => const LoginScreen(),
        '/bottomNav': (context) => const BottomNav(),
      },
    );
  }
}
