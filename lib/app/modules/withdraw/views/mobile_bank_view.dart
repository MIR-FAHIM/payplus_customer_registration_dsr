import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/main_drawer_widget.dart';

import '../controllers/withdraw_controller.dart';

class MobileBankView extends GetView<WithdrawController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: MainDrawerWidget(),
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          title: Text('Withdraw'.tr),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.bell,
                  color: Colors.white70,
                )),
            IconButton(
                onPressed: () => {Scaffold.of(context).openEndDrawer()},
                icon: Icon(
                  Icons.menu,
                  color: Colors.white70,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            height: 80,
            padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF652981).withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(0, 2)),
              ],
              //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Mobile Banking".tr,
                  style: Get.textTheme.headlineSmall,
                  textAlign: TextAlign.start,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.size.width * .7,
                      child: Text('City Bank'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image(
                        image: AssetImage('assets/city.jpeg'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 80,
            padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF652981).withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(0, 2)),
              ],
              //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Mobile Banking Name".tr,
                  style: Get.textTheme.headlineSmall,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.size.width * .7,
                  child: Text('Name'),
                )
              ],
            ),
          ),
          Container(
            height: 80,
            padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF652981).withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(0, 2)),
              ],
              //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Mobile Banking No.".tr,
                  style: Get.textTheme.headlineSmall,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.size.width * .7,
                  child: Text('0198765432'),
                )
              ],
            ),
          ),
          BlockButtonWidget(
            onPressed: () {},
            color: Color(0xFF652981),
            text: Text(
              "Next".tr,
              style: Get.textTheme.headlineSmall!
                  .merge(TextStyle(color: Colors.white)),
            ),
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ]),
      ),
    );
  }
}
