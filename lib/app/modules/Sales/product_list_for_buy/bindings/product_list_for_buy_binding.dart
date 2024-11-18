import 'package:get/get.dart';

import '../controllers/product_list_for_buy_controller.dart';

class ProductListForBuyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListForBuyController>(
      () => ProductListForBuyController(),
    );
  }
}
