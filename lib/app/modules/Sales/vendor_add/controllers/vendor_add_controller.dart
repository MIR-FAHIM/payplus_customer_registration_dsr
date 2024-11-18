import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/customerlistmodel.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/material.dart';

class VendorAddController extends GetxController {
  //TODO: Implement VendorAddController

  late GlobalKey<FormState> addvendorFormKey;

  final customer = CustomerData().obs;
  @override
  void onInit() {
    super.onInit();
    addvendorFormKey = GlobalKey<FormState>();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addVendor() async {
    if (addvendorFormKey.currentState!.validate()) {
      addvendorFormKey.currentState!.save();
      Ui.customLoaderDialog();
      BuySellRepository()
          .addVendor(
              customer.value.name!, customer.value.mobile!, customer.value.address!)
          .then((response) {
        Get.back();
        if (response['result'] == 'success') {
          Get.showSnackbar(Ui.SuccessSnackBar(
              message: response['message'].toString(), title: 'Success'.tr));
        } else {
          Get.showSnackbar(Ui.ErrorSnackBar(
              message: response['message'].toString(), title: 'Error'.tr));
        }
      });
    }
  }
}
