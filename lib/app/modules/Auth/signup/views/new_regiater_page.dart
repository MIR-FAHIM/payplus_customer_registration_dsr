import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../../../global_widgets/text_field_widget.dart';
import '../controllers/signup_controller.dart';

class NewSignUpView extends GetView<SignupController> {
  final _size = Get.size;

  final ScrollController _controller = ScrollController();
  //signature - Z+7FVOca7EZ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register".tr, style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Container(
              height: _size.height * 1.5,
              child: Form(
                key: controller.userinfo,
                child: Column(
                  children: [
                    TextFieldWidget(
                      labelText: "Name".tr,
                      hintText: "Enter Name".tr,
                      onChanged: (input) =>
                          controller.userData.value.name = input,
                      validator: (input) =>
                          input!.length < 1 ? 'Please provide name'.tr : null,
                      iconData: null,
                      imageData: 'assets/images/shop.png',
                    ),
                    TextFieldWidget(
                      labelText: "Personal Mobile No".tr,
                      initialValue: '',
                      hintText: 'Mobile'.tr,
                      keyboardType: TextInputType.phone,
                      limit: 11,
                      // hasDropdown: true,
                      onChanged: (input) =>
                          controller.userData.value.personalMobile = input,
                      validator: (input) =>
                          input!.length < 11 || input.length > 11
                              ? 'Enter valid phone number'.tr
                              : null,
                      iconData: CupertinoIcons.device_phone_portrait,
                    ),
                    TextFieldWidget(
                      labelText: "Address".tr,
                      hintText: "Enter Address".tr,
                      onChanged: (input) =>
                          controller.userData.value.outletAddress = input,
                      validator: (input) =>
                          input!.length < 1 ? 'Please provide name'.tr : null,
                      iconData: null,
                      imageData: 'assets/images/shop.png',
                    ),
                    TextFieldWidget(
                      labelText: "Outlet Name".tr,
                      hintText: "Enter Outlet Name".tr,
                      onChanged: (input) =>
                          controller.userData.value.outletName = input,
                      validator: (input) => input!.length < 1
                          ? 'Please provide outlet name'.tr
                          : null,
                      iconData: null,
                      imageData: 'assets/images/shop.png',
                    ),
                    //জেলা
                    Container(
                      padding: EdgeInsets.only(bottom: 14, left: 20, right: 0),
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
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
                              enabled: true,
                              items: (filter, infiniteScrollProps) =>controller.districtsTypes.isNotEmpty
                                  ? controller.districtsTypes!
                                  .map((item) => item.districtName!)
                                  .toList()
                                  : [],
                              onChanged: (input) {
                                for (var item in controller.districtsTypes) {
                                  if (item.districtName == input) {
                                    controller.userData.value.districts =
                                        item.id!.toString();
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
                      padding: EdgeInsets.only(
                          top: 10, bottom: 14, left: 20, right: 0),
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
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
                                    controller.userData.value.thana =
                                        item.id!.toString();
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
                      padding: EdgeInsets.only(
                          top: 10, bottom: 14, left: 20, right: 0),
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
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
                                    controller.userData.value.union =
                                        item.id!.toString();
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
                    //
                    TextFieldWidget(
                      labelText: "Pin:".tr,
                      hintText: "••••••••••••".tr,
                      keyboardType: TextInputType.number,
                      onChanged: (input) {
                        controller.userData.value.password = input;
                      },

                      // onSaved: (input) =>
                      // controller.currentUser.value.password = input,
                      validator: (input) {
                        if (input!.length < 6 || input.length > 6)
                          return "Should be 6 characters";
                        else {
                          return null;
                        }
                      },
                      limit: 6,
                      counterText: "",
                      obscureText: controller.hidePassword.value,
                      iconData: Icons.lock_outline,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          color: const Color(0xFF652981),
                          icon: controller.hidePassword.value == false
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off_outlined)),
                    ),
                    TextFieldWidget(
                      labelText: "Confirm PIN Number:".tr,
                      hintText: "••••••••••••".tr,
                      keyboardType: TextInputType.number,
                      validator: (input) {
                        if (input!.length < 6 || input.length > 6) {
                          return "Should be 6 characters";
                        } else if (input !=
                            controller.userData.value.password) {
                          return "Password doesn't match";
                        } else {
                          return null;
                        }
                      },
                      limit: 6,
                      counterText: "",
                      obscureText: controller.hideConfirmPassword.value,
                      iconData: Icons.lock_outline,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hideConfirmPassword.value =
                                !controller.hideConfirmPassword.value;
                          },
                          color: const Color(0xFF652981),
                          icon: controller.hideConfirmPassword.value == false
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off_outlined)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.newRegistrtionApiController();
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
                              "Register".tr,
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
