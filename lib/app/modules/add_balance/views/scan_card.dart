import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/add_balance/widgets/addbalance_drawer.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/add_balance_controller.dart';

class ScanCardView extends GetView<AddbalanceController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        endDrawer: AddBalanceDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size(65, 65),
          child: AppBar(
            backgroundColor: const Color(0xFF652981),
            centerTitle: true,
            title: Text('Visa/Master Card'.tr),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                // controller.scanMyCard();
                //  Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            // actions: [
            //   IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         CupertinoIcons.bell,
            //         color: Colors.white70,
            //       )),
            // ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CreditCardWidget(
                cardNumber: "567567567567",
                expiryDate: "423423",
                cardHolderName: "fdgdfgdfgdfg",
                cvvCode: "546",
                showBackView: false, //true when you want to show cvv(back) view
                onCreditCardWidgetChange: (CreditCardBrand
                    brand) {}, // Callback for anytime credit card brand is changed
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.scanCard();
                      },
                      child: Icon(Icons.adf_scanner_rounded),
                    ),
                    Container(
                        width: _size.width,
                        height: _size.height * .1,
                        decoration: Ui.getBoxDecoration(
                          color: AppColors.primaryColor.withOpacity(.6),
                          radius: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${controller.amount.value} BDT",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      labelText: "Account No:".tr,
                      hintText: "Mobile Number".tr,
                      keyboardType: TextInputType.phone,
                      readOnly: false,

                      // onTapped: () {
                      //   FocusScope.of(context).requestFocus(FocusNode());
                      // },
                      initialValue: controller.amount.value,
                      onChanged: (input) => controller.amount.value = input,
                      // onSaved: (input) =>
                      // controller.currentUser.value.email = input,
                      // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                      // iconData: CupertinoIcons.device_phone_portrait,
                      imageData: 'assets/icons/number_pad.png',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      labelText: "Account No:".tr,
                      hintText: "Mobile Number".tr,
                      keyboardType: TextInputType.phone,
                      readOnly: false,

                      // onTapped: () {
                      //   FocusScope.of(context).requestFocus(FocusNode());
                      // },
                      initialValue: controller.amount.value,
                      onChanged: (input) => controller.amount.value = input,
                      // onSaved: (input) =>
                      // controller.currentUser.value.email = input,
                      // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                      // iconData: CupertinoIcons.device_phone_portrait,
                      imageData: 'assets/icons/number_pad.png',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      labelText: "Account No:".tr,
                      hintText: "Mobile Number".tr,
                      keyboardType: TextInputType.phone,
                      readOnly: false,

                      // onTapped: () {
                      //   FocusScope.of(context).requestFocus(FocusNode());
                      // },
                      initialValue: controller.amount.value,
                      onChanged: (input) => controller.amount.value = input,
                      // onSaved: (input) =>
                      // controller.currentUser.value.email = input,
                      // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                      // iconData: CupertinoIcons.device_phone_portrait,
                      imageData: 'assets/icons/number_pad.png',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class bodyItem extends StatelessWidget {
  const bodyItem({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width,
      decoration: Ui.getBoxDecoration(
        color: Colors.white,
        radius: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    'assets/images/Group.png',
                    height: 45,
                    width: 45,
                    color: const Color(0xFF652981),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'OTF',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'TK0.00',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
