import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/controllers/mobile_banking_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';

class MBankingSuccessView extends GetView<MobileBankingController> {
  final _size = Get.size;

  @override
  Widget build(BuildContext context) {
    var argument = Get.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(_size.width, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            controller.currentTabIndex.value == 0
                ? 'Cash In'
                : controller.currentTabIndex.value == 1
                ? 'Cash Out'
                : 'Money Out',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SUCCESS ICON
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 85,
                ),
              ),

              SizedBox(height: 20),

              // SUCCESS TITLE
              Text(
                "${controller.currentTabIndex.value == 0 ? "Cash In" : controller.currentTabIndex.value == 1 ? "Cash Out" : "Money Out"} Successful",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.green.shade700,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 12),

              // MESSAGE BOX
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  argument[0],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 40),

              // BUTTON
              BlockButtonWidget(
                onPressed: () {
                  Get.back();
                  Get.back();
                  controller.refresh();
                  Get.toNamed(Routes.MBANKINGNUMAMOUNT);
                },
                color: Color(0xFF652981),
                text: Text(
                  "BACK TO Mobile Banking",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ).paddingSymmetric(vertical: 20, horizontal: 20)
            ],
          ),
        ),
      ),
    );
  }
}
