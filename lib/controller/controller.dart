import 'package:get/get.dart';

class HomeController extends GetxController{
  bool isShow = false;
  bool show = true;
  bool checkBox= false;
  bool checkBox2= false;

  void visibility(){
    isShow = !isShow;
    //print(isShow);
    update();
  }
  void visibilityInLogin(){
    show = !show;
    update();
  }
  void changeCheckBox(){
    checkBox = !checkBox;
    update();
  }
  void changeCheckBoxInLogin(){
    checkBox2 = !checkBox2;
    update();
  }

}