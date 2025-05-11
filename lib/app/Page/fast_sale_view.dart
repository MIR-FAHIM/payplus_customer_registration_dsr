import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/Page/Transaction_successful.dart';
import 'package:latest_payplus_agent/app/Page/widget/IncomeTransaction.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/payment_collection/widgets/payment_collect_drawer.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class FastSaleViewScreen extends StatelessWidget {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: PaymentCollectionDrawer(),
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Fast Sale'.tr),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.bell,
                  color: Colors.white70,
                )),
            Builder(
              builder: (context) => // Ensure Scaffold is in context
                  IconButton(
                      onPressed: () => {Scaffold.of(context).openEndDrawer()},
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white70,
                      )),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF652981).withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Product Name".tr,
                      style: Get.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    TextFormField(
                      // controller: controller.descController,
                      keyboardType: TextInputType.text,
                      style: Get.textTheme.bodyMedium,
                      obscureText: false,
                      textAlign: TextAlign.start,
                      cursorColor: Color(0xFF652981),
                      decoration: Ui.getInputDecoration(
                        hintText: "Enter Product Name".tr,
                        iconData: null,
                        imageData: 'assets/collection/4.png',
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: _size.width * 0.45,
                    padding:
                        EdgeInsets.only(top: 12, bottom: 5, left: 12, right: 8),
                    margin: EdgeInsets.only(
                        left: 10, right: 5, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF652981).withOpacity(0.2),
                            blurRadius: 2,
                            offset: Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Amount".tr + ' *',
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          // controller: controller.amountController,
                          keyboardType: TextInputType.number,
                          style: Get.textTheme.bodyMedium,
                          // validator: (input) {
                          //   if (controller.amountController.text.isEmpty) {
                          //     return 'Please enter valid amount'.tr;
                          //   } else if (double.parse(
                          //           controller.amountController.text) <=
                          //       0) {
                          //     return 'Please enter valid amount'.tr;
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          obscureText: false,
                          textAlign: TextAlign.start,
                          cursorColor: Color(0xFF652981),
                          decoration: Ui.getInputDecoration(
                            hintText: "Enter Amount".tr,
                            iconData: null,
                            imageData: 'assets/collection/2.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: _size.width * 0.45,
                    padding:
                        EdgeInsets.only(top: 12, bottom: 5, left: 12, right: 8),
                    margin: EdgeInsets.only(
                        left: 10, right: 5, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF652981).withOpacity(0.2),
                            blurRadius: 2,
                            offset: Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Unit Price".tr + ' *',
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          // controller: controller.amountController,
                          keyboardType: TextInputType.number,
                          style: Get.textTheme.bodyMedium,
                          // validator: (input) {
                          //   if (controller.amountController.text.isEmpty) {
                          //     return 'Please enter valid amount'.tr;
                          //   } else if (double.parse(
                          //           controller.amountController.text) <=
                          //       0) {
                          //     return 'Please enter valid amount'.tr;
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          obscureText: false,
                          textAlign: TextAlign.start,
                          cursorColor: Color(0xFF652981),
                          decoration: Ui.getInputDecoration(
                            hintText: "Enter Unit Price".tr,
                            iconData: null,
                            imageData: 'assets/collection/2.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              BlockButtonWidget(
                onPressed: () {
                  Get.offAll(TransactionSuccessful());
                  // controller.getPaymentCollectionUrl(false);
                },
                color: Color(0xFF652981),
                text: Text(
                  "Add".tr,
                  style: Get.textTheme.headlineSmall!
                      .merge(TextStyle(color: Colors.white)),
                ),
              ).paddingSymmetric(vertical: 10, horizontal: 20),
              Income(),
            ],
          ),
        ),
      ),
    );
  }
}
