import 'dart:io';

import 'package:flutter/foundation.dart'; // Import this to use kIsWeb
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myfluffy/model/post.dart';
import 'dart:convert';
import 'package:myfluffy/model/user.dart';

class UserInfoProvider with ChangeNotifier {
  User? _user;
  User? _currentUser;
  bool _isLoading = false;

  User? get user => _user;
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  String _getBaseUrl() {
      if (kIsWeb) {
        return 'http://localhost:5000'; // Use localhost for web
      } else if (Platform.isAndroid) {
        return 'http://10.0.2.2:5000'; // Use 10.0.2.2 for Android emulator
      } else if (Platform.isIOS) {
        return 'http://127.0.0.1:5000'; // Use 127.0.0.1 for iOS simulator
      } else {
        return 'http://localhost:5000'; // Default to localhost for any other platform
      }
    }

  // Fetch user data by ID
  Future<void> fetchUserById(String id) async {
    _isLoading = true;
    notifyListeners();

    // Determine the base URL depending on the platform

    final baseUrl = _getBaseUrl();
    final response = await http.get(Uri.parse('$baseUrl/FetchUserById/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'success' && data.containsKey('user')) {
        final userData = data['user'];
        _user = User(
          bankAccount: userData['Bankaccount'],
          email: userData['email'],
          location: userData['location'],
          name: userData['name'],
          password: userData['password'], // Ensure not to expose this sensitive data
          phone: userData['phone'],
          userId: userData['user_id'],
        );

        // Debugging output
        print('Fetched User: ${_user!.name}, Email: ${_user!.email}');
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('Failed to load user data');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> postNewCatPost(Post post) async {
      _isLoading = true;
      notifyListeners();

      final baseUrl = _getBaseUrl();
      final response = await http.post(
        Uri.parse('$baseUrl/PostPostings'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'description': post.description,
          'found': post.found,
          'image': post.image,
          'location': post.location,
          'owner_id': post.ownerId,
          'pet_name': post.petName,
          'reward': post.reward,
        }),
      );

      if (response.statusCode == 200) {
        // If you want to refresh the posts after posting, you can add a method from CatspostProvider here
        // For example, you could pass CatspostProvider instance and call fetchAllPosts()
      } else {
        throw Exception('Failed to post new cat post');
      }

      _isLoading = false;
      notifyListeners();
  }

  // Set current user
  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}
