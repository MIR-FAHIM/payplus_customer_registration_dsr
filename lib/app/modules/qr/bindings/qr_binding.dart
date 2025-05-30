import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/qr/controllers/qr_controller.dart';




class QRBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRController>(
          () => QRController(),
    );
  }
}
