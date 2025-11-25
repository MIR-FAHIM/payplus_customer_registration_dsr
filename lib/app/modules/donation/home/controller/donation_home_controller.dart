import 'dart:io';


import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:latest_payplus_agent/app/models/buysell/add_product_model.dart';
import 'package:latest_payplus_agent/app/models/categoriesmodel.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/material.dart';

class DonationHomeController extends GetxController {
  //TODO: Implement AddProductController

  final categoriesList = CategoriesModel().obs;
  final categoriesLaoded = false.obs;
  final subCategoriesList = SubCategoriesModel().obs;
  final categoryId = ''.obs;
  final subCategoryId = ''.obs;

  final addproductData = AddProductModel().obs;
  final productImage = [].obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // Crop code
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;

  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  final image = [].obs;
  @override
  void onInit() {
    super.onInit();

    getDonationProjectList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addAProduct() async {
    BuySellRepository().addProduct(addproductData.value, image).then((response) {
      if (response['result'] == 'success') {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: response['message'], title: 'Success'.tr));
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: response['message'], title: 'Error'));
      }
    });
  }

  getCategoriesList() async {
    BuySellRepository().getCategories().then((response) {
      if (response.result == 'success') {
        categoriesList.value = response;
        categoriesLaoded.value = true;
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: response.message.toString(), title: 'Error'));
      }
    }).catchError((onError) {
      throw (onError);
    });
  }

  getDonationProjectList() async {
    print("get donation calle");
    Ui.customLoaderDialog();
    BuySellRepository().getDonationProjectList().then((response) {
      Get.back();
     print("my donation project list is $response");
    }).catchError((onError) {
      throw (onError);
    });
  }


}
