import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latest_payplus_agent/app/modules/qr/controllers/qr_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';

import 'package:velocity_x/velocity_x.dart';


class QrTabPage extends GetView<QRController> {
  const QrTabPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop)  {
        // Navigate to Routes.ROOT when the back button is pressed
        Get.offAllNamed(Routes.ROOT);

      },
      child: Scaffold(
        backgroundColor: Colors.white,


        body: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [



                Container(
                  height: Get.height*.12,
                  color: AppColors.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('QR Code'.tr, style: TextStyle(color: Colors.white)),
                        Image.asset(
                          "assets/Logo.png",

                          color: Colors.white,
                          height: Get.height*.04,
                          width: Get.width*.3,
                          fit: BoxFit.contain,
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * .65,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: controller.qrPages, //tabscreen list
                  ),
                ),
                SizedBox(height: 10),
                TabBar(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  dividerColor: AppColors.primaryColor,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  tabs: [
                    Tab(

                      text: 'General QR',
                    ),
                    Tab(
                      icon:  Row(children:
                      [
                        Image.asset("assets/images/banglaqr.png",),
                        Text("Bangla QR")
                      ]
                      ),

                    ),
                  ],
                )
                    .box
                    .height(50)
                    .color(AppColors.primaryColor)
                    .roundedSM
                    .width(340)
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
