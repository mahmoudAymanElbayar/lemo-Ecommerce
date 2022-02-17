import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/controller/details_controller.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/controller/getdata_controller.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailsScreen extends StatelessWidget {
  ProductModel productModel;

  var carouselController = CarouselController();
  DetailsController detailsController = Get.put(DetailsController());
  CartController cartController = Get.put(CartController());
  GetDataFromAPI favourite = Get.put(GetDataFromAPI());
  List<Color> itemColor = [
    kCOlor1,
    kCOlor2,
    kCOlor3,
    kCOlor4,
    kCOlor5,
  ];

  DetailsScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scale = MediaQuery.of(context).textScaleFactor;
    print(scale);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*.5,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)

                      ),
                      child: CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (context,index,realIndex){
                            return
                            Image(image: NetworkImage(productModel.image),
                            fit: BoxFit.contain,
                            width: double.infinity,
                            );
                          },

                          carouselController: carouselController,

                          options: CarouselOptions(

                              height:double.infinity,
                              initialPage: 1,
                              viewportFraction: 1.0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration: const Duration(seconds: 3),
                              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index,CarouselPageChangedReason carousel){
                                detailsController.currentPage.value = index;
                                print(index);
                              }
                          )
                      ),

                    ),
                    Obx(()=>Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AnimatedSmoothIndicator(
                        count:  3,
                        axisDirection: Axis.horizontal,
                        activeIndex: detailsController.currentPage.value,
                        effect:  const ExpandingDotsEffect(
                            spacing:  8.0,
                            radius:  5.0,
                            dotWidth:  10.0,
                            dotHeight:  8.0,
                            expansionFactor: 4.0,
                            paintStyle:  PaintingStyle.fill,
                            strokeWidth:  1.5,
                            dotColor:  Colors.grey,
                            activeDotColor:  Colors.black
                        ),

                      ),
                    )),
                    Positioned(
                        right: 8,
                        bottom: 16,
                        child: Container(
                            width: MediaQuery.of(context).size.width * .1,
                            height: MediaQuery.of(context).size.height * .25,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.3),
                                borderRadius: BorderRadius.circular(20)),
                            child: GetBuilder<DetailsController>(
                              builder: (_) => Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) =>
                                            itemOfColorList(
                                                itemColor[index],
                                                detailsController
                                                        .currentColor ==
                                                    index,
                                                index),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              height: 3,
                                            ),
                                        itemCount: itemColor.length),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ))),
                    Positioned(
                      left: 20,
                      top: 20,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .1,
                          height: MediaQuery.of(context).size.width * .1,
                          decoration: BoxDecoration(
                              color: !Get.isDarkMode?mainColor.withOpacity(.7):HexColor('#2f2a2a'),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.arrow_back_outlined,
                            color: !Get.isDarkMode?Colors.white:Colors.pink,
                          ),
                        ),
                      ),
                    ),
                   Obx(()=> Positioned(
                     right: 20,
                     top: 20,
                     child: InkWell(
                       onTap: () {
                         Get.toNamed(RouteNames.shopScreen);
                       },
                       child: Container(
                         width: MediaQuery.of(context).size.width * .1,
                         height: MediaQuery.of(context).size.width * .1,
                         decoration: BoxDecoration(
                             color: !Get.isDarkMode?mainColor.withOpacity(.7):HexColor('#2f2a2a'),
                             shape: BoxShape.circle),
                         child: Badge(
                           badgeColor: Colors.red,
                           animationDuration: const Duration(milliseconds: 300),
                           animationType: BadgeAnimationType.slide,
                           badgeContent: Text( '${
                               cartController.cartMapProducts.isNotEmpty?
                               cartController
                                   .cartMapProducts
                                   .entries.map((e) => e.value).toList()
                                   .reduce((value, element) => value+element):0
                           }'),
                           child: Icon(
                             Icons.shopping_cart,
                             color: !Get.isDarkMode?Colors.white:Colors.pink,
                           ),
                         ),
                       ),
                     ),
                   ),)
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(()=>Row(
                  children: [
                    Expanded(
                        child: Column(
                          children: [
                            defaultText(
                                text: productModel.title.toString(),
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                                color: !Get.isDarkMode?Colors.black:Colors.white,
                                size: 24),
                            Row(
                              children: [
                                defaultText(
                                    text: productModel.rating!.rate.toString(),
                                    color: !Get.isDarkMode?Colors.black:Colors.white,
                                    size: 16),
                                const SizedBox(width: 10,),
                                RatingBarIndicator(
                                  rating: productModel.rating!.rate,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 30.0,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        )),
                    const SizedBox(width: 8,),
                    CircleAvatar(
                      backgroundColor: !Get.isDarkMode?Colors.grey.withOpacity(.4):Colors.white,
                      child: IconButton(
                          onPressed: () {
                            favourite.addAndRemoveFavouriteItem(productModel.id);
                          },
                          icon:favourite.changeIcon(productModel.id)? const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                          ):const Icon(
                            Icons.favorite_outline_rounded,
                            color: Colors.black,
                          )
                      ),
                    ),
                  ],
                ),),
                const SizedBox(
                  height: 8,
                ),
                ReadMoreText(
                '${productModel.description}',
                trimLines: 3,
                textAlign: TextAlign.justify,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                lessStyle: TextStyle(fontSize: 16,
                    color: !Get.isDarkMode?const Color(0xff00BE84):Colors.pink
                  , fontWeight: FontWeight.bold),
                style: TextStyle(color: !Get.isDarkMode?Colors.black:Colors.white
                    ,height: 1.5,fontSize: 16),
                moreStyle: TextStyle(fontSize: 16,color: !Get.isDarkMode?const Color(0xff00BE84):Colors.pink, fontWeight: FontWeight.bold),
              ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.07,
                  child:GetBuilder<DetailsController>(
                    builder: (_)=>ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=>InkWell(
                          onTap: (){
                            detailsController.currentSize=index;
                            detailsController.changeSize(index);
                          },
                          child: itemSize(detailsController.size[index],
                              index,
                              context)),
                      separatorBuilder:(context,index)=>SizedBox(
                        width: MediaQuery.of(context).size.width*.05,
                      ),
                      itemCount: detailsController.size.length),)
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(height: 6,),
                          defaultText(text: 'total',
                              color: !Get.isDarkMode?Colors.grey:Colors.pink,
                              size: scale*15),
                          defaultText(
                              text: '${productModel.price.toString()} \$',
                              color: !Get.isDarkMode?Colors.black:Colors.white,
                              size: scale*10),
                          const SizedBox(height: 6,),
                        ],
                      ),
                      const SizedBox(width: 8.0,),
                      Expanded(
                        child: ElevatedButton(
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
                            cartController.addCart(productModel);
                          },
                          child: Row(
                            children: [
                              defaultText(text: 'Add To Cart',size: scale*16),
                              const SizedBox(width: 20,),
                              const Icon(Icons.shopping_cart)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
               ],
            ),
          ),
        ),
      ),
    );
  }
  Widget itemOfColorList(Color color, bool border, int index) => InkWell(
        onTap: () {
          detailsController.currentColor = index;
          detailsController.update();
        },
        child: Container(
          padding: const EdgeInsetsDirectional.all(3),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              //color: Colors.black,
              border: border ? Border.all(color: color, width: 3) : null),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ),
      );
  Widget itemSize(String size,int index,context)=>Container(
    height: double.infinity,
    width: MediaQuery.of(context).size.width*.14,
    decoration: BoxDecoration(
      border: Border.all(color: !Get.isDarkMode?Colors.black:Colors.white),
      borderRadius: BorderRadius.circular(16),
      color: detailsController.currentSize==index?
      !Get.isDarkMode?mainColor.withOpacity(.4):Colors.pink.withOpacity(.7)
          :Theme.of(context).scaffoldBackgroundColor,
    ),
    child: Center(child: defaultText(
        text: size,
        size: 16,
        color: !Get.isDarkMode?Colors.black:Colors.white
    ),
    ),
  );
}
