import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/component/my_string.dart';
import 'package:ecommerce/model/facebook_user_model.dart';
import 'package:ecommerce/model/user_model.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:ecommerce/shared_pref/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController{
  @override
  void onInit() {
    var islogin = CacheHelper.getValue(key: 'isLogin');
      getUser();

  }
  UserModel? userModel;
  bool isFacebook=false;
  void creatUser({
      required String uId,
      required String name,
      required String email,
      required String image
   }){
    userModel = UserModel(name, email, image, uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId).set(userModel!.toMap()).then((value) {
          print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
          CacheHelper.putValue(key: 'isLogin',value: uId );
          update();
          Get.offNamed(RouteNames.homeLayout);
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void getUser({String? newToken})async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(newToken??CacheHelper.getValue(key: 'isLogin').toString())
        .get()
        .then((value) {
          print(CacheHelper.getValue(key: 'isLogin'));
          print('||||||||||||||||||||||||||||||$newToken');
          if(CacheHelper.getValue(key: 'facebook') !=null){
            faceUserModel = FaceBookUserModel.fromJson(value.data() as Map<String,dynamic>);
            isFacebook = true;
          }else{
            userModel = UserModel.fromjson(value.data() as Map<String,dynamic>);
            isFacebook = false;
          }
          print('============================ user get ======================');
          update();
        }).catchError((onError){
      print(onError.toString());
    });
  }
  void login({
    required String email,
    required String password,
})async{
    String message = '';
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value){
        print(value.user!.uid);
        uId=value.user!.uid;
        CacheHelper.putValue(key: 'isLogin',value: value.user!.uid ).then((value) => {
          getUser(newToken: uId )
        });
        update();
        Get.offNamed(RouteNames.homeLayout);

      }).catchError((onError){
        print(onError.toString());
        if (onError.code == 'user-not-found') {
          message = 'No user found for that email.';
          print('No user found for that email.');

          print('No user found for that email.');
        } else if (onError.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          message = 'Wrong password provided for that user.';
        }
        Get.snackbar(
            'error',
            message,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP
        );

      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
        print('No user found for that email.');

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        message = 'Wrong password provided for that user.';
      }
      Get.snackbar(
          'error',
          message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP
      );
    }
  }
  void register({
  required String name,
    required String email,
    required String password,
}) async {
    String title = '';
    String message = '';
    try {
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
        print(value.user);
        print('===============================================================');
        print(value.user!.uid);
        print('===============================================================');
        uId = value.user!.uid;
        creatUser(
            uId: value.user!.uid,
            name: name,
            email: email,
            image: 'https://image.flaticon.com/icons/png/512/747/747545.png'
        );

       });

    } on FirebaseAuthException catch (e) {
      title = e.code.toString().replaceAll(RegExp('-'), ' ').capitalize!;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
        print('The account already exists for that email.');
      }
      Get.snackbar(
          title,
          message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP
      );
    } catch (e) {
      print(e);
      Get.snackbar('error', e.toString());
    }
  }
  void resetPassword(String email)async{
    try {
       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
       update();
       Get.toNamed(RouteNames.loginScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  GoogleSignInAccount? googleUser;
  void loginWithGoogle()async{
      await GoogleSignIn().signIn().then((value) {
        creatUser(uId: value!.id, name: value.displayName.toString(), email: value.email, image: value.photoUrl.toString());
        googleUser= value;
        getUser(newToken: value.id);
        CacheHelper.putValue(key: 'isLogin', value: value.id).then((value) {
          Get.offNamed(RouteNames.homeLayout);
        });
        // print('=============================================rr=============================');
        // print(value.email);
        // print(value.displayName);
        // print(value.id);
        // print(value.photoUrl);
        // print('==========================================================================');
        //update();

      }).catchError((onError){
        print(onError.toString());
      });

  }
  FaceBookUserModel? faceUserModel;
  void loginWithFacebook()async{
    final LoginResult loginResult = await FacebookAuth.instance.login();
    FacebookAuth.instance.getUserData().then((value) {
      faceUserModel = FaceBookUserModel.fromJson(value);
      CacheHelper.putValue(key:'isLogin',value: faceUserModel!.id);
      CacheHelper.putValue(key: 'facebook', value: faceUserModel!.id).then((value) {
        getUser(newToken: CacheHelper.getValue(key: 'isLogin').toString());
      });
      // print(faceUserModel!.email);
      // print(faceUserModel!.name);
      // print(faceUserModel!.id);
      // print(faceUserModel!.picture.data.url);

      creatUserFromFaceBook(
          id: faceUserModel!.id,
          name: faceUserModel!.name,
          email: faceUserModel!.email,
          picture: faceUserModel!.picture
      );
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void creatUserFromFaceBook({
    required String id,
    required String name,
    required String email,
    required Picture picture,
}){
    faceUserModel = FaceBookUserModel(
        name: name,
        email: email,
        picture: picture,
        id: id
    );
    FirebaseFirestore.instance
        .collection('users').doc(id)
        .set(faceUserModel!.toJson()).then((value) {
          print('successssssssssssssssssssssssssssss');
          Get.offNamed(RouteNames.homeLayout);
    }).catchError((onError){
      print(onError.toString());
    });
  }
}