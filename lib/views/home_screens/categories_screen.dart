import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/views/home_screens/categories_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/get_categories.dart';
class CategoriesScreen extends StatelessWidget {
  GetCategories getCategories = Get.put(GetCategories());
   CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(()=>!getCategories.getCat.value?
      const Center(child:  CircularProgressIndicator()):
      ListView.separated(
          itemBuilder: (context,index)=>itemOfList(context,getCategories.namesCategories[index],getCategories.imageCategories[index]),
          separatorBuilder: (context,index)=>const SizedBox(
            height: 12,
          ),
          itemCount: getCategories.namesCategories.length))
    );
  }
  Widget itemOfList (context,String name,String imageUrl)=>InkWell(
    onTap: (){
      getCategories.getCategories();
      getCategories.getCategoriesItems(name: name);
      Get.to(()=>CategoriesItems());
    },
    child: Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: MediaQuery.of(context).size.height*.3,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              image: DecorationImage(image: NetworkImage(imageUrl),
                  fit: BoxFit.cover
              ),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))
          ),
        ),
        Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.3)

            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: defaultText(text: name,size: MediaQuery.of(context).textScaleFactor*16,),
            )),
      ],
    ),
  );
}
