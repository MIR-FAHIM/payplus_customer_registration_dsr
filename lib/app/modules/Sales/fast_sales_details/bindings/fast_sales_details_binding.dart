import 'package:get/get.dart';

import '../controllers/fast_sales_details_controller.dart';

class FastSalesDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FastSalesDetailsController>(
      () => FastSalesDetailsController(),
    );
  }
}
