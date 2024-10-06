import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myfluffy/model/post.dart';

class CatspostProvider with ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  // Fetch all posts
  Future<void> fetchAllPosts() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('http://localhost:5000/FetchAllPost'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Access the 'post' field and extract all posts
      List<Post> allPosts = [];
      if (data.containsKey('post')) {
        data['post'].forEach((location, posts) {
          // Check if posts is a List
          if (posts is List) {
            allPosts.addAll(posts.map((post) => Post(
              description: post['description'],
              found: post['found'],
              image: post['image'],
              location: location, // Set the location from the key
              ownerId: post['owner_id'],
              petName: post['pet_name'],
              postId: post['post_id'],
              reward: post['reward'],
            )));
          }
        });
      }

      _posts = allPosts;

      // Debugging output
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

    final response = await http.get(Uri.parse('http://localhost:5000/FetchPostByLocation?location=$location'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Ensure we are looking for the specific location's posts
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
        
        // Debugging output
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

  // Post a new cat post
  Future<void> postNewCatPost(Post post) async {
    _isLoading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse('http://localhost:5000/PostPostings'),
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
