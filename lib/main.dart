import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/splash/splash_screen.dart';

void main() {
  runApp(const Greengrocer());
}

class Greengrocer extends StatelessWidget {
  const Greengrocer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greengrocer',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white.withAlpha(190)),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
