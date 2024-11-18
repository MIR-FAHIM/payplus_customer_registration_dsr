import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latest_payplus_agent/app/models/add_product_model.dart';
import 'package:latest_payplus_agent/app/models/categoriesmodel.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/material.dart';

class AddProductController extends GetxController {
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
    getCategoriesList();
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

  getSubCategoriesList() async {
    Ui.customLoaderDialog();
    BuySellRepository().getSubCategories(categoryId.value).then((response) {
      Get.back();
      if (response.result == 'success') {
        subCategoriesList.value = response;
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please try again', title: 'Error'));
      }
    }).catchError((onError) {
      throw (onError);
    });
  }

  void getImage(ImageSource imageSource) async {
    selectedImagePath = ''.obs;
    selectedImageSize = ''.obs;

    // Crop code
    cropImagePath = ''.obs;
    cropImageSize = ''.obs;

    // Compress code
    compressImagePath = ''.obs;
    compressImageSize = ''.obs;

    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";

      // Crop
      final cropImageFile = await ImageCropper().cropImage(
          sourcePath: selectedImagePath.value,
          maxWidth: 512,
          maxHeight: 512,
          compressFormat: ImageCompressFormat.jpg);
      cropImagePath.value = cropImageFile!.path;
      cropImageSize.value =
          ((File(cropImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2) +
              " Mb";

      // Compress
      print('compress path: ${cropImagePath.value}');
      final dir = Directory.systemTemp;
      final targetPath = dir.absolute.path + '/' + cropImagePath.value.split('/').last;
      var compressedFile = await FlutterImageCompress.compressAndGetFile(
          cropImagePath.value, targetPath,
          quality: 100, keepExif: false, autoCorrectionAngle: true, rotate: 0);
      compressImagePath.value = compressedFile!.path;
      compressImageSize.value =
          ((File(compressImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
      image.clear();
      image.add(File(compressedFile.path));

      // uploadImage(compressedFile);
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
