import 'package:flutter/material.dart';
import 'package:myfluffy/providers/catspost_provider.dart';
import 'package:myfluffy/screen/ToggleScreen.dart';
import 'package:provider/provider.dart';
import 'package:myfluffy/providers/userinfo_provider.dart'; // Import your provider
import 'package:myfluffy/model/user.dart'; // Import your user model

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    _fetchCurrentUser(); // Call the fetch function when the screen initializes
  }

  Future<void> _fetchCurrentUser() async {
    final userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    final catspostProvider = Provider.of<CatspostProvider>(context, listen: false);

    try {
      // Fetch all the posts
      await catspostProvider.fetchAllPosts();
      // get the first post
      final post = catspostProvider.posts.first;
      print('First post: ${post.postId}, ${post.ownerId}');
      // Fetch user data by ID
      await userInfoProvider.fetchUserById(post.ownerId);
      // Set the fetched user as the current user
      userInfoProvider.setCurrentUser(userInfoProvider.user!);

      // Navigate to the ToggleScreen after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Togglescreen()),
        );
      });
    } catch (e) {
      // Handle errors (e.g., show an error message)
      print('Error fetching user: $e');
      // You might want to show a message or stay on the landing screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('lib/assets/cat.png'),
              width: 250,
              height: 250,
            ),
            SizedBox(height: 10),
            Text(
              "Where's MyFluffy",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
