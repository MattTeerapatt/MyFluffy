import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfluffy/global/balance.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 103, 99, 99),
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
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 60),
            Icon( Icons.account_circle, color: Colors.white, size: 32),
              ],
            ),
            const SizedBox(height: 60),
            
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
            
          
          ],
        ),
      ),
    );
  }
}
