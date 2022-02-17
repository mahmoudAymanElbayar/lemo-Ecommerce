import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/component/my_string.dart';
import 'package:ecommerce/controller/shop_controller.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:ecommerce/shared_pref/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'language/localiztion.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  await CacheHelper.init();
  String widgetName;
  var isLogin = CacheHelper.getValue(key: 'isLogin');
  if(isLogin != null) widgetName = RouteNames.homeLayout;
  else widgetName = Routes.first;
  runApp(MyApp(screenName: widgetName,));
}

class MyApp extends StatelessWidget {
  String screenName;
   MyApp({Key? key,required this.screenName}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemesApp.light,
      locale: Locale(eng),
      translations: Localiztion(),
      fallbackLocale: Locale(eng),
      darkTheme: ThemesApp.dark,
      themeMode: ShopController().themeDataGet,
      initialRoute: screenName,
      getPages: Routes.getPages,
    );
  }
}
