import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/buy_product/controllers/buy_product_controller.dart';

class ScanBuyProductView extends GetView<BuyProductController> {
  // Barcode? result;
  // QRViewController? qcontroller;

  String qrcode = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,
        title: Text('Scan Product'.tr),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: Get.size.width, // custom wrap size
          height: Get.size.height,
          child: controller.buildQrView(context),
        ),
      ),
    );
  }
}
