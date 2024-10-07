import 'package:flutter/material.dart';
import 'package:myfluffy/screen/FindPage.dart';
import 'package:myfluffy/section/AboutUsSection.dart';
import 'package:myfluffy/section/AdsSection.dart';
import 'package:myfluffy/section/CharitySection.dart';
import 'package:myfluffy/section/ForumViewSection.dart';
import 'package:myfluffy/section/NearMeSection.dart';
import 'package:myfluffy/screen/PostPage.dart';
import 'package:myfluffy/screen/ProfilePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: const Text(
            'MyFluffy',
            style: TextStyle(
                color: Color(0xFF330295),
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color(0xFFFFFFFF),
        width: 200,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image.asset(
                  'lib/assets/cat.png',
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
                  color: Color(0xFF330295),
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: const Icon(Icons.person, color: Color(0xFF330295)),
                title: const Text(
                  'Profile',
                  style: TextStyle(color: Color(0xFF330295)),
                ),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.post_add, color: Color(0xFF330295)),
                title: const Text(
                  'Post',
                  style: TextStyle(color: Color(0xFF330295)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.search, color: Color(0xFF330295)),
                title: const Text(
                  'Find',
                  style: TextStyle(color: Color(0xFF330295)),
                ),
                onTap: () {
                  // Navigator.pop(context);  /
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FindPage()),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.notifications, color: Color(0xFF330295)),
                title: const Text(
                  'News',
                  style: TextStyle(color: Color(0xFF330295)),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Color(0xFF330295)),
                title: const Text(
                  'Settings',
                  style: TextStyle(color: Color(0xFF330295)),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          // Aboutussection(),
          ForumViewSection(),
          NearMeSection(),
          CharitySection(),
          AdsSection(),
        ],
      ),
    );
  }
}
