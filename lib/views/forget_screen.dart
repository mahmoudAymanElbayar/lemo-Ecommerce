import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/component/my_string.dart';
import 'package:ecommerce/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgetPasswordScreen extends StatelessWidget {
  var emailController = TextEditingController();
  AuthController resetpass = Get.put(AuthController());
  var formKey = GlobalKey<FormState>();
   ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode?Colors.white:HexColor('#2f2a2a'),
      appBar: AppBar(
        backgroundColor: Get.isDarkMode?Colors.white:HexColor('#2f2a2a'),
        title: Text('forget Password',
        style: TextStyle(
          color: Get.isDarkMode? mainColor:Colors.pink,
          fontSize: 24
        ),
        ),
        elevation: 0.0,
        leading: IconButton(onPressed: (){
          Get.back();
        },
            icon: const Icon(Icons.arrow_back),color: Get.isDarkMode?mainColor:Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    icon: Icon(Icons.close,size: 30,color:Get.isDarkMode?mainColor: Colors.white,),
                  ),
                ),
                defaultText(text: 'check your email',size: 24,color: Get.isDarkMode?mainColor:Colors.white),
                Image.asset('asset/images/forgetpass.png'),
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
                const SizedBox(height: 30,),

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
                            resetpass.resetPassword(emailController.text.trim());
                          }
                        },
                        child: defaultText(text: 'send email',size: 30),
                      ),
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
