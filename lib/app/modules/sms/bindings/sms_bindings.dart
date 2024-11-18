import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/settings/controllers/language_controller.dart';
import 'package:latest_payplus_agent/app/modules/sms/controller/sms_controller.dart';

class SMSBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SMSController>(
      () => SMSController(),
    );
  }
}
