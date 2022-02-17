import 'package:badges/badges.dart';
import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/controller/shop_controller.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'home_screens/categories_screen.dart';
import 'home_screens/favourite_screen.dart';
import 'home_screens/product_screen.dart';
import 'home_screens/profile_screen.dart';

class HomeLayout extends StatelessWidget {
  ShopController controller = Get.find<ShopController>();
  CartController cartController = Get.put(CartController());
  final screens=[
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    ProfileScreen()
  ];
  final screenTitle=[
    'Limo Shop',
    'Notifications',
    'Favourites',
    'Profile'
  ];
   HomeLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text('lemo Shop',style: TextStyle(
    //       fontSize: 24,
    //     ),),
    //     elevation: 0,
    //     backgroundColor: mainColor,
    //   ),
    //   body: Column(children: [
    //     Container(
    //       width: double.infinity,
    //       height: MediaQuery.of(context).size.height*.25,
    //       decoration: BoxDecoration(
    //           color: mainColor,
    //           borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
    //       ),
    //       child: Column(
    //         //mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 30),
    //             child: defaultText(text: 'F i n d   Y o u r',size: 24),
    //           ),
    //           SizedBox(height: 8,),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 30),
    //             child: defaultText(text: 'INSPIRASTION',size: 28),
    //           ),
    //           SizedBox(height: 8,),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   child: SizedBox(
    //                     child: defaultFormFaild(
    //                         controller: searchController,
    //                         prefixIcon: Icon(Icons.search),
    //                         padding: EdgeInsets.only(bottom: 0),
    //                         hintText: 'search you\'re looking for'),
    //
    //                   ),
    //                 ),
    //                 IconButton(onPressed: (){},
    //                     icon: Icon(Icons.filter_list_outlined ),color: Colors.white,iconSize: 40,)
    //               ],
    //             ),
    //           )
    //
    //         ],
    //       ),
    //     ),
    //     TextButton(onPressed: (){
    //       Get.offNamed(RouteNames.loginScreen);
    //     }, child: Text('log out'))
    //   ],),
    // );
    return SafeArea(
        child: Obx((){
          return Scaffold(
              backgroundColor: context.theme.scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Get.isDarkMode?HexColor('#2f2a2a'):mainColor,
                elevation: 0.0,
                centerTitle: true,
                actions: [

                  if (controller.currentIndex.value!=3) Badge(
                    position: BadgePosition.topEnd(top: 0, end: 3),
                    animationDuration: const Duration(milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      '${cartController.cartMapProducts.length!=0?
                          cartController
                          .cartMapProducts
                          .entries.map((e) => e.value).toList()
                      .reduce((value, element) => value+element):0
                      }',
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: IconButton(onPressed: (){
                      Get.toNamed(RouteNames.shopScreen);
                    },
                      icon: const Icon(Icons.shopping_cart),
                      color: Get.isDarkMode?Colors.pink:Colors.white,
                    ),
                  )
                ],
                title: Text(screenTitle[controller.currentIndex.value],
                  style:  TextStyle(fontSize: 24,color: !Get.isDarkMode?Colors.white:Colors.pink),),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                selectedItemColor: !Get.isDarkMode?mainColor:Colors.pink,
                unselectedItemColor: !Get.isDarkMode?Colors.black:Colors.white,
                backgroundColor: !Get.isDarkMode?Colors.white:HexColor('#2f2a2a'),
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home,),label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.category_rounded ),label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: ''),
                  BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled,),label: ''),
                ],
                onTap: (index){
                  controller.currentIndex.value = index;
                },
              ),
              body: IndexedStack(
                index: controller.currentIndex.value,
                children: screens,
              )
          );
        })
    );
  }
}
