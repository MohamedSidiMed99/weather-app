



import 'package:get_storage/get_storage.dart';

class LocalStorage{

  ///Write
  void SaveLanguageToDisk(String language)async{
    await GetStorage().write('lang', language);
  }

  ///Read
  Future<dynamic> get languageSelected async{
    return await GetStorage().read('lang');
  }
}