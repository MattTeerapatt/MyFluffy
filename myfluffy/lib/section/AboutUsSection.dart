import 'package:flutter/material.dart';

class Aboutussection extends StatelessWidget {
  const Aboutussection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 300, 
        height: 300, 
        child: Image.asset(
          'lib/assets/aboutus.png', 
          fit: BoxFit.cover, 
        ),
      ),
    );
  }
}
