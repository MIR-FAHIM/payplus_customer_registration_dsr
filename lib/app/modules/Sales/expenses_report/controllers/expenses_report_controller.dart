import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/models/expenses_history_model.dart';
import 'package:latest_payplus_agent/app/repositories/expenses_repository.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ExpensesReportController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement ExpensesReportController
  late TabController? tabController;
  final currentTabIndex = 0.obs;
  final selectedStartDate = ''.obs;
  final selectedEndDate = ''.obs;
  final expensesHistory = ExpensesHistoryModel().obs;
  final expensesHistoryLoaded = false.obs;
  final color = <Color>[
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.green,
  ].obs;
  final pieChartColors = <Color>[].obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    DateTime _selectedDate = DateTime.now();
    var date = DateTime(_selectedDate.year, _selectedDate.month, 1).toString();
    selectedStartDate.value = date.split(' ').first;
    selectedEndDate.value = _selectedDate.toString().split(' ').first;
    getExpensesHistory();
    tabController?.addListener(() {
      getExpensesHistory();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onTabChange() {
    currentTabIndex.value = tabController!.index;
    print(currentTabIndex);
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
      getExpensesHistory(isFirstTimeCall: false);
    }
  }

  getExpensesHistory({bool isFirstTimeCall = true}) async {
    if (isFirstTimeCall == false) {
      Ui.customLoaderDialog();
    } else {
      expensesHistoryLoaded.value = false;
    }

    ExpensesRepo()
        .getExpensesHistory(tabController!.index == 0 ? 'Personal' : 'Business',
            selectedStartDate.value, selectedEndDate.value)
        .then((response) {
      if (isFirstTimeCall == false) {
        Get.back();
      }

      if (response.result == 'success') {
        expensesHistory.value = response;

        expensesHistory.value.expensesdata!.sort((b, a) => a.total!.compareTo(b.total!));

        expensesHistoryLoaded.value = true;
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
}
