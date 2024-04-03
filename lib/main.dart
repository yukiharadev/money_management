import 'package:flutter/material.dart';
import 'package:money_lover/screens/onboarding_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OnboardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

