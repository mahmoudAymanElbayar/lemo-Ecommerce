import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/controller/getdata_controller.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/views/home_screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/get_categories.dart';

class CategoriesItems extends StatelessWidget {
  GetCategories getCategories = Get.put(GetCategories());
  GetDataFromAPI getDataController = Get.put(GetDataFromAPI());
  CartController cartController = Get.put(CartController());
  CategoriesItems({Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Obx(()=>!getCategories.isLoading.value?const Center(child: CircularProgressIndicator()):
          GridView.builder(
          itemCount: getCategories.categoriesItem.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 0,
              childAspectRatio: 1/1.25,
              crossAxisSpacing: 0,
              maxCrossAxisExtent: 300
          ),
          itemBuilder: (context,index)=>itemOfCard(context,getCategories.categoriesItem[index],index)
      )),
    );
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
                    icon: const Icon(Icons.shopping_cart,
                      color: Colors.black
                    )
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
