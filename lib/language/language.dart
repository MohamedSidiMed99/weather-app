



import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:weatherapptest/language/type_lang/en.dart';
import 'package:weatherapptest/language/type_lang/ru.dart';

class Language extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>{
    'ru':ru,
    'en':en,


  };



}