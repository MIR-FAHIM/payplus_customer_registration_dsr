import 'package:get/get.dart';

import '../controllers/expenses_details_by_head_controller.dart';

class ExpensesDetailsByHeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpensesDetailsByHeadController>(
      () => ExpensesDetailsByHeadController(),
    );
  }
}
