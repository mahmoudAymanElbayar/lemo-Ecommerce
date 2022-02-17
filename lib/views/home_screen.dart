import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('asset/images/background.png',fit: BoxFit.cover,),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*.16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*.5,
                  height: MediaQuery.of(context).size.height*.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(16),
                    color: Colors.black.withOpacity(.3),
                  ),
                  child:Center(
                      child: defaultText(text: 'welcome')
                  )

                ),
                const SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width*.65,
                  height: MediaQuery.of(context).size.height*.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(16),
                    color: Colors.black.withOpacity(.3),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultText(text: 'lemo',color: mainColor),
                      const SizedBox(width: 6,),
                      defaultText(text: 'Shop'),
                    ],
                  )

                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width*.5,
                ),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width*.15,
                      vertical: MediaQuery.of(context).size.width*.03,
                    ),
                    primary: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(16)
                    )
                  ),
                    onPressed: (){
                    Get.offNamed(RouteNames.loginScreen);
                    },
                    child: defaultText(text: 'Get start',size: 30),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultText(text: 'Don\'t have an Account?',size: 16,fontWeight: FontWeight.normal),
                    TextButton(
                        onPressed: (){
                          Get.toNamed(RouteNames.registerScreen);
                        },
                        child: defaultText(text: 'sign up',undelLineText: true,size: 16,fontWeight: FontWeight.normal)
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),

      ),
    );
  }
}
