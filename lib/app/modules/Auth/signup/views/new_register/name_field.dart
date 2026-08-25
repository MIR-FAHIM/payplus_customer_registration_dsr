import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/views/new_register/address_field.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/widgets/progress_sign_up.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../../../../global_widgets/text_field_widget.dart';

import '../../controllers/signup_controller.dart';

class NewSignUpNameFieldView extends GetView<SignupController> {
  final _size = Get.size;

  final ScrollController _controller = ScrollController();
  //signature - Z+7FVOca7EZ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text("Register".tr),
          centerTitle: true,
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Container(
              height: _size.height,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressSignUp(
                      indexP: 0,
                      step1: "Outlet Information".tr,
                      step2: "Address".tr,
                      step3: "Password set".tr,
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Customer Name".tr + ' *',
                      style: Get.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: controller.customerName.value,
                        keyboardType: TextInputType.text,
                        style: Get.textTheme.bodyMedium,
                        // validator: (input) {
                        //   if (controller.phoneController.text.length != 11) {
                        //     return 'Invalid phone number'.tr;
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        obscureText: false,
                        textAlign: TextAlign.start,
                        cursorColor: Color(0xFF652981),
                        decoration: Ui.getInputDecoration(
                          hintText: "Enter Customer Name".tr,
                          iconData: CupertinoIcons.device_phone_portrait,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    Text(
                      "Personal Mobile No".tr + ' *',
                      style: Get.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: controller.personalPhone.value,
                        keyboardType: TextInputType.phone,
                        style: Get.textTheme.bodyMedium,
                        // validator: (input) {
                        //   if (controller.phoneController.text.length != 11) {
                        //     return 'Invalid phone number'.tr;
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        obscureText: false,
                        textAlign: TextAlign.start,
                        cursorColor: Color(0xFF652981),
                        decoration: Ui.getInputDecoration(
                          hintText: "Enter Customer Mobile No.".tr,
                          iconData: CupertinoIcons.device_phone_portrait,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),

                    Text(
                      "Outlet Name".tr + ' *',
                      style: Get.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: controller.outletName.value,
                        keyboardType: TextInputType.text,
                        style: Get.textTheme.bodyMedium,
                        // validator: (input) {
                        //   if (controller.phoneController.text.length != 11) {
                        //     return 'Invalid phone number'.tr;
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        obscureText: false,
                        textAlign: TextAlign.start,
                        cursorColor: Color(0xFF652981),
                        decoration: Ui.getInputDecoration(
                          hintText: "Enter Outlet Name".tr,
                          iconData: CupertinoIcons.bookmark,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: controller.email.value,
                        keyboardType: TextInputType.text,
                        style: Get.textTheme.bodyMedium,
                        obscureText: false,
                        textAlign: TextAlign.start,
                        cursorColor: Color(0xFF652981),
                        decoration: Ui.getInputDecoration(
                          hintText: "Enter Email".tr,
                          iconData: CupertinoIcons.bookmark,
                        ),
                      ),
                    ),

                    //জেলা

                    //

                    const SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.personalPhone.value.text.isEmpty ||
                            controller.outletName.value.text.isEmpty) {
                          Get.showSnackbar(Ui.ErrorSnackBar(
                              message: "Please fill all the field",
                              title: 'Error'.tr));
                        } else {
                          Get.to(NewSignUpAddressFieldView());
                        }
                      },
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: const Color(0xFF652981),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Center(
                            child: Text(
                              "Continue".tr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ).paddingSymmetric(vertical: 5, horizontal: 20),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
