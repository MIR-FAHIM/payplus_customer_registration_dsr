import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';

import 'package:latest_payplus_agent/common/ui.dart';

class NewNIDInputWidget extends GetWidget<SignupController> {
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text("Register".tr),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,

            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 43, 42, 43).withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(0, -2)),
            ],
            //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                //Get.toNamed(Routes.NEWNIDINPUT);
                if (controller.faceMatched.value == false) {
                  Get.showSnackbar(Ui.ErrorSnackBar(
                      message: 'Your Image is not matched with your NID.'.tr,
                      title: 'Error'.tr));
                } else {
                  controller.newNIDVerificationController();
                }
              },
              child: Container(
                width: _size.width,
                height: _size.width * .1,
                decoration:
                    Ui.getBoxDecoration(color: Color(0xFF652981), radius: 10),
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(
                labelText: "NID No".tr,
                readOnly: false,
                // initialValue: '',
                initialValue: controller.userData.value.nid,
                keyboardType: TextInputType.number,
                limit: 17,
                iconData: null,

                onChanged: (input) {
                  controller.userData.value.nid = input;
                  print(
                      "hlw bro ${controller.userData.value.nid!} length ${controller.userData.value.nid!.length}");
                  if (controller.userData.value.nid!.length == 17) {
                    print("nid check 1");
                    // controller.duplicateNIDCheck();
                  }
                },
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'This field cannot be empty'.tr;
                  } else if (input.length < 17) {
                    return 'Please provide valid NID number'.tr;
                  } else {
                    return null;
                  }
                },
                hintText: 'NID No'.tr,
                imageData: 'assets/images/nid.png',
              ),

              Obx(() {
                return Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 10),
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 2,
                          offset: const Offset(0, 2)),
                    ],
                    //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Date of birth".tr,
                        style: Get.textTheme.bodyText1,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        // color: AppColors.primaryColor,
                        width: Get.size.width,
                        child: TextFormField(
                          onTap: () {
                            controller.pickDate();
                          },
                          initialValue: controller.userData.value.dob,
                          // controller: controller.dateInput.value,
                          keyboardType: TextInputType.phone,
                          onChanged: (input) {
                            controller.userData.value.dob = input;
                          },
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'This field cannot be empty'.tr;
                            } else {
                              return null;
                            }
                          },
                          style: Get.textTheme.bodyText2,
                          textAlign: TextAlign.start,
                          cursorColor: AppColors.primaryColor,
                          decoration: Ui.getInputDecorationWithoutCounter(
                            hintText: 'yyyy-mm-dd',
                            imageData: 'assets/images/dob.png',
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),

              Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 14, left: 20, right: 20),
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xFF652981).withOpacity(0.2),
                        blurRadius: 2,
                        offset: const Offset(0, 2)),
                  ],
                  //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Merchant Image".tr,
                      style: Get.textTheme.bodyText1,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return Center(
                        child: Container(
                          height: Get.width * .3,
                          width: Get.width * .3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 2,
                                color: Color(0xFF652981),
                              )),
                          child: GestureDetector(
                            onTap: () {
                              showPopup(context, 'user');
                            },
                            child: controller.userData.value.image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.memory(
                                      base64Decode(
                                        controller.userData.value.image!,
                                      ),
                                      height: Get.size.width * .45,
                                      width: Get.size.width,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Icon(
                                    Icons.camera_alt_outlined,
                                    color: Color(0xFF652981),
                                    size: 30,
                                  ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              controller.faceMatched.value == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "NID and Your Image Matched".tr,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Match your NID Image".tr,
                        style: Get.textTheme.bodyText1,
                        textAlign: TextAlign.start,
                      ),
                    ),
              // GestureDetector(
              //   onTap: (){
              //     controller.skipTrade.value = true;
              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.width * .15,
              //     decoration: controller.skipTrade.value == true ? Ui.getBoxDecoration(color: Colors.blue, radius: 10): Ui.getBoxDecoration(color: Colors.white, radius: 10),
              //
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Center(
              //         child: Text(
              //           'Skip Trade License for now'.tr,
              //           style: const TextStyle(
              //             fontSize: 16,
              //             color: Color(0xFF652981),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10,),
              // GestureDetector(
              //   onTap: (){
              //     controller.skipTrade.value = false;
              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.width * .15,
              //     decoration: controller.skipTrade.value == false ? Ui.getBoxDecoration(color: Colors.blue, radius: 10): Ui.getBoxDecoration(color: Colors.white, radius: 10),
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Center(
              //         child: Text(
              //           'Sign up with trade license'.tr,
              //           style: const TextStyle(
              //             fontSize: 16,
              //             color: Color(0xFF652981),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              // TextFieldWidget(
              //   labelText: "Date of birth".tr,
              //   keyboardType: TextInputType.number,
              //   readOnly: false,
              //   initialValue: '',
              //   onChanged: (input) {
              //     controller.userData.value.dob = input;
              //   },
              //   iconData: null,
              //   hintText: 'yyyy-mm-dd',
              //   imageData: 'assets/images/dob.png',
              // ),
            ],
          ),
        ),
      );
    });
  }

  showPopup(context, String type) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            //title: Text('Select '),
            content: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Wrap(
                children: <Widget>[
                  // ListTile(
                  //     leading: const Icon(Icons.photo_library),
                  //     title: Text('Photo Library'.tr),
                  //     onTap: () {
                  //       controller.getImageAndroid13(ImageSource.gallery, type);
                  //       Get.back();
                  //     }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Camera'.tr),
                    onTap: () {
                      controller.nidImageMatch(ImageSource.camera, type);
                      Get.back();
                    },
                  ),
                ],
              ),
            )
            // actions: <Widget>[

            // ],
            );
      },
    );
  }
}
