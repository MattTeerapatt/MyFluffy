import 'dart:async';
import 'package:flutter/material.dart';

class CharitySection extends StatefulWidget {
  const CharitySection({Key? key}) : super(key: key);

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

    // Start the timer to change the page every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
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
          _buildCharityTile('Charity Section'),
          _buildCharityTile('Charity 1'),
          _buildCharityTile('Charity 2'),
          _buildCharityTile('Charity 3'),
          _buildCharityTile('Charity 4'),
          _buildCharityTile('Charity 5'),
        ],
      ),
    );
  }

  // Helper method to create charity tiles
  Widget _buildCharityTile(String title) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 150, // Adjust width
      child: Card(
        child: Center(
          child: ListTile(
            title: Text(title),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: CharitySection(),
    ),
  ));
}
