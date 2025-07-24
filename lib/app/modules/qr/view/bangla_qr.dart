import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/qr/controllers/qr_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';


class BanglaQRView extends GetView<QRController> {
  const BanglaQRView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.offAllNamed(Routes.ROOT);
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(
             () {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: controller.getAgentAppValueByName("bangla_qr_lock") == "1" ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo Row

                    // QR Code with Frame

                   SizedBox(height: 20),

                    // Image Frame (Placeholder or QR Image)
                    Center(
                      child: Container(
                        width: Get.width * 0.7,
                        height: Get.height * 0.38,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)
                        ),

                        child: controller.isBanglaQR.value == true
                            ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RepaintBoundary(
                                key: controller.globalKey.value,
                                child: QrImageView(
                                  data: controller.genrateBanglaQrData.value,
                                  version: QrVersions.auto,
                                  size: 250.0,
                                  gapless: false,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4, right: 4),
                                child: Image.asset(
                                  "assets/qr_pay_method.png",
                                  height: 40,
                                  width: Get.width,
                                ),
                              ),
                            ],
                          ),
                        )
                            : Center(
                            child: Text("No Bangla QR created for you yet.")),
                      ),
                    ),

                    BlockButtonWidget(



                      width: Get.width*.9,
                      onPressed: () {
                        print("bangla qr url is ${controller.qrUrlBangla.value}");

                        if(controller.isBanglaQR.value == true){
                          controller.shareBanglaQR(controller.qrUrlBangla.value);
                        }else{
                          Get.toNamed(Routes.HOTLINE);
                        }

                      },
                      color: Colors.grey.withOpacity(.1),
                      text: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.isBanglaQR.value == true
                              ? Text(
                            "Share Bangla QR".tr,
                            style: Get.textTheme.bodyMedium!.merge(
                                TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          )
                              : Text(
                            "Please Contact with admin for Bangla QR."
                                .tr,
                            style: Get.textTheme.bodySmall!.merge(
                                TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Image.asset(
                            "assets/images/banglaqr.png",
                            height: 40,
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Container(
                      height: Get.height*.1,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/qr_bottom.png",
                            height: 40,
                            width: Get.width,
                            fit: BoxFit.fitWidth,
                          ),
                          Image.asset(
                            "assets/qr_mtb.png",
                            height: 40,
                            width: Get.width*.8,
                          ),
                        ],
                      ),
                    ),



                    // Payment Options (Cards/Icons)
                  ],
                )
                :Center(
                  child: Text("Coming Soon....")
                ),
              );
            }
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
