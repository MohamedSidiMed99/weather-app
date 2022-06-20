import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapptest/controller/dataservice.dart';
import 'package:weatherapptest/controller/sixdays.dart';
import 'package:weatherapptest/model/model.dart';
import 'package:weatherapptest/model/sixdays.dart';

import '../controller/language.dart';
import '../controller/language.dart';
import 'fivedays.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FiveDaysResponse> sevenDay = [];
  FiveDaysResponse? fiveDaysResponse;
  late Position pt;
  var lat ;
  var long;

  TextEditingController city =TextEditingController();
  final dataServece = DataServices();
  final getFiveDays = GetFiveDays();

  var lang = GetStorage().read('lang');

   WeatherResponse? _response;



  Future getPosition()async{
    bool services;
    LocationPermission per;

    services = await Geolocator.isLocationServiceEnabled();
    if(services == false){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Message"),
             content: Text("you need to activate the location"),
            );
          });
    }
    else{

    }

    per = await Geolocator.checkPermission();


    if(per == LocationPermission.denied){
      per = await Geolocator.requestPermission();
    }else{

    }
  }

  Future<void> getLongLat()async{
    pt = await Geolocator.getCurrentPosition().then((value) => value);

     lat = pt.latitude;
     long = pt.longitude;

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  getData()async{


      await getPosition();
      await getLongLat();

     await getMyLocation();
     await getMyLocationFiveDays();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("logo".tr,
        style: TextStyle(
           color: Colors.white
        ),),

        actions: [
          Container(
            width: 150,

            child: Center(
              child: GetBuilder<Languages>(
                  init: Languages(),
                  builder: (controller) {
                    return DropdownButton<dynamic>(

                        items: [
                          DropdownMenuItem(
                            child: Text("English",
                              style: TextStyle(
                                  fontSize: 22,

                              ),),
                            value: "en",
                          ),

                          DropdownMenuItem(
                            child: Text("Russia",
                              style: TextStyle(
                                  fontSize: 22,

                              ),),
                            value: "ru",
                          ),
                        ],
                        value: controller.appLocal,
                        onChanged: (val)async{
                          controller.changeLanguage(val);


                          Get.updateLocale(Locale(val));
                          var city1 = await GetStorage().read('city');
                          // String? city1;
                          // SharedPreferences shp =await SharedPreferences.getInstance();
                          //  setState(() {
                          //    city1 = shp.getString("city");
                          //  });

                           print(city1);
                          if(city1 == null) {
                            getMyLocation();
                          }else {
                            _Search(city1,val);
                            getFiveDaysNow(city1,val);
                          }

                        });
                  }
              ),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          
          Container(
            height: 300,
            width: double.infinity,
            child: Image.asset("images/cloud-in-blue-sky.jpg"),
          ),

          Container(
            height: 280,
            width: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),
          
          ListView(

            children: [

              /// -------------------Search from text ------------------
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child: SizedBox(

                  child: TextFormField(

                    controller: city,
                    decoration: InputDecoration(
                        labelText: "City",
                    suffixIcon: IconButton(
                      onPressed: ()async{

                        if(city.text ==""){

                        }else {
                          _Search("","");
                          getFiveDaysNow("","");
                          GetStorage().write('city',city.text );

                          city.text ="";
                          // getFiveDaysNow();
                          // print(city.text);
                        }

                      },
                      icon: Icon(Icons.search),
                    ),
                      prefixIcon: IconButton(
                          onPressed: (){
                            city.text="";
                          },
                          icon: Icon(Icons.close)),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)
                      ),

                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)
                      )

                    ),


                  ),


                ),
              ),

              SizedBox(height: 10,),

              /// -------------------image ------------------

              if(_response != null)
                Card(
                  elevation: 5,
                  color: Colors.white.withOpacity(0.0),
                  child: Container(

                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${_response!.cityName},",
                              style: TextStyle(
                                  fontSize: 40,
                                color: Colors.white
                              ),),

                            Text(" ${_response!.country!.country}",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white
                              ),),
                          ],
                        ),
                        Divider(thickness: 1,color: Colors.white,),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${_response!.weatherInfo!.description}",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.yellow
                                      ),),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("${_response!.temp!.temp?.round()}°C",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.bold
                                    ),),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("max".tr,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white.withOpacity(0.7),
                                            fontWeight: FontWeight.bold
                                        ),),

                                      Text(" / ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white.withOpacity(0.7),
                                            fontWeight: FontWeight.bold
                                        ),),

                                      Text("min".tr,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white.withOpacity(0.7),
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Text("${_response!.temp!.tempmax}°c / ${_response!.temp!.tempmin}°c",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.bold
                                    ),),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Column(
                                children: [
                                  Image.network(_response!.iconURL,),
                                  Text("wind: ${_response!.speed!.wind} m/s",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.bold
                                    ),)
                                ],
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [


                            SizedBox(width: 10,),

                          ],
                        ),


                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                )else Text(""),


              ///-------------------- list fiveDays ------------------

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),),
                    Text("Next 6 Days >",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        color: Colors.teal
                      ),),
                  ],
                ),
              ),

              SizedBox(height: 10,),
              Container(
                height: 210,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sevenDay.length,
                    itemBuilder: (ctx , i){
                      return  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                         decoration: BoxDecoration(
                           color: Colors.teal,
                           borderRadius: BorderRadius.circular(20)
                         ),
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 7,),
                                Text("${sevenDay[i].temp}°C",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.bold
                                  ),),
                                Image.network(sevenDay[i].iconURL),

                                Text("${sevenDay[i].desc}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 5,),
                                Text("${sevenDay[i].day}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(height: 5,),
                              ],
                            )),
                      );
                    }),
              )

            ],
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: ()async{
      //     await getLongLat();
      //
      //     getMyLocation();
      //     getMyLocationFiveDays();
      //   },
      //   backgroundColor: Colors.teal,
      //
      //   child: Icon(Icons.stream),
      // ),
    );
  }

  void _Search(String ct,String ln)async{


   final  res = await dataServece.getWeather(city.text.isEmpty?ct:city.text, "${ct.isEmpty?lang:ln}","","");
   setState(() {
     _response = res!;
   });


   // GetStorage().remove("city");
   //  GetStorage().write('city',city.text );
   // SharedPreferences shp =await SharedPreferences.getInstance();
   // shp.setString("city", city.text);
  }

  Future getMyLocation()async{
    final  res =await dataServece.getWeather("", "$lang", lat, long);

    setState(() {
      _response = res!;
    });

    GetStorage().write('city',_response?.cityName );
  }

  ///---------------------location five days--------------------
 Future getMyLocationFiveDays()async{
    final  res =await getFiveDays.getFiveDay("", "$lang", lat, long);
    var list = await getFiveDays.days;

    var date = DateTime.now();

    for(int i = 1 ; i <7 ; i++){

      var temp = list[i];
      String day = DateFormat("EEEE").format(DateTime(date.year,date.month,date.day+i-1)).substring(0,3);
      var hourly = FiveDaysResponse(
        icon: temp['weather'][0]['icon'].toString(),
        temp: temp['main']['temp']?.round()??0,
        main: temp['weather'][0]['main'].toString(),
        dt_text: temp['dt_txt'],
        desc: temp['weather'][0]['description'].toString(),
        day: day,
      );

      if(sevenDay.length < 6){
        setState(() {
          sevenDay.add(hourly);
        });

      }else if(sevenDay.length == 6){
        sevenDay.clear();
        setState(() {
          sevenDay.add(hourly);
        });
      }

      print(hourly.day);

    }
    GetStorage().write('city',_response?.cityName );
  }
  //get fiveDays
  void getFiveDaysNow(String ct,String ln)async{
   var res = await getFiveDays.getFiveDay(city.text.isEmpty?ct:city.text, "${ct.isEmpty?lang:ln}", lat, long);
   var list = await getFiveDays.days;

var date = DateTime.now();

for(int i = 1 ; i <7 ; i++){

  var temp = list[i];
  String day = DateFormat("EEEE").format(DateTime(date.year,date.month,date.day+i-1)).substring(0,3);
  var hourly = FiveDaysResponse(
    icon: temp['weather'][0]['icon'].toString(),
    temp: temp['main']['temp']?.round()??0,
    main: temp['weather'][0]['main'].toString(),
    dt_text: temp['dt_txt'],
    desc: temp['weather'][0]['description'].toString(),
    day: day,
  );

  if(sevenDay.length < 6){
    setState(() {
      sevenDay.add(hourly);
    });

  }else if(sevenDay.length == 6){
    sevenDay.clear();
    setState(() {
      sevenDay.add(hourly);
    });
  }

  print(hourly.day);

}



  }
}
