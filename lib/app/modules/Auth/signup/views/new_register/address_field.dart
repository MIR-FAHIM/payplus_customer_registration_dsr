import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/views/new_register/password_field.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/widgets/progress_sign_up.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class NewSignUpAddressFieldView extends GetView<SignupController> {
  final _size = Get.size;

  final ScrollController _controller = ScrollController();
  //signature - Z+7FVOca7EZ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register".tr),
          centerTitle: true,
        ),
        body: Obx(() {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              height: _size.height * 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressSignUp(
                      indexP: 1,
                      step1: "Outlet Information".tr,
                      step2: "Address".tr,
                      step3: "Password set".tr,
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Address".tr + ' *',
                      style: Get.textTheme.bodyText1,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                    Container(

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
                      child: TextFormField(

                        controller: controller.addressController.value,
                        keyboardType: TextInputType.text,
                        style: Get.textTheme.bodyText2,
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
                          hintText: "Enter Address".tr,
                          iconData: CupertinoIcons.location_circle,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
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
                            "City".tr,
                            style: Get.textTheme.bodyText1,
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            height: 45,
                            color: Colors.white,
                            child: DropdownSearch<String>(
                            //  mode: Mode.MENU,
                              // showSearchBox: true,
                              // dropdownSearchDecoration: Ui.getInputDecoration(
                              //   hintText: '',
                              //   iconData: CupertinoIcons.location_solid,
                              // ),
                              // showSelectedItems: true,
                              items: controller.cityList
                                  .map((item) => item.cityName!)
                                  .toList(),
                              onChanged: (input) {
                                for (var item in controller.cityList) {
                                  if (item.cityName == input) {
                                    controller.selectedCityId.value =
                                        item.cityId!.toString();
                                    print(
                                        "my city id is ${controller.selectedCityId.value}");
                                  }
                                }
                                controller.getZoneList();
                              },
                              selectedItem: "Select City".tr,
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
                            "Zone".tr,
                            style: Get.textTheme.bodyText1,
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            height: 45,
                            color: Colors.white,
                            child: DropdownSearch<String>(
                              // showSearchBox: true,
                              // mode: Mode.MENU,
                              // dropdownSearchDecoration: Ui.getInputDecoration(
                              //   hintText: '',
                              //   iconData: CupertinoIcons.location_solid,
                              // ),
                              // showSelectedItems: true,
                              items: controller.zoneList
                                  .map((item) => item.zoneName!)
                                  .toList(),
                              onChanged: (input) {
                                for (var item in controller.zoneList) {
                                  if (item.zoneName == input) {
                                    controller.selectedZoneId.value =
                                        item.zoneId!.toString();
                                  }
                                }
                                controller.getAreaList();
                              },
                              selectedItem: "Select Zone".tr,
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
                            "Area".tr,
                            style: Get.textTheme.bodyText1,
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            height: 45,
                            color: Colors.white,
                            child: DropdownSearch<String>(
                              // showSearchBox: true,
                              // mode: Mode.MENU,
                              // dropdownSearchDecoration: Ui.getInputDecoration(
                              //   hintText: '',
                              //   iconData: CupertinoIcons.location_solid,
                              // ),
                              // showSelectedItems: true,
                              items: controller.areaList
                                  .map((item) => item.areaName!)
                                  .toList(),
                              onChanged: (input) {
                                for (var item in controller.areaList) {
                                  if (item.areaName == input) {
                                    controller.selectedAreaId.value =
                                        item.areaId!.toString();
                                    print(
                                        "my area id is ${controller.selectedAreaId.value}");
                                  }
                                }
                              },
                              selectedItem: "Select Area".tr,
                            ),
                          ),
                          // Text(controller.addresses.value),
                        ],
                      ),
                    ),
                    //

                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.addressController.value.text.isEmpty ||
                            controller.selectedCityId.value.isEmpty ||
                            controller.selectedZoneId.value.isEmpty ||
                            controller.selectedAreaId.value.isEmpty) {
                          Get.showSnackbar(Ui.ErrorSnackBar(
                              message: "Please fill all the field",
                              title: 'Error'.tr));
                        } else {
                          Get.to(NewSignUpPassFieldView());
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
