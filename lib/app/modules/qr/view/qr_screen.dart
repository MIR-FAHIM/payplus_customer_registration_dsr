import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/account_setting/controllers/account_setting_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/qr/controllers/qr_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';

import 'package:qr_flutter/qr_flutter.dart';


class QRView extends GetView<QRController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          Get.offAllNamed(Routes.ROOT);

        },
        child: Obx(
           () {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child:  controller.getAgentAppValueByName("general_qr_lock") == "1" ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Row

                  Container(
                    height: Get.height*.12,
                    color: AppColors.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('QR Code'.tr, style: TextStyle(color: Colors.white)),
                          Image.asset(
                            "assets/pslogo.png",

                            color: Colors.white,
                            height: Get.height*.04,
                            width: Get.width*.3,
                            fit: BoxFit.contain,
                          ),

                        ],
                      ),
                    ),
                  ),

                  // QR Code with Frame

                  SizedBox(height: Get.height*.2),

                  // Image Frame (Placeholder or QR Image)
                  Center(
                    child: Container(
                        width: Get.width * 0.7,
                        height: Get.height * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child:  Center(
                          child: RepaintBoundary(
                            key: controller.globalKey.value,
                            child: QrImageView(
                              data: "https://shl.com.bd/customer/payment/${Get.find<AuthService>().currentUser.value.customerCode}",
                              version: QrVersions.auto,
                              size: 250.0,
                              gapless: false,
                            ),
                          ),
                        )

                    ),
                  ),

                  BlockButtonWidget(
                    onPressed: () {
                      controller.shareGeneralQR('https://shl.com.bd/customer/payment/${Get.find<AuthService>().currentUser.value.customerCode}');
                    },
                    color: Colors.grey.withOpacity(.1),
                    text: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Share General QR".tr,
                          style: Get.textTheme.bodyMedium!.merge(
                              TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Payment Options (Cards/Icons)
                ],
              ) : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Row

                  Container(
                    height: Get.height*.12,
                    color: AppColors.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('QR Code'.tr, style: TextStyle(color: Colors.white)),
                          Image.asset(
                            "assets/pslogo.png",

                            color: Colors.white,
                            height: Get.height*.04,
                            width: Get.width*.3,
                            fit: BoxFit.contain,
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height*.2,),

                  Text('Coming Soon ..........'.tr, style: TextStyle(color: Colors.black, fontSize: 16)),



                  // Payment Options (Cards/Icons)
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  // Helper function for Payment Icons
  Widget _buildPaymentIcon(String assetPath) {
    return Image.asset(
      assetPath,
      height: Get.height * 0.05,
      width: Get.width * 0.07,
    );
  }
}
