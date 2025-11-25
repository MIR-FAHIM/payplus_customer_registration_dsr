import 'dart:async';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/registration_payment_info_model.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/repositories/registartion_payment_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/material.dart';


class SignupServiceFeeConfirmController extends GetxController {
  //TODO: Implement SignupServiceFeeConfirmController

  final isAgree = false.obs;
  final registrationInf = RegistrationPaymentInformationModel().obs;
  final mobileNumber = ''.obs;
  final paymentUrl = ''.obs;
  final paymentURlLoaded = false.obs;
  final serviceTypeID = ''.obs;
  final serviceType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    mobileNumber.value = Get.arguments[0];
    registrationInf.value = Get.arguments[1];
    serviceType.value = Get.arguments[2];
    serviceTypeID.value = Get.arguments[3];

    print('SignupServiceFeeConfirmController.onInit: ${serviceTypeID.value}');
  }

  @override
  void onReady() {
    super.onReady();
    showPopup();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getRegPaymentUrl() async {
    print(mobileNumber.value);
    Ui.customLoaderDialog();

    RegistartionPaymentRepository()
        .getPaymentCollectionUrl(mobileNumber.value, registrationInf.value.termsAndConditions!.first.amount!.toString(),
            registrationInf.value.registrationInformation!.id.toString())
        .then((resp) {
      Get.back();
      if (resp['status'] == 'success') {
        paymentUrl.value = resp['payment_url'];
        paymentURlLoaded.value = true;
        print(paymentUrl.value);

        if (Uri.parse(paymentUrl.value).isAbsolute) {
          var data = {
            "mobileNumber": mobileNumber.value,
            "paymentURL": paymentUrl.value,
            "title": "Registration Payment".tr,
            'selectedServiceTypeId': serviceTypeID.value,
          };
          Get.toNamed(Routes.SIGNUP_WEBVIEW, arguments: data);
        }
      } else {
        if (resp['already_paid'] == 1) {
          // Get.toNamed(Routes.PHONE_VERIFICATION_WTIH_O_T_P, arguments: {
          //   'mobileNumber': mobileNumber.value,
          //   'isRegistered': '0',
          //   'selectedServiceTypeId': serviceTypeID.value,
          // });
          Get.offAllNamed(Routes.SIGNUP, arguments: [
            mobileNumber.value,
            serviceTypeID.value,
          ]);
        }
      }
    });
  }
goSignUp(){
  Get.offAllNamed(Routes.SIGNUP, arguments: [
    mobileNumber.value,
    serviceTypeID.value,
  ]);
}
  showPopup() {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              height: Get.size.width + 5,
              width: Get.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image(
                  //   height: Get.size.width * 0.3,
                  //   width: Get.size.width * 0.35,
                  //   image: const AssetImage(
                  //     'assets/Logo.png',
                  //   ),
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: Get.size.width * 0.3,
                    width: Get.size.width * 0.35,
                    child: Text(''),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      registrationInf.value.termsAndConditions![0].message ?? '',
                      //  'সম্মানিত গ্রাহক আপনার অবগতির জন্য জানানো যাচ্ছে যে,আমাদের এই সংযোগ ব্যবহার করতে দৈনিক মাসিক বাৎসরিক সার্ভিস চার্জ দিতে হবে,রেজিস্ট্রেশন ফি এর জন্য আপনাকে ${serviceType.value} দিতে হবে, এই শর্তে যদি আপনি সম্মতি থাকেন তাহলে এগিয়ে যান',
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
                      text: const Text(
                        'Okay',
                        style: TextStyle(
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
