import 'package:flutter/material.dart';
import 'package:myfluffy/model/post.dart';

class CatTile extends StatelessWidget {
  final Post post; // Store the passed Post object

  const CatTile({super.key, required this.post}); // Constructor that takes a Post object

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
            post.petName, // Display the pet name from the Post object
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Last Seen: ${post.location}', // Display the last seen location
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Text(
            'Reward: \$${post.reward}', // Display the reward amount
            style: const TextStyle(fontSize: 14, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
