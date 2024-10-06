import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myfluffy/model/user.dart';


class UserInfoProvider with ChangeNotifier {
  User? _user;
  User? _currentUser;
  bool _isLoading = false;

  User? get user => _user;
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  // Fetch user data by ID
  Future<void> fetchUserById(String id) async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('http://localhost:5000/FetchUserById/$id'));

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

  // set current user
  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}