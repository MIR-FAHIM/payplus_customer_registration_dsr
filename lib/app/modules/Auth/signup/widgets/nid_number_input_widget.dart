import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';

import 'package:latest_payplus_agent/common/ui.dart';

class NIDInputWidget extends GetWidget<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
     () {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFieldWidget(
              labelText: "NID No".tr,
              readOnly: true,
              // initialValue: '',
              initialValue: controller.userData.value.nid,
              keyboardType: TextInputType.number,
              limit: 17,
              iconData: null,

              onChanged: (input) {
                controller.userData.value.nid = input;
                print("hlw bro ${controller.userData.value.nid!} length ${controller.userData.value.nid!.length}");
                if(controller.userData.value.nid!.length == 17){
                  print("nid check 1");
                   controller.duplicateNIDCheck();
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

            Container(
              padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 10),
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF652981).withOpacity(0.2), blurRadius: 2, offset: const Offset(0, 2)),
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

                            controller.pickDate("dob");







                      },
                      controller: controller.dateInput,
                      keyboardType: TextInputType.phone,
                      onChanged: (input) {
                        controller.dateInput.text = input;
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
                      cursorColor: const Color(0xFF652981),
                      decoration: Ui.getInputDecorationWithoutCounter(
                        hintText: 'yyyy-mm-dd',
                        imageData: 'assets/images/dob.png',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
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
                    style: Get.textTheme.bodyMedium,
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
                            controller.getImage(ImageSource.camera, 'user');
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
        );
      }
    );
  }
}
