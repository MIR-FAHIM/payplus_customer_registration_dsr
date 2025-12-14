import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Auth/checkPhoneNumber/controllers/check_phone_number_controller.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:latest_payplus_agent/app/models/registration_payment_info_model.dart';
import 'package:latest_payplus_agent/app/repositories/otp_repository.dart';
import 'package:latest_payplus_agent/app/repositories/registartion_payment_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneVerificationWtihOTPController extends GetxController {
  //TODO: Implement PhoneVerificationWtihOTPController

  RxInt codeVerifyTime = 180.obs;
  final mobileNumber = ''.obs;
  final isRegistered = ''.obs;
  final isProfileUpdate = 0.obs;
  final code = ''.obs;
  final codeController = TextEditingController().obs;
  //final registrationInf = RegistrationPaymentInformationModel().obs;

  final serviceTypeID = ''.obs;
  final newCode = ''.obs;
  @override
  void onInit() {
    verifyTimeStart();

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

// Example for checking and requesting permissions
  Future<void> requestSmsPermission() async {
    final status = await Permission.sms.status;
    if (!status.isGranted) {
      await Permission.sms.request();
    }
  }

  Future<void> initSmsListener() async {
    try {
      // Request SMS permissions if not already granted

      // Fetch app signature
      final signature = await OTPInteractor().getAppSignature();
      print('signature - $signature');

      // Clear previous code
      codeController.value.clear();

      // Initialize OTPTextEditController
      final otpController = OTPTextEditController(
        codeLength: 6,
        onCodeReceive: (code) {
          print('Your Application received code - $code');
          print(
              'Your Application received code 2 - ${codeController.value.text}');
        },
      )..startListenUserConsent(
          (code) {
            final message = code ?? '';
            final isPayPlusOtp = message.contains('PayPlus:') &&
                message.contains('(OTP) for Agent');

            if (!isPayPlusOtp) {
              print('Ignored SMS (not PayPlus OTP): $message');
              // return empty string so controller will not auto fill
              return '';
            }
            final exp = RegExp(r'(\d{6})');
            codeController.value.addListener(() {
              newCode.value = exp.stringMatch(code ?? '') ?? '';
              codeController.value.text = newCode.value;
            });
            return exp.stringMatch(code ?? '') ?? '';
          },
        );

      // Start listening for user consent
      // otpController.startListenUserConsent(
      //       (code) {
      //     print('code 2: $code');
      //     final exp = RegExp(r'(\d{6})');
      //     codeController.value.addListener(() {
      //       final newCode = exp.stringMatch(code ?? '') ?? '';
      //       codeController.value.text = newCode;
      //     });
      //
      //     return exp.stringMatch(code ?? '') ?? '';
      //   },
      // strategies: [
      //   SampleStrategy(),
      // ],
      // Uncomment and add your strategies if needed
      // strategies: [SampleStrategy()],
      // );

      // Update the controller
      codeController.value = otpController;
    } catch (e) {
      print("Error is $e");
    }

    // Check if Android version is 34 or higher
  }

  sendOTP() async {
    // await requestSmsPermission();
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
          if (Get.find<CheckPhoneNumberController>()
                  .registeredWithoutPass
                  .value ==
              1) {
            Get.toNamed(Routes.ADD_PASS_REG, arguments: [
              Get.find<CheckPhoneNumberController>().acoountID.value,
              mobileNumber.value
            ]);
          } else {
            Get.offAllNamed(Routes.LOGIN, arguments: mobileNumber.value);
          }
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
      } else if (resp['result'] == 'failed') {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
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

class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 4),
      () => 'Your code is 54321',
    );
  }
}
