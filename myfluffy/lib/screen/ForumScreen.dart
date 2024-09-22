import 'package:flutter/material.dart';

class Forumscreen extends StatefulWidget {
  const Forumscreen({super.key});

  @override
  State<Forumscreen> createState() => _ForumscreenState();
}

class _ForumscreenState extends State<Forumscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Forum"),
      ),
      body: Container(
        child: Text("ForumScreen"),
      ),
    );
  }
}