import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:latest_payplus_agent/app/Page/Transaction_successful.dart';
import 'package:latest_payplus_agent/app/models/buysell/barcode_product_model.dart';
import 'package:latest_payplus_agent/app/models/buysell/customerlistmodel.dart';
import 'package:latest_payplus_agent/app/models/buysell/product_model.dart';
import 'package:latest_payplus_agent/app/models/buysell/sell_model.dart';
import 'package:latest_payplus_agent/app/modules/Sales/sale_now/views/fastSaleWidget.dart';
import 'package:latest_payplus_agent/app/modules/Sales/sale_now/views/listSaleWidget.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class SaleNowController extends GetxController {
  //TODO: Implement SaleNowController
  final qty = 1.obs;
  final currentIndex = 0.obs;
  final addThisCutomer = false.obs;



  final cartList = <ProductData>[].obs;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final selectedCustomer = CustomerData().obs;

  final subTotalPrice = 0.0.obs;
  final discountAmount = 0.0.obs;
  final nowPaying = 0.0.obs;

  List<Widget> pages = [
    FastSaleWidget(),
    ListSaleWidget(),
  ];

  final productList = ProductModel().obs;
  final productLoaded = false.obs;

  final sellData = SellModel().obs;

  TextEditingController searchController = TextEditingController();
  final productName = "".obs;
  final productPrice = "".obs;

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
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: response.message.toString(), title: 'Error'.tr));
      }
    });
  }

  Widget get currentPage => pages[currentIndex.value];








  @override
  void dispose() {

    super.dispose();
  }

  calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartList) {
      totalPrice = totalPrice + (item.sellingPrice! * item.quantity!);
    }
    subTotalPrice.value = totalPrice;
    return totalPrice;
  }

  placeOrder() async {
    sellData.value.idCustomer = selectedCustomer.value.id;
    sellData.value.subtotal = calculateTotalPrice();
    sellData.value.discType = 'percentage';
    sellData.value.discount = sellData.value.discount ?? 0.0;
    sellData.value.discountAmount = discountAmount.value;
    sellData.value.grandTotal = calculateTotalPrice() - discountAmount.value;
    sellData.value.netPayable = calculateTotalPrice() - discountAmount.value;
    sellData.value.due =
        (calculateTotalPrice() - discountAmount.value) - nowPaying.value;
    sellData.value.paid = nowPaying.value;
    sellData.value.sellingDate = DateTime.now().toString();
    sellData.value.paidVia = 'Cash';
    sellData.value.paymentInfo = 'Cash';
    sellData.value.remark = '';

    List<SellingItems> sellingItemList = <SellingItems>[];

    for (var item in cartList) {
      SellingItems sellingItem = SellingItems();
      sellingItem.idItem = item.id;
      sellingItem.rate = item.sellingPrice!.toDouble();
      sellingItem.quantity = item.quantity!.toDouble();

      sellingItem.buyingRate = item.buyingPrice!.toDouble();
      sellingItem.discountPercent = item.discountPercent!.toDouble();
      sellingItem.rateWithDisc = item.sellingPrice! -
          (item.sellingPrice! * (item.discountPercent! / 100));
      sellingItem.total = sellingItem.rateWithDisc! * sellingItem.quantity!;

      sellingItemList.add(sellingItem);
    }
    sellData.value.sellingItems = sellingItemList;
    print('order data: ${sellData.value.toJson()}');
    print('order data: ${sellData.value.toJson()['items']}');

    Ui.customLoaderDialog();

    BuySellRepository().salePlaceOrder(sellData.value).then((response) {
      Get.back();
      Get.back();
      Get.back();
      cartList.clear();
      Get.to(TransactionSuccessful());
      print('order response: $response');
    });
  }
}
