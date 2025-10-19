import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class OperatorwiseOfferView extends GetWidget<RechargeController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Obx(() {

        return SingleChildScrollView(
            child: Column(


              children:[

                   SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.mobileNumberFocus.value
                                  .unfocus();
                              controller.currentIndexOfOperator.value = 0;
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.all(4.0),
                              child: Ui.getIconButton(
                                  color: controller
                                      .currentIndexOfOperator ==
                                      0
                                      ? const Color(0xFF652981)
                                      : Colors.white,
                                  textColor:
                                  controller.currentIndexOfOperator ==
                                      0
                                      ? Colors.white
                                      : Get.theme.textTheme
                                      .bodyMedium!.color,
                                  text: 'Data'.tr,
                                  horrizontal: 10,
                                  vertical: 5,
                                  radius: 5),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.mobileNumberFocus.value
                                  .unfocus();
                              controller.currentIndexOfOperator.value = 1;

                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.all(4.0),
                              child: Ui.getIconButton(
                                  color: controller
                                      .currentIndexOfOperator ==
                                      1
                                      ? const Color(0xFF652981)
                                      : Colors.white,
                                  textColor:
                                  controller.currentIndexOfOperator ==
                                      1
                                      ? Colors.white
                                      : Get.theme.textTheme
                                      .bodyMedium!.color,
                                  text: 'Combo'.tr,
                                  horrizontal: 10,
                                  vertical: 5,
                                  radius: 5),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.mobileNumberFocus.value
                                  .unfocus();
                              controller.currentIndexOfOperator.value = 2;

                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.all(4.0),
                              child: Ui.getIconButton(
                                  color: controller
                                      .currentIndexOfOperator ==
                                      2
                                      ? const Color(0xFF652981)
                                      : Colors.white,
                                  textColor:
                                  controller.currentIndexOfOperator ==
                                      2
                                      ? Colors.white
                                      : Get.theme.textTheme
                                      .bodyMedium!.color,
                                  text: 'Minute'.tr,
                                  horrizontal: 10,
                                  vertical: 5,
                                  radius: 5),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.mobileNumberFocus.value
                                  .unfocus();
                              controller.currentIndexOfOperator.value = 3;

                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.all(4.0),
                              child: Ui.getIconButton(
                                  color: controller
                                      .currentIndexOfOperator ==
                                      3
                                      ? const Color(0xFF652981)
                                      : Colors.white,
                                  textColor:
                                  controller.currentIndexOfOperator ==
                                      3
                                      ? Colors.white
                                      : Get.theme.textTheme
                                      .bodyMedium!.color,
                                  text: 'PL'.tr,
                                  horrizontal: 10,
                                  vertical: 5,
                                  radius: 5),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),



                   controller
                      .offerPageOperator[controller.currentIndexOfOperator.value]

              ]
            ));

    });
  }
}
