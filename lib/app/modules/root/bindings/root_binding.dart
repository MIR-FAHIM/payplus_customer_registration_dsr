import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:latest_payplus_agent/app/modules/offer/controllers/offer_controller.dart';
import 'package:latest_payplus_agent/app/modules/package/controller/package_list_controller.dart';
import 'package:latest_payplus_agent/app/modules/qr/controllers/qr_controller.dart';
import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<RootController>(
      () => RootController(),
    );


    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<QRController>(
          () => QRController(),
    );
    Get.lazyPut<OfferController>(
      () => OfferController(),
    );

    Get.lazyPut<InboxController>(
      () => InboxController(),
    );
  }
}
