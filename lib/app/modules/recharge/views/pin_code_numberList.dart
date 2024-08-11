import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/recharge_controller.dart';

class RechargePINViewNumberList extends GetView<RechargeController> {
  RechargeController controller = Get.put(RechargeController());
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    print('Recharge number : ${controller.rechargeNumber.value}');
    print('cashback amount : ${controller.cashBackAmount.value}');
    // print('cashback amount : ${controller.amountController.clear}');
    return Obx(() {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size(65, 65),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF652981),
              centerTitle: true,
              title: Text(
                'Mobile Recharge'.tr,
                style: TextStyle(fontSize: 15),
              ),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Get.back(),
              ),
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
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: _size.width,
              height: _size.height,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 10.0, right: 10.0),
                    //  height: _size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: Get.width * .9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width * .35,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryLightColor,
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Number".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * .17,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryLightColor,
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Amount".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * .38,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryLightColor,
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Message".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: Get.height * .25,
                                width: Get.width * .9,
                                child: Table(
                                    border: TableBorder.all(
                                        width: 1.0, color: Colors.black),
                                    children: [
                                      for (var data in controller
                                          .rechargeNumberObjectList.value)
                                        TableRow(children: [
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    width: Get.width * .35,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16)),
                                                            height: 20,
                                                            width: 20,
                                                            child: Image.asset(
                                                                data.logo!),
                                                          ),
                                                          Text(data.number
                                                              .toString()),
                                                        ],
                                                      ),
                                                    )),
                                                Container(
                                                    width: Get.width * .17,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(data.amount
                                                          .toString()),
                                                    )),
                                                Container(
                                                    width: Get.width * .38,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        data.message ??
                                                            "Ready to initiate",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          )
                                        ])
                                    ]),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                  width: Get.width,
                                  //  height: 50,
                                  decoration: Ui.getBoxDecoration(radius: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: TextFormField(
                                      obscureText: true,
                                      controller:
                                          controller.pinController.value,
                                      cursorColor: AppColors.primaryColor,
                                      textAlign: TextAlign.center,
                                      maxLength: 6,

                                      decoration: InputDecoration(
                                        counterText: "",
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                        hintText: 'Enter PIN here'.tr,
                                        hintStyle: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 15),
                                        prefixIcon: Icon(
                                          CupertinoIcons.lock,
                                          color: AppColors.primaryColor,
                                        ).marginOnly(right: 14),

                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            if (controller.pinController.value
                                                .text.isEmpty) {
                                              Get.showSnackbar(Ui.ErrorSnackBar(
                                                  message:
                                                      "Check Your Pin Number Again",
                                                  title: 'Error'.tr));
                                            } else {
                                              controller
                                                  .rechargeNumbersFromList(
                                                      "Prepaid");
                                            }

                                            print("sahed");
                                            controller.pinController.value
                                                .clear();
                                          },
                                          icon: Icon(
                                            CupertinoIcons.arrow_right,
                                            color: AppColors.primaryColor,
                                            size: 35,
                                          ).marginOnly(right: 14),
                                        ),
                                        // floatingLabelBehavior: FloatingLabelBehavior.never,
                                        focusColor: AppColors.primaryColor,
                                      ),
                                      focusNode: controller.pinFocusFocus.value,
                                      keyboardType: TextInputType.phone,
                                      // validator: (String? value) {
                                      //
                                      // },
                                      onChanged: (input) {
                                        controller.pinNumber.value = input;
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ));
    });
  }
}
