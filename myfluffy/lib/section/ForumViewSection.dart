import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myfluffy/model/ForumPreviewTile.dart';
import 'package:provider/provider.dart';
import 'package:myfluffy/providers/catspost_provider.dart';

class ForumViewSection extends StatefulWidget {
  const ForumViewSection({Key? key}) : super(key: key);

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
    // Fetch posts when the widget is initialized
    Future.microtask(() {
      Provider.of<CatspostProvider>(context, listen: false).fetchAllPosts();
    });

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

  // Method to refresh the content
  void _refreshContent() {
    // Call the provider's fetchAllPosts method to refresh posts
    Provider.of<CatspostProvider>(context, listen: false).fetchAllPosts();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Content refreshed!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 150, // Adjust the height as needed
          child: Consumer<CatspostProvider>(
            builder: (context, provider, child) {
              // Display loading indicator if data is being fetched
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              // If fetch fails, you can show an error message or an empty state here

              return ListView(
                controller: _scrollController, // Attach the ScrollController
                scrollDirection: Axis.horizontal, // Scroll horizontally
                children: provider.posts.map((post) {
                  return Forumpreviewtile(
                    // Pass the image URL and binary data to Forumpreviewtile
                    imageUrl: post.image, // Use this to fetch the image from network
                    imageData: post.image != null ? base64Decode(post.image!) : null, // Decode binary data if available
                  );
                }).toList(),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            onPressed: _refreshContent, // Call the refresh method
            child: const Icon(Icons.refresh), // Refresh icon
          ),
        ),
      ],
    );
  }
}
