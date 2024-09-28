import 'package:flutter/material.dart';

class Charitytile extends StatefulWidget {
  String title;
   Charitytile({super.key, required this.title});

  @override
  State<Charitytile> createState() => _CharitytileState();
}

class _CharitytileState extends State<Charitytile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 150, // Adjust width
      child: Card(
        child: Center(
          child: ListTile(
            title: Text(widget.title),
          ),
        ),
      ),
    );
  }
}
  