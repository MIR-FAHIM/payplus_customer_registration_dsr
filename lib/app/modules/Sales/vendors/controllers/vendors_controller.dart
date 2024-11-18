import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/vendorlistmodel.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:flutter/material.dart';

class VendorsController extends GetxController {
  //TODO: Implement VendorsController

  final vendorList = VendorListModel().obs;
  final vendorListLoaded = false.obs;
  final isFromSaleNow = false.obs;

  TextEditingController searchController = TextEditingController();

  final duplicateVendorList = <VendorData>[].obs;
  final vendorNewList = <VendorData>[].obs;
  @override
  void onInit() {
    super.onInit();
    isFromSaleNow.value = Get.arguments ?? false;
    getVendorList();
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
    List<VendorData> dummySearchList = <VendorData>[];
    dummySearchList.addAll(duplicateVendorList);
    if (query.isNotEmpty) {
      List<VendorData> dummyListData = <VendorData>[];
      dummySearchList.forEach((item) {
        if (item.name!.contains(query)) {
          dummyListData.add(item);
        }
      });
      vendorNewList.clear();
      vendorNewList.addAll(dummyListData);
      return;
    } else {
      vendorNewList.clear();
      vendorNewList.addAll(duplicateVendorList);
    }
  }

  getVendorList() async {
    BuySellRepository().getVendor().then((response) {
      vendorList.value = response;
      duplicateVendorList.addAll(vendorList.value.data!);
      vendorNewList.addAll(duplicateVendorList);
      vendorListLoaded.value = true;
    });
  }
}
