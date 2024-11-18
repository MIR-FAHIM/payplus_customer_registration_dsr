import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/package/controller/package_list_controller.dart';
import 'package:latest_payplus_agent/app/modules/settings/controllers/language_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/cupertino.dart';

import '../../../../common/custom_data.dart';

class BuyNowPackageView extends GetView<PackageController> {
  BuyNowPackageView({Key? key}) : super(key: key);
  final _size = Get.size;
  var index = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(65, 65),
        child: AppBar(
          backgroundColor: const Color(0xFF652981),
          centerTitle: true,
          title: Text('Package List'.tr),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.Notification_View);
                },
                icon: const Icon(
                  CupertinoIcons.bell,
                  color: Colors.white70,
                )),
          ],
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Package Details".tr,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetStorage().read<String>('language') == 'en_US'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: _size.height * .03,
                                          width: _size.width * .5,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius: const BorderRadius
                                                  .all(
                                                  const Radius.circular(5.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12
                                                        .withOpacity(0.1),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.1)
                                              ]),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .star_border_purple500_sharp,
                                                  color: controller
                                                              .packageListModel
                                                              .value
                                                              .data![index]
                                                              .currentPackage ==
                                                          true
                                                      ? AppColors.primaryColor
                                                      : Colors.white,
                                                ),
                                                Text(
                                                  controller
                                                      .packageListModel
                                                      .value
                                                      .data![index]
                                                      .packageName,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                                Icon(
                                                  Icons
                                                      .star_border_purple500_sharp,
                                                  color: controller
                                                              .packageListModel
                                                              .value
                                                              .data![index]
                                                              .currentPackage ==
                                                          true
                                                      ? Colors.green
                                                      : Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: _size.height * .03,
                                          width: _size.width * .3,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius: const BorderRadius
                                                  .all(
                                                  const Radius.circular(5.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12
                                                        .withOpacity(0.1),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.1)
                                              ]),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "price".tr + ": ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  controller
                                                      .packageListModel
                                                      .value
                                                      .data![index]
                                                      .price
                                                      .tr,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  child: Image.asset(
                                                    "assets/icons/taka.png",
                                                    height: 10,
                                                    width: 10,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: _size.height * .03,
                                          width: _size.width * .5,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius: const BorderRadius
                                                  .all(
                                                  const Radius.circular(5.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12
                                                        .withOpacity(0.1),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.1)
                                              ]),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .star_border_purple500_sharp,
                                                  color: controller
                                                              .packageListModel
                                                              .value
                                                              .data![index]
                                                              .currentPackage ==
                                                          true
                                                      ? Colors.green
                                                      : Colors.white,
                                                ),
                                                Text(
                                                  controller
                                                      .packageListModel
                                                      .value
                                                      .data![index]
                                                      .packageNameBn,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                                Icon(
                                                  Icons
                                                      .star_border_purple500_sharp,
                                                  color: controller
                                                              .packageListModel
                                                              .value
                                                              .data![index]
                                                              .currentPackage ==
                                                          true
                                                      ? Colors.green
                                                      : Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: _size.height * .03,
                                          width: _size.width * .3,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius: const BorderRadius
                                                  .all(
                                                  const Radius.circular(5.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12
                                                        .withOpacity(0.1),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.1)
                                              ]),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "price".tr + ": ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  controller
                                                      .packageListModel
                                                      .value
                                                      .data![index]
                                                      .price
                                                      .tr,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  child: Image.asset(
                                                    "assets/icons/taka.png",
                                                    height: 10,
                                                    width: 10,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                              controller.packageListModel.value.data![index]
                                          .serviceList.isNotEmpty ||
                                      controller.packageListModel.value
                                              .data![index].currentPackage ==
                                          false
                                  ? Container(
                                      height: controller
                                                  .packageListModel
                                                  .value
                                                  .data![index]
                                                  .serviceList
                                                  .length ==
                                              1
                                          ? 50
                                          : controller
                                                      .packageListModel
                                                      .value
                                                      .data![index]
                                                      .serviceList
                                                      .length ==
                                                  2
                                              ? 100
                                              : controller
                                                          .packageListModel
                                                          .value
                                                          .data![index]
                                                          .serviceList
                                                          .length ==
                                                      3
                                                  ? 150
                                                  : controller
                                                              .packageListModel
                                                              .value
                                                              .data![index]
                                                              .serviceList
                                                              .length ==
                                                          4
                                                      ? 200
                                                      : 250,
                                      child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: controller
                                              .packageListModel
                                              .value
                                              .data![index]
                                              .serviceList
                                              .length,
                                          itemBuilder: (b, i) {
                                            if (GetStorage()
                                                    .read<String>('language') ==
                                                'en_US') {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                      dense: true,
                                                      visualDensity:
                                                          VisualDensity(
                                                              horizontal: 0,
                                                              vertical: -4),
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      minVerticalPadding: 0,
                                                      horizontalTitleGap: 0,
                                                      leading: Icon(
                                                        Icons.bookmark_sharp,
                                                        color: AppColors
                                                            .primaryColor,
                                                        size: 15,
                                                      ),
                                                      title: Text(
                                                        controller
                                                            .packageListModel
                                                            .value
                                                            .data![index]
                                                            .serviceList![i]
                                                            .name,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )),
                                                  Divider(),
                                                ],
                                              );
                                            } else {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                      dense: true,
                                                      visualDensity:
                                                          VisualDensity(
                                                              horizontal: 0,
                                                              vertical: -4),
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      minVerticalPadding: 0,
                                                      horizontalTitleGap: 0,
                                                      leading: Icon(
                                                        Icons.bookmark_sharp,
                                                        color: AppColors
                                                            .primaryColor,
                                                        size: 15,
                                                      ),
                                                      title: Text(
                                                        controller
                                                            .packageListModel
                                                            .value
                                                            .data![index]
                                                            .serviceList![i]
                                                            .nameBn,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )),
                                                  Divider(),
                                                ],
                                              );
                                            }
                                          }),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Your Current Package".tr,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    controller.packagePurchaseId.value = "0";
                    showDialog(
                      context: Get.context!,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: SizedBox(
                            height: Get.size.width * .6,
                            width: Get.size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.width * .03,
                                  ),
                                  Text(
                                    'Enter your PIN number to confirm'.tr,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width * .1,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Price'.tr,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        ": " +
                                            uniCodeTk +
                                            ' ' +
                                            controller.packageListModel.value
                                                .data![index].price.tr,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width * .1,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      //  height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey,
                                          )),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: TextFormField(
                                          obscureText: true,
                                          controller: controller.pinController,
                                          cursorColor: const Color(0xFF652981),
                                          textAlign: TextAlign.center,
                                          maxLength: 6,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: InputBorder.none,
                                            hintText: 'Enter PIN here'.tr,
                                            hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                            focusColor: const Color(0xFF652981),
                                          ),
                                          keyboardType: TextInputType.phone,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .35,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: Get.theme.primaryColor,
                                        )),
                                    child: Center(
                                      child: Text(
                                        'Cancel'.tr,
                                        style: TextStyle(
                                          color: Get.theme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                BlockButtonWidget(
                                  onPressed: () {
                                    if (controller
                                        .pinController.text.isNotEmpty) {
                                      controller.buyPackage(
                                          controller.packageListModel.value
                                              .data![index].packageId!,
                                          "");
                                    } else {
                                      Get.showSnackbar(Ui.ErrorSnackBar(
                                          message:
                                              'Please Enter Your PIN No'.tr,
                                          title: 'Error'.tr));
                                    }
                                  },
                                  color: Get.theme.primaryColor,
                                  width:
                                      MediaQuery.of(context).size.width * .35,
                                  text: Text(
                                    'Confirm'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        child: Container(
                          child: Image.asset(
                            "assets/icons/taka.png",
                            height: 15,
                            width: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text("Main Balance".tr +
                          " (${controller.mainBalance.value})"),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    controller.packagePurchaseId.value = "1";
                    Get.toNamed(Routes.MFS_PACKAGE, arguments: [
                      controller.packageListModel.value.data![index].price,
                      controller.packageListModel.value.data![index].packageId
                    ]);
                    // showDialog(
                    //   context: Get.context!,
                    //   builder: (BuildContext context) {
                    //     return AlertDialog(
                    //       contentPadding: EdgeInsets.zero,
                    //       content: SizedBox(
                    //         height: Get.size.width * .6,
                    //         width: Get.size.width,
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               SizedBox(
                    //                 height: size.width * .03,
                    //               ),
                    //               Text(
                    //                 'Enter your PIN number to confirm'.tr,
                    //                 style: const TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 18,
                    //                   fontWeight: FontWeight.w500,
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 height: MediaQuery.of(context).size.width * .1,
                    //               ),
                    //
                    //               SizedBox(
                    //                 height: MediaQuery.of(context).size.width * .01,
                    //               ),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //
                    //                   Text(
                    //                     'Price'.tr,
                    //                     style: const TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.normal,
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     ": " +uniCodeTk + ' ' + controller.packageListModel.value.data![index].price.tr,
                    //                     style: const TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.normal,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               SizedBox(
                    //                 height: MediaQuery.of(context).size.width * .1,
                    //               ),
                    //               Container(
                    //                   width: MediaQuery.of(context).size.width,
                    //                   //  height: 50,
                    //                   decoration: BoxDecoration(
                    //                       borderRadius: BorderRadius.circular(5),
                    //                       border: Border.all(
                    //                         width: 1,
                    //                         color: Colors.grey,
                    //                       )),
                    //                   child: ClipRRect(
                    //                     borderRadius: BorderRadius.circular(5.0),
                    //                     child: TextFormField(
                    //                       obscureText: true,
                    //                       controller: controller.pinController,
                    //                       cursorColor: const Color(0xFF652981),
                    //                       textAlign: TextAlign.center,
                    //                       maxLength: 6,
                    //                       decoration: InputDecoration(
                    //                         counterText: "",
                    //                         filled: true,
                    //                         fillColor: Colors.white,
                    //                         border: InputBorder.none,
                    //                         hintText: 'Enter PIN here'.tr,
                    //                         hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                    //                         focusColor: const Color(0xFF652981),
                    //                       ),
                    //                       keyboardType: TextInputType.phone,
                    //                     ),
                    //                   )),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       actions: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             InkWell(
                    //               onTap: () {
                    //                 Get.back();
                    //               },
                    //               child: Container(
                    //                 width: MediaQuery.of(context).size.width * .35,
                    //                 height: 40,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(8),
                    //                     border: Border.all(
                    //                       width: 1,
                    //                       color: Get.theme.primaryColor,
                    //                     )),
                    //                 child: Center(
                    //                   child: Text(
                    //                     'Cancel'.tr,
                    //                     style: TextStyle(
                    //                       color: Get.theme.primaryColor,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             BlockButtonWidget(
                    //               onPressed: () {
                    //
                    //                 if (controller.pinController.text.isNotEmpty) {
                    //                   controller.buyPackage(controller.packageListModel.value.data![index].packageId!);
                    //
                    //
                    //                 } else {
                    //                   Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please Enter Your PIN No'.tr, title: 'Error'.tr));
                    //                 }
                    //               },
                    //               color: Get.theme.primaryColor,
                    //               width: MediaQuery.of(context).size.width * .35,
                    //               text: Text(
                    //                 'Confirm'.tr,
                    //                 style: const TextStyle(
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         )
                    //       ],
                    //     );
                    //   },
                    // );
                  },
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        child: Container(
                          child: Image.asset(
                            "assets/icons/taka.png",
                            height: 15,
                            width: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text("Payment Gateway".tr),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
