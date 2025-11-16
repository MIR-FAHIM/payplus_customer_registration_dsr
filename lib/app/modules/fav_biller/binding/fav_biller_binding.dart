import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/fav_biller/controller/fav_biller_controller.dart';



class FavBillerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavBillerController>(
          () => FavBillerController(),
    );
  }
}
