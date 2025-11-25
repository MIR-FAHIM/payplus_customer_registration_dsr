import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:latest_payplus_agent/app/repositories/otp_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ForgetPassWtihOTPController extends GetxController {
  //TODO: Implement ForgetPassWtihOTPController

  late GlobalKey<FormState> pinOtpFormKey;
  RxInt codeVerifyTime = 120.obs;
  final mobileNumber = ''.obs;
  final imeiNumber = ''.obs;
  final isRegistered = ''.obs;
  final code = ''.obs;
  late TextEditingController codeController;
  var startDate = ''.obs;
  var nidNumber = ''.obs;
  var myFormat = DateFormat('yyyy-MM-dd');
  String _comingSms = 'Unknown';

  @override
  void onInit() {
    verifyTimeStart();
    pinOtpFormKey = GlobalKey<FormState>();
    mobileNumber.value = Get.arguments['mobileNumber'];
    imeiNumber.value = Get.arguments['imeiNumber'];
    // isRegistered.value = Get.arguments['isRegistered'];
    codeController = TextEditingController();
    sendOTP();
    print(imeiNumber.value);
    print(mobileNumber.value);
    initSmsListener();

    super.onInit();
  }

  DateTime _selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        locale: Locale('en', 'US'),
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
    }
    startDate.value = "${myFormat.format(_selectedDate)}";
  }

  test() {
    print(startDate.value);
    print(mobileNumber.value);
    print(codeController.text);
    print(nidNumber.value);
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

    codeController = OTPTextEditController(
      codeLength: 6,

      onCodeReceive: (code) {
        print('Your Application receive code - $code');
        print('Your Application receive code 2 - ${codeController.text}');
      },
    )..startListenUserConsent(
          (code) {
        final message = code ?? '';

        // 1) Filter so we only accept PayPlus agent OTP messages
        final isPayPlusOtp = message.contains('PayPlus:') &&
            message.contains('(OTP) for Agent');

        if (!isPayPlusOtp) {
          print('Ignored SMS (not PayPlus OTP): $message');
          // return empty string so controller will not auto fill
          return '';
        }
        final exp = RegExp(r'(\d{6})');
        return exp.stringMatch(code ?? '') ?? '';
      },
      // strategies: [
      //   SampleStrategy(),
      // ],
    );

    print(codeController.text);
  }

  // Future<void> initSmsListener() async {
  //   // Optional: get app signature (useful if you later add it into the SMS text)
  //   final appSignature = await OTPInteractor().getAppSignature();
  //   print('App signature: $appSignature');
  //
  //   codeController = OTPTextEditController(
  //     codeLength: 6,
  //     onCodeReceive: (code) {
  //       print('Your Application receive code - $code');
  //       print('Your Application receive code 2 - ${codeController.text}');
  //     },
  //   )..startListenUserConsent(
  //         (sms) {
  //       final message = sms ?? '';
  //
  //       // 1) Filter so we only accept PayPlus agent OTP messages
  //       final isPayPlusOtp = message.contains('PayPlus:') &&
  //           message.contains('OTP for Agent');
  //
  //       if (!isPayPlusOtp) {
  //         print('Ignored SMS (not PayPlus OTP): $message');
  //         // return empty string so controller will not auto fill
  //
  //       }
  //
  //       // 2) Only now extract the 6 digit OTP
  //       final exp = RegExp(r'(\d{6})');
  //       final otp = exp.stringMatch(message) ?? '';
  //
  //       print('PayPlus OTP SMS: $message');
  //       print('Extracted OTP: $otp');
  //
  //       print(codeController.text);
  //       return exp.stringMatch(sms ?? '') ?? '';
  //     },
  //     // strategies: [
  //     //   SampleStrategy(),
  //     // ],
  //   );
  //
  //   print('Initial controller text: ${codeController.text}');
  // }

  sendOTP() async {
    OTPRepository().otpSend(mobileNumber.value).then((resp) {
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
        .verifyOTP(mobileNumber.value, codeController.text)
        .then((resp) {
      if (resp['result'] == 'success') {
        Get.back();
        if (isRegistered.value == '1') {
          Get.offAllNamed(Routes.LOGIN, arguments: mobileNumber.value);
        } else {
          Get.offAllNamed(Routes.SIGNUP, arguments: mobileNumber.value);
        }
      } else {
        Get.back();
      }
    });
  }

  VerifyOTPWithNID() async {
    Ui.customLoaderDialog();
    OTPRepository()
        .verifyOTPWithNID(mobileNumber.value, codeController.text,
            nidNumber.value, startDate.value)
        .then((resp) {
      if (resp['result'] == 'success') {
        Get.back();
        var data = {
          "mobileNumber": mobileNumber.value,
          "imeiNumber": Get.find<LocationService>().imei.value,
        };
        Get.offNamed(Routes.Forget_password, arguments: data);
        print(resp['message']);
      } else {
        Get.back();
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Failed'.tr));
      }
    });
  }
}
