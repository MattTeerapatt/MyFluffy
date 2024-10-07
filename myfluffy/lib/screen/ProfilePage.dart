import 'package:flutter/material.dart';
import 'package:myfluffy/global/balance.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = namee;
  String email = emaill;
  String location = locationn;
  String birthday = birthdayy;
  String phone = phonee;
  String bankAccount = bankAccountt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF7B3FF4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Handle back navigation
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      'https://www.w3schools.com/howto/img_avatar.png'),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Location'),
                  subtitle: Text(location),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editInfo(context, 'Location', location, (value) {
                        setState(() {
                          location = value;
                        });
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone'),
                  subtitle: Text(phone),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editInfo(context, 'Phone', phone, (value) {
                        setState(() {
                          phone = value;
                        });
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.account_balance),
                  title: const Text('Bank Account'),
                  subtitle: Text(_maskedBankAccount(bankAccount)),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editInfo(context, 'Bank Account', bankAccount, (value) {
                        setState(() {
                          bankAccount = value;
                        });
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  String _maskedBankAccount(String accountNumber) {
    if (accountNumber.length > 4) {
      return '*' * (accountNumber.length - 4) +
          accountNumber.substring(accountNumber.length - 4);
    }
    return accountNumber;
  }

  void _editInfo(BuildContext context, String field, String currentValue,
      Function(String) onSave) {
    final TextEditingController controller = TextEditingController();
    controller.text = currentValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Enter new $field'),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
