import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/app/models/customerlistmodel.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';

class CustomersController extends GetxController {
  //TODO: Implement CustomersController

  final customerList = CustomerListModel().obs;
  final customerListLoaded = false.obs;
  final isFromSaleNow = false.obs;

  TextEditingController searchController = TextEditingController();

  final duplicateCustomerList = <CustomerData>[].obs;
  final customerNewList = <CustomerData>[].obs;

  @override
  void onInit() {
    super.onInit();
    isFromSaleNow.value = Get.arguments ?? false;
    getCustomerList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void filterSearchResults(String query) {
    List<CustomerData> dummySearchList = <CustomerData>[];
    dummySearchList.addAll(duplicateCustomerList);
    if (query.isNotEmpty) {
      List<CustomerData> dummyListData = <CustomerData>[];
      dummySearchList.forEach((item) {
        if (item.name!.contains(query)) {
          dummyListData.add(item);
        }
      });
      customerNewList.clear();
      customerNewList.addAll(dummyListData);
      return;
    } else {
      customerNewList.clear();
      customerNewList.addAll(duplicateCustomerList);
    }
  }

  getCustomerList() async {
    BuySellRepository().getCustomer().then((response) {
      customerList.value = response;

      duplicateCustomerList.addAll(customerList.value.data!);
      customerNewList.addAll(duplicateCustomerList);

      customerListLoaded.value = true;
    });
  }
}
