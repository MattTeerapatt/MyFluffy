import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Johnny Nigga'; 
  String email = 'nigga56@example.com'; 
  String location = 'Bangkok, Thailand';
  String birthday = 'January 1, 9999';
  String phone = '+66 123 456 789';
  String bankAccount = '123456781432'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name\'s Profile'),
        backgroundColor: Colors.yellow[300],
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
      return '*' * (accountNumber.length - 4) + accountNumber.substring(accountNumber.length - 4);
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


