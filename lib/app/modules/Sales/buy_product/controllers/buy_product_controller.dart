import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/buy_product/views/fastBuyWidget.dart';
import 'package:latest_payplus_agent/app/modules/Sales/buy_product/views/listBuyWidget.dart';

import 'package:latest_payplus_agent/app/Page/Transaction_successful.dart';
import 'package:latest_payplus_agent/app/models/buysell/buy_model.dart';
import 'package:latest_payplus_agent/app/models/buysell/product_model.dart';
import 'package:latest_payplus_agent/app/models/buysell/vendorlistmodel.dart';

import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/material.dart';

class BuyProductController extends GetxController {
  //TODO: Implement BuyProductController

  final qty = 1.obs;
  final currentIndex = 0.obs;


  final cartList = <ProductData>[].obs;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final selectedVendor = VendorData().obs;

  final subTotalPrice = 0.0.obs;
  final discountAmount = 0.0.obs;
  final nowPaying = 0.0.obs;

  List<Widget> pages = [
    FastBuyWidget(),
    ListBuyWidget(),
  ];

  final productList = ProductModel().obs;
  final productLoaded = false.obs;

  final buyData = BuyModel().obs;
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
    buyData.value.idVendor = selectedVendor.value.id;
    buyData.value.invoiceNo = '';
    buyData.value.subtotal = calculateTotalPrice();
    buyData.value.discType = 'percentage';
    buyData.value.discount = buyData.value.discount ?? 0.0;
    buyData.value.discountAmount = discountAmount.value;
    buyData.value.grandTotal = calculateTotalPrice() - discountAmount.value;
    buyData.value.netPayable = calculateTotalPrice() - discountAmount.value;
    buyData.value.due =
        (calculateTotalPrice() - discountAmount.value) - nowPaying.value;
    buyData.value.paid = nowPaying.value;
    buyData.value.purchaseDate = DateTime.now().toString();
    buyData.value.paidVia = 'Cash';
    buyData.value.paymentInfo = 'Cash';
    buyData.value.remark = '';

    List<BuyingItems> buyingItems = <BuyingItems>[];

    for (var item in cartList) {
      BuyingItems buyingItem = BuyingItems();
      buyingItem.idItem = item.id;
      buyingItem.rateWithoutDisc = item.buyingPrice!.toDouble();
      buyingItem.discountPercent = item.discountPercent!.toDouble();
      buyingItem.quantity = item.quantity!;
      buyingItem.rate = item.buyingPrice! -
          (item.buyingPrice! * (item.discountPercent! / 100));

      buyingItem.total = buyingItem.rate! * buyingItem.quantity!;

      buyingItem.totalWithoutDisc =
          buyingItem.rateWithoutDisc! * buyingItem.quantity!;

      buyingItems.add(buyingItem);
    }
    buyData.value.buyingitems = buyingItems;
    print('order data: ${buyData.value.toJson()}');
    print('order data: ${buyData.value.toJson()['items']}');

    Ui.customLoaderDialog();

    BuySellRepository().buyPlaceOrder(buyData.value).then((response) {
      Get.back();
      Get.back();
      Get.back();
      cartList.clear();
      Get.to(TransactionSuccessful());
      print('buy order response: $response');
    });
  }
}
