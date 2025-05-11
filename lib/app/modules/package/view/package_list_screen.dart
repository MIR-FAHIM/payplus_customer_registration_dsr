import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/modules/package/controller/package_list_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:flutter/cupertino.dart';

class PackageListForBuyView extends GetView<PackageController> {
  PackageListForBuyView({Key? key}) : super(key: key);
  final _size = Get.size;
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
        if (controller.productLoaded.isTrue) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  controller.currentPackageModel.value.data == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Your Current Package".tr,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor),
                              ),
                              Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Spacer(),
                                          controller.currentPackageModel.value
                                                      .data!.packageName ==
                                                  "Basic Package"
                                              ? Container()
                                              : Container(
                                                  height: _size.height * .03,
                                                  width: _size.width * .7,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryLightColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(const Radius
                                                                  .circular(
                                                                  5.0)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors
                                                                .black12
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 0.5,
                                                            spreadRadius: 0.1)
                                                      ]),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.lock_clock,
                                                        color: Colors.red,
                                                      ),
                                                      // ১০/১১/২০২৩
                                                      GetStorage().read<String>(
                                                                  'language') ==
                                                              'en_US'
                                                          ? Text(
                                                              "Expire Date: ${controller.currentPackageModel.value.data!.expireDate}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12),
                                                            )
                                                          : Text(
                                                              "মেয়াদ উত্তির্ণ তারিখঃ ${controller.currentPackageModel.value.data!.expireDate}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12),
                                                            ),
                                                    ],
                                                  ),
                                                )
                                        ],
                                      ),
                                      ListTile(
                                        title: Text(
                                          controller.currentPackageModel.value
                                              .data!.packageName,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        //প্যাকেজটির একটিভ্যাশন সম্য:৩০ আগষ্ট ২০২৩
                                        subtitle: GetStorage()
                                                    .read<String>('language') ==
                                                'en_US'
                                            ? Text(
                                                "Activation Date: ${controller.currentPackageModel.value.data!.packageActivationDate}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.green),
                                              )
                                            : Text(
                                                "প্যাকেজটির একটিভ্যাশন সময়: ${controller.currentPackageModel.value.data!.packageActivationDate}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.green),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                  //product
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Package List".tr,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),

                  SingleChildScrollView(
                    child: controller.packageListModel.value.data == null
                        ? CircularProgressIndicator()
                        : Container(
                            height: MediaQuery.of(context).size.height * .5,
                            child: ListView.builder(
                              itemCount: controller
                                  .packageListModel.value.data!.length,
                              itemBuilder: (buildContext, index) {
                                var data = controller
                                    .packageListModel.value.data![index];
                                return InkWell(
                                  onTap: () {
                                    print(
                                        "lang ${GetStorage().read<String>('language') == 'en_US'}");
                                    //Get.toNamed(Routes.PRODUCT_DETAILS, arguments: controller.productItems[index]);
                                  },
                                  child: data.packageId == 1
                                      ? Container()
                                      : Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GetStorage().read<String>(
                                                            'language') ==
                                                        'en_US'
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            height:
                                                                _size.height *
                                                                    .03,
                                                            width: _size.width *
                                                                .5,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                borderRadius: const BorderRadius
                                                                    .all(
                                                                    const Radius
                                                                        .circular(
                                                                        5.0)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black12
                                                                          .withOpacity(
                                                                              0.1),
                                                                      blurRadius:
                                                                          0.5,
                                                                      spreadRadius:
                                                                          0.1)
                                                                ]),
                                                            child: Center(
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .star_border_purple500_sharp,
                                                                    color: data.currentPackage ==
                                                                            true
                                                                        ? AppColors
                                                                            .golden
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                  Text(
                                                                    data.packageName,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .star_border_purple500_sharp,
                                                                    color: data.currentPackage ==
                                                                            true
                                                                        ? AppColors
                                                                            .golden
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height:
                                                                _size.height *
                                                                    .03,
                                                            width: _size.width *
                                                                .3,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                borderRadius: const BorderRadius
                                                                    .all(
                                                                    const Radius
                                                                        .circular(
                                                                        5.0)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black12
                                                                          .withOpacity(
                                                                              0.1),
                                                                      blurRadius:
                                                                          0.5,
                                                                      spreadRadius:
                                                                          0.1)
                                                                ]),
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "price".tr +
                                                                        ": ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Text(
                                                                    data.price
                                                                        .tr,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Container(
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/icons/taka.png",
                                                                      height:
                                                                          10,
                                                                      width: 10,
                                                                      color: Colors
                                                                          .white,
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
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            height:
                                                                _size.height *
                                                                    .03,
                                                            width: _size.width *
                                                                .5,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                borderRadius: const BorderRadius
                                                                    .all(
                                                                    const Radius
                                                                        .circular(
                                                                        5.0)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black12
                                                                          .withOpacity(
                                                                              0.1),
                                                                      blurRadius:
                                                                          0.5,
                                                                      spreadRadius:
                                                                          0.1)
                                                                ]),
                                                            child: Center(
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .star_border_purple500_sharp,
                                                                    color: data.currentPackage ==
                                                                            true
                                                                        ? AppColors
                                                                            .golden
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                  Text(
                                                                    data.packageNameBn,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .star_border_purple500_sharp,
                                                                    color: data.currentPackage ==
                                                                            true
                                                                        ? AppColors
                                                                            .golden
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height:
                                                                _size.height *
                                                                    .03,
                                                            width: _size.width *
                                                                .3,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                borderRadius: const BorderRadius
                                                                    .all(
                                                                    const Radius
                                                                        .circular(
                                                                        5.0)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black12
                                                                          .withOpacity(
                                                                              0.1),
                                                                      blurRadius:
                                                                          0.5,
                                                                      spreadRadius:
                                                                          0.1)
                                                                ]),
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "price".tr +
                                                                        ": ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Text(
                                                                    data.price
                                                                        .tr,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Container(
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/icons/taka.png",
                                                                      height:
                                                                          10,
                                                                      width: 10,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                data.serviceList.isNotEmpty ||
                                                        data.currentPackage ==
                                                            false
                                                    ? Container(
                                                        height: data.serviceList
                                                                    .length ==
                                                                1
                                                            ? 50
                                                            : data.serviceList
                                                                        .length ==
                                                                    2
                                                                ? 100
                                                                : data.serviceList
                                                                            .length ==
                                                                        3
                                                                    ? 150
                                                                    : data.serviceList.length ==
                                                                            4
                                                                        ? 200
                                                                        : 250,
                                                        child: ListView.builder(
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount: data
                                                                .serviceList
                                                                .length,
                                                            itemBuilder:
                                                                (b, i) {
                                                              if (GetStorage().read<
                                                                          String>(
                                                                      'language') ==
                                                                  'en_US') {
                                                                return Column(
                                                                  children: [
                                                                    ListTile(
                                                                        dense:
                                                                            true,
                                                                        visualDensity: VisualDensity(
                                                                            horizontal:
                                                                                0,
                                                                            vertical:
                                                                                -4),
                                                                        contentPadding:
                                                                            EdgeInsets.all(
                                                                                0),
                                                                        minVerticalPadding:
                                                                            0,
                                                                        horizontalTitleGap:
                                                                            0,
                                                                        leading:
                                                                            Icon(
                                                                          Icons
                                                                              .bookmark_sharp,
                                                                          color:
                                                                              AppColors.primaryColor,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                        title:
                                                                            Text(
                                                                          data.serviceList![i]
                                                                              .name,
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )),
                                                                    Divider(),
                                                                  ],
                                                                );
                                                              } else {
                                                                return Column(
                                                                  children: [
                                                                    ListTile(
                                                                        dense:
                                                                            true,
                                                                        visualDensity: VisualDensity(
                                                                            horizontal:
                                                                                0,
                                                                            vertical:
                                                                                -4),
                                                                        contentPadding:
                                                                            EdgeInsets.all(
                                                                                0),
                                                                        minVerticalPadding:
                                                                            0,
                                                                        horizontalTitleGap:
                                                                            0,
                                                                        leading:
                                                                            Icon(
                                                                          Icons
                                                                              .bookmark_sharp,
                                                                          color:
                                                                              AppColors.primaryColor,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                        title:
                                                                            Text(
                                                                          data.serviceList![i]
                                                                              .nameBn,
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )),
                                                                    Divider(),
                                                                  ],
                                                                );
                                                              }
                                                            }),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Your Current Package"
                                                              .tr,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .primaryColor),
                                                        ),
                                                      ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                data.currentPackage == true
                                                    ? Container(
                                                        height: 10,
                                                        width: 10,
                                                      )
                                                    : Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                Routes
                                                                    .BUYNOWPACKAGE,
                                                                arguments: [
                                                                  index
                                                                ]);
                                                            //controller.buyPackage(data.packageId!);
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: _size.width *
                                                                .2,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        .7),
                                                                borderRadius: const BorderRadius
                                                                    .all(
                                                                    const Radius
                                                                        .circular(
                                                                        15.0)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black12
                                                                          .withOpacity(
                                                                              0.1),
                                                                      blurRadius:
                                                                          0.5,
                                                                      spreadRadius:
                                                                          0.1)
                                                                ]),
                                                            child: Center(
                                                              child: Text(
                                                                "Buy Now".tr,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                  ),
                  const SizedBox(height: 3),
                  // Container(
                  //   color: AppColors.SecondbackgroundColor,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: <Widget>[
                  //       Padding(
                  //           padding: const EdgeInsets.all(10.0),
                  //
                  //           /// Image item
                  //           child: Container(
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius:
                  //                       const BorderRadius.all(const Radius.circular(15.0)),
                  //                   image: const DecorationImage(
                  //                       image: const AssetImage('assets/images/shop.png')),
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                         color: Colors.black12.withOpacity(0.1),
                  //                         blurRadius: 0.5,
                  //                         spreadRadius: 0.1)
                  //                   ]),
                  //               child: Container(
                  //                 height: 65.0,
                  //                 width: 65.0,
                  //                 decoration: const BoxDecoration(
                  //                   borderRadius:
                  //                       const BorderRadius.all(Radius.circular(15.0)),
                  //                   image: const DecorationImage(
                  //                       image: AssetImage('assets/images/shop.png')),
                  //                 ),
                  //               ))),
                  //       Flexible(
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                  //           child: Column(
                  //             /// Text Information Item
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: <Widget>[
                  //               Row(
                  //                 children: [
                  //                   Container(
                  //                     width: 100.0,
                  //                     child: const Text(
                  //                       'Dell Monitor',
                  //                       style: TextStyle(
                  //                           fontWeight: FontWeight.w600,
                  //                           fontFamily: "Sans",
                  //                           color: Colors.black87,
                  //                           fontSize: 14.0),
                  //                       overflow: TextOverflow.clip,
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     // width:
                  //                     //     MediaQuery.of(context).size.width * 0.4,
                  //                     // height: 25,
                  //                     decoration: BoxDecoration(
                  //                       color: Theme.of(context).secondaryHeaderColor,
                  //                       border: Border.all(color: Colors.green, width: 1),
                  //                       borderRadius: BorderRadius.circular(10),
                  //                     ),
                  //                     child: const Padding(
                  //                       padding: EdgeInsets.only(
                  //                           left: 8, right: 8, top: 3, bottom: 3),
                  //                       child: const Center(
                  //                         child: Text(
                  //                           'Active',
                  //                           style: TextStyle(
                  //                               color: Colors.green,
                  //                               fontWeight: FontWeight.bold,
                  //                               fontSize: 12),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               const SizedBox(
                  //                 height: 8.0,
                  //               ),
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                 children: [
                  //                   Column(
                  //                     children: [
                  //                       Text(
                  //                         'In Stock'.tr,
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.w300,
                  //                             fontFamily: "Sofia",
                  //                             color: AppColors.homeTextColor3,
                  //                             fontSize: 12),
                  //                         overflow: TextOverflow.ellipsis,
                  //                       ),
                  //                       const Padding(
                  //                         padding: EdgeInsets.only(bottom: 5.0, top: 5),
                  //                         child: const Text(
                  //                           '১০',
                  //                           style: const TextStyle(
                  //                               color: Colors.black,
                  //                               fontFamily: "Sofia",
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w700),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   Column(
                  //                     children: [
                  //                       Text(
                  //                         'Buy Price'.tr,
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.w300,
                  //                             fontFamily: "Sofia",
                  //                             color: AppColors.homeTextColor3,
                  //                             fontSize: 12),
                  //                         overflow: TextOverflow.ellipsis,
                  //                       ),
                  //                       const Padding(
                  //                         padding: EdgeInsets.only(bottom: 5.0, top: 5),
                  //                         child: const Text(
                  //                           '৳ ৪৫০',
                  //                           style: const TextStyle(
                  //                               color: Colors.black,
                  //                               fontFamily: "Sofia",
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w700),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   Column(
                  //                     children: [
                  //                       Text(
                  //                         'Sell Price'.tr,
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.w300,
                  //                             fontFamily: "Sofia",
                  //                             color: AppColors.homeTextColor3,
                  //                             fontSize: 12),
                  //                         overflow: TextOverflow.ellipsis,
                  //                       ),
                  //                       const Padding(
                  //                         padding: EdgeInsets.only(bottom: 5.0, top: 5),
                  //                         child: const Text(
                  //                           '৳ ৫০০',
                  //                           style: TextStyle(
                  //                               color: Colors.black,
                  //                               fontFamily: "Sofia",
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w700),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(right: 20),
                  //         child: Image.asset(
                  //           "assets/icons/right_arrow.png",
                  //           width: 15,
                  //           height: 15,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
