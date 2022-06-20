/*

{"coord":{"lon":-122.0841,"lat":37.4219},

"weather":[{
"description":"broken clouds",
"icon":"04d"
}],
"main":{
"temp":291.36,
,"temp_min":286.16,
"temp_max":286.16,
},
"sys":{"country":"RU"}
"name":"Mountain View",
}

"pressure":1015,
"humidity":88
"wind":{"speed":2,"deg":240}

 */

///-------------country -------------
class WeatherCountry{
  String? country;
  
  WeatherCountry({this.country});
  
  factory WeatherCountry.fromJson(Map<String, dynamic> json){
    return WeatherCountry(
      country: json['country'],
    );
  }
}
///-------------weather info-------------
class WeatherInfo {
 final String? description;
 final String? icon;
 
 WeatherInfo({this.description,this.icon});
 
 factory WeatherInfo.fromJson(Map<String, dynamic> json){
   return WeatherInfo(
     description: json['description'],
     icon: json['icon']
   );
 }
}
///-------------temp info-------------
class TempInfo{
  final double? temp;
  final double? tempmax;
  final double? tempmin;

  TempInfo({this.temp,this.tempmax,this.tempmin});

  factory TempInfo.formJson(Map<String, dynamic> json){
    return TempInfo(
      temp: json['temp'],
      tempmax: json['temp_max'],
      tempmin: json['temp_min']
    );
  }
}

///-------------wind-------------

class WindSpeed{
  var wind;

  WindSpeed({this.wind});

  factory WindSpeed.fromJson(Map<String , dynamic> json){
    return WindSpeed(
      wind: json['speed']
    );
  }
}

class WeatherResponse{
   String? cityName;
   TempInfo? temp;
   WeatherInfo? weatherInfo;
   WeatherCountry? country;
   WindSpeed? speed;
   String get iconURL {
      return "http://openweathermap.org/img/wn/${weatherInfo?.icon}@2x.png";
}

   WeatherResponse({this.cityName,this.temp,this.weatherInfo,this.country,this.speed});

   factory WeatherResponse.fromJson(Map<String, dynamic> json){

     return WeatherResponse(
       cityName: json['name'],
       temp: TempInfo.formJson(json['main']),
       weatherInfo: WeatherInfo.fromJson(json['weather'][0]),
       country: WeatherCountry.fromJson(json['sys']),
       speed: WindSpeed.fromJson(json['wind'])
     );
   }
}