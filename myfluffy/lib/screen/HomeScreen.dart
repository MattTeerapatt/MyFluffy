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
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
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
                leading: const Icon(Icons.post_add),
                title: const Text('Post'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Find'),
                onTap: () {
                  // Navigator.pop(context);  /
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FindPage()),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('News'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
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
          Aboutussection(),
          ForumViewSection(),
          NearMeSection(),
          CharitySection(),
          AdsSection(),
        ],
      ),
    );
  }
}
