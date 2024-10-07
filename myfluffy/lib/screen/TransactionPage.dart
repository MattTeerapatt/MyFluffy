import 'package:flutter/material.dart';
import 'package:myfluffy/global/balance.dart';
import 'package:myfluffy/screen/Fullscreenimage.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF7B3FF4),  // Dark purple
                  Color(0xFF9D63E7),  // Light purple
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Circular shape on the background
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Color(0xFF9D63E7).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: -150,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: Color(0xFF7B3FF4).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
                    Positioned(
            top: 50,
            left: -200,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 91, 35, 210).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Text(
                  namee,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  emaill,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      (_maskedBankAccount(bankAccountt)),
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 220,

            child: 
          Container(
              width: MediaQuery.of(context).size.width, // Full screen width
              height: MediaQuery.of(context).size.height, // Full screen height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                   SizedBox(height: 20),
                   SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 60,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Withdraw action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20),
                          Image(image: AssetImage('lib/assets/paypal.png'), width: 30),
                          SizedBox(width: 20),
                          const Text(
                        'Paypal',
                        style: TextStyle(fontSize: 18),
                      ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                        SizedBox(width: 20),
                        

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 60,

                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Withdraw action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20),
                          Image(image: AssetImage('lib/assets/visa.png'), width: 40),
                          SizedBox(width: 20),
                          const Text(
                        'Visa',
                        style: TextStyle(fontSize: 18),
                      ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                        SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 60,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImage(imagePath: 'lib/assets/truemoney.jpg'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20),

                          Image(image: AssetImage('lib/assets/truemoney.png'), width: 60),
                          SizedBox(width: 10),
                          const Text(
                        'Truemoney',
                        style: TextStyle(fontSize: 18),
                      ),
                         Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                        SizedBox(width: 20),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 60,

                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImage(imagePath: 'lib/assets/bank.jpg'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20),
                          Icon(Icons.account_balance, color: Colors.black, size: 30),
                          SizedBox(width: 20),
                          const Text(
                        'Bank Transfer',
                        style: TextStyle(fontSize: 18),
                      ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                        SizedBox(width: 20),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


  String _maskedBankAccount(String accountNumber) {
    if (accountNumber.length > 4) {
      return '*' * (accountNumber.length - 4) + accountNumber.substring(accountNumber.length - 4);
    }
    return accountNumber; 
  }

