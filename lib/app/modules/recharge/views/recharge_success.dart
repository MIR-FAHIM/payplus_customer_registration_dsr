import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';

import '../controllers/recharge_controller.dart';

class RechargeSuccessView extends GetView<RechargeController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    var status_code = Get.arguments['status_code'];
    var result = Get.arguments['result'];
    var message = Get.arguments['message'];
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
      body: Stack(
        children: [
          Container(
            height: Get.size.height,
            width: Get.size.width,
          ),
          Positioned(
            top: Get.size.width / 3,
            bottom: Get.size.width / 3,
            left: 20,
            right: 20,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   width: Get.width,
                  //   color: Colors.blue,
                  //   child: Center(
                  //     child: Text(
                  //       'Your application has been accepted, please wait..'.tr,
                  //       style:
                  //           TextStyle(fontSize: 24, color: Color(0xFF652981)),
                  //     ),
                  //   ),
                  // ),
                  status_code == '2'
                      ?Container()
                      : status_code == '1'
                          ? Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Your Request has been '.tr,
                                    style: TextStyle(fontSize: 20, color: Color(0xFF652981)),
                                  ),
                                  Text(
                                    'accepted.'.tr,
                                    style: TextStyle(fontSize: 20, color: Color(0xFF652981)),
                                  )
                                ],
                              ),
                            )
                          : Center(
                              child: Text(
                                'Mobile Recharge Failed..'.tr,
                                style: TextStyle(fontSize: 22, color: AppColors.redTextColor),
                              ),
                            ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      message,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  BlockButtonWidget(
                    onPressed: () {
                      Get.back();
                      Get.back();
                      controller.refresh();

                      // Get.offAndToNamed(Routes.RECHARGE);
                      // Get.offAllNamed(Routes.RECHARGE);

                      Get.toNamed(Routes.RECHARGE);
                      controller.mobileNumberFocus.value.requestFocus();
                      controller.currentIndex.value = 0;
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
