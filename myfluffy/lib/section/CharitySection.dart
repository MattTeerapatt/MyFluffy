import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myfluffy/model/CharityTile.dart';

class CharitySection extends StatefulWidget {
  const CharitySection({super.key});

  @override
  _CharitySectionState createState() => _CharitySectionState();
}

class _CharitySectionState extends State<CharitySection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Start the timer to change the page every 7 seconds
    _timer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      if (_currentPage < 5) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      // Animate to the next page
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Charitytile(imagePath: 'lib/assets/charity.jpg'),
          Charitytile(imagePath: 'lib/assets/charity.jpg'),
          Charitytile(imagePath: 'lib/assets/charity.jpg'),
          Charitytile(imagePath: 'lib/assets/charity.jpg'),
          Charitytile(imagePath: 'lib/assets/charity.jpg'),
          Charitytile(imagePath: 'lib/assets/charity.jpg'),


        ],
      ),
    );
  }
}
