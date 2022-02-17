import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartController extends GetxController{


  var cartMapProducts={}.obs;

  ProductModel? productModel;
  get totalOfItem => cartMapProducts.entries
      .map((e) => e.key.price *e.value).toList();
  get totalPrice => cartMapProducts.entries
      .map((e) => e.key.price *e.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);
  void addCart(ProductModel productModel){
    if(cartMapProducts.containsKey(productModel)){
      cartMapProducts[productModel] +=1;
      //print(cartMapProducts.toString());
      print(cartMapProducts
          .entries
          .map((e) => e.key.price *e.value).toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2)
      );
      Get.snackbar(
        'add prodect',
        'the producd added ',
        icon: const Icon(Icons.check),
        backgroundColor: Colors.grey.withOpacity(.8),
        colorText: Colors.black,


      );
    }else{
      cartMapProducts[productModel] = 1;
      //print(cartMapProducts.toString());
      print(cartMapProducts
          .entries
          .map((e) => e.key.price *e.value).toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2)
      );
      Get.snackbar(
          'add prodect',
          'the producd added ',
        icon: const Icon(Icons.check),
        backgroundColor: Colors.grey.withOpacity(.8),
        colorText: Colors.black,
        snackStyle: SnackStyle.GROUNDED,
      );
    }
  }
  void removeCart(ProductModel productModel){
    if(cartMapProducts.containsKey(productModel)&&cartMapProducts[productModel]==1){
      cartMapProducts.removeWhere((key, value) => key == productModel);
    }else{
      cartMapProducts[productModel] -=1;
    }
  }
  void removeItem(ProductModel productModel){
    Get.defaultDialog(
        title: 'remove product',
        titleStyle: TextStyle(
          color:Colors.black,
          fontSize: 20,
          fontFamily: GoogleFonts.zenTokyoZoo().toString(),
        ),
        middleText:'are you sure you want to remove this product',
        middleTextStyle: TextStyle(
          color:Colors.black,
          fontSize: 18,
          fontFamily: GoogleFonts.zenTokyoZoo().toString(),
        ),
        backgroundColor: Colors.white.withOpacity(.8),
        textCancel: 'No',
        cancelTextColor: Colors.black,
        textConfirm: 'Yes',
        confirmTextColor: Colors.black,
        buttonColor: mainColor,
        onConfirm: (){
          cartMapProducts.removeWhere((key, value) => key == productModel);
          Get.back();
        },
        onCancel: (){
          Get.offNamed(RouteNames.shopScreen);
        }


    );

  }
  void clearAll(){
    Get.defaultDialog(
        title: 'remove products',
        titleStyle: TextStyle(
          color:Colors.black,
          fontSize: 20,
          fontFamily: GoogleFonts.zenTokyoZoo().toString(),
        ),
        middleText:'are you sure you want to remove all products',
        middleTextStyle: TextStyle(
          color:Colors.black,
          fontSize: 18,
          fontFamily: GoogleFonts.zenTokyoZoo().toString(),
        ),
        backgroundColor: Colors.white.withOpacity(.8),
        textCancel: 'No',
        cancelTextColor: Colors.black,
        textConfirm: 'Yes',
        confirmTextColor: Colors.black,
        buttonColor: mainColor,
        onConfirm: (){
          cartMapProducts.clear();
          Get.back();
        },
        onCancel: (){
          Get.offNamed(RouteNames.shopScreen);
        }


    );
  }

}