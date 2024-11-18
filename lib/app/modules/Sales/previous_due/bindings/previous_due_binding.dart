import 'package:get/get.dart';

import '../controllers/previous_due_controller.dart';

class PreviousDueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviousDueController>(
      () => PreviousDueController(),
    );
  }
}
