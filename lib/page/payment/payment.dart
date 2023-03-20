import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerces/components/alert.dart';
import 'package:e_commerces/components/color.dart';
import 'package:e_commerces/components/loading.dart';
import 'package:e_commerces/controller/order_controller.dart';
import 'package:e_commerces/models/order_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../controller/cart_controller.dart';
import '../../controller/location_controller.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final CartController cartController = Get.put(CartController());
  final AuthController authController = Get.put(AuthController());
  final LocationController locationController = Get.put(LocationController());
  final OrderController orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    locationController.getLocation();
    authController.getProfile();
  }



  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (locationController.locationLoading.value) {
        return Loading();
      } else {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: primaryColorWhite,
              ),
            ),
            centerTitle: true,
            title: Text(
              'Payment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColorWhite,
              ),
            ),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.call, color: Colors.indigo.shade800),
                    SizedBox(width: 10),
                    Text(
                      "ຊ່ອງທາງຕິດຕໍ່",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.edit, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 5),
                // GetBuilder<AuthController>(builder: (controller) {
                //   if (mainController.userLoading.value) {
                //     return CircularProgressIndicator();
                //   }
                //   return
                GetBuilder<AuthController>(builder: (context) {
                  if (authController.authLoading.value) {
                    return CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ຊື່ ແລະ ນາມສະກຸນ"),
                            Text(authController.userModel[0].firstName! +
                                "-" +
                                authController.userModel[0].lastName!)
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ເບີໂທຕິດຕໍ່"),
                            Text(authController.userModel[0].phoneNumber!),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ອີເມວຕິດຕໍ່"),
                            Text(authController.userModel[0].email!),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }
                }),
                //   );
                // }),
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade50),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.time_to_leave, color: Colors.indigo.shade800),
                    SizedBox(width: 10),
                    Text(
                      "ເວລາຈັດສົ່ງສິນຄ້າ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.edit, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 5),
                locationController.locationModel.isEmpty
                    ? InkWell(
                        onTap: () {
                          Get.toNamed('/address');
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade800,
                          ),
                          child: Center(
                            child: Text(
                              'ເພີ່ມເວລາຈັດສົ່ງ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : GetBuilder<LocationController>(builder: (context) {
                        if (locationController.locationLoading.value) {
                          return CircularProgressIndicator();
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ວັນທີ່ ແລະ ເວລາຈັດສົ່ງ"),
                                  Text(locationController
                                      .locationModel[0].dateTime!)
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        }
                      }),
                SizedBox(height: 10),
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade50),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.map, color: Colors.indigo.shade800),
                    SizedBox(width: 10),
                    Text(
                      "ສະຖານທີ່ຈັດສົ່ງສິນຄ້າ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.amber),
                      onPressed: () {},
                    ),
                  ],
                ),
                locationController.locationModel.isEmpty
                    ? InkWell(
                        onTap: () {
                          Get.toNamed('/add_address');
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade800,
                          ),
                          child: Center(
                            child: Text(
                              'ເພີ່ມທີ່ຢູ່ຈັດສົ່ງ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : GetBuilder<LocationController>(builder: (context) {
                        if (locationController.locationLoading.value) {
                          return CircularProgressIndicator();
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ບ້ານ"),
                                  Text(locationController
                                      .locationModel[0].village!)
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ເມືອງ"),
                                  Text(locationController
                                      .locationModel[0].district!)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ແຂວງ"),
                                  Text(locationController
                                      .locationModel[0].province!)
                                ],
                              ),
                            ],
                          );
                        }
                      }),

                SizedBox(height: 10),
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade50),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.list_alt, color: Colors.indigo.shade800),
                    SizedBox(width: 10),
                    Text(
                      "ລາຍລະອຽດສິນຄ້າ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.edit, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ຊື່"),
                    Text("ຈຳນວນ"),
                    Text("ລາຄາ"),
                  ],
                ),
                SizedBox(height: 5),
                GetBuilder<CartController>(builder: (controller) {
                  if (cartController.loadingCart.value) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.cartModelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = controller.cartModelList;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${data[index].name}"),
                            Text("${data[index].amout.toString()}"),
                            Text("${data[index].price.toString()} Kip"),
                          ],
                        );
                      });
                }),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ລາຄາລວມ"),
                    GetBuilder<CartController>(builder: (controller) {
                      if (cartController.loadingCart.value) {
                        return CircularProgressIndicator();
                      }
                      return Text(
                        "${controller.totalPrice.toString()} Kip",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade50),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.money_off, color: Colors.indigo.shade800),
                    SizedBox(width: 10),
                    Text(
                      "ປະເພດການຊຳລະ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.edit, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ປະເພດການຊຳລະ"),
                    Text(
                      "ຈ່າຍປາຍທາງ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.indigo.shade800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
          bottomNavigationBar: InkWell(
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                title: 'ແຈ້ງເຕືອນ',
                desc: 'ທ່ານໝັ້ນໃຈບໍ່ວ່າຈະຊຳລະເງິນ!',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  orderController.saveOrder(
                      orderModel: OrderModel(
                    userId: authController.auth.currentUser!.uid,
                    cartList: cartController.cartModelList,
                    locationList: locationController.locationModel,
                    userList: authController.userModel,
                    totalPrice: cartController.totalPrice.toInt(),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ));
                },
              )..show();
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(color: primaryColor),
              child: Center(
                child: Text(
                  'ຊຳລະເງີນ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColorWhite,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
