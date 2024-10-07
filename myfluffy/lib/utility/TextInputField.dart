import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String value;
  final String placeholder; // Add a placeholder property

  const TextInputField({
    super.key,
    required this.label,
    required this.value,
    required this.placeholder, // Add a placeholder parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            initialValue: value,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
              hintText: placeholder, // Add the placeholder text
            ),
          ),
        ),
      ],
    );
  }
}