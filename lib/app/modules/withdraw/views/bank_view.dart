import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/main_drawer_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';

import '../controllers/withdraw_controller.dart';

class BankView extends GetView<WithdrawController> {
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
            height: Get.height * .15,
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
                  "Bank Name".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.size.width * .6,
                      child: Text(
                          controller.selectedBankInfo.value.bankName ?? ''),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://shl.com.bd/public/uploads/bank-logo/${controller.selectedBankInfo.value.logo_name!}',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image(
                              image: AssetImage('assets/images/bank.png'),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image(
                              image: AssetImage('assets/images/bank.png'),
                            ),
                          ),
                        ),
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
                  "Bank Account Name".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.size.width * .7,
                  child: Text(controller.selectedBankInfo.value.accName ?? ''),
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
                  "Bank Account No.".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.size.width * .7,
                  child: Text(controller.selectedBankInfo.value.accNo ?? ''),
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
                  "Bank Branch Name".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.size.width * .7,
                  child: Text('dhaka'),
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
                  "Bank Routing Number".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.size.width * .7,
                  child:
                      Text(controller.selectedBankInfo.value.routingNo ?? ''),
                )
              ],
            ),
          ),
          BlockButtonWidget(
            onPressed: () {
              Get.toNamed(Routes.WITHDRAW_AMOUNT);
            },
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
