import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class UserDetailsAddressWidget extends GetWidget<SignupController> {
  // late double latitude;
  // late double longitude;
  // var selectedAddress;
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Column(
      children: [
        Obx(() {
          print("object");

          return Column(
            children: [
              //জেলা
              Container(
                padding: EdgeInsets.only(bottom: 14, left: 20, right: 0),
                margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF652981).withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 2)),
                  ],
                  //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "জেলা".tr,
                      style: Get.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      height: 45,
                      color: Colors.white,
                      child: DropdownSearch<String>(
                        // mode: Mode.MENU,
                        // dropdownSearchDecoration: Ui.getInputDecoration(
                        //   hintText: '',
                        //   iconData: CupertinoIcons.location_solid,
                        // ),
                        // showSelectedItems: true,
                        items: (filter, infiniteScrollProps) =>controller.districtsTypes.isNotEmpty
                            ? controller.districtsTypes!
                            .map((item) => item.districtName!)
                            .toList()
                            : [],
                        onChanged: (input) {
                          for (var item in controller.districtsTypes) {
                            if (item.districtName == input) {
                              controller.userData.value.districts = item.id!.toString();
                            }
                          }
                          controller.getThanaUpojila();
                        },
                        selectedItem: "জেলা নির্বাচন করুন".tr,
                      ),
                    ),
                    // Text(controller.addresses.value),
                  ],
                ),
              ),

              //উপজেলা
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 0),
                margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF652981).withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 2)),
                  ],
                  //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "উপজেলা".tr,
                      style: Get.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      height: 45,
                      color: Colors.white,
                      child: DropdownSearch<String>(
                        // mode: Mode.MENU,
                        // dropdownSearchDecoration: Ui.getInputDecoration(
                        //   hintText: '',
                        //   iconData: CupertinoIcons.location_solid,
                        // ),
                        // showSelectedItems: true,
                        items: (filter, infiniteScrollProps) =>controller.thanas.isNotEmpty
                            ? controller.thanas!
                            .map((item) => item.upazilaName!)
                            .toList()
                            : [],
                        onChanged: (input) {
                          for (var item in controller.thanas) {
                            if (item.upazilaName == input) {
                              controller.userData.value.thana = item.id!.toString();
                            }
                          }
                          controller.getUnion();
                        },
                        selectedItem: "উপজেলা নির্বাচন করুন".tr,
                      ),
                    ),
                    // Text(controller.addresses.value),
                  ],
                ),
              ),
              //ইউনিয়ন
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 0),
                margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF652981).withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 2)),
                  ],
                  //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "ইউনিয়ন".tr,
                      style: Get.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      height: 45,
                      color: Colors.white,
                      child: DropdownSearch<String>(
                        // mode: Mode.MENU,
                        // dropdownSearchDecoration: Ui.getInputDecoration(
                        //   hintText: '',
                        //   iconData: CupertinoIcons.location_solid,
                        // ),
                        // showSelectedItems: true,
                        items: (filter, infiniteScrollProps) =>controller.unions.isNotEmpty
                            ? controller.unions!
                            .map((item) => item.unionName!)
                            .toList()
                            : [],
                        onChanged: (input) {
                          for (var item in controller.unions) {
                            if (item.unionName == input) {
                              controller.userData.value.union = item.id!.toString();
                            }
                          }
                        },
                        selectedItem: "ইউনিয়ন নির্বাচন করুন".tr,
                      ),
                    ),
                    // Text(controller.addresses.value),
                  ],
                ),
              ),
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
                keyboardType: TextInputType.number,
                initialValue: controller.postalCode.value,
                labelText: "পোস্ট অফিসের নাম্বার".tr,
                hintText: "পোস্ট অফিসের নাম্বার লিখুন".tr,
                onChanged: (value) {
                  controller.postalCode.value = value;
                  controller.userData.value.post_code = value;
                },

                // onSaved: (input) =>
                // controller.currentUser.value.email = input,
                // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,

                iconData: CupertinoIcons.location_solid,
                // imageData: 'assets/bill/account.png',
              ),
            ],
          );
        }),
      ],
    );
  }
}
