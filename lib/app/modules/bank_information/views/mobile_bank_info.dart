import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/bank_information/controllers/bank_information_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/main_drawer_widget.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class MobileBankingInfo extends GetView<BankInformationController> {
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
          title: Text('Bank Information'.tr),
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 2,
                child: Container(
                  height: _size.width * .28,
                  width: _size.width,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mobile Number'.tr,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25.0, top: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      width: _size.width * .5,
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        initialValue: '',
                                        onChanged: (input) {
                                          controller.bankAccountNo.value =
                                              input;
                                        },
                                        autofocus: true,
                                        validator: (input) => input!.length < 11
                                            ? 'Please provide valid phone number'
                                            : null,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF652981),
                                        ),
                                        obscureText: false,
                                        textAlign: TextAlign.start,
                                        cursorColor: Color(0xFF652981),
                                        decoration: InputDecoration(
                                          hintText: '+880',
                                          hintStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                          focusColor: Color(0xFF652981),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
            BlockButtonWidget(
              onPressed: () {
                if (controller.bankAccountNo.value != '') {
                  controller.saveBankDetails();
                } else {
                  Get.showSnackbar(Ui.ErrorSnackBar(
                      message: 'Please Enter Account No.'.tr,
                      title: 'Error'.tr));
                }
              },
              color: Color(0xFF652981),
              text: Text(
                "Next".tr,
                style: Get.textTheme.bodyMedium!
                    .merge(TextStyle(color: Colors.white)),
              ),
            ).paddingSymmetric(vertical: 10, horizontal: 20),
          ],
        ),
      ),
    );
  }

  buildSuccessDialog() {
    return Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.only(left: 20, right: 20),
        contentPadding: EdgeInsets.all(10),
        radius: 8,
        content: Container(
          width: Get.size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Bank info success'.tr,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF652981),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration:
                  Ui.getBoxDecoration(color: Color(0xFF652981), radius: 8),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8, top: 5, bottom: 5),
                child: Center(
                  child: Text(
                    'Okay'.tr,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ]);
  }
}
