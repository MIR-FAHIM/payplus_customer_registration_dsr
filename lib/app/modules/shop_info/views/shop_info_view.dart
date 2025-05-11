import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/shop_info_controller.dart';

class ShopInfoView extends GetView<ShopInfoController> {
  const ShopInfoView({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Scaffold(
      body: Obx(() {
        return controller.shopInfoLoaded.isTrue && controller.divisionLoaded.isTrue
            ? Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Stack(
                        children: [
                          Container(
                            height: 300,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/login.png'),
                              fit: BoxFit.fill,
                            )),
                          ),
                          const Positioned(
                              top: 70,
                              left: 80,
                              right: 80,
                              child: Image(
                                image: AssetImage('assets/Logow.png'),
                              ))
                        ],
                      )),
                  Positioned(
                      top: 190,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Stack(
                        children: [
                          Container(
                            height: _size.height,
                            width: _size.width,
                            margin: const EdgeInsets.all(20),
                            decoration: Ui.getBoxDecoration(color: Colors.white),
                            child: Form(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        'Shop Info'.tr,
                                        style: const TextStyle(
                                          color: Color(0xFF652981),
                                          fontSize: 22,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        TextFieldWidget(
                                          keyboardType: TextInputType.text,

                                          initialValue: controller
                                              .shopInfo.value.shopdata!.shopName
                                              .toString(),
                                          labelText: "Shop Name".tr,
                                          hintText: "Enter Shop Name".tr,
                                          onChanged: (value) {
                                            controller.shopname.value = value;
                                          },

                                          // onSaved: (input) =>
                                          // controller.currentUser.value.email = input,
                                          // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,

                                          iconData: CupertinoIcons.location_solid,
                                          // imageData: 'assets/bill/account.png',
                                        ),
                                        // Container(
                                        //   padding: const EdgeInsets.only(
                                        //       bottom: 14, left: 20, right: 0),
                                        //   margin: const EdgeInsets.only(
                                        //       left: 15, right: 15, top: 10, bottom: 10),
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.white,
                                        //     borderRadius: BorderRadius.circular(10),
                                        //     boxShadow: [
                                        //       BoxShadow(
                                        //           color: const Color(0xFF652981)
                                        //               .withOpacity(0.2),
                                        //           blurRadius: 2,
                                        //           offset: const Offset(0, 2)),
                                        //     ],
                                        //     //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                                        //   ),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.stretch,
                                        //     children: [
                                        //       Text(
                                        //         "Division".tr,
                                        //         style: Get.textTheme.bodyMedium,
                                        //         textAlign: TextAlign.start,
                                        //       ),
                                        //       Container(
                                        //         height: 45,
                                        //         color: Colors.white,
                                        //         child: DropdownSearch<String>(
                                        //
                                        //
                                        //          // showSelectedItems: true,
                                        //           items: (filter, infiniteScrollProps) =>controller.divisionList.isNotEmpty
                                        //               ? controller.divisionList!
                                        //               .map((item) => item['division_name']!)
                                        //               .toList()
                                        //               : [],
                                        //           onChanged: (String? input) {
                                        //             for (var item
                                        //                 in controller.divisionList) {
                                        //               if (item['division_name'] ==
                                        //                   input) {
                                        //                 controller.divisionId.value =
                                        //                     item['id']!.toString();
                                        //               }
                                        //             }
                                        //             controller.getDistrictData();
                                        //           },
                                        //           selectedItem: controller.shopInfo.value
                                        //                   .shopdata!.division ??
                                        //               '',
                                        //         ),
                                        //       ),
                                        //       // Text(controller.addresses.value),
                                        //     ],
                                        //   ),
                                        // ),
                                        // //জেলা
                                        // Container(
                                        //   padding: const EdgeInsets.only(
                                        //       bottom: 14, left: 20, right: 0),
                                        //   margin: const EdgeInsets.only(
                                        //       left: 15, right: 15, top: 10, bottom: 10),
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.white,
                                        //     borderRadius: BorderRadius.circular(10),
                                        //     boxShadow: [
                                        //       BoxShadow(
                                        //           color: const Color(0xFF652981)
                                        //               .withOpacity(0.2),
                                        //           blurRadius: 2,
                                        //           offset: const Offset(0, 2)),
                                        //     ],
                                        //     //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                                        //   ),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.stretch,
                                        //     children: [
                                        //       Text(
                                        //         "জেলা".tr,
                                        //         style: Get.textTheme.bodyMedium,
                                        //         textAlign: TextAlign.start,
                                        //       ),
                                        //       Container(
                                        //         height: 45,
                                        //         color: Colors.white,
                                        //         child: DropdownSearch<String>(
                                        //           // mode: Mode.MENU,
                                        //           // dropdownSearchDecoration:
                                        //           //     Ui.getInputDecoration(
                                        //           //   hintText: '',
                                        //           //   iconData:
                                        //           //       CupertinoIcons.location_solid,
                                        //           // ),
                                        //          // showSelectedItems: true,
                                        //           items:
                                        //               controller.districtList.isNotEmpty
                                        //                   ? controller.districtList
                                        //                       .map((item) =>
                                        //                           item['district_name']
                                        //                               .toString())
                                        //                       .toList()
                                        //                   : [],
                                        //           onChanged: (String? input) {
                                        //             for (var item
                                        //                 in controller.districtList) {
                                        //               if (item['district_name'] ==
                                        //                   input) {
                                        //                 controller.districtId.value =
                                        //                     item['id']!.toString();
                                        //               }
                                        //             }
                                        //             controller.getUpazilaData();
                                        //           },
                                        //           selectedItem: controller
                                        //               .shopInfo.value.shopdata!.district!,
                                        //         ),
                                        //       ),
                                        //       // Text(controller.addresses.value),
                                        //     ],
                                        //   ),
                                        // ),
                                        //
                                        // //উপজেলা
                                        // Container(
                                        //   padding: const EdgeInsets.only(
                                        //       top: 10, bottom: 14, left: 20, right: 0),
                                        //   margin: const EdgeInsets.only(
                                        //       left: 15, right: 15, top: 10, bottom: 10),
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.white,
                                        //     borderRadius: BorderRadius.circular(10),
                                        //     boxShadow: [
                                        //       BoxShadow(
                                        //           color: const Color(0xFF652981)
                                        //               .withOpacity(0.2),
                                        //           blurRadius: 2,
                                        //           offset: const Offset(0, 2)),
                                        //     ],
                                        //     //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                                        //   ),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.stretch,
                                        //     children: [
                                        //       Text(
                                        //         "উপজেলা".tr,
                                        //         style: Get.textTheme.bodyMedium,
                                        //         textAlign: TextAlign.start,
                                        //       ),
                                        //       Container(
                                        //         height: 45,
                                        //         color: Colors.white,
                                        //         child: DropdownSearch<String>(
                                        //          // mode: Mode.MENU,
                                        //          //  dropdownSearchDecoration:
                                        //          //      Ui.getInputDecoration(
                                        //          //    hintText: '',
                                        //          //    iconData:
                                        //          //        CupertinoIcons.location_solid,
                                        //          //  ),
                                        //          //  showSelectedItems: true,
                                        //           items: controller.upazilaList.isNotEmpty
                                        //               ? controller.upazilaList
                                        //                   .map((item) =>
                                        //                       item['upazila_name']
                                        //                           .toString())
                                        //                   .toList()
                                        //               : [],
                                        //           onChanged: (String? input) {
                                        //             for (var item
                                        //                 in controller.upazilaList) {
                                        //               if (item['upazila_name'] == input) {
                                        //                 controller.upazilaId.value =
                                        //                     item['id']!.toString();
                                        //               }
                                        //             }
                                        //           },
                                        //           selectedItem: controller
                                        //               .shopInfo.value.shopdata!.upazila,
                                        //         ),
                                        //       ),
                                        //       // Text(controller.addresses.value),
                                        //     ],
                                        //   ),
                                        // ),
                                        //ইউনিয়ন
                                        // Container(
                                        //   padding: const EdgeInsets.only(
                                        //       top: 10, bottom: 14, left: 20, right: 0),
                                        //   margin: const EdgeInsets.only(
                                        //       left: 15, right: 15, top: 10, bottom: 10),
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.white,
                                        //     borderRadius: BorderRadius.circular(10),
                                        //     boxShadow: [
                                        //       BoxShadow(
                                        //           color: const Color(0xFF652981)
                                        //               .withOpacity(0.2),
                                        //           blurRadius: 2,
                                        //           offset: const Offset(0, 2)),
                                        //     ],
                                        //     //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                                        //   ),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.stretch,
                                        //     children: [
                                        //       Text(
                                        //         "ইউনিয়ন".tr,
                                        //         style: Get.textTheme.bodyMedium,
                                        //         textAlign: TextAlign.start,
                                        //       ),
                                        //       Container(
                                        //         height: 45,
                                        //         color: Colors.white,
                                        //         child: DropdownSearch<String>(
                                        //           mode: Mode.MENU,
                                        //           dropdownSearchDecoration:
                                        //               Ui.getInputDecoration(
                                        //             hintText: '',
                                        //             iconData:
                                        //                 CupertinoIcons.location_solid,
                                        //           ),
                                        //           showSelectedItems: true,
                                        //           items: [''],
                                        //           onChanged: (input) {},
                                        //           selectedItem:
                                        //               "ইউনিয়ন নির্বাচন করুন".tr,
                                        //         ),
                                        //       ),
                                        //       // Text(controller.addresses.value),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
                                        //   child: Container(
                                        //     height: 95,
                                        //     width: _size.width,
                                        //     decoration: Ui.getBoxDecoration(
                                        //       color: Colors.white,
                                        //       radius: 8,
                                        //     ),
                                        //     child: Padding(
                                        //       padding: const EdgeInsets.only(left: 12, top: 10),
                                        //       child: Column(
                                        //         crossAxisAlignment: CrossAxisAlignment.start,
                                        //         children: [
                                        //           Padding(
                                        //             padding: const EdgeInsets.only(left: 5, bottom: 5),
                                        //             child: Text(
                                        //               'পোস্ট অফিসের নাম্বার'.tr,
                                        //               style: TextStyle(fontWeight: FontWeight.bold),
                                        //             ),
                                        //           ),
                                        //           Row(
                                        //             crossAxisAlignment: CrossAxisAlignment.start,
                                        //             children: [
                                        //               Icon(
                                        //                 CupertinoIcons.location_solid,
                                        //                 color: AppColors.primaryColor,
                                        //                 size: 25,
                                        //               ),
                                        //               SizedBox(width: 10),
                                        //               Container(
                                        //                   // color: Colors.blue,
                                        //                   width: _size.width * 0.65,
                                        //                   height: 60,
                                        //                   child: Padding(
                                        //                     padding: const EdgeInsets.only(top: 5),
                                        //                     child: Text(
                                        //                       "পোস্ট অফিসের নাম্বার লিখুন".tr,
                                        //                       style: TextStyle(
                                        //                           color: AppColors.homeTextColor3),
                                        //                     ),
                                        //                   )),
                                        //             ],
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),

                                        TextFieldWidget(
                                          keyboardType: TextInputType.text,

                                          initialValue: controller
                                              .shopInfo.value.shopdata!.address
                                              .toString(),
                                          labelText: "Address".tr,
                                          hintText: "Enter Full Address".tr,
                                          onChanged: (value) {
                                            controller.address.value = value;
                                          },

                                          // onSaved: (input) =>
                                          // controller.currentUser.value.email = input,
                                          // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,

                                          iconData: CupertinoIcons.location_solid,
                                          // imageData: 'assets/bill/account.png',
                                        ),

                                        TextFieldWidget(
                                          keyboardType: TextInputType.number,

                                          initialValue: controller
                                              .shopInfo.value.shopdata!.postCode
                                              .toString(),
                                          labelText: "পোস্ট অফিসের নাম্বার".tr,
                                          hintText: "পোস্ট অফিসের নাম্বার লিখুন".tr,
                                          onChanged: (value) {
                                            controller.postal.value = value;
                                          },

                                          // onSaved: (input) =>
                                          // controller.currentUser.value.email = input,
                                          // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,

                                          iconData: CupertinoIcons.location_solid,
                                          // imageData: 'assets/bill/account.png',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 30,
                            right: 30,
                            child: BlockButtonWidget(
                              onPressed: () {
                                controller.updateShop();
                              },
                              color: Get.theme.primaryColor,
                              text: const Center(
                                  child: Text(
                                'Submit',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              )),
                            ),
                          )
                        ],
                      )),
                  Positioned(
                    top: 40,
                    left: 15,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Center(child: Ui.customLoader());
      }),
    );
  }
}
