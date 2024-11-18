import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/drawer_link_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';

class MobileBankDrawer extends StatelessWidget {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Center(
            child: Text(
              'Pay Plus'.tr,
              style: const TextStyle(
                fontSize: 35,
                color: Color(0xFF652981),
              ),
            ),
          )),

          // DrawerLinkWidget(
          //   icon: 'assets/drawer/report.png',
          //   text: "Recharge Report".tr,
          //   onTap: (e) {
          //     Get.toNamed(Routes.RECHARGE_REPORT);
          //   },
          // ),
          DrawerLinkWidget(
            icon: 'assets/drawer/search.png',
            text: "Transaction History".tr,
            onTap: (e) {
              Get.toNamed(Routes.MOBILE_BANK_TRANSACTION_HISTORY,
                  arguments: ['all']);
            },
          ),

          // DrawerLinkWidget(
          //   icon: 'assets/drawer/1.png',
          //   text: "Sign Out".tr,
          //   onTap: (e) {
          //     Get.find<AuthService>().removeCurrentUser();
          //     Get.offAndToNamed(Routes.CHECK_PHONE_NUMBER);
          //   },
          // ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
