import 'package:flutter/material.dart';
import 'package:rvr_flutter/widgets/calculate/rates.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class APIService{

  Client client = http.Client();

  Map<String, String>? headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*"
  };

  Future<void> sendData(BuildContext context, {

    required String name,
    required int total,

  }) async {
    const url = "http://127.0.0.1:8000/api/create-entrance";

    Uri uri = Uri.parse(url);

    final bc = [
        { 'cottage_id': '',
          'quantity': ''}
    ];

    final cc = [
        {'customer_id': '',
         'count': ''}
    ];

    final body = jsonEncode({
      "name": name, 
      "total": total,
      "bc" : bc,
      "cc" : cc
    });

    final response =  await client.post(
      uri,headers: headers, body: body
    );

  }
}