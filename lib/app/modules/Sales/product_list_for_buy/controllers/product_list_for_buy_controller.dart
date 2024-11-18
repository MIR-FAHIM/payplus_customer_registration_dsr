import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/product_model.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/material.dart';

class ProductListForBuyController extends GetxController {
  //TODO: Implement ProductListForBuyController

  final productList = ProductModel().obs;
  final productLoaded = false.obs;

  TextEditingController searchController = TextEditingController();

  final duplicateProductItems = <ProductData>[].obs;
  final productItems = <ProductData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProductList();
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
    List<ProductData> dummySearchList = <ProductData>[];
    dummySearchList.addAll(duplicateProductItems);
    if (query.isNotEmpty) {
      List<ProductData> dummyListData = <ProductData>[];
      dummySearchList.forEach((item) {
        if (item.name!.contains(query)) {
          dummyListData.add(item);
        }
      });
      productItems.clear();
      productItems.addAll(dummyListData);
      return;
    } else {
      productItems.clear();
      productItems.addAll(duplicateProductItems);
    }
  }

  getProductList() async {
    BuySellRepository().getProducts().then((response) {
      if (response.result == 'success') {
        productList.value = response;

        duplicateProductItems.addAll(productList.value.data!);
        productItems.addAll(duplicateProductItems);
        productLoaded.value = true;
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: response.message.toString(), title: 'Error'.tr));
      }
    });
  }

  calculateBuyingPrice() {
    double totalBuyingPrice = 0.0;
    for (var item in productList.value.data!) {
      totalBuyingPrice = totalBuyingPrice + item.buyingPrice!;
    }

    return totalBuyingPrice;
  }
}
