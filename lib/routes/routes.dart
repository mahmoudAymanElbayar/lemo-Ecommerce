

import 'package:ecommerce/binding/home_biding.dart';
import 'package:ecommerce/views/forget_screen.dart';
import 'package:ecommerce/views/home_layout.dart';
import 'package:ecommerce/views/home_screen.dart';
import 'package:ecommerce/views/home_screens/details_screen.dart';
import 'package:ecommerce/views/home_screens/shop_screen.dart';
import 'package:ecommerce/views/login_screen.dart';
import 'package:ecommerce/views/register_screen.dart';
import 'package:get/get.dart';

import '../views/home_screens/categories_items.dart';
import '../views/home_screens/profile_screen.dart';

class Routes{
  //initial route
  static String first = RouteNames.firstScreen;

  static List <GetPage> getPages = [
    GetPage(
        name: RouteNames.firstScreen,
        page:()=> HomeScreen()
    ),
    GetPage(
        name: RouteNames.loginScreen,
        page:()=> LoginScreen()
    ),
    GetPage(
        name: RouteNames.registerScreen,
        page:()=> RegisterScreen()
    ),
    GetPage(
        name: RouteNames.forgetPassword,
        page:()=> ForgetPasswordScreen()
    ),
    GetPage(
        name: RouteNames.homeLayout,
        page: ()=>HomeLayout(),
      binding: HomeBindings()
    ),
    GetPage(
        name: RouteNames.shopScreen,
        page: ()=>ShopScreen()
    ),
    GetPage(
      name: RouteNames.settingScreen,
      page: ()=>ProfileScreen()
    )
  ];
}
class RouteNames{
  static String firstScreen= '/firstScreen';
  static String loginScreen = '/loginScreen';
  static String registerScreen = '/registerScreen';
  static String forgetPassword = '/forgetPassword';
  static String homeLayout = '/homeLayout';
  static String shopScreen = '/shopScreen';
  static String detailsScreen = '/detailsScreen';
  static String settingScreen = '/settingScreen';

}
// first
// Second
// third