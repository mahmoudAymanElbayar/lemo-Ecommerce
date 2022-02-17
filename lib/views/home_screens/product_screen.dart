import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/controller/getdata_controller.dart';
import 'package:ecommerce/controller/shop_controller.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/views/home_screens/details_screen.dart';
import 'package:flutter/material.dart' ;
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductScreen extends StatelessWidget {
  ShopController shopController = Get.put(ShopController());
  GetDataFromAPI getDataController = Get.put(GetDataFromAPI());
  CartController cartController = Get.put(CartController());
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();

   ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(builder: (_)=>Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(children: [
        Container(

          width: double.infinity,
          height: MediaQuery.of(context).size.height*.25,
          decoration: BoxDecoration(
              color: !Get.isDarkMode?mainColor:HexColor('#2f2a2a'),
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: defaultText(text: 'F i n d   Y o u r',
                    color: !Get.isDarkMode?Colors.white:Colors.pink,
                    size: 24),
              ),
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: defaultText(text: 'INSPIRASTION',color:!Get.isDarkMode?Colors.white:Colors.pink,size: 28),
              ),
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Obx((){
                    return Expanded(
                    child: SizedBox(
                    child: defaultFormFaild(
                    controller: getDataController.searchController,
                    fillColor: HexColor('#F5F5F5'),
                    textColor: !Get.isDarkMode?mainColor:Colors.pink,
                    onChange: (value){
                      if(value.isNotEmpty) {
                        getDataController.changesuffIcon.value = true;
                      } else {
                        getDataController.changesuffIcon.value = false;
                      }

                    getDataController.searcWithTitleAndPrice(value);
                    },
                    suffixIcon:getDataController.changesuffIcon.value? IconButton(
                      onPressed: (){
                        getDataController.clearSearch();
                      },
                      icon:const Icon(Icons.close),color: !Get.isDarkMode?Colors.black:Colors.pink,):null,
                    prefixIcon: Icon(Icons.search,color: !Get.isDarkMode?Colors.grey:Colors.pink,),
                    padding: const EdgeInsets.only(bottom: 0),
                    hintText: 'search you\'re looking for'),

                    ),
                    );
                    }),
                    IconButton(onPressed: (){},
                      icon: const Icon(Icons.filter_list_outlined ),color: Get.isDarkMode?Colors.pink:Colors.white,iconSize: 40,)
                  ],
                ),
              )

            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Obx((){
            if(!getDataController.isLoading.value&&getDataController.searchList.isEmpty){
              return Center(child: SpinKitWave(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      //color: index.isEven ? Colors.red : Colors.green,
                      color: mainColor
                    ),
                  );
                },
               ),
              );
            }
            else if(getDataController.changesuffIcon.value){
              return AnimationLimiter(
                child: GridView.builder(
                    itemCount: getDataController.searchList.length,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisSpacing: 0,
                        childAspectRatio: 1/1.25,
                        crossAxisSpacing: 0,
                        maxCrossAxisExtent: 300
                    ),
                    itemBuilder: (context,index){
                      return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 2,
                          duration: const Duration(milliseconds: 375),
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: itemOfCard(context,getDataController.searchList[index],index),
                            ),
                          )
                      );
                    }
                ),
              );
            }else{
              return AnimationLimiter(
                child: GridView.builder(
                    itemCount: getDataController.productList.length,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisSpacing: 0,
                        childAspectRatio: 1/1.25,
                        crossAxisSpacing: 0,
                        maxCrossAxisExtent: 300
                    ),
                    itemBuilder: (context,index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: itemOfCard(context,getDataController.productList[index],index)
                          ),
                        ),
                      );
                    }
                ),
              );
            }
          })
        ),
      ],),
    ));
  }
  Widget itemOfCard(BuildContext context,ProductModel model,index)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: (){
        Get.to(DetailsScreen(productModel: model));
      },
      child: Card(
        color: Colors.white,
        elevation: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.grey,
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(16)
        ),
        // decoration: BoxDecoration(
        //     color: Colors.grey.withOpacity(.2),
        //   borderRadius: BorderRadiusDirectional.circular(16),
        //   boxShadow: const [
        //     BoxShadow(
        //       color: Colors.white,
        //       blurRadius: 5.0
        //     ),
        //   ]
        // ),
        child: Column(
          children: [
            Row(
              children: [
                Obx(()=>IconButton(
                    onPressed: (){
                      getDataController.addAndRemoveFavouriteItem(model.id);
                    },
                    icon: getDataController.changeIcon(model.id)?const Icon(Icons.favorite,color: Colors.red,)
                        :const Icon(Icons.favorite_border_outlined,
                                 color: Colors.black,
                    )
                ),),
                const Spacer(),
                IconButton(
                    onPressed: (){
                      cartController.addCart(model);
                    },
                    icon: const Icon(Icons.shopping_cart,color: Colors.black,)
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0,right: 8,left: 8),
              child:  Container(
                width: double.infinity,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height:  MediaQuery.of(context).size.height*.225,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(16),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Image(image: NetworkImage(model.image.toString()),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0,left: 6.0,bottom: 8.0),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.4),
                            borderRadius: BorderRadiusDirectional.circular(30)
                        ),
                        child:(Row(children:[
                          const SizedBox(width: 8,),
                          defaultText(
                            text: 'price',
                            size: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.red
                          ),
                          const Spacer(),
                          defaultText(
                              text: model.price.toString(),
                              size: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.normal
                          ),
                          const SizedBox(width: 8,),
                        ])),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

