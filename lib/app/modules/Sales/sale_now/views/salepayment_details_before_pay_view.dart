import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/Page/Transaction_successful.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/modules/Sales/sale_now/controllers/sale_now_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';

class SalePaymentDetailsBeforePayView extends GetView<SaleNowController> {
  SalePaymentDetailsBeforePayView({Key? key}) : super(key: key);
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
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
                                    left: 15, top: 10, bottom: 10, right: 10),

                                /// Image item
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            const BorderRadius.all(Radius.circular(15.0)),
                                        image: const DecorationImage(
                                            image: AssetImage('assets/collection/1.png')),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12.withOpacity(0.1),
                                              blurRadius: 0.5,
                                              spreadRadius: 0.1)
                                        ]),
                                    child: Container(
                                      height: 40.0,
                                      width: 40.0,
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(15.0)),
                                        image: DecorationImage(
                                            image: AssetImage('assets/collection/1.png')),
                                      ),
                                    ))),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                              child: Column(
                                /// Text Information Item
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    controller.selectedCustomer.value.name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Sans",
                                        color: Colors.black87,
                                        fontSize: 14.0),
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    controller.selectedCustomer.value.mobile!,
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
                          padding: const EdgeInsets.only(top: 25, right: 15),
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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.PREVIOUS_DUE);
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: _size.width * .45,
                            width: _size.width * .4,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Previous Due'.tr,
                                  style: TextStyle(
                                      color: Get.theme.primaryColor, fontSize: 18),
                                ),
                                Text(
                                  'BDT 1000',
                                  style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Details >'.tr,
                                  style: TextStyle(
                                    color: Get.theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.CURRENT_DUE);
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: _size.width * .45,
                            width: _size.width * .4,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Current Due'.tr,
                                  style: TextStyle(
                                      color: Get.theme.primaryColor, fontSize: 18),
                                ),
                                Text(
                                  'BDT 1000',
                                  style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Details >'.tr,
                                  style: TextStyle(
                                    color: Get.theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlockButtonWidget(
                  onPressed: () {
                    showPaymentDialog(true);
                    //
                  },
                  color: const Color(0xFF652981),
                  radius: 30,
                  text: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'Partial Payment'.tr,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  width: Get.size.width * .45,
                ),
                BlockButtonWidget(
                  onPressed: () {
                    showPaymentDialog(false);
                    // Get.to(TransactionSuccessful());
                  },
                  color: const Color(0xFF652981),
                  radius: 30,
                  text: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'Full Payment'.tr,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  width: Get.size.width * .45,
                ),
              ],
            ))
      ],
    );
  }

  showPaymentDialog(bool isPartial) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Center(
                child: Text(
              'Payment Details'.tr,
              style: const TextStyle(
                fontSize: 20,
              ),
            )),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(8),
            content: Obx(() {
              return SizedBox(
                height: Get.size.width * .85,
                width: Get.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldWidget(
                      keyboardType: TextInputType.number,
                      initialValue: controller.calculateTotalPrice().toString(),
                      labelText: !isPartial ? "Total".tr : "Paying Now".tr,
                      hintText: "Amount".tr,
                      readOnly: !isPartial,
                      onChanged: (String? input) {
                        if (isPartial) {
                          controller.nowPaying.value =
                              double.parse(input!.isNotEmpty ? input : '0.0');
                        }
                      },
                    ),
                    TextFieldWidget(
                      keyboardType: TextInputType.number,
                      initialValue: '',
                      labelText: "Discount".tr,
                      hintText: "0.0 %".tr,
                      onChanged: (String? input) {
                        controller.subTotalPrice.value = controller.calculateTotalPrice();
                        controller.sellData.value.discount =
                            double.parse(input!.isNotEmpty ? input : '0.0');
                        print(controller.sellData.value.discount);
                        if (controller.sellData.value.discount! > 0.0) {
                          controller.discountAmount.value =
                              controller.subTotalPrice.value *
                                  (controller.sellData.value.discount! / 100);
                          controller.nowPaying.value = controller.calculateTotalPrice() -
                              controller.discountAmount.value;
                          controller.subTotalPrice.value =
                              controller.subTotalPrice.value -
                                  controller.discountAmount.value;

                          print(controller.subTotalPrice.value);
                          controller.subTotalPrice.refresh();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return Text(
                        'Total Payable: $uniCodeTk ${controller.subTotalPrice.value}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Get.theme.primaryColor,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        controller.placeOrder();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: Get.size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Get.theme.primaryColor,
                          ),
                          child: const Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                            child: Text(
                              'Place Order',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            })
            // actions: <Widget>[

            // ],
            );
      },
    );
  }
}
