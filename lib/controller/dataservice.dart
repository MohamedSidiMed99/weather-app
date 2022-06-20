import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapptest/model/model.dart';
class DataServices{

  Future<WeatherResponse?> getWeather(String city, String lang,lat,long)async{

    ///https://api.openweathermap.org/data/2.5/weather?q=voronezh&lang=ar&mode=html&appid=
    ///apikey = 51fe82a73cac71da3c5cdff27b55ab0b
    ///lat={lat}&lon={lon}
    final queryParameters = {
      "q" : city,
      "lat":"$lat",
      "lon":"$long",
      "lang":lang,
      "appid" : "51fe82a73cac71da3c5cdff27b55ab0b",
      "units":"metric"
    };

    final uri = Uri.https("api.openweathermap.org", "/data/2.5/weather",queryParameters);

  try{
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      // print(response.body);
      final data = jsonDecode(response.body);
      print(data);
      return WeatherResponse.fromJson(data);
    }
  }catch(e){
    print("----$e-----");
  }
    
  }
}