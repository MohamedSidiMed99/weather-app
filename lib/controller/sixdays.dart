import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weatherapptest/model/sixdays.dart';

class GetFiveDays{

  ///https://api.openweathermap.org/data/2.5/forecast?q=nouakchott&appid=
  ///key = cdf7f7d82de62e742066ceecd6ba9b88
  ///api.openweathermap.org/data/2.5/forecast


    List days = [];

  Future<FiveDaysResponse?> getFiveDay(String city, String lang,lat,lon,)async{
    final querylink ={
      "q":city,
      "lat":"$lat",
      "lon":"$lon",
      "lang":lang,
      "appid":"cdf7f7d82de62e742066ceecd6ba9b88",
      "units":"metric"
    };
   try{
     final uri = Uri.https("api.openweathermap.org", "/data/2.5/forecast",querylink);
     var res = await http.get(uri);

     DateTime date = DateTime.now();
     if(res.statusCode == 200){

       var data = jsonDecode(res.body);

       String? day;
       String? day1;
       days.clear();
       for(int i =0 ; i < data['list'].length ;i++) {

         days.add(data['list'][i]);

         // day1 = DateFormat("EEEE dd MMMM").format(date);
         // day = DateFormat("EEEE").format(DateTime(date.year,date.month,date.day));
       }

       // print(day);
       // print(days[0]['dt_txt'].toString().substring(0,10));
       // days.clear();
       //  return FiveDaysResponse.fromJson(data);


     }
   }catch(e){

   }
  }

}