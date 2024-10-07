import 'package:flutter/material.dart';
import 'package:myfluffy/section/Reel.dart';
class ReelPage extends StatefulWidget {
  const ReelPage({super.key});

  @override
  State<ReelPage> createState() => _ReelPageState();
}

class _ReelPageState extends State<ReelPage> {
  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: 0);

    List<Widget> reel = [
      Reel(
         name: 'Johnson',
        description: 'White cat, 1 year old, very friendly and loves to play. Lost in the park near the river.',
        location: 'Asok, Bangkok',
        image: 'lib/assets/kitty2.jpg',
        reward: '100',
      ),
      Reel(
        name: 'Diddy',
        description: 'White small kitten about 3 month old, very playful and friendly. Lost while playing in the garden.',
        location: 'Rama9, Bangkok',
        image: 'lib/assets/kitty1.jpeg',
        reward: '8,000',

      ),
  
        Reel(
         name: 'Garfield',
        description: 'Tiger color cat, 2 years old, very lazy and loves to sleep. Lost in the market.',
        location: 'Bangna, Bangkok',
        image: 'lib/assets/kitty3.jpg',
        reward: '108,000',
      ),
       Reel(
         name: 'Tin',
        description: 'Small Tiger Cat, 1 year old, very playful and loves to play with kids. Lost in the market.',
        location: 'Sukumvit, Bangkok',
        image: 'lib/assets/kitty5.jpg',
        reward: '108,000',
      ),
       Reel(
         name: 'Dobby',
        description: 'Cat that lookilike harry potter elf, 1 year old, very friendly and loves to play. Lost in the park.',
        location: 'Hogward, Bangkok',
        image: 'lib/assets/kitty4.jpg',
        reward: '1,008,000',
      ),
       Reel(
         name: 'Milo',
        description: 'Black cat, 1 year old, very friendly and loves to play. Lost in the park near the river.',
        location: 'KMITL, Bangkok',
        image: 'lib/assets/kitty6.jpg',
        reward: '50',
      ),
      
    ];
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Container(
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          children: reel,
        )
      ),
    );
  }
}
