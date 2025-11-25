import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/controllers/mobile_banking_controller.dart';


class ErrorTimerPage extends GetView<MobileBankingController> {
  final _size = Get.size;
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
          title: Obx(() {
            if (controller.showButton.value == true) {
              return Text("Error");
            } else {
              return Text("Processing...");
            }
          }),
          elevation: 0,
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * .7,
                height: Get.height * .4,
                child: Text("Loading"),
              ),
              Center(
                child: SlideCountdownSeparated(
                  duration: Duration(minutes: 1),
                  separatorType: SeparatorType.title,
                  slideDirection: SlideDirection.up,
                  onDone: () {
                    controller.checkRocketTransactionStatus();
                    controller.showButton.value = true;
                  },
                ),
              ),
              controller.showButton.value == true
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          "Transaction Failed",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Please wait 3 minutes and do not close the page. Your Cash In is processing...",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
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

              SizedBox(
                height: 20,
              ),

              controller.showButton.value == true
                  ? BlockButtonWidget(
                      onPressed: () {
                        Get.back();
                        Get.back();
                        controller.showButton.value = false;
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
                    ).paddingSymmetric(vertical: 40, horizontal: 30)
                  : Container()
            ],
          );
        }),
      ),
    );
  }
}
