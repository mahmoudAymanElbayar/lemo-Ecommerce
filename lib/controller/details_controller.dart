import 'package:get/get.dart';

class DetailsController extends GetxController{
  RxInt currentPage = 0.obs;
  int currentColor = 0;
  int currentSize = 0;
  List<String> size=[
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];
  void change(int ibex){
    currentColor = ibex;
    update();
  }
  void changeSize(int index){
    currentSize = index;
    update();
  }

}