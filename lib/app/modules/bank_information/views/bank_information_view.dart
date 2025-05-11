import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/bank_information/widgets/bank.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/drop_down_search_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/main_drawer_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/bank_information_controller.dart';

class BankInformationView extends GetView<BankInformationController> {
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
        body: Obx(() {
          if (controller.bankListLoaded.isTrue) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropDownWidget(
                    labelText: "Provide Bank Information".tr,
                    hintText: "Bank".tr,
                    //items: ['Bank', 'Mobile Banking'],
                    items: ['Bank',],
                    onChanged: (input) {
                      controller.paymentMethod.value = input;

                      controller.selectedBankId.value = '';
                      controller.selectedBankId.update((val) {});

                      controller.bankAccountHolderName.value = '';
                      controller.bankAccountHolderName.update((val) {});
                      controller.bankAccountNo.value = '';
                      controller.bankAccountNo.update((val) {});

                      controller.bankRouting.value = '';
                      controller.bankRouting.update((val) {});
                    },
                    iconData: null,
                  ),
                  BankWidget(),
                  // controller.paymentMethod.value == 'Bank'
                  //     ? BankWidget()
                  //     : MobileBankingWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  BlockButtonWidget(
                    onPressed: () {
                      if (controller.paymentMethod.value == 'Mobile Banking') {
                        if (controller.selectedBankId.value != '') {
                          Get.toNamed(Routes.MOBILE_BANK_INFORMATION);
                        } else {
                          Get.showSnackbar(Ui.ErrorSnackBar(
                              message: 'Please Select a Mobile Bank'.tr,
                              title: 'Error'.tr));
                        }
                      } else {
                        controller.saveBankDetails();
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
