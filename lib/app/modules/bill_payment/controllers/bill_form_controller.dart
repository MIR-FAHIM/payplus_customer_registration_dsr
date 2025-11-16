import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/electricity/bpdb_fetch_model.dart';
import 'package:latest_payplus_agent/app/models/electricity/favourite_bill_list_model.dart';
import 'package:latest_payplus_agent/app/repositories/bill_payment_repository.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/app/services/settings_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:http/http.dart' as http;
class BillFormController extends GetxController {
  //TODO: Implement BillPaymentController
 final fetchBpdbModel  = FetchBpdbModel().obs;
  final isChecked = false.obs;
  final refName = ''.obs;
  final bill_id = ''.obs;
  final selectedMonth = DateTime(DateTime.now().year, DateTime.now().month-1, DateTime.now().day).month.obs;
  final selectedYear = DateTime(DateTime.now().year, DateTime.now().month-1, DateTime.now().day).year.obs;
  final meterNo = ''.obs;
  final amount = ''.obs;
  final accountID = ''.obs;
  final monthsList = [].obs;
  final billAccountController = TextEditingController().obs;
  final mobileController = TextEditingController().obs;
  final years = [].obs;
  final mobile = ''.obs;
  final initialDate = DateTime.now().obs;
  final selectedDate = DateTime.now().obs;
  var myFormat = DateFormat('yyyy-MM');
  var myFormat1 = DateFormat('MMMM, y');
  final favBillerLoaded = false.obs;
  final favBillList = FavouriteListModel().obs;
  var lstTask = List<dynamic>.empty(growable: true).obs;
  // final refName = ''.obs;

  @override
  void onInit() {
    getFavouriteBiller();
    getLastTwelveMonthsMap();
    //  getLastTwelveMonths();
    print("my all years are ${years.value}");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void refreshList() async {
    DeleteBiller();
  }

  getFavouriteBiller() async {
    favBillerLoaded.value = false;
    BillPaymentRepository().getFavBill().then((resp) {
      favBillList.value = resp;
      favBillerLoaded.value = true;
    });
  }

  String getMonthName(int month) {
    // Convert the month number to its name
    DateTime date =
        DateTime(2021, month, 1); // Using a fixed year for getting month name
    return DateFormat('MMMM').format(date);
  }

  getLastTwelveMonthsMap() {
    // Get the current month and year
    DateTime currentDate = DateTime.now();
    int currentMonth = currentDate.month;
    int currentYear = currentDate.year;

    // Create a loop to get the last twelve months
    for (int i = 0; i < 12; i++) {
      int month = currentMonth - i;
      int year = currentYear;

      if (month <= 0) {
        month += 12;
        year--;
      }

      monthsList.add({'year': year, 'month': month});
    }
  }

  Future selectMonthYear(BuildContext context) async {
    final picked = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2060),
      locale: Locale('en', 'US'),
    );
    return picked;
  }

  void openBottomSheetBill() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select Month:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: monthsList
                        .map((month) => Card(
                              child: ListTile(
                                tileColor: AppColors.primaryLightColor,
                                onTap: () {
                                  selectedYear.value = month['year'];
                                  selectedMonth.value =
                                      month['month'];
                                  print("selected year and month ${selectedYear.value} and ${selectedMonth.value}");
                                  Get.back();
                                },
                                title: Text(
                                    '${getMonthName(month['month']!)}, ${month['year']}'),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // get last 12 months
  getLastTwelveMonths() {
    // Get the current month and year
    DateTime currentDate = DateTime.now();
    int currentMonth = currentDate.month;
    int currentYear = currentDate.year;

    // Create a loop to get the last twelve months
    for (int i = 0; i < 12; i++) {
      DateTime date = DateTime(currentYear, currentMonth - i, 1);
      String formattedMonth = DateFormat('MMMM y').format(date);
      monthsList.add(formattedMonth);
    }
  }
  Future selectDate() async {
    selectedDate.value = DateTime.now();
    final DateTime? picked = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: Get.context!,
      initialDate: selectedDate.value, // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2080),
    );
    if (picked != null && picked != selectedDate) selectedDate.value = picked;

    print(DateFormat('dd-MM-yyyy').format(selectedDate.value));
  }

  DeleteBiller() async {
    BillPaymentRepository().deleteFavBillerTemp(bill_id.value).then((resp) {
      print(resp['result']);
      if (resp['result'] == 'success') {
        // favBillList.clear();
        getFavouriteBiller();
      } else {}
    });
  }
}
