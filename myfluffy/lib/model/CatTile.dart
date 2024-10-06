import 'dart:convert';
import 'dart:typed_data'; // Import the required package for Uint8List
import 'package:flutter/material.dart';
import 'package:myfluffy/model/post.dart';

class CatTile extends StatelessWidget {
  final Post post; // Store the passed Post object

  const CatTile({super.key, required this.post}); // Constructor that takes a Post object

  Future<Image> _loadImage() async {
    // Check if the post has an image
    if (post.image != null && post.image!.isNotEmpty) {
      // Decode the base64 string to binary data
      final Uint8List imageData = base64Decode(post.image!);
      return Image.memory(imageData); // Create an Image from the binary data
    }
    // If no image is available, load the default image
    return Image.asset('lib/assets/cat.png'); // Default image
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Use FutureBuilder to load the image asynchronously
          FutureBuilder<Image>(
            future: _loadImage(),
            builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show loading indicator while the image is being loaded
              } else if (snapshot.hasError) {
                return const Text('Error loading image'); // Error handling
              } else {
                return SizedBox(
                  height: 100, // Set a fixed height for the image
                  width: 100, // Set a fixed width for the image
                  child: snapshot.data, // Display the loaded image
                );
              }
            },
          ),
          const SizedBox(height: 10),
          Text(
            post.petName, // Display the pet name from the Post object
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Last Seen: ${post.location}', // Display the last seen location
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Text(
            'Reward: \$${post.reward}', // Display the reward amount
            style: const TextStyle(fontSize: 14, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
