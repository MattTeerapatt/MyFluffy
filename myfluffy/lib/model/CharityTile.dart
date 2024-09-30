import 'package:flutter/material.dart';

class Charitytile extends StatelessWidget {
  final String imagePath;

  Charitytile({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Advertisement tile',
      child: GestureDetector(
        onTap: () {
          // Show dialog with full image on tap
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent, // Make dialog background transparent
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog on tap
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.9, // Set max height to 90% of screen
                      maxWidth: MediaQuery.of(context).size.width * 0.9, // Set max width to 90% of screen
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain, // Adjust the image to fit within dialog
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Card(
          child: Center(
            child: ListTile(
              title: Container(
                constraints: BoxConstraints(
                  maxHeight: 100,
                  maxWidth: double.infinity,
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
