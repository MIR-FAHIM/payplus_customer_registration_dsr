import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/models/buysell/expenses_details_by_head_model.dart';
import 'package:latest_payplus_agent/app/repositories/expenses_repository.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/material.dart';

class ExpensesDetailsByHeadController extends GetxController {
  //TODO: Implement ExpensesDetailsByHeadController
  final selectedStartDate = ''.obs;
  final selectedEndDate = ''.obs;
  final expenseHeadId = ''.obs;
  final expenseHeadTitle = ''.obs;
  final type = ''.obs;
  final expensesDetails = ExpensesDetailsByHeadModel().obs;
  final expensesDetailsLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    DateTime _selectedDate = DateTime.now();
    var date = DateTime(_selectedDate.year, _selectedDate.month, 1).toString();
    selectedStartDate.value = date.split(' ').first;
    selectedEndDate.value = _selectedDate.toString().split(' ').first;
    type.value = Get.arguments[0];
    expenseHeadId.value = Get.arguments[1].toString();
    expenseHeadTitle.value = Get.arguments[2];
    getExpensesDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> selectDate(BuildContext context, String type) async {
    DateTime _selectedDate = DateTime.now();
    var myFormat = DateFormat('dd-MM-yyyy');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      if (type == 'start') {
        selectedStartDate.value = _selectedDate.toString().split(' ').first;
        print('date: ${selectedStartDate.value}');
      } else {
        selectedEndDate.value = _selectedDate.toString().split(' ').first;
        print('date: ${selectedEndDate.value}');
      }
      getExpensesDetails(isFirstTimeCall: false);
    }
  }

  getExpensesDetails({bool isFirstTimeCall = true}) async {
    if (isFirstTimeCall == false) {
      Ui.customLoaderDialog();
    }

    ExpensesRepo()
        .getExpensesDetailsByHead(expenseHeadId.value, type.value,
            selectedStartDate.value, selectedEndDate.value)
        .then((response) {
      if (isFirstTimeCall == false) {
        Get.back();
      }

      if (response.result == 'success') {
        expensesDetails.value = response;
        expensesDetailsLoaded.value = true;
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: response.message!, title: 'Error'.tr));
      }
    }).catchError((onError) {
      if (isFirstTimeCall == false) {
        Get.back();
      }
      throw (onError);
    });
  }

  deleteExpense(String id) async {
    Ui.customLoaderDialog();
    ExpensesRepo().deleteExpensesItemByHead(id).then((response) {
      Get.back();
      if (response['result'] == 'success') {
        getExpensesDetails(isFirstTimeCall: false);
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: response['message'], title: 'Error'.tr));
      }
    });
  }
}
