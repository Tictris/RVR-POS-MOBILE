import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rvr_flutter/dashboard.dart';
import 'package:rvr_flutter/widgets/login/email_field.dart';
import 'package:rvr_flutter/widgets/login/password_field.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class APIService{

  Client client = http.Client();

  Map<String, String>? headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*"
  };

  Future sendFeedback({

    required String email,
    required String password,

  }) async {
    const url = "http://127.0.0.1:8000/api/login";

    Uri uri = Uri.parse(url);

    final body = jsonEncode({
      "email": email,
      "password": password,
    });

    final response =  await client.post(
      uri,headers: headers, body: body
    );

    debugPrint(response.body.toString());
  }
}


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {

    APIService apiService = APIService();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 65,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your email address'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                'Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your password'),
              ),
              ],
            ),
            const SizedBox(
                      height: 20,
                    ),
            ElevatedButton(onPressed: () {
              apiService.sendFeedback(email: _emailController.text, password: _passwordController.text);
            }, child: const Text('Login')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Go to Dashboard",
                    style: TextStyle(
                      fontSize: 16,
                    )),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                  },
                  child: const Text('Here!', style: TextStyle(fontSize: 16)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}