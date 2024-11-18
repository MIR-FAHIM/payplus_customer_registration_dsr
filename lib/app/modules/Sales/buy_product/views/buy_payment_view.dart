import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter/cupertino.dart';
import 'package:latest_payplus_agent/app/models/icon_model.dart';
import 'package:latest_payplus_agent/app/modules/Sales/buy_product/controllers/buy_product_controller.dart';
import 'package:latest_payplus_agent/app/modules/Sales/buy_product/views/buy_payment_details_before_pay_view.dart';

import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class BuyPaymentView extends GetView<BuyProductController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(65, 65),
        child: AppBar(
          backgroundColor: const Color(0xFF652981),
          centerTitle: true,
          title: Text('Payment Method'.tr),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              controller.selectedVendor.value.id != null
                  ? GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.CUSTOMERS, arguments: true);
                      },
                      child: Container(
                        width: _size.width,
                        color: AppColors.homeCardBg,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 10,
                                          bottom: 10,
                                          right: 10),

                                      /// Image item
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15.0)),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/collection/1.png')),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12
                                                        .withOpacity(0.1),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.1)
                                              ]),
                                          child: Container(
                                            height: 40.0,
                                            width: 40.0,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/collection/1.png')),
                                            ),
                                          ))),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, left: 5.0, right: 5.0),
                                    child: Column(
                                      /// Text Information Item
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          controller.selectedVendor.value.name!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Sans",
                                              color: Colors.black87,
                                              fontSize: 14.0),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          controller
                                              .selectedVendor.value.mobile!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: "Sofia",
                                              color: Colors.black,
                                              fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, right: 15),
                                child: Image.asset(
                                  "assets/icons/right_arrow.png",
                                  width: 15,
                                  height: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlockButtonWidget(
                        onPressed: () {
                          Get.toNamed(Routes.VENDORS, arguments: true);
                        },
                        color: Get.theme.primaryColor,
                        text: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              'Select Vendor'.tr,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
              Container(
                width: _size.width,
                height: _size.height * 0.25,
                color: Colors.black12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$uniCodeTk ${controller.calculateTotalPrice()}',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Total'.tr,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: List.generate(paymentMethod.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 20),
                      child: InkWell(
                        onTap: () {
                          if (paymentMethod[index].title == 'Hand Cash' &&
                              controller.selectedVendor.value.id != null) {
                            Get.to(BuyPaymentDetailsBeforePayView());
                          } else {
                            Get.showSnackbar(Ui.ErrorSnackBar(
                                message: 'Please select a vendor'.tr,
                                title: 'Error'.tr));
                          }
                        },
                        child: Container(
                          width: _size.width,
                          decoration: Ui.getBoxDecoration(
                            color: Colors.white,
                            radius: 8,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Image.asset(
                                      paymentMethod[index].image!,
                                      height: 50,
                                      width: 50,
                                      color: const Color(0xFF652981),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      paymentMethod[index].title!.tr,
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 25,
                                    color: Color(0xFF652981),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
