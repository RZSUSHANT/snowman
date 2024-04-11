import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username') ?? '';
    final storedPassword = prefs.getString('password') ?? '';
    final enteredUsername = _usernameController.text;
    final enteredPassword = _passwordController.text;

    if (enteredUsername == storedUsername && enteredPassword == storedPassword) {
      int? lastScore = prefs.getInt('score_$enteredUsername');
      String scoreMessage = lastScore != null ? "Your last score: $lastScore" : "Play to set your first score!";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(scoreMessage), duration: Duration(seconds: 2)));
      Navigator.pushReplacementNamed(context, '/game');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: Text('No account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
