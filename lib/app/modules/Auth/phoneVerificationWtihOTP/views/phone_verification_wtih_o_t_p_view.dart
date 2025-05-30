import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/Color.dart';

import '../controllers/phone_verification_wtih_o_t_p_controller.dart';

class PhoneVerificationWtihOTPView extends GetView<PhoneVerificationWtihOTPController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF652981),
          centerTitle: true,
          title: Text('Mobile Number Verification'.tr),
          elevation: 0,
        ),
        body: Obx(() {
          return GestureDetector(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.size.height * .07,
                  ),
                  Center(
                    child: SizedBox(
                      height: Get.size.width * .4,
                      width: Get.size.width * .4,
                      child: const Image(
                        image: AssetImage('assets/images/Vector.png'),
                        // color: Color(0xFF652981),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.size.height * .03,
                  ),

                  Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                        child: RichText(
                          text: TextSpan(
                            text: "A verification has been sent to this number".tr + " +88${controller.mobileNumber.value}.",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' ( Change Number ) '.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF652981),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.back();
                                  },
                              ),
                            ],
                          ),
                        )),
                  ),
                  Obx(() {
                    return Column(
                      children: [
                        // Obx(() {
                        //   return Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        //     child: PinCodeTextField(
                        //       // showCursor: false,
                        //       appContext: context,
                        //       pastedTextStyle: TextStyle(
                        //         color: Colors.green.shade600,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //       length: 6,
                        //       obscureText: false,
                        //       animationType: AnimationType.fade,
                        //       readOnly: true,
                        //       pinTheme: PinTheme(
                        //         shape: PinCodeFieldShape.box,
                        //         borderRadius: BorderRadius.circular(10),
                        //         fieldHeight: 50,
                        //         fieldWidth: 40,
                        //         inactiveFillColor: Colors.white,
                        //         inactiveColor: Colors.grey,
                        //         selectedColor: const Color(0xFF652981),
                        //         selectedFillColor: Colors.white,
                        //         activeFillColor: Colors.white,
                        //         activeColor: const Color(0xFF652981),
                        //       ),
                        //       cursorColor: Colors.black,
                        //       animationDuration: const Duration(milliseconds: 300),
                        //       enableActiveFill: false,
                        //       controller: controller.codeController.value,
                        //
                        //       keyboardType: TextInputType.number,
                        //       enabled: true,
                        //       textStyle: const TextStyle(
                        //         color: Color(0xFF652981),
                        //       ),
                        //       boxShadows: [
                        //         BoxShadow(
                        //           offset: const Offset(0, 1),
                        //           color: controller.code.value == '1'
                        //               ? Colors.black12
                        //               : Colors.black12,
                        //           blurRadius: 10,
                        //         )
                        //       ],
                        //       onCompleted: (v) {
                        //         controller.code.value = '1';
                        //         //do something or move to next screen when code complete
                        //       },
                        //       onChanged: (value) {
                        //         controller.code.value = '1';
                        //         print(value);
                        //       },
                        //     ),
                        //   );
                        // }),
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(6, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    width: Get.size.width * .12,
                                    height: Get.size.width * .15,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 2,
                                          color: Get.theme.primaryColor,
                                        )),
                                    child: Center(
                                      child: Text(
                                        controller.newCode.isNotEmpty ? controller.newCode.value[index] : '',
                                        style: TextStyle(
                                          color: Get.theme.primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Text(
                              //   'Verification Code'.tr,
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: 16,
                              //   ),
                              // ),
                              controller.codeVerifyTime.value == 0
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        await controller.sendOTP();
                                        controller.initSmsListener();
                                        controller.update();
                                        controller.codeVerifyTime.value = 180;
                                        controller.verifyTimeStart();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF652981),
                                      ),
                                      child: Text(
                                        'Resend Code'.tr,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ))
                                  : Text(
                                      'Resend code after'.tr + ' ${controller.codeVerifyTime.value}s',
                                    )
                              // Obx(() {
                              //   if (controller.codeVerifyTime.value == 0) {
                              //     return ElevatedButton(
                              //         onPressed: () {
                              //           controller.sendOTP();
                              //           controller.initSmsListener();
                              //           controller.codeVerifyTime.value = 60;
                              //           controller.verifyTimeStart();
                              //         },
                              //         style: ElevatedButton.styleFrom(
                              //           primary: Color(0xFF652981),
                              //         ),
                              //         child: Text(
                              //           'Resend Code'.tr,
                              //           style: TextStyle(
                              //             fontSize: 16,
                              //             color: Colors.white,
                              //           ),
                              //         ));
                              //   } else {
                              //     return Text(
                              //       'Resend code after'.tr + ' ${controller.codeVerifyTime.value}s',
                              //     );
                              //   }
                              // }),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: Get.size.height * .1,
                  ),

                  InkWell(
                    onTap: () {
                      controller.verifyOTP();
                    },
                    child: Container(
                      // width: MediaQuery.of(context).size.width * 0.17,
                      // height: MediaQuery.of(context).size.height * 0.08,
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: [
                          BoxShadow(color: const Color(0xFF652981).withOpacity(0.4), blurRadius: 6, spreadRadius: 1, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/arrow_for.png'),
                              fit: BoxFit.contain,
                            ),
                          )),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: Container(
                  //     height: 100,
                  //     width: Get.size.width,
                  //     decoration: BoxDecoration(
                  //       color: Color(0xFF652981),
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     child: Center(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Text(
                  //           "Don't share your pin and verification code with anyone."
                  //               .tr,
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 22,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          );
        }),
        // bottomNavigationBar: GestureDetector(
        //   onTap: () {
        //     controller.verifyOTP();
        //   },
        //   child: Container(
        //     height: 60,
        //     decoration: Ui.getBoxDecoration(color: Colors.white, radius: 0),
        //     child: Stack(
        //       children: [
        //         Container(
        //           width: Get.size.width,
        //           height: 60,
        //           color: Colors.white,
        //         ),
        //         Align(
        //             alignment: Alignment.center,
        //             child: Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Text(
        //                 'Confirm'.tr,
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 24,
        //                   color: Color(0xFF652981),
        //                 ),
        //               ),
        //             )),
        //         Align(
        //             alignment: Alignment.bottomRight,
        //             child: GestureDetector(
        //               onTap: () {
        //                 controller.verifyOTP();
        //               },
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Icon(
        //                   Icons.arrow_forward,
        //                   color: Color(0xFF652981),
        //                   size: 40,
        //                 ),
        //               ),
        //             )),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
