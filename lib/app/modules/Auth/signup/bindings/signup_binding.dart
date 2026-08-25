import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/views/merchant/agent_register/controller/agent_register_controller.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/views/merchant/controller/merchant_register_controller.dart';


import '../controllers/signup_controller.dart';


class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      () => SignupController(),
    );

    Get.lazyPut<MerchantRegisterController>(
      () => MerchantRegisterController(),
    );
    Get.lazyPut<AgentRegisterController>(
      () => AgentRegisterController(),
    );
  }
}
