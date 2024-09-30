import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Forumpreviewtile extends StatelessWidget {
  late String title;
  late Image image;
  Forumpreviewtile({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    width: 150, 
    child: Card(
      color: Colors.white, 
      child: Center(
        child: ListTile(
          leading: image,
          title: Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    ),
  );
}
}