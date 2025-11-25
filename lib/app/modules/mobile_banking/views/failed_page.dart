import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/controllers/mobile_banking_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';

class MBankingFailedView extends GetView<MobileBankingController> {
  @override
  Widget build(BuildContext context) {
    final argument = Get.arguments; // expecting: [message, details?]
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          elevation: 0,
          title: Obx(() {
            final index = controller.currentTabIndex.value;
            if (index == 0) return Text('Cash In'.tr);
            if (index == 1) return Text('Cash Out'.tr);
            return Text('Money Out'.tr);
          }),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Icon(Icons.error_outline,
                  size: size.width * 0.25, color: Colors.red),

              SizedBox(height: 20),

              Text(
                'Transaction Failed'.tr,
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),

              SizedBox(height: 10),

              if (argument != null && argument.isNotEmpty)
                Text(
                  argument[0].toString(),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),

              SizedBox(height: 5),

              Obx(() => Text(
                controller.devMessage.value,
                style: TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
              )),

              SizedBox(height: 30),

              BlockButtonWidget(
                onPressed: () {
                  Get.back();
                  Get.back();

                  controller.update(); // or your custom refresh

                  Get.toNamed(Routes.CASHINOUT);
                },
                color: Color(0xFF652981),
                text: Text(
                  "BACK TO Mobile Banking".tr,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ).paddingSymmetric(vertical: 30, horizontal: 30),
            ],
          ),
        ),
      ),
    );
  }
}
