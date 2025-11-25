import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/app/repositories/auth_repositories.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController
  final oldPin = ''.obs;
  final newPin = ''.obs;
  late GlobalKey<FormState> pinFormKey;
  final hideOldPin = true.obs;
  final hideNewPIN = true.obs;
  final hideConfirmPIN = true.obs;
  final result = false.obs;

  @override
  Future<void> onInit() async {
    pinFormKey = GlobalKey<FormState>();
    print(await FirebaseMessaging.instance.getToken());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  changePin() async {
    Ui.customLoaderDialog();
    AuthRepository().pinChange(oldPin.value, newPin.value).then((resp) {
      Get.back();
      if (resp['Request_Status'] == 'Success') {
        Get.showSnackbar(Ui.SuccessSnackBar(
            message: 'PIN has been updated'.tr, title: 'Success'.tr));
        Get.find<AuthService>().logOutApi(false);
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: 'Something Went Wrong', title: 'error'.tr));
        print("not done");
      }
    });
  }
}
