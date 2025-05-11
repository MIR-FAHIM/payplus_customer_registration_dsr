import 'package:get/get.dart';

import '../controllers/sale_now_controller.dart';

class SaleNowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaleNowController>(
      () => SaleNowController(),
    );
  }
}
