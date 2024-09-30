import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myfluffy/model/ForumPreviewTile.dart';

class ForumViewSection extends StatefulWidget {
  const ForumViewSection({Key? key}) : super(key: key);

  @override
  _ForumViewSectionState createState() => _ForumViewSectionState();
}

class _ForumViewSectionState extends State<ForumViewSection> {
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
    child: Container(
      color: Colors.white, // Set the background color to white
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Forumpreviewtile(title: 'Diddy', image: Image(image: AssetImage('lib/assets/kitty1.jpeg'), width: 150, height: 150)),
          Forumpreviewtile(title: 'Johnson', image: Image(image: AssetImage('lib/assets/kitty2.jpg'), width: 150, height: 150)),
        ],
      ),
    ),
  );
  }

 
}



