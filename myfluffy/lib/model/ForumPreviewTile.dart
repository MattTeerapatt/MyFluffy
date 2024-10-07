import 'package:flutter/material.dart';

class Forumpreviewtile extends StatelessWidget {
  final Image image;  // Image object to display

  Forumpreviewtile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Spacing between tiles
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
            child: Container(
              width: 150,  // Adjust the width of the tile
              height: 142, // Adjust the height of the tile
              child: image, // Display the image
            ),
          ),
          const SizedBox(height: 8), // Space between image and text
        ],
      ),
    );
  }
}
