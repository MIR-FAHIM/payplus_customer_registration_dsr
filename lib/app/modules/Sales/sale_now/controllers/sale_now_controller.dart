import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
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

  QRViewController? qcontroller;

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

  getProductByBarcode(String barcode) async {
    BuySellRepository().getProductByBarcode(barcode).then((resp) {
      if (resp.result == 'success') {
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Center(
                    child: Text(
                  'Product Details',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
                content: Obx(() {
                  return SizedBox(
                    height: Get.size.width * .45,
                    width: Get.size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CachedNetworkImage(
                              height: 60,
                              width: 60,
                              imageUrl: resp.data!.first.image ?? '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image(
                                  image: AssetImage('assets/Logo.png'),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image(
                                  image: AssetImage('assets/Logo.png'),
                                ),
                              ),
                            ),
                            Text(
                              resp.data!.first.name!,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              uniCodeTk +
                                  ' ' +
                                  resp.data!.first.sellingPrice!.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                          // color: Colors.grey.shade200,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quantity:',
                                style: TextStyle(
                                  color: Get.theme.primaryColor,
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (qty.value > 1) {
                                          qty.value--;
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove_circle_outline_outlined,
                                        size: 30,
                                        color: Get.theme.primaryColor,
                                      )),
                                  Text(
                                    '${qty.value}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        qty.value++;
                                      },
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        size: 30,
                                        color: Get.theme.primaryColor,
                                      )),
                                ],
                              ),
                            ],
                          )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            ProductData product = resp.data!.first;
                            product.quantity = qty.value;
                            cartList.removeWhere(
                                (element) => element.id == product.id);
                            cartList.add(product);
                          },
                          child: Container(
                            width: Get.size.width * .35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.theme.primaryColor,
                            ),
                            child: const Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 8),
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  );
                })
                // actions: <Widget>[

                // ],
                );
          },
        ).then((value) => qcontroller!.resumeCamera());
      } else {}
    }).catchError((onError) {
      print(onError);
      throw (onError);
    });
  }

  Widget buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, qcontroller!, p),
    );
  }

  void onQRViewCreated(QRViewController cont) {
    qcontroller = cont;
    qcontroller?.scannedDataStream.listen((scanData) {
      if (scanData.code!.isNotEmpty) {
        qcontroller!.pauseCamera();
        getProductByBarcode(scanData.code.toString());

        print('scanData: ${scanData.code}');
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    qcontroller!.resumeCamera();
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    qcontroller!.dispose();
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
