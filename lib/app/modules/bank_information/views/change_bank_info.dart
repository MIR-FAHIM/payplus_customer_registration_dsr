import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/user_bank_information_model.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/drop_down_search_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/main_drawer_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/bank_information_controller.dart';

class ChangeBankInformationView extends GetView<BankInformationController> {
  @override
  Widget build(BuildContext context) {
    UserBankInformationModel data = Get.arguments[0];
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
                  onPressed: () {
                    Get.toNamed(Routes.Notification_View);
                  },
                  icon: Icon(
                    CupertinoIcons.bell,
                    color: Colors.white70,
                  )),

            ],
          ),
        ),
        body: Obx(() {
          if (controller.bankListLoaded.isTrue) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          elevation: 2,
                          child: SizedBox(
                            height: size.width * .26,
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                                  child: Text(
                                    "Account Holder Name".tr,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: controller.bankAccountController.value,
                                    autofocus: true,
                                    validator: (input) => input!.isNotEmpty ? "This field is required".tr : null,
                                    obscureText: false,
                                    textAlign: TextAlign.start,
                                    cursorColor: const Color(0xFF652981),
                                    decoration: InputDecoration(
                                      hintText: data.accName,
                                      hintStyle: TextStyle(fontSize: 13),
                                      focusColor: const Color(0xFF652981),
                                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          elevation: 2,
                          child: SizedBox(
                            height: size.width * .24,
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                                  child: Text(
                                    "Account No".tr,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: controller.accountNoController.value,
                                    autofocus: true,
                                    validator: (input) => input!.isNotEmpty ? "This field is required".tr : null,
                                    obscureText: false,
                                    textAlign: TextAlign.start,
                                    cursorColor: const Color(0xFF652981),
                                    decoration: InputDecoration(
                                      hintText: data.accNo,
                                      hintStyle: TextStyle(fontSize: 13),
                                      focusColor: const Color(0xFF652981),
                                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      DropDownWidget(
                        labelText: "Bank Name".tr,
                        hintText: "Select Bank".tr,
                        initialValue: '',
                        items: controller.bankList.map((item) => item.bankName!).toList(),
                        onChanged: (input) {
                          for (var item in controller.bankList) {
                            if (item.bankName == input) {
                              controller.selectedBankId.value = item.id.toString();
                            }
                          }
                          print('bank id: ${controller.selectedBankId.value}');
                        },
                        iconData: null,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          elevation: 2,
                          child: SizedBox(
                            height: size.width * .24,
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                                  child: Text(
                                    "Bank Routing No".tr,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: controller.routingController.value,
                                    autofocus: true,
                                    validator: (input) => input!.isNotEmpty ? "This field is required".tr : null,
                                    obscureText: false,
                                    textAlign: TextAlign.start,
                                    cursorColor: const Color(0xFF652981),
                                    decoration: InputDecoration(
                                      hintText: data.routingNo,
                                      hintStyle: const TextStyle(fontSize: 13),
                                      focusColor: const Color(0xFF652981),
                                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlockButtonWidget(
                    onPressed: () {
                      if (controller.paymentMethod.value == 'Mobile Banking') {
                        if (controller.selectedBankId.value != '') {
                          Get.toNamed(Routes.MOBILE_BANK_INFORMATION);
                        } else {
                          Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please Select a Mobile Bank'.tr, title: 'Error'.tr));
                        }
                      } else {
                        if( controller.accountNoController.value.text.isEmpty && controller.bankAccountController.value.text.isEmpty && controller.routingController.value.text.isEmpty){
                          Get.showSnackbar(Ui.ErrorSnackBar(
                              message: 'Please Change valid information'.tr, title: 'Error'.tr));
                        }else{
                          controller.editBankDetails(selectAcccountId: data.id.toString(),
                              accountName:controller.bankAccountController.value.text.isEmpty? data.accName: controller.bankAccountController.value.text,
                              accRouting:controller.routingController.value.text.isEmpty? data.routingNo :controller.routingController.value.text ,
                              accNo:controller.accountNoController.value.text.isEmpty ? data.accNo : controller.accountNoController.value.text);
                        }

                      }
                    },
                    color: const Color(0xFF652981),
                    text: Text(
                      "Next".tr,
                      style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Colors.white)),
                    ),
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                ],
              ),
            );
          } else {
            return Container(
              height: Get.size.height,
              child: Center(
                child: Ui.customLoader(),
              ),
            );
          }
        }));
  }
}
