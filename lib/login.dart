import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rvr_flutter/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class APIService{
  final storage = const FlutterSecureStorage();

  Client client = http.Client();

  Map<String, String>? headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*"
  };

  Future<void> _storeToken(String newToken) async {
    try {
      await storage.write(key: 'authToken', value: newToken);
    } catch (e) {
      debugPrint('Error storing token: $e');
    }
  }

  Future<bool> sendFeedback(BuildContext context, {

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

    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      final token = data['token'];

      if(token != null){
        await _storeToken(token);
        debugPrint('Token stored successfully.');
         debugPrint(response.body.toString());
        return true;
      } else {
        debugPrint('Token not found in response.');
        return false;
      }

    } else {
      return false;
    }
   
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
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
                  controller: emailController,
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
                controller: passwordController,
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
            ElevatedButton(
              onPressed: () async {
              final email = emailController.text;
              final password = passwordController.text;

              final loginSuccessful = await apiService.sendFeedback(context, email: email, password: password);
                    if (loginSuccessful) {
                      debugPrint("It has worked!");
                      if(context.mounted){
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                      }
                    } else{
                      // Handle login failure (e.g., show error message)
                      if(context.mounted){
                        ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Login failed!')));
                      }
                    }
                 },
            child: const Text('Login')
            ),
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