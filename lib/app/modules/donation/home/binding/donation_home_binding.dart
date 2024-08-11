import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/donation/home/controller/donation_home_controller.dart';



class DonationHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationHomeController>(
          () => DonationHomeController(),
    );
  }
}
