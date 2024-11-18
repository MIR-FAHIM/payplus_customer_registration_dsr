import 'package:get/get.dart';

import '../controllers/vendor_add_controller.dart';

class VendorAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorAddController>(
      () => VendorAddController(),
    );
  }
}
