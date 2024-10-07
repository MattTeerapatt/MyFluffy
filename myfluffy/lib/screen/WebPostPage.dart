// Conditional imports for platform-specific code
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:myfluffy/utility/TextInputField.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:myfluffy/model/post.dart'; // Ensure your Post model is imported
import 'package:myfluffy/providers/userinfo_provider.dart'; // Import UserInfoProvider

// Import platform-specific file
import 'package:myfluffy/utility/web_specific.dart' 
    if (dart.library.io) 'package:myfluffy/utility/mobile_specific.dart';

class WebPostPage extends StatefulWidget {
  const WebPostPage({super.key});

  @override
  _WebPostPageState createState() => _WebPostPageState();
}

class _WebPostPageState extends State<WebPostPage> {
  Uint8List? _imageData; // Use Uint8List to store the image data
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _rewardController = TextEditingController();

  // Method to pick an image using the platform-specific implementation
  void _pickImage() {
    pickImage((Uint8List imageData) {
      setState(() {
        _imageData = imageData; // Set image data
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Set initial values for controllers if needed
    _nameController.text = ''; // Set your desired initial value here
    _descriptionController.text = ''; // For other controllers
    _locationController.text = '';
    _rewardController.text = '';
  }
  
  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _rewardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Post', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF7B3FF4),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Handle back navigation
          },
        ),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text(
                'Photo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // GestureDetector to pick image from file input
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: _imageData == null
                        ? const Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.black54,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.memory(
                              _imageData!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    TextInputField(
                      label: 'Name',
                      placeholder: 'Enter name',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 24),
                    TextInputField(
                      label: 'Description',
                      placeholder: 'Enter description',
                      controller: _descriptionController,
                    ),
                    const SizedBox(height: 24),
                    TextInputField(
                      label: 'Location',
                      placeholder: 'Enter location',
                      controller: _locationController,
                    ),
                    const SizedBox(height: 24),
                    TextInputField(
                      label: 'Reward',
                      placeholder: 'Enter reward',
                      controller: _rewardController,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 20,
                    ),
                    backgroundColor: Colors.grey[400], // Post button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    // Handle post button action
                    String petName = _nameController.text;
                    String description = _descriptionController.text;
                    String location = _locationController.text;
                    String reward = _rewardController.text !='' ? _rewardController.text : 'No specified reward';
                    bool found = false; // Set this based on your logic
                    
                    // Create the Post object
                    Post newPost = Post(
                      postId: "No Need to Set this", // This will be set by the server
                      petName: petName,
                      description: description,
                      location: location,
                      reward: reward,
                      found: found,
                      image: _imageData != null ? base64Encode(_imageData!) : null, // Convert image data to base64 if needed
                      // set ownerId to the current user's id
                      ownerId: Provider.of<UserInfoProvider>(context, listen: false).currentUser!.userId,
                    );

                    // Call the postNewCatPost method in UserInfoProvider
                    final userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
                    try {
                      print('call posting new cat post...');
                      await userInfoProvider.postNewCatPost(newPost);
                      print('new cat post created successfully!');
                      // Optionally, show a success message or navigate back
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Post created successfully!')),
                      );
                      Navigator.pop(context); // Navigate back after posting
                    } catch (error) {
                      // Handle errors (e.g., show an error message)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error posting new cat post: $error')),
                      );
                    }
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
