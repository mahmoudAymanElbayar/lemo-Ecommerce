import 'dart:ui';

import 'package:get/get.dart';

class SettingController extends GetxController{
  var darkMode = true.obs;
  void updateLang({required String typeOfLang}){
    Get.updateLocale(Locale(typeOfLang));
    update();
  }
}