import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myfluffy/model/ForumPreviewTile.dart';

class ForumViewSection extends StatefulWidget {
  const ForumViewSection({super.key});

  @override
  _ForumViewSectionState createState() => _ForumViewSectionState();
}

class _ForumViewSectionState extends State<ForumViewSection> {
  final ScrollController _scrollController = ScrollController(); // Scroll controller for ListView
  late Timer _timer; // Timer for auto-scrolling
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();

    // Start the timer to auto-scroll every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        
        if (_scrollPosition < maxScrollExtent) {
          _scrollPosition += 200.0; // Adjust the scrolling distance
        } else {
          _scrollPosition = 0.0; // Scroll back to the start
        }

        _scrollController.animateTo(
          _scrollPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Adjust the height as needed
      child: ListView(
        controller: _scrollController, // Attach the ScrollController
        scrollDirection: Axis.horizontal, // Scroll horizontally
        children: <Widget>[
          Forumpreviewtile(
            image: Image.asset('lib/assets/kitty1.jpeg', width: 200, height: 100, fit: BoxFit.cover),
          ),
          Forumpreviewtile(
            image: Image.asset('lib/assets/kitty2.jpg', width: 200, height: 100, fit: BoxFit.cover),
          ),
          Forumpreviewtile(
            image: Image.asset('lib/assets/kitty3.jpg', width: 200, height: 100, fit: BoxFit.cover),
          ),
          Forumpreviewtile(
            image: Image.asset('lib/assets/kitty4.jpg', width: 200, height: 100, fit: BoxFit.cover),
          ),
          Forumpreviewtile(
            image: Image.asset('lib/assets/kitty5.jpg', width: 200, height: 100, fit: BoxFit.cover),
          ),
          // Add more images as needed
        ],
      ),
    );
  }
}
