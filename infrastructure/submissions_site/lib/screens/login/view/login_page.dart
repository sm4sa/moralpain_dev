import 'package:submissions_site/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              key: Key('__loginPage_email_textField__'),
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              key: Key('__loginPage_password_textField__'),
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              key: Key('__loginPage_login_elevatedButton__'),
              onPressed: () {
                Navigator.of(context).push(MainScreen.route());
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
