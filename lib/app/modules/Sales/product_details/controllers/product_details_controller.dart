import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/data_model_product.dart';
import 'package:latest_payplus_agent/app/models/product_model.dart';

class ProductDetailsController extends GetxController {
  //TODO: Implement ProductDetailsController

  final productDetails = ProductData().obs;

  RxList<ProductDetailModel> productDetailList = <ProductDetailModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    productDetails.value = Get.arguments;

    productDetailList.value = [
      ProductDetailModel(
          title: 'স্টক মূল্য',
          value:
              '৳ ${(productDetails.value.sellingPrice! * productDetails.value.quantity!)}',
          press: () {

          }),
      ProductDetailModel(
          title: 'ক্রয় মূল্য',
          value: '৳ ${productDetails.value.buyingPrice}',
          press: () {}),
      ProductDetailModel(
          title: 'বিক্রয় মূল্য',
          value: '৳ ${productDetails.value.sellingPrice}',
          press: () {}),
      ProductDetailModel(
          title: 'স্টক সংখ্যা', value: '${productDetails.value.quantity}', press: () {}),
      ProductDetailModel(
          title: 'ডিসকাউন্ট',
          value: '${productDetails.value.discountPercent ?? 0.0} %',
          press: () {}),
      ProductDetailModel(
          title: 'ভ্যাট',
          value: '${productDetails.value.vatPercent ?? 0.0}%',
          press: () {}),
      ProductDetailModel(
          title: 'পণ্যের পরিমাণ',
          value: '${productDetails.value.size} ${productDetails.value.unit}',
          press: () {}),
    ];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
