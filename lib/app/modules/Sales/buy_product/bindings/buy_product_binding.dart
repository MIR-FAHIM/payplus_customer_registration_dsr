import 'package:get/get.dart';

import '../controllers/buy_product_controller.dart';

class BuyProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyProductController>(
      () => BuyProductController(),
    );
  }
}
