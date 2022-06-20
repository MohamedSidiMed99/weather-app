
import 'dart:ui';

import 'package:get/get.dart';

import '../language/type_lang/localstorage/local_storage.dart';


class Languages extends GetxController{

  late String appLocal = "ru";

  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();

    LocalStorage localStorage = LocalStorage();

    try {
      String ls = await localStorage.languageSelected;

      appLocal = ls == null ? "ru" : ls;
    }catch(e){
      // print("----------error-----------");
    }
    update();

    Get.updateLocale(Locale(appLocal));
  }


  void changeLanguage (String type)async{

    LocalStorage localStorage =LocalStorage();

    if(appLocal == type){
      return ;
    }else if(type == "ru"){
      appLocal ="ru";
      localStorage.SaveLanguageToDisk("ru");

    }else{
      appLocal ="en";
      localStorage.SaveLanguageToDisk("en");
    }
    update();
  }

}