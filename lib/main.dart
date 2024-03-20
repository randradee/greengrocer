import 'package:flutter/material.dart';
import 'package:greengrocer/src/auth/sign_in_screen.dart';

void main() {
  runApp(const Greengrocer());
}

class Greengrocer extends StatelessWidget {
  const Greengrocer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}
