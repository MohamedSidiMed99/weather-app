

/*
"name": "Nouakchott",
 "country": "MR",
 "dt_txt": "2022-06-18 21:00:00"
   "main": {"temp": 301.5,
*/

class FiveDaysResponse{
  String? dt_text;
  String? country;
  String? city;
  String? icon;
  String? main;
  String? day;
  int? temp;
  String? desc;
  String get iconURL {
    return "http://openweathermap.org/img/wn/${icon}@2x.png";
  }

  FiveDaysResponse({this.dt_text,this.city,this.country,this.icon,this.main,this.day,this.temp,this.desc});

  // factory FiveDaysResponse.fromJson(Map<String, dynamic> json){
  //    return FiveDaysResponse(
  //        country: json['city']['country'],
  //        city : json['city']['name'],
  //      icon: json['weather']['icon'],
  //      day: json['']
  //
  //    );

  // }


}



