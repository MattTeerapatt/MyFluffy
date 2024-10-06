import 'package:flutter/material.dart';
import 'package:myfluffy/screen/LandingScreen.dart';
import 'package:provider/provider.dart';
import 'package:myfluffy/providers/catspost_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CatspostProvider()),
        // ChangeNotifierProvider(create: (context) => UserInfoProvider()),
      ],
      builder:(context, child) => MaterialApp(
        title: 'Flutter Demo',
        home: LandingScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

