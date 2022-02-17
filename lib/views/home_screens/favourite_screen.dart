import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/controller/getdata_controller.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatelessWidget {
  GetDataFromAPI getController = Get.put(GetDataFromAPI());
   FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Obx(()=>Scaffold(
        body: getController.favouriteList.isEmpty?
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Image.asset(
                'asset/images/heart.png',
                color: Colors.grey.withOpacity(.4),
              ),
              defaultText(
                  text: 'No Items Yet', color: Colors.grey.withOpacity(.4))
            ],
          ),
        ):
        Obx(()=>ListView.separated(
            itemBuilder: (context,index)=>itemList(getController.favouriteList[index], context),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 1,color: Colors.grey,),
            ),
            itemCount: getController.favouriteList.length),)
    ));
  }
  Widget itemList( ProductModel model,context)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Image(image: NetworkImage(model.image),
            height: 100,
            width: 100,
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text( model.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        height: 1.5
                    ),
                  ),

                  Row(

                    children: [
                      Text( model.price.toString(),

                        style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 16
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          //color: ShopAppCubit.get(context).favouriteMap[dataList.productData!.id] == true ? Colors.orange : Colors.grey[400] ,
                          onPressed: (){
                            getController.addAndRemoveFavouriteItem(model.id);
                          },
                          icon: getController.changeIcon(model.id)? const Icon(Icons.favorite,color: Colors.red,):const Icon(Icons.favorite_outline_rounded)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
