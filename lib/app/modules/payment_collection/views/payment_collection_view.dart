import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/payment_collection/widgets/payment_collect_drawer.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/payment_collection_controller.dart';

class PaymentCollectionView extends GetView<PaymentCollectionController> {
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
          title: Text('Payment Collection'.tr),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.Notification_View);
                },
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: _size.width,
          height: _size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: controller.paymentFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 14, left: 20, right: 20),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
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
                          "Product Description".tr,
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          controller: controller.descController,
                          keyboardType: TextInputType.text,
                          style: Get.textTheme.bodyMedium,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          cursorColor: Color(0xFF652981),
                          decoration: Ui.getInputDecoration(
                            hintText: "Enter Product Description".tr,
                            iconData: null,
                            imageData: 'assets/collection/4.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 14, left: 20, right: 20),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
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
                          controller: controller.amountController,
                          keyboardType: TextInputType.number,
                          style: Get.textTheme.bodyMedium,
                          validator: (input) {
                            if (controller.amountController.text.isEmpty) {
                              return 'Please enter valid amount'.tr;
                            } else if (double.parse(
                                    controller.amountController.text) <=
                                0) {
                              return 'Please enter valid amount'.tr;
                            } else {
                              return null;
                            }
                          },
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
                    padding: EdgeInsets.only(
                        top: 10, bottom: 14, left: 20, right: 20),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
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
                          "Customer Name".tr + ' *',
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.text,
                          style: Get.textTheme.bodyMedium,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          validator: (input) {
                            if (controller.nameController.text.isEmpty) {
                              return 'This field is required'.tr;
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Color(0xFF652981),
                          decoration: Ui.getInputDecoration(
                            hintText: "Enter Customer Name".tr,
                            iconData: null,
                            imageData: 'assets/collection/1.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 14, left: 20, right: 20),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
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
                          "Customer Email Address".tr,
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.text,
                          style: Get.textTheme.bodyMedium,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          cursorColor: Color(0xFF652981),
                          decoration: Ui.getInputDecoration(
                            hintText: "Enter Customer Email Address".tr,
                            iconData: CupertinoIcons.mail,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 14, left: 20, right: 20),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
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
                          "Customer Mobile No".tr + ' *',
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          style: Get.textTheme.bodyMedium,
                          validator: (input) {
                            if (controller.phoneController.text.length != 11) {
                              return 'Invalid phone number'.tr;
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          textAlign: TextAlign.start,
                          cursorColor: Color(0xFF652981),
                          decoration: Ui.getInputDecoration(
                            hintText: "Enter Customer Mobile No.".tr,
                            iconData: CupertinoIcons.device_phone_portrait,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlockButtonWidget(
                    onPressed: () {
                      controller.getPaymentCollectionUrl(false);
                      // controller.getRegPaymentUrl();
                    },
                    color: Color(0xFF652981),
                    text: Text(
                      "Payment Collection".tr,
                      style: Get.textTheme.bodyMedium!
                          .merge(TextStyle(color: Colors.white)),
                    ),
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
