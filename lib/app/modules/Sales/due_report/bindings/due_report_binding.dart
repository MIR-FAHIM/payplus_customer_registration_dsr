import 'package:get/get.dart';

import '../controllers/due_report_controller.dart';

class DueReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DueReportController>(
      () => DueReportController(),
    );
  }
}
