import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'payment_screen.dart';

class ShopScreen extends StatelessWidget {

  CartController cartController =Get.put(CartController());
   ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      appBar: AppBar(
        backgroundColor: !Get.isDarkMode?mainColor:HexColor('#2f2a2a'),
        centerTitle: true,

        title: defaultText(text: 'Cart item',
          size: 24,
          color:!Get.isDarkMode?mainColor:Colors.pink,
        ),
        actions: [
          if(cartController.cartMapProducts.isNotEmpty)
          IconButton(
              onPressed: (){
                cartController.clearAll();
              },
              icon: const Icon(Icons.close,color: Colors.pink,)
          ),
        ],
      ),
      body:cartController.cartMapProducts.isEmpty? Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart,size: 180,color: Colors.grey.withOpacity(.4),),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultText(text: 'your cart is ',
                      color: !Get.isDarkMode?Colors.black:Colors.white
                  ),
                  defaultText(text: 'Empty'
                      ,color: !Get.isDarkMode?mainColor:Colors.pink),
                ],
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                style:ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(

                      vertical: MediaQuery.of(context).size.width*.025,
                      horizontal: MediaQuery.of(context).size.width*.1,

                    ),
                    primary: Get.isDarkMode?Colors.pink:mainColor.withOpacity(.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(16)
                    )
                ),
                onPressed: (){

                },
                child: defaultText(text: 'Go To Home',size: 30),
              ),
            ],
          ),
        ),

      ):Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: cartController.cartMapProducts.length,
                itemBuilder: (context,index)=>itemOfList(cartController.cartMapProducts.keys.toList()[index],context,index)
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 6,),
                    defaultText(text: 'total'
                        ,color: !Get.isDarkMode?Colors.grey:Colors.pink,
                        size: 20),
                    defaultText(
                        text: cartController.totalPrice.toString(),
                        color: !Get.isDarkMode?Colors.black:Colors.grey,size: 20),
                    const SizedBox(height: 6,),
                  ],
                ),
                ElevatedButton(

                  style:ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width*.025,
                        horizontal: MediaQuery.of(context).size.width*.1,
                      ),

                      primary: Get.isDarkMode?Colors.pink:mainColor.withOpacity(.8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(16)
                      )
                  ),
                  onPressed: (){
                    Get.to(PaymentScreen(totalPrice: cartController.totalPrice.toString()));
                  },
                  child: Row(
                    children: [
                      defaultText(text: 'Check Out',size: 30),
                      const SizedBox(width: 20,),
                      const Icon(Icons.shopping_cart)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
  Widget itemOfList(ProductModel model,context,index)=>Padding(
    padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*.22,
      decoration: BoxDecoration(
          color: mainColor.withOpacity(.5),
          borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: MediaQuery.of(context).size.width*.25,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(16)
              ),
              child: Image(
                image: NetworkImage(model.image.toString()),
                fit: BoxFit.contain,),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultText(
                    text:model.title.toString(),
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    size: 16,
                    color: Colors.black
                ),
                const SizedBox(
                  height: 25,
                ),
                defaultText(
                    text:('${cartController.totalOfItem[index].toStringAsFixed(2)} \$'),
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    size: 16,
                    color: Colors.black
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*.08,
                      child: FittedBox(
                        child: FloatingActionButton(
                          heroTag: "btn1$index",
                          onPressed: (){
                            cartController.removeCart(model);
                            print('${cartController.cartMapProducts.entries.map((e) => e.value).toList()[index]}');
                          },
                          elevation: 0.0,
                          backgroundColor: Colors.black,
                          child: const Icon(CupertinoIcons.minus,color: Colors.white,),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    defaultText(text: '${cartController.cartMapProducts.entries.map((e) => e.value).toList()[index]}',
                        size: 14,color: Colors.black),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*.08,
                      child: FittedBox(
                        child: FloatingActionButton(
                          heroTag: "btn2$index",
                          onPressed: (){
                            cartController.addCart(model);
                          },
                          elevation: 0.0,
                          backgroundColor: Colors.black,
                          child:
                          const Icon(Icons.add,color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                ),
                IconButton(
                    onPressed: (){
                      cartController.removeItem(model);
                    },
                    icon: const Icon(Icons.delete),color: Colors.red,)
              ],
            ),
          )
        ],
      ),
    ),
  );
}
