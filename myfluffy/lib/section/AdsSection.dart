import 'package:flutter/material.dart';
import 'dart:async';

import 'package:myfluffy/model/AdsTile.dart';


class AdsSection extends StatefulWidget {
  const AdsSection({super.key});

  @override
  State<AdsSection> createState() => _AdsSectionState();
}

class _AdsSectionState extends State<AdsSection> {
  PageController? _pageController;
  int _currentPage = 0;
  late Timer _timer;

  static const int numAds = 6;
  static const int timerDurationSeconds = 9;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: timerDurationSeconds), (Timer timer) {
      if (!mounted) return;

      setState(() {
        _currentPage = (_currentPage + 1) % numAds;
      });

      _pageController?.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          numAds,
          (index) => AdsTile(text: 'Ads $index'), // Use AdsTile here
        ),
      ),
    );
  }
}

