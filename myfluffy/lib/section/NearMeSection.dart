import 'package:flutter/material.dart';
import '../zone/SukhumvitPage.dart'; 
import '../zone/SukhumvitPage2.dart'; 
import '../zone/SukhumvitPage3.dart'; 

class NearMeSection extends StatelessWidget {
  const NearMeSection({Key? key}) : super(key: key);

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
                return buildLocationButton(context, labels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLocationButton(BuildContext context, String label) {
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
    );
  }
}
