import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfluffy/global/balance.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: SingleChildScrollView( // Wrap content inside SingleChildScrollView to make it scrollable
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
              namee, 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 20),
            Icon( Icons.account_circle, color: Colors.black, size: 32),
              ],
            ),
            const SizedBox(height: 20),
            
            Container(
              width: MediaQuery.of(context).size.width, // Full screen width
              height: MediaQuery.of(context).size.height, // Full screen height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                      child: const Text(
                        'Paypal',
                        style: TextStyle(fontSize: 18),
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
                      child: const Text(
                        'Visa',
                        style: TextStyle(fontSize: 18),
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
                      child: const Text(
                        'Mastercard',
                        style: TextStyle(fontSize: 18),
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
                      child: const Text(
                        'Bank Transfer',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
          
          ],
        ),
      ),
    );
  }
}
