import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:latest_payplus_agent/app/Page/fast_sale_view.dart';
import 'package:latest_payplus_agent/app/modules/Sales/views/fast_sale.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class SalePage extends StatelessWidget {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          title: Text('Sales'.tr),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.bell,
                  color: Colors.white70,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: _size.width,
              height: _size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: _size.width * 0.75,
                        padding: EdgeInsets.only(
                            top: 12, bottom: 14, left: 12, right: 20),
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF652981).withOpacity(0.4),
                                blurRadius: 2,
                                offset: Offset(1, 2)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Customer Mobile No".tr + ' *',
                              style: Get.textTheme.bodyMedium,
                              textAlign: TextAlign.start,
                            ),
                            Container(
                              width: 300,
                              child: TextFormField(
                                // controller: controller.phoneController,
                                keyboardType: TextInputType.phone,
                                style: Get.textTheme.headlineSmall,
                                // validator: (input) {
                                //   if (controller.phoneController.text.length != 11) {
                                //     return 'Invalid phone number'.tr;
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                obscureText: false,
                                textAlign: TextAlign.start,
                                cursorColor: Color(0xFF652981),
                                decoration: Ui.getInputDecoration(
                                  hintText: "Enter Customer Mobile No.".tr,
                                  iconData:
                                      CupertinoIcons.device_phone_portrait,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: _size.width * 0.1,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF652981).withOpacity(0.4),
                                  blurRadius: 2,
                                  offset: Offset(1, 2)),
                            ],
                          ),
                          child: Icon(
                            Icons.mobile_friendly,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 25, left: 18),
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.67,
                  //     height: 25,
                  //     decoration: BoxDecoration(
                  //       color: Colors.lightGreen,
                  //       border: Border.all(
                  //           color: Theme.of(context).primaryColor, width: 1),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 12, right: 12),
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.add,
                  //             color: Colors.white,
                  //             size: 20.0,
                  //           ),
                  //           Text(
                  //             "Add From Phone Book".tr,
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 12),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 14, left: 20, right: 20),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF652981).withOpacity(0.4),
                            blurRadius: 2,
                            offset: Offset(1, 2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Customer Name".tr + ' *',
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          // controller: controller.nameController,
                          keyboardType: TextInputType.text,
                          style: Get.textTheme.headlineSmall,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          // validator: (input) {
                          //   if (controller.nameController.text.isEmpty) {
                          //     return 'This field is required'.tr;
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          cursorColor: Color(0xFF652981),
                          decoration: Ui.getInputDecoration(
                            hintText: "Enter Customer Name".tr,
                            iconData: null,
                            imageData: 'assets/collection/1.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(FastSaleViewScreen());
                      },
                      child: Container(
                        width: _size.width,
                        height: _size.width * .12,
                        decoration: Ui.getBoxDecoration(
                            color: Color(0xFF652981), radius: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/shopping-cart.png",
                                  width: 30,
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Fast Sale'.tr,
                                    style: Get.textTheme.titleLarge!
                                        .merge(TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(FastSalesView());
                      },
                      child: Container(
                        width: _size.width,
                        height: _size.width * .12,
                        decoration: Ui.getBoxDecoration(
                            color: Color(0xFF652981), radius: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/sales/sale_from_list.png",
                                  width: 30,
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Product From List'.tr,
                                    style: Get.textTheme.titleLarge!
                                        .merge(TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
