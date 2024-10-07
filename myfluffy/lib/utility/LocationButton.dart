import 'package:flutter/material.dart';
import 'package:myfluffy/zone/SukhumvitPage.dart';
import 'package:myfluffy/zone/SukhumvitPage2.dart';
import 'package:myfluffy/zone/SukhumvitPage3.dart';


class LocationButton extends StatelessWidget {
  final String label;

  const LocationButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (label) {
          case 'Sukhumvit':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SukhumvitPage()),
            );
            break;
          case 'Sukhumvit2':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SukhumvitPage2()),
            );
            break;
          case 'Sukhumvit3':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SukhumvitPage3()),
            );
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Page not found for $label')),
            );
        }
      },
      child: SizedBox(
        width: 100,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, size: 30, color: Colors.black),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
