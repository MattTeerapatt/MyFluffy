import 'package:flutter/material.dart';

class AdsTile extends StatelessWidget {
  final String text;

  const AdsTile({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Advertisement tile: $text',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Center(
            child: ListTile(
              title: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
