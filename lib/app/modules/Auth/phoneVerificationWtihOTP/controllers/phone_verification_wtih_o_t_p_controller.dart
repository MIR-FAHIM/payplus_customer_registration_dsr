import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:otp_autofill/otp_autofill.dart';
import 'package:latest_payplus_agent/app/models/registration_payment_info_model.dart';
import 'package:latest_payplus_agent/app/repositories/otp_repository.dart';
import 'package:latest_payplus_agent/app/repositories/registartion_payment_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/data.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class PhoneVerificationWtihOTPController extends GetxController {
  //TODO: Implement PhoneVerificationWtihOTPController

  RxInt codeVerifyTime = 60.obs;
  final mobileNumber = ''.obs;
  final isRegistered = ''.obs;
  final code = ''.obs;
  final codeController = TextEditingController().obs;
  //final registrationInf = RegistrationPaymentInformationModel().obs;

  final serviceTypeID = ''.obs;
  final newCode = ''.obs;
  @override
  void onInit() {
    verifyTimeStart();
    // mobileNumber.value = Get.arguments['mobileNumber'];
    mobileNumber.value = MyData.phone_no;
    isRegistered.value = Get.arguments['isRegistered'];

    if (isRegistered.value != '1') {
      serviceTypeID.value = Get.arguments['selectedServiceTypeId'];
    }

    sendOTP();
    print(isRegistered.value);
    print(mobileNumber.value);
    initSmsListener();

    super.onInit();
  }

  void verifyTimeStart() {
    var duration = const Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      if (codeVerifyTime.value == 0) {
        timer.cancel();
      } else {
        codeVerifyTime.value -= 1;
      }
    });
  }

  Future<void> initSmsListener() async {
    OTPInteractor()
        .getAppSignature()
        .then((value) => print('signature - $value'));
    codeController.value.clear();

    codeController.value = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        print('Your Application receive code - $code');
        print('Your Application receive code 2 - ${codeController.value.text}');
      },
    )..startListenUserConsent(
        (code) {
          print('code 2: $code');
          final exp = RegExp(r'(\d{6})');
          codeController.value.addListener(() {
            newCode.value = exp.stringMatch(code ?? '') ?? '';
            codeController.value.text = newCode.value;
          });

          return exp.stringMatch(code ?? '') ?? '';
        },
        // strategies: [
        //   SampleStrategy(),
        // ],
      );
  }

  sendOTP() async {
    print("my phn no for otp is ${mobileNumber.value}");
    OTPRepository().otpSend(mobileNumber.value).then((resp) {
      if (resp["result"] == "success") {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: resp["message"], title: 'Success'.tr));
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp["message"], title: 'Error'.tr));
      }

      // if (resp['result'] == 'success') {
      //   Get.back();
      //   if (isRegistered.value == '1') {
      //     Get.toNamed(Routes.LOGIN);
      //   } else {
      //     Get.toNamed(Routes.SIGNUP);
      //   }
      // } else {
      //   Get.back();
      // }
    });
  }

  verifyOTP() async {
    Ui.customLoaderDialog();

    OTPRepository()
        .verifyOTP(mobileNumber.value, codeController.value.text)
        .then((resp) {
      print("verify otp +++++++ $resp");
      //failed
      if (resp['result'] == 'success') {
        Get.back();
        // Get.offAllNamed(Routes.LOGIN, arguments: mobileNumber.value);
        if (isRegistered.value == '1') {
          Get.offAllNamed(Routes.LOGIN, arguments: mobileNumber.value);
        } else {
          Get.offAllNamed(Routes.NEWSIGNUP, arguments: mobileNumber.value);
          // Get.back();

          // Get.offAllNamed(Routes.SIGNUP, arguments: [
          //   mobileNumber.value,
          //   serviceTypeID.value,
          // ]);

          //  Get.offAllNamed(Routes.SIGNUP, arguments: mobileNumber.value);
          // RegistartionPaymentRepository().RegPaymentInfo(mobileNumber.value).then((resp) {
          //   if (resp['result'] == 'success') {
          //     if (resp['payment_status'] == 'unpaid') {
          //       // Get.offAllNamed(Routes.SIGNUP, arguments: mobileNumber.value);
          //       print(mobileNumber.value);
          //       Get.offAllNamed(Routes.Registration_Payment_View, arguments: [mobileNumber.value, resp['registration_information']['id']]);
          //     } else if (resp['payment_status'] == 'paid') {
          //       print(mobileNumber.value);
          //       Get.offAllNamed(Routes.SIGNUP, arguments: mobileNumber.value);
          //     }
          //   } else {
          //     Get.back();
          //   }
          // });

          // Get.offAllNamed(Routes.SIGNUP, arguments: mobileNumber.value);
          // Get.offAllNamed(Routes.Registration_Payment_View, arguments: mobileNumber.value);
        }
      } else {
        Get.back();
      }
    });
  }
  // verifyOTP() async {
  //   Ui.customLoaderDialog();
  //   OTPRepository()
  //       .verifyOTP(mobileNumber.value, codeController.text)
  //       .then((resp) {
  //     if (resp['result'] == 'success') {
  //       Get.back();
  //       if (isRegistered.value == '1') {
  //         Get.offAllNamed(Routes.LOGIN, arguments: mobileNumber.value);
  //       } else {
  //         Get.defaultDialog(
  //             titlePadding: const EdgeInsets.only(top: 12),
  //             title: "Location Permission",
  //             backgroundColor: Colors.white,
  //             titleStyle: TextStyle(color: AppColors.primaryColor),
  //             textConfirm: "Accept",
  //             onConfirm: () {
  //               var data = {
  //                 "mobileNumber": mobileNumber.value,
  //                 "locationPermission": 'true',
  //               };

  //               Get.offAllNamed(Routes.SIGNUP, arguments: data);
  //               print("Confirm");
  //             },
  //             textCancel: "Decline",
  //             onCancel: () {
  //               var data = {
  //                 "mobileNumber": mobileNumber.value,
  //                 "locationPermission": 'false',
  //               };

  //               Get.offAllNamed(Routes.SIGNUP, arguments: data);
  //               print("Cancel");
  //             },
  //             cancelTextColor: Colors.red,
  //             confirmTextColor: Colors.white,
  //             buttonColor: Colors.green,
  //             barrierDismissible: false,
  //             radius: 20,
  //             content: Column(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(12.0),
  //                   child: Container(
  //                       child: Text(
  //                     "Paystation collects your location so that our sales represntative can easily find your shop location & provide a quick service to you.",
  //                     textAlign: TextAlign.justify,
  //                     style:
  //                         TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
  //                   )),
  //                 ),
  //                 SizedBox(height: 10),
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 12, right: 12),
  //                   child: Container(
  //                       child: Text(
  //                     "By accepting, you agree to the PayStation's Terms of Service.",
  //                     style: TextStyle(
  //                         fontSize: 12, color: AppColors.primaryColor),
  //                   )),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 12, right: 12, top: 6),
  //                   child: Container(
  //                       child: Text(
  //                     "Note: The Privacy Policy describes how data is handled in this service.",
  //                     style: TextStyle(
  //                         fontSize: 12, color: AppColors.primaryColor),
  //                   )),
  //                 ),
  //               ],
  //             ));

  //         // Get.offAllNamed(Routes.SIGNUP, arguments: mobileNumber.value);

  //       }
  //     } else {
  //       Get.back();
  //     }
  //   });
  // }
}
