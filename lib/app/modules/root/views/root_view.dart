import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/main_drawer_widget.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../../../services/auth_service.dart';
import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {

    return Obx(() {

      return Scaffold(
        body: controller.currentPage,
        endDrawer: MainDrawerWidget(),
        bottomNavigationBar: BottomAppBar(
          //shape: CircularNotchedRectangle(),
          //notchMargin: 15,
          elevation: 10,
          child: Container(
            height: 60,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(color: const Color(0xFF652981).withOpacity(0.2), blurRadius: 2, offset: const Offset(0, 2)),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {

                    controller.currentIndex.value = 0;
                    Get.lazyPut<HomeController>(
                      () => HomeController(),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        height: 16,
                        width: 16,
                        image: const AssetImage('assets/icons/home.png'),
                        color: controller.currentIndex.value == 0 ? const Color(0xFF652981) : Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Home'.tr,
                          style: TextStyle(
                            color: controller.currentIndex.value == 0 ? const Color(0xFF652981) : Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // MaterialButton(
                //   minWidth: 30,
                //   onPressed: () {
                //
                //     controller.currentIndex.value = 1;
                //   },
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Image(
                //         height: 16,
                //         width: 16,
                //         image: const AssetImage('assets/icons/gift.png'),
                //         color: controller.currentIndex.value == 1 ? const Color(0xFF652981) : Colors.grey,
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(top: 5),
                //         child: Text(
                //           'Offer'.tr,
                //           style: TextStyle(
                //             color: controller.currentIndex.value == 1 ? const Color(0xFF652981) : Colors.grey,
                //             fontWeight: FontWeight.normal,
                //             fontSize: 12,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                MaterialButton(
                  minWidth: 30,
                  onPressed: () {
                    controller.currentIndex.value = 1;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        height: 16,
                        width: 16,
                        image: AssetImage('assets/icons/gift.png'),
                        color: controller.currentIndex.value == 1
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'QR'.tr,
                          style: TextStyle(
                            color: controller.currentIndex.value == 1
                                ? AppColors.primaryColor
                                : Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                MaterialButton(
                  minWidth: 30,
                  onPressed: () {
                    controller.currentIndex.value = 2;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        height: 16,
                        width: 16,
                        image: const AssetImage('assets/icons/avatar.png'),
                        color: controller.currentIndex.value == 2 ? const Color(0xFF652981) : Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Profile'.tr,
                          style: TextStyle(
                            color: controller.currentIndex.value == 2
                                ? const Color(0xFF652981) : Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
