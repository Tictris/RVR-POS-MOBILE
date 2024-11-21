import 'package:flutter/material.dart';
import 'package:rvr_flutter/login.dart';
import 'package:rvr_flutter/widgets/calculate_total.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class APIService {
  final storage = const FlutterSecureStorage();

  Client client = http.Client();

  Future<bool> requestLogout(BuildContext context) async {
    final token = await storage.read(key: 'authToken');

    final headers = {
      'Authorization': "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*"
    };
    const url = "http://127.0.0.1:8000/api/logout";

    Uri uri = Uri.parse(url);

    final response = await client.post(uri, headers: headers);

    if (response.statusCode == 200) {
      await storage.delete(key: 'authToken');
      debugPrint('Logout successful.');
      return true;
    } else {
      debugPrint('Token not found in response.');
      return false;
    }
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    APIService apiService = APIService();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
            ],
          ),
          title: const Text('Roselyn View Resort'),
          actions: [
            IconButton(
              onPressed: () async {
                final logoutSuccessful =
                    await apiService.requestLogout(context);

                if (logoutSuccessful) {
                  if (context.mounted) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  }
                }
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const Calculator(),
      ),
    );
  }
}
