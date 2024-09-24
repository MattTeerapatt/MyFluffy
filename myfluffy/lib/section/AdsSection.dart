import 'package:flutter/material.dart';
import 'dart:async';


class AdsSection extends StatefulWidget {
  const AdsSection({super.key});

  @override
  State<AdsSection> createState() => _AdsSectionState();
}

class _AdsSectionState extends State<AdsSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Start the timer to change the page every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 9), (Timer timer) {
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
  void dispose(){
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
          _buildAdsTile('Ads Section'),
          _buildAdsTile('Ads 1'),
          _buildAdsTile('Ads 2'),
          _buildAdsTile('Ads 3'),
          _buildAdsTile('Ads 4'),
          _buildAdsTile('Ads 5'),
        ],
      ),
    );
  }

  Widget _buildAdsTile(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 150, // Adjust width
      child: Card(
        child: Center(
          child: ListTile(
            title: Text(text),
          ),
        ),
      ),
    );
  }
  }

  void main() {
    runApp(const MaterialApp(
      home: Scaffold(
        body: AdsSection(),
      ),
    ));
  }
