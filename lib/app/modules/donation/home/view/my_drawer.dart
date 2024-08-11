import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latest_payplus_agent/app/modules/donation/home/controller/donation_home_controller.dart';
import 'package:latest_payplus_agent/common/Color.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';


class MyDrawer extends GetView<DonationHomeController> {
  @override
  Widget build(BuildContext context) {

      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: Get.height * .25,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                  ],
                ),
              ),
            ),

          Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                onTap: () {

                },
                child: ListTile(
                  minLeadingWidth: 12,
                  title: const Text('Profile & Accounts'),
                  leading: SvgPicture.asset(
                    "assets/icons/drawer_icons/profile.svg",
                    height: 24,
                    width: 24,
                    theme: SvgTheme(
                      currentColor: AppColors.primaryColor,
                    ),
                  ),

                ),
              ),
            ),


          ],
        ),
      );

  }


}
