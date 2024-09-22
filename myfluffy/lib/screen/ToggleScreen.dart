import 'package:flutter/material.dart';
import 'package:myfluffy/screen/ForumScreen.dart';
import 'package:myfluffy/screen/HomeScreen.dart';
import 'package:myfluffy/screen/LandingScreen.dart';
import 'package:myfluffy/screen/SettingScreen.dart';
import 'package:myfluffy/section/%E0%B8%BABottomNavBar.dart';

class Togglescreen extends StatefulWidget {
  const Togglescreen({super.key});

  @override
  State<Togglescreen> createState() => _TogglescreenState();
}

class _TogglescreenState extends State<Togglescreen> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [

    const HomeScreen(),
    const Forumscreen(),
    const Settingscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      
      body: _pages[_selectedIndex],
      );
  }
}
