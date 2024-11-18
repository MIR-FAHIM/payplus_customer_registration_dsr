import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/models/expense_head_data.dart';
import 'package:latest_payplus_agent/app/repositories/expenses_repository.dart';
import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class AddNewExpensesController extends GetxController {
  //TODO: Implement AddNewExpensesController

  final expenseHeads = ExpenseHeadModel().obs;
  final expenseHeadLoaded = false.obs;
  final selectedexpenseHead = ''.obs;

  final expensDate = ''.obs;

  final expenseAmount = ''.obs;
  final expensesReason = ''.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // Crop code
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;

  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  final image = [].obs;

  final type = 'Personal'.obs;
  @override
  void onInit() {
    super.onInit();
    getExpenseHeads();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getExpenseHeads() async {
    ExpensesRepo().getExpenseHead().then((response) {
      if (response.result == 'success') {
        expenseHeads.value = response;
        expenseHeadLoaded.value = true;
      } else {}
    });
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime _selectedDate = DateTime.now();
    var myFormat = DateFormat('dd-MM-yyyy');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;

      expensDate.value = _selectedDate.toString().split(' ').first;
      print('date: ${expensDate.value}');
    }
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

  addNewExpenses() async {
    Ui.customLoaderDialog();
    ExpensesRepo()
        .addNewExpense(selectedexpenseHead.value, expensDate.value, '',
            expenseAmount.value, type.value, image)
        .then((response) {
      Get.back();
      if (response['result'] == 'success') {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: response['message']!, title: 'Success'.tr));
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: response['message']!, title: 'Error'.tr));
      }
    });
  }
}
