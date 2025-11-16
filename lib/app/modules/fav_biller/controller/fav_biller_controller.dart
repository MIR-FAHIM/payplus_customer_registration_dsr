import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/models/daily_report_model.dart';
import 'package:latest_payplus_agent/app/models/electricity/favourite_bill_list_model.dart';
import 'package:latest_payplus_agent/app/repositories/bill_payment_repository.dart';
import 'package:latest_payplus_agent/app/repositories/daily_report.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class FavBillerController extends GetxController {
  final favBillerLoaded = false.obs;
  final meterNo = ''.obs;
  final bill_id = ''.obs;
  final favBillList = FavouriteListModel().obs;




  @override
  Future<void> onInit() async {

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
  getFavouriteBiller() async {
    favBillerLoaded.value = false;
    BillPaymentRepository().getFavBill().then((resp) {
      favBillList.value = resp;
      favBillerLoaded.value = true;
    });
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
