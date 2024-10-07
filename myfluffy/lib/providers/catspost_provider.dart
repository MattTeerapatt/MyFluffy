import 'dart:io';

import 'package:flutter/foundation.dart'; // Import this for kIsWeb
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myfluffy/model/post.dart';

class CatspostProvider with ChangeNotifier {
  List<Post> _posts = [];
  List<Post> _filteredPosts = [];
  bool _isLoading = false;

  List<Post> get posts => _filteredPosts.isEmpty ? _posts : _filteredPosts;
  bool get isLoading => _isLoading;

  // Base URL switching based on platform
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

  // Fetch all posts
  Future<void> fetchAllPosts() async {
    _isLoading = true;
    notifyListeners();

    final baseUrl = _getBaseUrl();
    final response = await http.get(Uri.parse('$baseUrl/FetchAllPost'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<Post> allPosts = [];
      if (data.containsKey('post')) {
        data['post'].forEach((location, posts) {
          if (posts is List) {
            allPosts.addAll(posts.map((post) => Post(
              description: post['description'],
              found: post['found'],
              image: post['image'],
              location: location,
              ownerId: post['owner_id'],
              petName: post['pet_name'],
              postId: post['post_id'],
              reward: post['reward'],
            )));
          }
        });
      }

      _posts = allPosts;

      print('Fetched Posts:');
      for (var post in _posts) {
        print('Post ID: ${post.postId}, Image: ${post.image}');
      }
    } else {
      throw Exception('Failed to load posts');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Fetch posts by location
  Future<void> fetchPostsByLocation(String location) async {
    _isLoading = true;
    notifyListeners();

    final baseUrl = _getBaseUrl();
    final response = await http.get(Uri.parse('$baseUrl/FetchPostByLocation?location=$location'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('post') && data['post'].containsKey(location)) {
        final List<dynamic> posts = data['post'][location];
        _posts = posts.map((post) => Post(
          description: post['description'],
          found: post['found'],
          image: post['image'],
          location: post['location'],
          ownerId: post['owner_id'],
          petName: post['pet_name'],
          postId: post['post_id'],
          reward: post['reward'],
        )).toList();
        
        print('Fetched Posts for $location:');
        for (var post in _posts) {
          print('Post ID: ${post.postId}, Image: ${post.image}');
        }
      } else {
        throw Exception('No posts found for this location');
      }
    } else {
      throw Exception('Failed to load posts by location');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Search posts by location or pet name
  void searchPosts(String query) {
    if (query.isEmpty) {
      _filteredPosts = [];
    } else {
      _filteredPosts = _posts.where((post) =>
        post.location.toLowerCase().contains(query.toLowerCase()) ||
        post.petName.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

  // Sort posts by pet name
  void sortPosts() {
    _posts.sort((a, b) => a.petName.compareTo(b.petName));
    notifyListeners();
  }

  // Post a new cat post
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
      await fetchAllPosts(); // Refresh the list of posts
    } else {
      throw Exception('Failed to post new cat post');
    }

    _isLoading = false;
    notifyListeners();
  }
}
