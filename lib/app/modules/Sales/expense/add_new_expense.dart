import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';

class AddNewExpense extends GetWidget<SignupController> {
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
            title: Text('Add New Expense'.tr),
            elevation: 0,
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: _size.width,
            height: _size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: _size.width,
                    height: _size.height * 0.75,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            // width: _size.width * 0.45,
                            // height: 100,
                            // color: AppColors.primaryColor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          'Select'.tr,
                                          style: TextStyle(
                                              color: AppColors.homeTextColor3,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        decoration: BoxDecoration(
                                          color: AppColors.homeCardBg,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 10),
                                              Text(
                                                "Select Section".tr,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13),
                                              ),
                                              SizedBox(width: 8),
                                              Image.asset(
                                                'assets/icons/down_arrow.png',
                                                height: 10,
                                                width: 10,
                                                color: AppColors.homeTextColor1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          'Select'.tr,
                                          style: TextStyle(
                                              color: AppColors.homeTextColor3,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.primarydeepLightColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 20),
                                              Image.asset(
                                                'assets/icons/calender.png',
                                                height: 10,
                                                width: 10,
                                                color: AppColors.homeTextColor1,
                                              ),
                                              IconGap(),
                                              Text(
                                                "তারিখ",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .homeTextColor1,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13),
                                              ),
                                              SizedBox(width: 20),
                                              Image.asset(
                                                'assets/icons/down_arrow.png',
                                                height: 10,
                                                width: 10,
                                                color: AppColors.homeTextColor1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
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
                                      'Recipt Picture'.tr,
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
                          TextFieldWidget(
                            // keyboardType: numberFormatSymbols,
                            labelText: "Expense Amount".tr,
                            hintText: "Enter Expense Amount".tr,
                            onChanged: (value) {
                              // bill_number = value;
                            },

                            // onSaved: (input) =>
                            // controller.currentUser.value.email = input,
                            // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                            keyboardType: TextInputType.number,
                            iconData: null,
                            imageData: 'assets/icons/price.png',
                          ),
                          TextFieldWidget(
                            // keyboardType: numberFormatSymbols,
                            labelText: "Expense Reason".tr,
                            hintText: "Enter Expense Reason".tr,
                            onChanged: (value) {
                              // bill_number = value;
                            },

                            // onSaved: (input) =>
                            // controller.currentUser.value.email = input,
                            // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                            keyboardType: TextInputType.number,
                            iconData: null,
                            imageData: 'assets/icons/expense.png',
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(15.0),
                          //   child: InkWell(
                          //     onTap: () {
                          //       // Get.toNamed(Routes.Add_New_Product);
                          //     },
                          //     child: Container(
                          //       width: _size.width,
                          //       height: _size.width * .1,
                          //       decoration: Ui.getBoxDecoration(
                          //           color: Color(0xFF652981), radius: 10),
                          //       child: Center(
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(left: 5),
                          //           child: Text(
                          //             'Add'.tr,
                          //             style: TextStyle(
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: _size.width,
                    // height: _size.height * 0.3,
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
                          Get.to(AddNewExpense());
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

  SizedBox IconGap() {
    return SizedBox(
      width: 4,
    );
  }
}
