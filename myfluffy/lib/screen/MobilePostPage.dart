import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data'; // Import Uint8List
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:myfluffy/utility/TextInputField.dart';
import 'package:myfluffy/model/post.dart';
import 'package:myfluffy/providers/userinfo_provider.dart';

class MobilePostPage extends StatefulWidget {
  const MobilePostPage({super.key});

  @override
  _MobilePostPageState createState() => _MobilePostPageState();
}

class _MobilePostPageState extends State<MobilePostPage> {
  Uint8List? _imageData; // Store image data

  // Controllers for the input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _rewardController = TextEditingController();

  // Method to pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      setState(() {
        _imageData = bytes;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _rewardController.dispose();
    super.dispose();
  }

  Future<void> _submitPost(UserInfoProvider userInfoProvider) async {
    // Create a new Post object using the input field values and image data
    final post = Post(
      postId: "This value arn't used",
      petName: _nameController.text,
      description: _descriptionController.text,
      location: _locationController.text,
      reward: _rewardController.text,
      image: _imageData != null ? base64Encode(_imageData!) : '',
      ownerId: userInfoProvider.currentUser!.userId, // Ensure userInfoProvider holds current user info
      found: false, // Assuming 'found' is initially false
    );

    try {
      await userInfoProvider.postNewCatPost(post);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post created successfully')),
      );
      // Clear form after successful submission
      _nameController.clear();
      _descriptionController.clear();
      _locationController.clear();
      _rewardController.clear();
      setState(() {
        _imageData = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create post')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Post', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF7B3FF4),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
              Center(
                child: GestureDetector(
                  onTap: () => _showImagePickerDialog(context),
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
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () => _submitPost(userInfoProvider),
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

  // Show a dialog to pick from camera or gallery
  void _showImagePickerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
