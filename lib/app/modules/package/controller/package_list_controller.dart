import 'dart:math';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/add_balance_model/mfs_list_model.dart';
import 'package:latest_payplus_agent/app/models/buysell/product_model.dart';
import 'package:latest_payplus_agent/app/models/user_model.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/material.dart';

import '../../../models/package model/my_current_package_model.dart';
import '../../../models/package model/package_list_model.dart';
import '../../../repositories/mfsPayment_type_repositoy.dart';

class PackageController extends GetxController {
  //TODO: Implement ProductListForBuyController
  final userData = UserModel().obs;
  final packageListModel = PackageListModel().obs;
  final currentPackageModel = CurrentPackageModel().obs;
  final productLoaded = false.obs;
  final packageByLoaded = false.obs;
  final pinNumber = "".obs;
  final packagePurchaseId = "".obs;
  final mainBalance = "".obs;
  final paymentTypesMFS = <MFSListModel>[].obs;
  TextEditingController pinController = TextEditingController();
  final random = Random();

  final duplicateProductItems = <ProductData>[].obs;
  final packageItems = <DatumPackage>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPackageList();
    currentPackage();
    getPaymentType();
    mainBalance.value = Get.find<HomeController>().balance.toString();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



  getPackageList() async {
    BuySellRepository().getPackages().then((response) {
      if (response.result == 'success') {
        packageListModel.value = response;
        packageItems.value = response.data!;

        productLoaded.value = true;
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: "Something wrong", title: 'Error'.tr));
      }
    });
  }
  currentPackage() async {
    BuySellRepository().currentPackage().then((response) {
      if (response.result == 'success') {
        currentPackageModel.value = response;
      //  packageItems.value = response.data!;
        productLoaded.value = true;
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: "Something wrong", title: 'Error'.tr));
      }
    });
  }
  getPaymentType() async {
    mfsPaymentTypeRepository().getBusinessType().then((resp) {
      paymentTypesMFS.value = resp;
      print("hlw pay plus 1 ________________${paymentTypesMFS.value.length}");
      print("hlw pay plus 1 ________________${paymentTypesMFS.value[0].charge}");
      // userData.value.businessType = businessTypes[0].id!.toString();


      return resp;
    });

  }
  buyPackage(id, gateway) async {
    BuySellRepository().buyPackage(id, pinController.value.text, packagePurchaseId.value, gateway).then((response) {
      packageByLoaded.value = true;
      Get.back();

      if (response['result'] == 'success') {


        Get.showSnackbar(
            Ui.SuccessSnackBar(message: response['message'], title: 'Success'.tr));
        packageByLoaded.value = false;
        if(response['url'] != null ){
          packageByLoaded.value = false;
          var data = {
            "paymentURL": response['url'],
            "title": "Package",
          };
          Get.toNamed(Routes.WEBVIEW, arguments: data);
        } else {
          packageByLoaded.value = false;
          getPackageList();
          currentPackage();
          Get.find<HomeController>().getBalance();
          Get.toNamed(Routes.PACKAGELIST);
        }

        //getBalance
        packageByLoaded.value = false;
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message:  response['message'], title: 'Error'.tr));
        packageByLoaded.value = false;
      }
    });
  }


}
