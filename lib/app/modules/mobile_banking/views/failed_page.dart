import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/controllers/mobile_banking_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:lottie/lottie.dart';

class MBankingFailedView extends GetView<MobileBankingController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    var argument = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          title: controller.currentTabIndex.value == 0
              ? Text('Cash In'.tr)
              : controller.currentTabIndex.value == 1
              ? Text('Cash Out'.tr)
              : Text('Money Out'.tr),

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
                  Container(
                    width: Get.width * .15,
                    height: Get.height * .1,
                    child: Lottie.asset(
                      'assets/animation/failed_ani.json',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Get.arguments[0],
                          style: TextStyle(fontSize: 22, color: Colors.red)),
                    ],
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      argument[0],
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      controller.devMessage.value,
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

                      Get.toNamed(Routes.CASHINOUT);

                      // controller.amountFocusFocus.requestFocus();
                    },
                    color: Color(0xFF652981),
                    text: Text(
                      "BACK TO Mobile Banking".tr,
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
