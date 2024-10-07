import 'dart:convert';
import 'dart:typed_data'; // Import the required package for Uint8List
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:myfluffy/model/post.dart';
import 'package:myfluffy/providers/userinfo_provider.dart'; // Adjust the import based on your file structure

class CatDetailPage extends StatelessWidget {
  final Post post; // Store the passed Post object

  const CatDetailPage({super.key, required this.post}); // Constructor that takes a Post object

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
    return Scaffold(
      appBar: AppBar(
        title: Text(post.petName), // Use the pet name from the Post object
        backgroundColor: Colors.yellow[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Text(
              post.petName, // Display the pet name
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              post.description, // Display the description from the Post object
              style: const TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${post.petName}', // Display the pet name
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Last Seen: ${post.location}', // Display the location from the Post object
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Reward: \$${post.reward}', // Display the reward amount
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final userinfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
                
                // Fetch user data using the UserinfoProvider
                await userinfoProvider.fetchUserById(post.ownerId); // Assuming post.ownerId is the user ID

                // Show the dialog with the user information
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final user = userinfoProvider.user; // Get the fetched user
                    return AlertDialog(
                      title: const Text('Owner Information'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: user != null
                            ? [
                                Text('Name: ${user.name}'),
                                Text('Email: ${user.email}'),
                                Text('Phone: ${user.phone}'),
                                Text('Location: ${user.location}'),
                                Text('Bank Account: ${user.bankAccount}'),
                              ]
                            : const [Text('User not found')],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); 
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Contact Owner'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
