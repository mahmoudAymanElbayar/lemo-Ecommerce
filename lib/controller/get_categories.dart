import 'dart:convert';

import 'package:ecommerce/model/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
class GetCategories extends GetxController{
  @override
  void onInit() {
    getCategories();
  }
  RxList <String> namesCategories = <String>[].obs;
  RxList categoriesItem = [].obs;
  RxList <String> imageCategories = <String>[
    'https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg',
    'https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
    'https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg'
  ].obs;
  var isLoading=true.obs;
  var getCat=true.obs;

  void getCategories ()async{
    getCat(false);
    var url = Uri.parse('https://fakestoreapi.com/products/categories');
    await http.get(url).then((value) {
      namesCategories = RxList<String>.from(
        jsonDecode(value.body)
      );
      getCat(true);
     // print('|||||||||||||||||||||$namesCategories');
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void getCategoriesItems({required String name})async{
    isLoading(false);
    var url = Uri.parse('https://fakestoreapi.com/products/category/$name');
    await http.get(url).then((value) {
     categoriesItem = RxList<ProductModel>.from(
       jsonDecode(value.body).map((x)=>ProductModel.fromjson(x))
     );
     isLoading(true);
     //print(categoriesItem);
    }).catchError((onError){
     print(onError.toString());
    });
  }
}