import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/repositories/mobile_banking_repository.dart';
import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class MobileBankCashinController extends GetxController {
  //TODO: Implement MobileBankCashinController
  TextEditingController numberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  final enable = 1.obs;
  late GlobalKey<FormState> cashinFormKey;
  @override
  void onInit() {
    cashinFormKey = GlobalKey<FormState>();
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

  sendRequestForCashin(String pin) async {
    Ui.customLoaderDialog();
    MobileBankingRepository().submitCashIn( number: numberController.text, amount: amountController.text, pin: pin).then((resp) {
      Get.back();
      if (resp['result'] == 'success') {
        showSuccessPopup(resp['message']);
        //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    }).catchError((onError) {});
  }

  sendRequestForCashinRocket(String pin) async {
    Ui.customLoaderDialog();
    MobileBankingRepository().submitCashInRocket( number: numberController.text, amount: amountController.text, pin: pin).then((resp) {
      Get.back();
      if (resp['result'] == 'success') {
        showSuccessPopup(resp['message']);
        //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    }).catchError((onError) {});
  }

  showPinPopup() {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Get.theme.primaryColor),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: Get.size.width * .6,
            width: Get.size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.width * .03,
                  ),
                  Text(
                    'Enter your PIN number to confirm'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: size.width * .1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'DBBL Account'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        numberController.text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cash In amount'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        uniCodeTk + ' ' + amountController.text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * .1,
                  ),
                  Container(
                      width: size.width,
                      //  height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: TextFormField(
                          obscureText: true,
                          controller: pinController,
                          cursorColor: const Color(0xFF652981),
                          textAlign: TextAlign.center,
                          maxLength: 6,
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'Enter PIN here'.tr,
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                            focusColor: const Color(0xFF652981),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      )),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: size.width * .35,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: Get.theme.primaryColor,
                        )),
                    child: Center(
                      child: Text(
                        'Cancel'.tr,
                        style: TextStyle(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                BlockButtonWidget(
                  onPressed: () {
                    if (pinController.text.isNotEmpty) {

                      if(Get.arguments[0] == 3){
                        sendRequestForCashinRocket(pinController.text);
                      }else{
                        sendRequestForCashin(pinController.text);
                      }


                    } else {
                      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please Enter Your PIN No'.tr, title: 'Error'.tr));
                    }
                  },
                  color: Get.theme.primaryColor,
                  width: size.width * .35,
                  text: Text(
                    'Confirm'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
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
                    child: Lottie.asset(
                      'assets/success.json',
                    ),
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
                        Get.back();
                        numberController.clear();
                        amountController.clear();
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
