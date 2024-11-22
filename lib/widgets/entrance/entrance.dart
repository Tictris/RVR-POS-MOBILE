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
    required int adultCount,
    required int seniorCount,
    required int childCount,
    required int umbrellaCount,
    required int cottageCount,
    required int tentCount,

  }) async {
    const url = "http://127.0.0.1:8000/api/create-entrance";

    Uri uri = Uri.parse(url);

    final rateFetcher = RateFetcher();
    final rateData = await rateFetcher.fetchRates();
    final cottageRateFetcher = CottageRateFetcher();
    final cottageRateData = await cottageRateFetcher.fetchRates();

    int adultId = rateData.adultId;
    int seniorId = rateData.seniorId;
    int childId = rateData.childId;

    int umbrellaId = cottageRateData.umbrellaId;
    int cottageId = cottageRateData.cottageId;
    int tentId = cottageRateData.tentId;


    final bc = [
        { //umbrella
          'cottage_id': umbrellaId,
          'quantity': umbrellaCount,
        },
        {//cottage
          'cottage_id': cottageId,
          'quantity': cottageCount,
        },
        {//tent
          'cottage_id': tentId,
          'quantity': tentCount,
        }
    ];

    final cc = [
        {//adults
         'customer_id': adultId,
         'count': adultCount
        },
        {//senior
         'customer_id': seniorId,
         'count': seniorCount
        },
        {//children
         'customer_id': childId,
         'count': childCount
        },
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

    if(response.statusCode == 201){
      debugPrint("it has connected uh successfallay");
    } else {
      debugPrint("Odd, it returned FALSE");
    }
  }
}