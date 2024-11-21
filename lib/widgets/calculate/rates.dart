import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';


class Rate {
  final double rate;
  final String type;
  final int id;

  Rate({required this.rate, required this.type, required this.id});

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      rate:  double.parse(json['rate']),
      type: json['type'],
      id: json['id'],
      
    );
  }
}
class RateData {
   double adultRate;
   double childRate;
   double seniorRate;
   int adultId;
   int childId;
   int seniorId;

  RateData({
     this.adultRate = 0.0,
     this.childRate = 0.0,
     this.seniorRate = 0.0,
     this.adultId = 0,    
     this.childId = 0,    
     this.seniorId = 0 ,
  });
}

class RateFetcher {
    Client client = http.Client();

    Future<RateData> fetchRates() async {
      const url = "http://127.0.0.1:8000/api/get-rate";

      Uri uri = Uri.parse(url);
      final response = await client.get(uri);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if(data.isNotEmpty) {
          final List<Rate> rates = data.map((item) => Rate.fromJson(item)).toList();

          RateData rateData = RateData();

          for (var rate in rates) {
            if(rate.type == "adults"){
              rateData.adultRate = rate.rate;
              rateData.adultId = rate.id;
            } else if(rate.type == "kids"){
              rateData.childRate = rate.rate;
              rateData.childId = rate.id;
            } else if(rate.type == "senior"){
              rateData.seniorRate = rate.rate;
              rateData.seniorId = rate.id;
            }
          }

          return rateData;
        }
       
      } else {
        throw Exception('Failed to fetch data');
      }
      throw Exception('unknown Error');
  }
}

//For Cottages
class CottageRate {
  final int price;
  final String type;
  final int id;
  
  CottageRate({required this.price,required this.type,required this.id});

  factory CottageRate.fromJson(Map<String, dynamic> json) {
    return CottageRate(
      price:  double.parse(json['price']).toInt(),
      type: json['type'],
      id: json['id'],
    );
  }
}

class CottageRateData {
  int tent = 0;
  int cottage = 0;
  int umbrella = 0;

  int tentId = 0;
  int cottageId = 0;
  int umbrellaId = 0;

  CottageRateData({
    this.tent = 0,
    this.cottage = 0,
    this.umbrella = 0,
    this.tentId = 0,
    this.cottageId = 0,
    this.umbrellaId = 0,
  });
}

class CottageRateFetcher {
    Client client = http.Client();

    Future<CottageRateData> fetchRates() async {
      const url = "http://127.0.0.1:8000/api/get-cottage-rate";

      Uri uri = Uri.parse(url);
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> cottageData = jsonDecode(response.body);

        if(cottageData.isNotEmpty){
          final List<CottageRate> prices = cottageData.map((item) => CottageRate.fromJson(item)).toList();
          CottageRateData cottageRateData = CottageRateData();

          for (var rate in prices){
            if (rate.type == "umbrella"){
              cottageRateData.umbrella = rate.price;
              cottageRateData.umbrellaId = rate.id;
            } else if(rate.type == "cottage"){
              cottageRateData.cottage = rate.price;
              cottageRateData.cottageId = rate.id;
            } else if(rate.type == "tent"){
              cottageRateData.tent = rate.price;
              cottageRateData.tentId = rate.id;
            }
          }
          return cottageRateData;
      } 
    }
          
      else {
        throw Exception('Failed to fetch data');
      }
      throw Exception('Unknown Error');
  }
}