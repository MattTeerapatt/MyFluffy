import 'dart:typed_data'; // Required for Uint8List
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for rootBundle

class Forumpreviewtile extends StatelessWidget {
  final String? imageUrl;  // Image URL from the post (nullable)
  final Uint8List? imageData; // Binary image data (nullable)

  Forumpreviewtile({super.key, this.imageUrl, this.imageData});

  Future<Image> _loadImage() async {
    // If imageData is not null, create an Image from the binary data
    if (imageData != null) {
      return Image.memory(imageData!);
    }

    // If imageData is null, load the default image
    return Image.asset('lib/assets/cat.png'); // Default image
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Image>(
      future: _loadImage(), // Load the image asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator while loading
        }

        if (snapshot.hasError) {
          return const Icon(Icons.error); // Show error icon if there's an error
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), // Spacing between tiles
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
                child: Container(
                  width: 150,  // Adjust the width of the tile
                  height: 142, // Adjust the height of the tile
                  child: snapshot.data!, // Display the loaded image
                ),
              ),
              const SizedBox(height: 8), // Space between image and text
            ],
          ),
        );
      },
    );
  }
}
