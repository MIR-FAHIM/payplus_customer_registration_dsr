import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';

import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/repositories/mobile_banking_repository.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class MobileBankCashoutController extends GetxController {
  //TODO: Implement MobileBankCashoutController

  TextEditingController numberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  late GlobalKey<FormState> cashoutFormKey;
  final enable = 1.obs;
  @override
  void onInit() {

    cashoutFormKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  sendRequestForCashOut() async {
    Ui.customLoaderDialog();
    MobileBankingRepository().submitCashOut(number: numberController.text, amount: amountController.text).then((resp) {
      Get.back();
      if (resp['result'] == 'success') {
        numberController.clear();
        amountController.clear();
        showSuccessPopup(resp['message']);
        //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    }).catchError((onError) {});
  }

  showSuccessPopup(String text) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              height: Get.size.width * .8,
              width: Get.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: Get.size.width * 0.3,
                    width: Get.size.width * 0.35,
                    child:Text('Success'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: BlockButtonWidget(
                      onPressed: () {
                        Get.back();
                      },
                      color: Get.theme.primaryColor,
                      radius: 30,
                      text: Text(
                        'Okay'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
            // actions: <Widget>[

            // ],
            );
      },
    );
  }
}
