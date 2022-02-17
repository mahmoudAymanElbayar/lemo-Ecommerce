import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/component/my_string.dart';
import 'package:ecommerce/controller/auth/auth_controller.dart';
import 'package:ecommerce/controller/controller.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  AuthController loginController = Get.put(AuthController());
  HomeController authController = Get.put(HomeController());
   LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode?Colors.white:HexColor('#2f2a2a'),
      appBar: AppBar(
        backgroundColor: Get.isDarkMode?Colors.white:HexColor('#2f2a2a'),
        elevation: 0.0,
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*.75,
                //color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          defaultText(
                              text: 'LOG',
                              color:Get.isDarkMode?mainColor:Colors.pink
                          ),
                          const SizedBox(width: 7,),
                          defaultText(text: 'IN',color: Get.isDarkMode?Colors.black:Colors.white),
                        ],
                      ),
                      const SizedBox(height: 30,),

                      SizedBox(
                        child: defaultFormFaild(
                            controller: emailController,
                            prefixIcon: Get.isDarkMode?Image.asset('asset/images/email.png'):const Icon(Icons.email,color: Colors.pink,size: 28,),
                            hintText: 'email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(!RegExp(validationEmail).hasMatch(value!)){
                                return 'invalid email';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 20,),
                      GetBuilder<HomeController>(
                          builder: (contr)=>SizedBox(
                            child: defaultFormFaild(
                              controller: passwordController,
                              prefixIcon: Get.isDarkMode?Image.asset('asset/images/lock.png'):const Icon(Icons.lock,color: Colors.pink,size: 28,),
                              hintText: 'password',
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value){
                                if (value.toString().length < 6){
                                  return 'the password is week';
                                }
                                return null;
                              },
                              obscureText: authController.show,
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    authController.visibilityInLogin();
                                  },
                                  icon: authController.show?const Icon(Icons.visibility,color: Colors.black,):const Icon(Icons.visibility_off_outlined,color: Colors.black,)
                              ),

                            ),
                          ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                            onPressed: (){
                              Get.toNamed(RouteNames.forgetPassword);
                            },
                            child: defaultText(text: 'forget password?',color: Get.isDarkMode?Colors.black:Colors.white,size: 16,fontWeight: FontWeight.normal),
                        ),
                      ),

                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              authController.changeCheckBoxInLogin();
                            },
                            child:GetBuilder<HomeController>(
                              builder: (cont)=> Container(
                                width: MediaQuery.of(context).size.width*.07,
                                height: MediaQuery.of(context).size.width*.07,
                                color: Colors.grey.shade300,
                                child: authController.checkBox2?
                                Get.isDarkMode?Image.asset('asset/images/check.png'):const Icon(Icons.check,color: Colors.pink,size: 28,)
                                :null,
                              ),
                            )
                          ),
                          defaultText(text: '  remember me',color: Get.isDarkMode?Colors.black:Colors.white,size: 16,fontWeight: FontWeight.normal),

                        ],
                      ),
                      const SizedBox(height: 20,),

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
                            if(formKey.currentState!.validate()){
                              loginController.login(email: emailController.text, password: passwordController.text);
                            }
                          },
                          child: defaultText(text: 'Get start',size: 30),
                        ),
                      ),
                      ),
                      const SizedBox(height: 10,),
                      defaultText(text: 'OR',color: Get.isDarkMode?Colors.black:Colors.white,size: 16,fontWeight: FontWeight.normal),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GetBuilder<AuthController>(builder: (_)=>IconButton(
                              onPressed: (){
                                loginController.loginWithFacebook();
                              },
                              icon: Image.asset('asset/images/facebook.png')),),
                          GetBuilder<AuthController>(builder: (_)=>IconButton(
                              onPressed: (){
                                loginController.loginWithGoogle();
                              },
                              icon: Image.asset('asset/images/google.png',)),)

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width*.222,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(

                      vertical: MediaQuery.of(context).size.width*.025,
                    ),
                    primary: Get.isDarkMode?mainColor:Colors.pink,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                    )
                ),
                onPressed: (){
                  Get.toNamed(RouteNames.registerScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultText(text: 'Already have an account?',size: 16),
                    defaultText(text: ' sign up',size: 16,undelLineText: true),

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
