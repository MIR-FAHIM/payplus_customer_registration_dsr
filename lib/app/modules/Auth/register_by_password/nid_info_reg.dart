import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';


class NIDInputWidgetReg extends GetWidget<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text("Add Information".tr),
      ),
      body: Obx(() {
        return Column(
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
              },
              validator: (input) {
                if (input!.isEmpty) {
                  return 'This field cannot be empty'.tr;
                } else if (input.length > 17) {
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
                        color: AppColors.primaryColor,
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
                      style: Get.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      // color: AppColors.primaryColor,
                      width: Get.size.width,
                      child: TextFormField(
                        onTap: () {
                          controller.pickDate("nid");
                        },
                        //initialValue: controller.userData.value.dob,
                        controller: controller.dateInputController.value,
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
                        style: Get.textTheme.bodyMedium,
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
              padding:
              const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
              margin:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primaryColor,
                      blurRadius: 2,
                      offset: const Offset(0, 2)),
                ],
                //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Match your NID Image".tr,
                    style: Get.textTheme.bodyMedium,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return GestureDetector(
                      onTap: () {
                        //controller.getImage(ImageSource.camera, 'nid_back');

                        showPopup(context, 'user');
                      },
                      child: controller.userImage.value.isNotEmpty
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          base64Decode(
                            controller.userImage.value,
                          ),
                          height: Get.size.width * .5,
                          width: Get.size.width,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Stack(
                        children: [
                          Image.asset(
                            'assets/images/nid.png',
                            height: Get.size.width * .35,
                            width: Get.size.width,
                            color: Colors.grey,
                          ),
                          Positioned(
                              bottom: 10,
                              right: 80,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius:
                                    BorderRadius.circular(50)),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
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
        );
      }),
    );
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
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text('Photo Library'.tr),
                      onTap: () {
                        controller.getImageAndroid13(ImageSource.gallery, type);
                        Get.back();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Camera'.tr),
                    onTap: () {
                      controller.getImage(ImageSource.camera, type);
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
