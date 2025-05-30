import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/account_setting/controllers/account_setting_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/qr/controllers/qr_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';

import 'package:qr_flutter/qr_flutter.dart';


class QRView extends GetView<QRController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.offAllNamed(Routes.ROOT);
          return Future.value(false);
        },
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child:  controller.getAgentAppValueByName("general_qr_lock") == "0" ?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Row



                // QR Code with Frame
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle, // Make the container circular
                  ),
                  child: CircleAvatar(
                    radius: Get.height * 0.05, // Adjust size
                    backgroundColor:
                    Colors.grey[200], // Placeholder background
                    backgroundImage: CachedNetworkImageProvider(
                      "https://shl.com.bd/uploads/userimages/${Get.find<AccountSettingController>().profileDataFromAPi.value.orgImage}",
                    ),
                    onBackgroundImageError: (_, __) {}, // Prevent errors
                  ),
                ),
                SizedBox(height: 20),

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
                    controller.shareBanglaQR('https://shl.com.bd/customer/payment/${Get.find<AuthService>().currentUser.value.customerCode}');
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
            ) : Center(
              child: Text("Coming Soon........"),
            ),
          ),
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
