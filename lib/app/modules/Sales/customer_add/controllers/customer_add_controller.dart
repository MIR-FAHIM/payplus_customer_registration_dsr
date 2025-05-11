import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/buysell/customerlistmodel.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/material.dart';

class CustomerAddController extends GetxController {
  //TODO: Implement CustomerAddController
  late GlobalKey<FormState> addcustomerFormKey;

  final customer = CustomerData().obs;
  @override
  void onInit() {
    super.onInit();
    addcustomerFormKey = GlobalKey<FormState>();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  clearData() {
    customer.value = CustomerData();
  }

  addCustomer() async {
    if (addcustomerFormKey.currentState!.validate()) {
      addcustomerFormKey.currentState!.save();
      Ui.customLoaderDialog();
      BuySellRepository()
          .addCustomer(customer.value.name!, customer.value.mobile!,
              customer.value.address!)
          .then((response) {
        Get.back();
        if (response['result'] == 'success') {
          clearData();
          Get.back();
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
