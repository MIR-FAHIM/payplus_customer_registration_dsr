import 'dart:async';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/models/notification/popup_image_notification.dart';
import 'package:latest_payplus_agent/app/modules/root/controllers/root_controller.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/main.dart';
import 'package:latest_payplus_agent/service/shared_pref.dart';
import '../../Auth/signup/controllers/signup_controller.dart';
import '../../package/controller/package_list_controller.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController

  final count = 0.obs;
  final imageUrlPop = "".obs;
  final imageNotificationPopList = <NotiDatum>[].obs;
  @override
  Future<void> onInit() async {
    if(SharedPreff.to.prefss.getString("popDate") == null){
      print("find null in pop up notification time sharedpref");
      SharedPreff.to.prefss.setString("popDate", DateTime.now().toString());
    }

    Get.lazyPut<SignupController>(
          () => SignupController(),
    );
    Get.lazyPut<PackageController>(
          () => PackageController(),
    );
   // getPackageName();
    getImageNotification();
    Timer(const Duration(seconds: 3), () {

      //Get.find<PackageController>().currentPackageModel.value.data!.packageName;
      if (Get.find<AuthService>().used.value) {
        if (Get.find<AuthService>().isAuth) {
          print('SplashscreenController.onInit:$type');
          Get.offAllNamed(Routes.ROOT, arguments: type);
        } else {
        //  Get.offAllNamed(Routes.WELCOME);
     Get.offAllNamed(Routes.CHECK_PHONE_NUMBER);
        }
      } else {
        Get.offAllNamed(Routes.WELCOME);
      }
    });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
  getImageNotification() async {
    print("Hlw image notification 111111  ++++++++++");
    BuySellRepository().getPopUpImageNotification().then((response) {
      if (response.result == true) {
        print("Hlw image notification  222222++++++++++");
        imageNotificationPopList.value = response.data!;
        imageUrlPop.value = imageNotificationPopList.value[0].image!;
        SharedPreff.to.prefss.setString("popImage", imageUrlPop.value);
        print("Hlw image notification  33333333++++++++++ ${SharedPreff.to.prefss.getString("popImage")}");
        //  packageItems.value = response.data!;
      } else {
        print("error in pop up image notification+++++++++++");

      }
    });
  }
  getPackageName(){


      return Get.find<PackageController>().currentPackageModel.value.data!.packageName;




  }
}
