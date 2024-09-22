import 'package:flutter/material.dart';
import 'package:myfluffy/screen/LandingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: LandingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

