import 'package:ecommerce/component/colors.dart';
import 'package:ecommerce/component/component.dart';
import 'package:ecommerce/controller/auth/auth_controller.dart';
import 'package:ecommerce/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../component/my_string.dart';

class PaymentScreen extends StatelessWidget {
  String totalPrice;
  PaymentController paymentController = Get.put(PaymentController());
  AuthController authController = Get.put(AuthController());
  TextEditingController phoneController =TextEditingController();
  var formKey = GlobalKey<FormState>();
  PaymentScreen({Key? key,required this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: !Get.isDarkMode?mainColor:HexColor('#2f2a2a'),
        centerTitle: true,
        title: defaultText(text: 'Cart item',
          color: !Get.isDarkMode?Colors.white:Colors.pink,
          size: 24,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GetBuilder<PaymentController>(
            builder: (GetxController controller) =>Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                SizedBox(
                  child: defaultText(
                      text: 'Shopping to',
                      size:MediaQuery.of(context).textScaleFactor*20,
                      color:  !Get.isDarkMode?Colors.black:Colors.pink,
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: ()=>paymentController.changeContainer(numberOfContainer: 0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 2),
                        borderRadius: BorderRadius.circular(12),
                        color: paymentController.isSelected==0?
                            Colors.grey[350]
                            :Theme.of(context).scaffoldBackgroundColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: paymentController.isSelected==0
                                    ?!Get.isDarkMode?Colors.pink:Colors.grey[350]:Colors.pink,
                              ),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: paymentController.isSelected==0
                                    ?!Get.isDarkMode
                                    ?Theme.of(context).scaffoldBackgroundColor
                                    : Colors.pink:Theme.of(context).scaffoldBackgroundColor,
                              ),
                              if(paymentController.isSelected==0)
                                CircleAvatar(
                                  radius: 7,
                                  backgroundColor: !Get.isDarkMode?Colors.pink:Colors.yellow,
                                ),
                            ],
                          ),
                          const SizedBox(width: 16,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: defaultText(
                                    text: 'Limo Shop',
                                    size:MediaQuery.of(context).textScaleFactor*20,
                                    color: paymentController.isSelected==0?
                                    Colors.black:!Get.isDarkMode?Colors.black:Colors.white
                                ),
                              ),
                              SizedBox(
                                child: defaultText(
                                    text: 'Limo Shop',
                                    size:MediaQuery.of(context).textScaleFactor*16,
                                    color: paymentController.isSelected==0?
                                    Colors.black:!Get.isDarkMode?Colors.black:Colors.white,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    defaultText(
                                        text: '🇪🇬+2',
                                        size:MediaQuery.of(context).textScaleFactor*16,
                                        color: paymentController.isSelected==0?
                                        Colors.black:!Get.isDarkMode?Colors.black:Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                    const SizedBox(width: 5),
                                    defaultText(
                                        text: '01099907551',
                                        size:MediaQuery.of(context).textScaleFactor*16,
                                        color:paymentController.isSelected==0?
                                        Colors.black:!Get.isDarkMode?Colors.black:Colors.white,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: defaultText(
                                    text: 'zifta-elGharbia-egypt',
                                    size:MediaQuery.of(context).textScaleFactor*16,
                                    color: paymentController.isSelected==0?
                                    Colors.black:!Get.isDarkMode?Colors.black:Colors.white,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                    ()=>InkWell(
                      onTap:(){
                        paymentController.changeContainer(numberOfContainer: 1);
                        paymentController.updateLocation();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 2),
                            borderRadius: BorderRadius.circular(12),
                            color: paymentController.isSelected==1
                                ?Colors.grey[400]
                                :Theme.of(context).scaffoldBackgroundColor
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: paymentController.isSelected==1
                                        ?!Get.isDarkMode?Colors.pink:Colors.grey[350]:Colors.pink,
                                  ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: paymentController.isSelected==1
                                        ?!Get.isDarkMode
                                        ?Theme.of(context).scaffoldBackgroundColor
                                        : Colors.pink:Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                  if(paymentController.isSelected==1)
                                    CircleAvatar(
                                      radius: 7,
                                      backgroundColor: !Get.isDarkMode?Colors.pink:Colors.yellow,
                                    ),
                                ],
                              ),
                              const SizedBox(width: 16,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: defaultText(
                                          text: 'Delivery',
                                          size:MediaQuery.of(context).textScaleFactor*20,
                                          color: paymentController.isSelected==1?
                                          Colors.black:!Get.isDarkMode?Colors.black:Colors.white
                                      ),
                                    ),
                                    SizedBox(
                                      child: defaultText(
                                          text: authController.isFacebook && authController.faceUserModel!=null
                                              ? authController.faceUserModel!.name.toString()
                                              : authController.userModel != null
                                              ? authController.userModel!.name.toString()
                                              : '',
                                          size:MediaQuery.of(context).textScaleFactor*16,
                                          color: paymentController.isSelected==1?
                                          Colors.black:!Get.isDarkMode?Colors.black:Colors.white,
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                    // Row(
                                    //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     defaultText(
                                    //         text: '🇪🇬+2',
                                    //         size:MediaQuery.of(context).textScaleFactor*16,
                                    //         color: Colors.black,
                                    //         fontWeight: FontWeight.bold
                                    //     ),
                                    //     SizedBox(width: 5),
                                    //     // SizedBox(
                                    //     //   child: defaultText(
                                    //     //       text: 'enter your phone',
                                    //     //       size:MediaQuery.of(context).textScaleFactor*16,
                                    //     //       color: Colors.black,
                                    //     //       fontWeight: FontWeight.normal
                                    //     //   ),
                                    //     // ),
                                    //    Spacer(),
                                    //     InkWell(
                                    //       onTap: (){
                                    //         Get.defaultDialog(
                                    //             title: 'enter your phone',
                                    //             titleStyle: TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 20,
                                    //               fontFamily: GoogleFonts.zenTokyoZoo().toString(),
                                    //             ),
                                    //             backgroundColor: Colors.white.withOpacity(.9),
                                    //             content: SizedBox(
                                    //               child: Padding(
                                    //                 padding: const EdgeInsets.all(16.0),
                                    //                 child: defaultFormFaild(
                                    //                   controller: phoneController,
                                    //                     fillColor: mainColor.withOpacity(.1),
                                    //                     onChange: (value){
                                    //                     },
                                    //                     prefixIcon: Icon(Icons.call_rounded,color: !Get.isDarkMode?Colors.grey:Colors.pink,),
                                    //                     padding: EdgeInsets.only(bottom: 0),
                                    //                     hintText: 'your phone'),
                                    //               ),
                                    //
                                    //             ),
                                    //             textCancel: 'cancel',
                                    //             cancelTextColor: Colors.black,
                                    //             textConfirm: 'Yes',
                                    //             confirmTextColor: Colors.black,
                                    //             buttonColor: mainColor,
                                    //             onConfirm: () {
                                    //
                                    //             },
                                    //             onCancel: () {
                                    //               Get.to(PaymentScreen(totalPrice: totalPrice));
                                    //             });
                                    //       },
                                    //       child: Icon(Icons.quick_contacts_dialer_outlined,
                                    //         color: mainColor,
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                    if(paymentController.isSelected == 1)
                                      Form(
                                        key: formKey,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: defaultFormFaild(
                                              controller: phoneController,
                                              fillColor: !Get.isDarkMode
                                                  ?Theme.of(context).scaffoldBackgroundColor
                                                  :Colors.white,
                                              maxLength: 11,
                                              keyboardType: TextInputType.phone,
                                              validator: (value){
                                                if(!RegExp(validationPhone).hasMatch(value!)){
                                                  return 'Invalid phone';
                                                }
                                                return null;
                                              },
                                              prefixIcon: Icon(Icons.call_rounded,color: !Get.isDarkMode?Colors.grey:Colors.pink,),
                                              padding: const EdgeInsets.only(bottom: 0),
                                              hintText: 'your phone'),
                                        ),
                                      ),
                                      SizedBox(
                                        child: defaultText(
                                            text: paymentController.address.value,
                                            size:MediaQuery.of(context).textScaleFactor*16,
                                            color: !Get.isDarkMode?Colors.black:Colors.white,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  child: defaultText(
                      text: 'Payment method',
                      size:MediaQuery.of(context).textScaleFactor*20,
                      color: !Get.isDarkMode?Colors.black:Colors.pink
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: ()=>paymentController.changeSelectedMethod(yourSelect: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.black,width: .5),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('asset/images/credit.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8,),
                          Expanded(
                            child: defaultText(
                                text: 'Credit method',
                                size:MediaQuery.of(context).textScaleFactor*20,
                                color: Colors.black
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: paymentController.selectedMethod==0
                                    ?!Get.isDarkMode?Colors.pink:Colors.grey[350]:Colors.pink,
                              ),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: paymentController.selectedMethod==0
                                    ?!Get.isDarkMode
                                    ?Theme.of(context).scaffoldBackgroundColor
                                    : Colors.pink:Theme.of(context).scaffoldBackgroundColor,
                              ),
                              if(paymentController.selectedMethod==0)
                                CircleAvatar(
                                  radius: 7,
                                  backgroundColor: !Get.isDarkMode?Colors.pink:Colors.yellow,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: ()=>paymentController.changeSelectedMethod(yourSelect: 1),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.black,width: .5),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('asset/images/paypal.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8,),
                          Expanded(
                            child: defaultText(
                                text: 'Paypal method',
                                size:MediaQuery.of(context).textScaleFactor*20,
                                color: Colors.black
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: paymentController.selectedMethod==1
                                    ?!Get.isDarkMode?Colors.pink:Colors.grey[350]:Colors.pink,
                              ),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: paymentController.selectedMethod==1
                                    ?!Get.isDarkMode
                                    ?Theme.of(context).scaffoldBackgroundColor
                                    : Colors.pink:Theme.of(context).scaffoldBackgroundColor,
                              ),
                              if(paymentController.selectedMethod==1)
                                CircleAvatar(
                                  radius: 7,
                                  backgroundColor: !Get.isDarkMode?Colors.pink:Colors.yellow,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: ()=>paymentController.changeSelectedMethod(yourSelect: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.black,width: .5),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('asset/images/google.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8,),
                          Expanded(
                            child: defaultText(
                                text: 'Google method',
                                size:MediaQuery.of(context).textScaleFactor*20,
                                color: Colors.black
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: paymentController.selectedMethod==2
                                    ?!Get.isDarkMode?Colors.pink:Colors.grey[350]:Colors.pink,
                              ),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: paymentController.selectedMethod==2
                                    ?!Get.isDarkMode
                                    ?Theme.of(context).scaffoldBackgroundColor
                                    : Colors.pink:Theme.of(context).scaffoldBackgroundColor,
                              ),
                              if(paymentController.selectedMethod==2)
                                CircleAvatar(
                                  radius: 7,
                                  backgroundColor: !Get.isDarkMode?Colors.pink:Colors.yellow,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center ,
                  children: [
                    SizedBox(
                      child: defaultText(
                          text: 'total : ',
                          size:MediaQuery.of(context).textScaleFactor*20,
                          color: !Get.isDarkMode?Colors.black:Colors.white
                      ),
                    ),
                    SizedBox(
                      child: defaultText(
                          text:'$totalPrice\$',
                          size:MediaQuery.of(context).textScaleFactor*20,
                          color: !Get.isDarkMode?Colors.black:Colors.white
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*.5,
                    child: ElevatedButton(

                      style:ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width*.025,
                            //horizontal: MediaQuery.of(context).size.width*.1,
                          ),

                          primary: Get.isDarkMode?Colors.pink:mainColor.withOpacity(.8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(16)
                          )
                      ),
                      onPressed: (){
                        if(paymentController.isSelected==1){
                            if (formKey.currentState!.validate()) {
                              print('true');
                            } else {
                              print('false');
                            }
                          }
                        },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultText(text: 'Pay Now',size: MediaQuery.of(context).textScaleFactor*20),
                          const SizedBox(width: 20,),
                          const Icon(Icons.shopping_cart)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
