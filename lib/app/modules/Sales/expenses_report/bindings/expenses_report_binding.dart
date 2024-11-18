import 'package:get/get.dart';

import '../controllers/expenses_report_controller.dart';

class ExpensesReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpensesReportController>(
      () => ExpensesReportController(),
    );
  }
}
