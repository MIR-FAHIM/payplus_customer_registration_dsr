import 'dart:io';
import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Buy/Widget/Input_discount.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class AddNewProduct extends GetWidget<SignupController> {
  PickedFile? imageFile = null;
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text('Product Description'.tr),
            elevation: 0,
            // actions: [
            //   IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         CupertinoIcons.bell,
            //         color: Colors.white70,
            //       )),
            // ],
          ),
        ),
        body: Form(
          key: controller.userinfo,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Obx(() {
                    print("object:${controller.count.value}");

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 5),
                          child: Container(
                            width: _size.width,
                            height: _size.height * 0.3,
                            decoration: Ui.getBoxDecoration(
                              color: Colors.white,
                              radius: 8,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    'Product Picture'.tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.homeTextColor2),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _openCamera(context);
                                  },
                                  child: Container(
                                    height: 130,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: AppColors.primarydeepLightColor,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: (imageFile == null)
                                        ? Icon(Icons.camera_alt,
                                            color: AppColors.primaryColor,
                                            size: 45)
                                        : ClipOval(
                                            child: Image.file(
                                            File(imageFile!.path),
                                            width: 130,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 14, left: 20, right: 20),
                          margin: EdgeInsets.only(
                              left: 13, right: 15, top: 10, bottom: 10),
                          decoration: Ui.getBoxDecoration(
                            color: Colors.white,
                            radius: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Product Name".tr,
                                    style: Get.textTheme.bodyText1,
                                    textAlign: TextAlign.start,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      "*".tr,
                                      style: TextStyle(
                                          color: AppColors.redTextColor),
                                    ),
                                  ),
                                ],
                              ),
                              TextField(
                                // controller: controller.nameController,
                                keyboardType: TextInputType.text,
                                style: Get.textTheme.bodyText2,

                                // validator: (input) {
                                //   if (controller.nameController.text.isEmpty) {
                                //     return 'This field is required'.tr;
                                //   } else {
                                //     return null;
                                //   }
                                // },

                                cursorColor: Color(0xFF652981),
                                decoration: InputDecoration(
                                    hintText: "Enter Product Name".tr,
                                    border: InputBorder.none),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 14, left: 20, right: 20),
                          margin: EdgeInsets.only(
                              left: 13, right: 15, top: 10, bottom: 10),
                          decoration: Ui.getBoxDecoration(
                            color: Colors.white,
                            radius: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Stock Amount".tr,
                                    style: Get.textTheme.bodyText1,
                                    textAlign: TextAlign.start,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      "*".tr,
                                      style: TextStyle(
                                          color: AppColors.redTextColor),
                                    ),
                                  ),
                                ],
                              ),
                              TextField(
                                // controller: controller.nameController,
                                keyboardType: TextInputType.text,
                                style: Get.textTheme.bodyText2,

                                // validator: (input) {
                                //   if (controller.nameController.text.isEmpty) {
                                //     return 'This field is required'.tr;
                                //   } else {
                                //     return null;
                                //   }
                                // },

                                cursorColor: Color(0xFF652981),
                                decoration: InputDecoration(
                                    hintText: "Enter Stock Amount".tr,
                                    border: InputBorder.none),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 14, left: 20, right: 20),
                          margin: EdgeInsets.only(
                              left: 13, right: 15, top: 10, bottom: 10),
                          decoration: Ui.getBoxDecoration(
                            color: Colors.white,
                            radius: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sell Price".tr,
                                    style: Get.textTheme.bodyText1,
                                    textAlign: TextAlign.start,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      "*".tr,
                                      style: TextStyle(
                                          color: AppColors.redTextColor),
                                    ),
                                  ),
                                ],
                              ),
                              TextField(
                                // controller: controller.nameController,
                                keyboardType: TextInputType.text,
                                style: Get.textTheme.bodyText2,

                                // validator: (input) {
                                //   if (controller.nameController.text.isEmpty) {
                                //     return 'This field is required'.tr;
                                //   } else {
                                //     return null;
                                //   }
                                // },

                                cursorColor: Color(0xFF652981),
                                decoration: InputDecoration(
                                    hintText: "Enter Sell Price".tr,
                                    border: InputBorder.none),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 14, left: 20, right: 20),
                          margin: EdgeInsets.only(
                              left: 13, right: 15, top: 10, bottom: 10),
                          decoration: Ui.getBoxDecoration(
                            color: Colors.white,
                            radius: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Buy Price".tr,
                                    style: Get.textTheme.bodyText1,
                                    textAlign: TextAlign.start,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      "*".tr,
                                      style: TextStyle(
                                          color: AppColors.redTextColor),
                                    ),
                                  ),
                                ],
                              ),
                              TextField(
                                // controller: controller.nameController,
                                keyboardType: TextInputType.text,
                                style: Get.textTheme.bodyText2,

                                // validator: (input) {
                                //   if (controller.nameController.text.isEmpty) {
                                //     return 'This field is required'.tr;
                                //   } else {
                                //     return null;
                                //   }
                                // },

                                cursorColor: Color(0xFF652981),
                                decoration: InputDecoration(
                                    hintText: "Enter Buy Price".tr,
                                    border: InputBorder.none),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: _size.width,
                          height: 80,
                          padding: EdgeInsets.only(
                              top: 10, bottom: 14, left: 20, right: 20),
                          margin: EdgeInsets.only(
                              left: 13, right: 15, top: 10, bottom: 10),
                          decoration: Ui.getBoxDecoration(
                            color: Colors.white,
                            radius: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Product Description".tr,
                                style: Get.textTheme.bodyText1,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Enter Product Description".tr,
                                style: TextStyle(
                                    color: AppColors.homeTextColor3,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        ExpandablePanel(
                            header: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 12),
                              child: Text(
                                "More Products Information".tr,
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ),
                            collapsed: Text(
                              "",
                              // softWrap: true,
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                            ),
                            expanded: Container(
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  //পণ্যের ক্যাটাগরি
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: 14, left: 20, right: 0),
                                    margin: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF652981)
                                                .withOpacity(0.2),
                                            blurRadius: 2,
                                            offset: Offset(0, 2)),
                                      ],
                                      //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Product Category".tr,
                                          style: Get.textTheme.bodyText1,
                                          textAlign: TextAlign.start,
                                        ),
                                        Container(
                                          height: 45,
                                          color: Colors.white,
                                          child: DropdownSearch<String>(
                                            // mode: Mode.MENU,
                                            // dropdownSearchDecoration:
                                            //     Ui.getInputDecorationWithIcon(
                                            //   hintText: '',
                                            //   // iconData:
                                            //   //     CupertinoIcons.location_solid,
                                            // ),
                                            // showSelectedItems: true,
                                            items: [''],
                                            // controller.businessTypes
                                            //     .map((item) => item.type!)
                                            //     .toList(),
                                            onChanged: (input) {
                                              // for (var item in controller.businessTypes) {
                                              //   if (item.type == input) {
                                              //     controller.userData.value.businessType =
                                              //         item.id!.toString();
                                              //   }
                                              // }
                                            },
                                            selectedItem:
                                                "Select Product Category".tr,
                                          ),
                                        ),
                                        // Text(controller.addresses.value),
                                      ],
                                    ),
                                  ),

                                  //পণ্যের উপ ক্যাটাগরি
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 14,
                                        left: 20,
                                        right: 0),
                                    margin: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF652981)
                                                .withOpacity(0.2),
                                            blurRadius: 2,
                                            offset: Offset(0, 2)),
                                      ],
                                      //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Product Sub-Category".tr,
                                          style: Get.textTheme.bodyText1,
                                          textAlign: TextAlign.start,
                                        ),
                                        Container(
                                          height: 45,
                                          color: Colors.white,
                                          child: DropdownSearch<String>(
                                            // mode: Mode.MENU,
                                            // dropdownSearchDecoration:
                                            //     Ui.getInputDecorationWithIcon(
                                            //   hintText: '',
                                            // ),
                                            // showSelectedItems: true,
                                            items: [''],
                                            // controller.businessTypes
                                            //     .map((item) => item.type!)
                                            //     .toList(),
                                            onChanged: (input) {
                                              // for (var item in controller.businessTypes) {
                                              //   if (item.type == input) {
                                              //     controller.userData.value.businessType =
                                              //         item.id!.toString();
                                              //   }
                                              // }
                                            },
                                            selectedItem:
                                                "Select Product Sub-Category"
                                                    .tr,
                                          ),
                                        ),
                                        // Text(controller.addresses.value),
                                      ],
                                    ),
                                  ),
                                  //পণ্য পরিমাপের একক
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 14,
                                        left: 20,
                                        right: 0),
                                    margin: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF652981)
                                                .withOpacity(0.2),
                                            blurRadius: 2,
                                            offset: Offset(0, 2)),
                                      ],
                                      //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Product Measurement Unit".tr,
                                          style: Get.textTheme.bodyText1,
                                          textAlign: TextAlign.start,
                                        ),
                                        Container(
                                          height: 45,
                                          color: Colors.white,
                                          child: DropdownSearch<String>(
                                            // mode: Mode.MENU,
                                            // dropdownSearchDecoration:
                                            //     Ui.getInputDecorationWithIcon(
                                            //   hintText: '',
                                            // ),
                                            // showSelectedItems: true,
                                            items: [''],
                                            // controller.businessTypes
                                            //     .map((item) => item.type!)
                                            //     .toList(),
                                            //
                                            onChanged: (input) {
                                              // for (var item in controller.businessTypes) {
                                              //   if (item.type == input) {
                                              //     controller.userData.value.businessType =
                                              //         item.id!.toString();
                                              //   }
                                              // }
                                            },
                                            selectedItem:
                                                "Select Product Measurement Unit"
                                                    .tr,
                                          ),
                                        ),
                                        // Text(controller.addresses.value),
                                      ],
                                    ),
                                  ),

                                  //মজুদ
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 14,
                                        left: 20,
                                        right: 20),
                                    margin: EdgeInsets.only(
                                        left: 13,
                                        right: 15,
                                        top: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF652981)
                                                .withOpacity(0.4),
                                            blurRadius: 2,
                                            offset: Offset(1, 2)),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Minimum Stock Alert ?".tr,
                                              style: Get.textTheme.bodyText1,
                                              textAlign: TextAlign.start,
                                            ),
                                            Center(
                                              child: Switch(
                                                value: isSwitched,
                                                onChanged: (value) {
                                                  // setState(() {
                                                  //   isSwitched = value;
                                                  //   print(isSwitched);
                                                  // });
                                                },
                                                activeTrackColor:
                                                    Colors.purple[200],
                                                activeColor:
                                                    AppColors.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextField(
                                          // controller: controller.nameController,
                                          keyboardType: TextInputType.text,
                                          style: Get.textTheme.bodyText2,

                                          // validator: (input) {
                                          //   if (controller.nameController.text.isEmpty) {
                                          //     return 'This field is required'.tr;
                                          //   } else {
                                          //     return null;
                                          //   }
                                          // },

                                          cursorColor: Color(0xFF652981),
                                          decoration: InputDecoration(
                                              hintText:
                                                  "Enter Minimum Stock Alert"
                                                      .tr,
                                              border: InputBorder.none),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //ভ্যাট প্রযোজ্য
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 14,
                                        left: 20,
                                        right: 20),
                                    margin: EdgeInsets.only(
                                        left: 13,
                                        right: 15,
                                        top: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF652981)
                                                .withOpacity(0.4),
                                            blurRadius: 2,
                                            offset: Offset(1, 2)),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Product Vat ?".tr,
                                              style: Get.textTheme.bodyText1,
                                              textAlign: TextAlign.start,
                                            ),
                                            Center(
                                              child: Switch(
                                                value: isSwitched,
                                                onChanged: (value) {
                                                  // setState(() {
                                                  //   isSwitched = value;
                                                  //   print(isSwitched);
                                                  // });
                                                },
                                                activeTrackColor:
                                                    Colors.purple[200],
                                                activeColor:
                                                    AppColors.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextField(
                                          // controller: controller.nameController,
                                          keyboardType: TextInputType.text,
                                          style: Get.textTheme.bodyText2,

                                          // validator: (input) {
                                          //   if (controller.nameController.text.isEmpty) {
                                          //     return 'This field is required'.tr;
                                          //   } else {
                                          //     return null;
                                          //   }
                                          // },

                                          cursorColor: Color(0xFF652981),
                                          decoration: InputDecoration(
                                              hintText:
                                                  "Enter Vat Percentage".tr,
                                              border: InputBorder.none),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: _size.width,
                                    height: 80,
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 14,
                                        left: 20,
                                        right: 20),
                                    margin: EdgeInsets.only(
                                        left: 13,
                                        right: 15,
                                        top: 10,
                                        bottom: 10),
                                    decoration: Ui.getBoxDecoration(
                                      color: Colors.white,
                                      radius: 8,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Warranty".tr,
                                          style: Get.textTheme.bodyText1,
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Enter Warranty(Month)".tr,
                                          style: TextStyle(
                                              color: AppColors.homeTextColor3,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () {
                                      Get.dialog(InputDiscount());
                                    },
                                    child: Container(
                                      width: _size.width,
                                      height: 80,
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 14,
                                          left: 20,
                                          right: 20),
                                      margin: EdgeInsets.only(
                                          left: 13,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      decoration: Ui.getBoxDecoration(
                                        color: Colors.white,
                                        radius: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Products Discount".tr,
                                            style: Get.textTheme.bodyText1,
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "Enter Discount (% or ৳)".tr,
                                            style: TextStyle(
                                                color: AppColors.homeTextColor3,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            // tapHeaderToExpand: true,
                            // hasIcon: true,
                            ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,

                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 43, 42, 43)
                                      .withOpacity(0.2),
                                  blurRadius: 2,
                                  offset: Offset(0, -2)),
                            ],
                            //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: InkWell(
                              onTap: () {
                                // Get.toNamed(Routes.Add_New_Product);
                              },
                              child: Container(
                                width: _size.width,
                                height: _size.width * .1,
                                decoration: Ui.getBoxDecoration(
                                    color: Color(0xFF652981), radius: 10),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Add'.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ));
  }

  void _openCamera(BuildContext context) async {
    final serviceStatus = await Permission.camera.isGranted;

    bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      final pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
      );
      // Ui.customLoaderDialog();

      // setState(() {
      //   imageFile = pickedFile!;
      // });

      // Navigator.pop(context);
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  // void _openCamera(BuildContext context) async {
  //   final pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //   );
  //   // Ui.customLoaderDialog();

  //   // setState(() {
  //   //   imageFile = pickedFile!;
  //   // });

  //   // Navigator.pop(context);
  // }
}
