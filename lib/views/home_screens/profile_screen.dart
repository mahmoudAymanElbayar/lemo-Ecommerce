import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/controller/auth/auth_controller.dart';
import 'package:ecommerce/controller/shop_controller.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:ecommerce/shared_pref/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../component/my_string.dart';
import '../../controller/setting_controller.dart';

class ProfileScreen extends StatelessWidget {
  ShopController controller = Get.find<ShopController>();
  AuthController authController = Get.put(AuthController());
  SettingController settingController = Get.put(SettingController());

  ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<AuthController>(
            builder: (_)=>Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(authController.isFacebook && authController.faceUserModel!=null?
                  authController.faceUserModel!.picture.data.url
                      .toString()
                      : authController.userModel != null
                      ? authController.userModel!.image.toString()
                      : 'https://static.remove.bg/remove-bg-web/1edb6b547ebc0098fab06852edf91aa18cfebce0/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png'),
                  radius: MediaQuery.of(context).size.width * .1,
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultText(
                        text: authController.isFacebook && authController.faceUserModel!=null
                            ? authController.faceUserModel!.name.toString()
                            : authController.userModel != null
                            ? authController.userModel!.name.toString()
                            : '',
                        color: !Get.isDarkMode?Colors.black:Colors.white,
                        size: MediaQuery.of(context).textScaleFactor * 20),
                    Text(
                      authController.isFacebook && authController.faceUserModel!=null
                          ? authController.faceUserModel!.email
                          .toString()
                          : authController.userModel != null
                          ? authController.userModel!.email.toString()
                          : '',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey,
            ),
          ),
          defaultText(
              text: 'General'.tr,
              color: !Get.isDarkMode?Colors.green:Colors.pink,
              size: MediaQuery.of(context).textScaleFactor * 20),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => Row(
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.brightness_4_sharp,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * .09,
                  ),
                  radius: MediaQuery.of(context).size.width * .08,
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: defaultText(
                      text: 'Dark Mode'.tr,
                      color: !Get.isDarkMode?Colors.black:Colors.white,
                      size: MediaQuery.of(context).textScaleFactor * 20),
                ),
                Switch(
                  value: settingController.darkMode.value,

                  activeColor: !Get.isDarkMode?Colors.deepPurpleAccent:Colors.pink,
                  onChanged: (value) {
                    print(value);
                    print(settingController.darkMode.value,);
                    Get.isDarkMode
                        ? Get.changeThemeMode(ThemeMode.light)
                        : Get.changeThemeMode(ThemeMode.dark);
                    controller.changeTheme();

                    settingController.darkMode.value = value;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GetBuilder<SettingController>( builder: (GetxController controller) =>Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.language,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * .09,
                ),
                radius: MediaQuery.of(context).size.width * .08,
                backgroundColor: Colors.purpleAccent,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: defaultText(
                    text: 'Language'.tr,
                    color: !Get.isDarkMode?Colors.black:Colors.white,
                    size: MediaQuery.of(context).textScaleFactor * 20),
              ),
              Container(
                width: MediaQuery.of(context).size.width*.25,
                height: MediaQuery.of(context).size.width * .12,
                decoration: BoxDecoration(
                  //color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)
                ),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(Icons.arrow_drop_down_sharp,
                        color: !Get.isDarkMode?Colors.black:Colors.white,
                      ),
                      iconSize: 30,
                      onChanged: (valuee) {
                        CacheHelper.putValue(key: 'lang', value: valuee).then((value) {
                          settingController.updateLang(typeOfLang: valuee!);
                        }).catchError((onError){
                          print(onError.toString());
                        });
                      },
                      value:CacheHelper.getValue(key: 'lang')!=null?
                          CacheHelper.getValue(key: 'lang').toString()
                          : eng,
                      items: [
                        DropdownMenuItem(
                          child: defaultText(text: '$english EN',
                              size: MediaQuery.of(context).textScaleFactor * 20,
                              color: !Get.isDarkMode?Colors.black:Colors.white,
                          ),
                          value: eng,
                        ) ,
                        DropdownMenuItem(
                          child: defaultText(text: '$arabic AR',
                              size: MediaQuery.of(context).textScaleFactor * 20,
                              color: !Get.isDarkMode?Colors.black:Colors.white,
                          ),
                          value: arb,
                        ) ,
                        DropdownMenuItem(
                          child: defaultText(text: '$french FR',
                              size: MediaQuery.of(context).textScaleFactor * 20,
                              color: !Get.isDarkMode?Colors.black:Colors.white,
                          ),
                          value: frn,
                        ) ,
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              Get.defaultDialog(
                  title: 'LOGOUT',
                  titleStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: GoogleFonts.zenTokyoZoo().toString(),
                  ),
                  middleText: 'are you sure you want to logout',
                  middleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: GoogleFonts.zenTokyoZoo().toString(),
                  ),
                  backgroundColor: Colors.white.withOpacity(.8),
                  textCancel: 'No',
                  cancelTextColor: Colors.black,
                  textConfirm: 'Yes',
                  confirmTextColor: Colors.black,
                  buttonColor: mainColor,
                  onConfirm: () {
                    CacheHelper.removeValue(key: 'isLogin');
                    CacheHelper.removeValue(key: 'facebook');
                    authController.userModel=null;
                    authController.faceUserModel=null;
                    controller.currentIndex.value = 0;
                    Get.offNamed(RouteNames.loginScreen);
                  },
                  onCancel: () {
                    Get.back();
                  });
            },
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * .09,
                  ),
                  radius: MediaQuery.of(context).size.width * .08,
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: defaultText(
                      text: 'logout'.tr,
                      color: !Get.isDarkMode?Colors.black:Colors.white,
                      size: MediaQuery.of(context).textScaleFactor * 20),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
