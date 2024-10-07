import 'package:flutter/material.dart';

class CatTile extends StatelessWidget {
  final String catName;

  const CatTile({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.pets, size: 40, color: Color.fromARGB(255, 79, 71, 6)),
          const SizedBox(height: 10),
          Text(
            catName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
