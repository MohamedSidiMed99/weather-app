import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'view/home.dart';
import 'language/language.dart';

void main()async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var ln = GetStorage().read('lang');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      translations: Language(),
      locale:ln == "ru"? Locale("ru"):Locale("en"),
      fallbackLocale: Locale("ru"),
      home: Home(),

    );
  }
}

