import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/mobile_bank_cashin_controller.dart';

class MobileBankCashinView extends GetView<MobileBankCashinController> {
  const MobileBankCashinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
        title: Text('Cash In'.tr),
        centerTitle: true,
      ),
      body: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: controller.cashinFormKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: size.width * .2,
                          width: size.width * .3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/mobilebank/rocket.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'DBBL',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: size.width * .28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Customer's Account No.".tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: size.width * .02,
                              ),
                              SizedBox(
                                width: size.width * .55,
                                // height: 50,
                                child: TextFormField(
                                    controller: controller.numberController,
                                    keyboardType: TextInputType.phone,
                                    maxLength: 11,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 5, top: 5),
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      hintText: "Customer's Account No.".tr,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    onChanged: (input) {
                                      if (input.length == 11) {
                                        Get.focusScope!.nextFocus();
                                      }
                                    }
                                    // validator: (input) {
                                    //   if (input!.length < 11) {
                                    //     return 'Please enter valid account number'.tr;
                                    //   } else {
                                    //     return null;
                                    //   }
                                    // },
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: size.width * .28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amount".tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: size.width * .02,
                              ),
                              SizedBox(
                                width: size.width * .35,
                                // height: 50,
                                child: TextFormField(
                                  controller: controller.amountController,
                                  keyboardType: TextInputType.number,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 5, top: 5),
                                    hintStyle: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    hintText: "Enter Amount".tr,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  // validator: (input) {
                                  //   if (input!.isEmpty) {
                                  //     return 'Please enter amount'.tr;
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  onChanged: (input) {
                                    if (input.isNotEmpty) {
                                      controller.enable.value = 1;
                                    } else {
                                      controller.enable.value = 0;
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlockButtonWidget(
                        onPressed: () {
                          if (controller.numberController.text.length == 11 &&
                              controller.amountController.text.isNotEmpty) {
                            Get.focusScope!.unfocus();
                            if (double.parse(
                                    controller.amountController.text) >=
                                50) {
                              controller.showPinPopup();
                            } else {
                              Get.showSnackbar(Ui.ErrorSnackBar(
                                  message:
                                      'Minimum transaction amount is 50 Tk.'.tr,
                                  title: 'Error'.tr));
                            }
                          }
                        },
                        color: controller.enable.value == 1 &&
                                controller.numberController.text.length == 11 &&
                                controller.amountController.text.isNotEmpty
                            ? Get.theme.primaryColor
                            : Colors.grey,
                        width: size.width * .4,
                        text: Text(
                          'Next'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
