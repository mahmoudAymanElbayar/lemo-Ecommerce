
import 'dart:convert';

import 'package:ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http;

class GetDataFromAPI extends GetxController{
  var storage = GetStorage();
  var  productList=[].obs;
  var isLoading=true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    List<dynamic>? lemoStore = GetStorage().read<List>('favourites');

    print('////////////////////////$lemoStore');
    if (lemoStore !=null) {
      favouriteList = lemoStore.map((element) => ProductModel.fromjson(element)).toList().obs ;
    }
    getData();
  }

  Future<void> getData() async {
    isLoading(false);
    var url = Uri.parse('https://fakestoreapi.com/products');
    await http.get(url).then((value) {
      // print('==================================================');
      // print(value.body);
      // print('==================================================');
      productList = RxList<ProductModel>.from(
        jsonDecode(value.body).map((x)=>ProductModel.fromjson(x))
      );
      ///another way ///
      // json.decode(value.body).forEach((element) {
      //   productList.add(ProductModel.fromjson(element));
      // });
      //print('======================== success =========================');
      isLoading(true);
    }).catchError((onError){
      //print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      Get.snackbar('check your data', 'connection timed out ');
      // print(onError.toString());
      // print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    });
  }

  var favouriteList=[].obs;
  var list=[].obs;
  ProductModel? productModel;
  void addAndRemoveFavouriteItem(int productId)async{
    var index = favouriteList.indexWhere((element) =>element.id==productId);
    print(index);
    if(index >= 0) {
      favouriteList.removeAt(index);
      await storage.remove('favourites').then((value) => {
        print('removed')
      }).catchError((onError){
        print(onError);
      });
    } else {
      list=[].obs;
      favouriteList.add(productList.firstWhere((element) => element.id==productId));
      favouriteList.forEach((element) {
        list.add(element.tojson());
      });
      await storage.write('favourites', list).then((value) => {
        print('adddddddddddedddddddddd')
      }).catchError((onError){
        print('the errrrrrrrrrrrrrrror$onError');
      });
    }
    print(favouriteList);
  }
  bool changeIcon(int productId){
    return favouriteList.any((element) => element.id==productId);
  }

  var searchList=[].obs;
  var searchController = TextEditingController();
  var changesuffIcon = false.obs;
  searcWithTitleAndPrice(String text){
    searchList.value = productList.where((search) {
      return search.title.toLowerCase().contains(text.toLowerCase())||
          search.price.toString().toLowerCase().contains(text.toLowerCase());
    } ).toList();
  }

  void clearSearch(){
    searchController.clear();
    searcWithTitleAndPrice('');
    changesuffIcon.value = false;
  }






















}