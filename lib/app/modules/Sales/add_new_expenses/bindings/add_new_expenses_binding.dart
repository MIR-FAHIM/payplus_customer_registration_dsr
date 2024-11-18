import 'package:get/get.dart';

import '../controllers/add_new_expenses_controller.dart';

class AddNewExpensesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewExpensesController>(
      () => AddNewExpensesController(),
    );
  }
}
