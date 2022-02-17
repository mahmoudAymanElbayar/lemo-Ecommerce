import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ShopController extends GetxController{
  RxInt currentIndex=0.obs;
  // void changeScreen({required int index}){
  //   currentIndex=index;
  //   update();
  // }
  GetStorage boxStorage = GetStorage();
    //bool isDark = false;
  String isDark= 'isDark';
  void saveData( {bool? isdarkbool }){
    boxStorage.write(isDark,isdarkbool);
  }
   bool getThemeMode(){
    //update();
   return boxStorage.read<bool>(isDark)??false;
  }
  ThemeMode get themeDataGet=>getThemeMode()?ThemeMode.dark:ThemeMode.light;
  void changeTheme(){
    Get.changeThemeMode(getThemeMode()?ThemeMode.light:ThemeMode.dark);
    saveData(isdarkbool: !getThemeMode());
  }
}