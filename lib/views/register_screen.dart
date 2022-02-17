import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/component/my_string.dart';
import 'package:ecommerce/controller/auth/auth_controller.dart';
import 'package:ecommerce/controller/controller.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  HomeController authController = Get.put(HomeController());
  AuthController registerController= Get.put(AuthController());
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
   RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode?Colors.white:HexColor('#2f2a2a'),
      appBar: AppBar(
        backgroundColor: Get.isDarkMode?Colors.white:HexColor('#2f2a2a'),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*.75,
              //color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          defaultText(text: 'Sign',color: Get.isDarkMode?mainColor:Colors.pink),
                          const SizedBox(width: 7,),
                          defaultText(text: 'Up',color:Get.isDarkMode?Colors.black:Colors.white),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      SizedBox(
                        child: defaultFormFaild(
                            controller: userNameController,
                            prefixIcon: Get.isDarkMode?Image.asset('asset/images/user.png'):const Icon(Icons.person,size: 28,color: Colors.pink,),
                            hintText: 'user name',
                            validator: (value){
                              if(value.toString().length <=2 || !RegExp(validationName).hasMatch(value.toString())){
                                return 'invalid name';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 16,),
                      SizedBox(
                        child: defaultFormFaild(
                            controller: emailController,
                            prefixIcon: Get.isDarkMode?Image.asset('asset/images/email.png'):const Icon(Icons.email,size: 28,color: Colors.pink,),
                            hintText: 'email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(!RegExp(validationEmail).hasMatch(value.toString())){
                                return 'invalid email';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 16,),
                      GetBuilder<HomeController>(
                          init: HomeController(),
                          builder: (control)=> SizedBox(
                            child: defaultFormFaild(
                                controller: passwordController,
                                prefixIcon: Get.isDarkMode?Image.asset('asset/images/lock.png'):const Icon(Icons.lock,size: 28,color: Colors.pink,),
                                hintText: 'password',
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !authController.isShow,
                                suffixIcon: IconButton(
                                    onPressed: (){
                                      authController.visibility();
                                    },
                                    icon: authController.isShow?const Icon(Icons.visibility_off_outlined,color: Colors.black,):const Icon(Icons.visibility,color: Colors.black,)
                                ),
                                validator: (value){
                                  if(value.toString().length < 6){
                                    return 'password is short';
                                  }
                                  return null;
                                }

                            ),
                          ),
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        children: [
                          InkWell(
                            child: GetBuilder<HomeController>(
                              init: HomeController(),
                              builder: (control)=> Container(
                                width: MediaQuery.of(context).size.width*.07,
                                height: MediaQuery.of(context).size.width*.07,
                                color: Colors.grey.shade300,
                                child: authController.checkBox?Get.isDarkMode?Image.asset('asset/images/check.png'):const Icon(Icons.check,size: 28,color: Colors.pink,):null,
                              ),
                            ),
                            onTap: (){
                              authController.changeCheckBox();
                            },
                          ),
                          defaultText(text: ' i accept',color: Get.isDarkMode?Colors.black:Colors.white,size: 16,fontWeight: FontWeight.normal),
                          defaultText(text: ' terms & conditions',color: Get.isDarkMode?Colors.black:Colors.white,size: 16,fontWeight: FontWeight.normal ,undelLineText: true)

                        ],
                      ),
                      const SizedBox(height: 16,),

                      GetBuilder<AuthController>(
                          builder: (_)=>SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style:ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(

                                    vertical: MediaQuery.of(context).size.width*.025,
                                  ),
                                  primary: Get.isDarkMode?mainColor:Colors.pink,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.circular(16)
                                  )
                              ),
                              onPressed: (){
                                if(formKey.currentState!.validate()&&authController.checkBox==true){
                                  registerController.register(
                                      name: userNameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text
                                  );
                                } else{
                                  Get.snackbar('error', 'you must accept terms',backgroundColor: Colors.green,colorText: Colors.white);
                                }

                              },
                              child: defaultText(text: 'Sign Up',size: 30),
                            ),
                          ),
                      )

                    ],
                  ),
                ),
              ),
            ),
            //SizedBox(height: 100,),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width*.222,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(

                      vertical: MediaQuery.of(context).size.width*.02,
                    ),
                    primary: Get.isDarkMode?mainColor:Colors.pink,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                    )
                ),
                onPressed: (){
                  Get.toNamed(RouteNames.loginScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultText(text: 'Already have an account?',size: 16),
                    defaultText(text: ' sign in',size: 16,undelLineText: true),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
