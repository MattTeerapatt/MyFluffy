import 'package:flutter/material.dart';
import 'package:myfluffy/utility/LocationButton.dart';

class NearMeSection extends StatelessWidget {
  const NearMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Find by category',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                List<String> labels = [
                  'Sukhumvit',
                  'Sukhumvit2',
                  'Sukhumvit3',
                  'Sukhumvit4',
                  'Sukhumvit5',
                  'Sukhumvit6',
                  'Sukhumvit7',
                  'LadProw',
                  'Taksin'
                ];
                return LocationButton(label: labels[index]);              },
            ),
          ),
        ],
      ),
    );
  }
}
