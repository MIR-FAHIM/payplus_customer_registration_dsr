import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';

import '../controllers/recharge_controller.dart';

class MultiRechargeSuccessView extends GetView<RechargeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text('Mobile Recharge'.tr),
            elevation: 0,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back_ios),
            //   onPressed: () => Get.back(),
            // ),
            // actions: [
            //   IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         CupertinoIcons.bell,
            //         color: Colors.white70,
            //       )),
            // ]
          ),
        ),
        body: WillPopScope(
          onWillPop: () {



            controller.getBackToRecharge();
            return Future.value(false);
          },
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center(
                //   child: Column(
                //     children: [
                //       Text(
                //         'Your Request has been '.tr,
                //         style: TextStyle(fontSize: 20, color: Color(0xFF652981)),
                //       ),
                //       Text(
                //         'accepted.'.tr,
                //         style: TextStyle(fontSize: 20, color: Color(0xFF652981)),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: Get.height * .05,
                ),
                Container(
                  width: Get.width * .9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width * .35,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLightColor,
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Number".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        width: Get.width * .17,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLightColor,
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Amount".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        width: Get.width * .38,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLightColor,
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Message".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: Get.height * .25,
                  width: Get.width * .9,
                  child: Table(
                      border: TableBorder.all(width: 1.0, color: Colors.black),
                      children: [
                        for (var data in controller.rechargeNumberObjectList.value)
                          TableRow(children: [
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      width: Get.width * .35,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16)),
                                              height: 20,
                                              width: 20,
                                              child: Image.asset(data.logo!),
                                            ),
                                            Text(data.number.toString()),
                                          ],
                                        ),
                                      )),
                                  Container(
                                      width: Get.width * .17,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(data.amount.toString()),
                                      )),
                                  Container(
                                      width: Get.width * .38,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data.message ?? "Ready to initiate",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      )),
                                ],
                              ),
                            )
                          ])
                      ]),
                ),
                SizedBox(
                  height: 25,
                ),
                BlockButtonWidget(
                  onPressed: () {

                    controller.getBackToRecharge();

                    // Get.offAndToNamed(Routes.RECHARGE);
                    // Get.offAllNamed(Routes.RECHARGE);

                //    controller.mobileNumberFocus.value.requestFocus();

                    // controller.amountFocusFocus.requestFocus();
                  },
                  color: Color(0xFF652981),
                  text: Text(
                    "BACK TO RECHARGE".tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ).paddingSymmetric(vertical: 40, horizontal: 30),
              ],
            );
          }),
        ));
  }
}
