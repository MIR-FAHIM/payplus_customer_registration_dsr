
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/app/modules/payment_collection/widgets/card.dart';
import 'package:latest_payplus_agent/app/modules/payment_collection/widgets/mobile_bank.dart';
import 'package:latest_payplus_agent/app/modules/payment_collection/widgets/net_bank.dart';
import 'package:latest_payplus_agent/app/repositories/payment_collection.dart';
import 'package:latest_payplus_agent/app/repositories/registartion_payment_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class PaymentCollectionController extends GetxController {
  //TODO: Implement PaymentCollectionController

  late TextEditingController amountController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController descController;

  final paymentUrl = ''.obs;
  final paymentURlLoaded = false.obs;

  late GlobalKey<FormState> paymentFormKey;

  late GlobalKey<FormState> paymentFormKeyShare;

  final currentIndex = 0.obs;
  final pages = [MobileBankForPayment(), CardForPayment(), NetBankForPayment()];
  @override
  void onInit() {
    paymentFormKey = GlobalKey<FormState>();
    paymentFormKeyShare = GlobalKey<FormState>();
    amountController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    descController = TextEditingController();
    super.onInit();
  }

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int page) {
    currentIndex.value = page;
  }

  getPaymentCollectionUrl(bool isShare) async {
    if (paymentFormKey.currentState!.validate()) {
      Ui.customLoaderDialog();
      PaymentCollectionRepository()
          .getPaymentCollectionUrl(amountController.text, nameController.text, phoneController.text, emailController.text, descController.text)
          .then((resp) {
        Get.back();
        if (resp['status'] == 'success') {
          paymentUrl.value = resp['payment_url'];
          paymentURlLoaded.value = true;
          refresh();

          if (Uri.parse(paymentUrl.value).isAbsolute) {
            Get.toNamed(Routes.WEBVIEW, arguments: paymentUrl.value);
          }
        }
      });
    }
  }

  getRegPaymentUrl() async {
    Ui.customLoaderDialog();

    RegistartionPaymentRepository().getPaymentCollectionUrl(amountController.text, phoneController.text, '1').then((resp) {
      Get.back();
      if (resp['status'] == 'success') {
        paymentUrl.value = resp['payment_url'];
        paymentURlLoaded.value = true;

        if (Uri.parse(paymentUrl.value).isAbsolute) {
          Get.toNamed(Routes.WEBVIEW, arguments: paymentUrl.value);
        }
      }
    });
  }

  sharePaymentCollectionUrl(bool isShare) async {
    if (paymentFormKeyShare.currentState!.validate()) {
      Ui.customLoaderDialog();
      PaymentCollectionRepository()
          .getPaymentCollectionUrl(amountController.text, nameController.text, phoneController.text, emailController.text, descController.text)
          .then((resp) {
        Get.back();
        if (resp['status'] == 'success') {
          paymentUrl.value = resp['payment_url'];
          paymentURlLoaded.value = true;
          refresh();

          share();
        }
      });
    }
  }
  Future<void> share() async {
    await SharePlus.instance.share(
        ShareParams(
          title:
          'Payment Collection Link from ${Get.find<AuthService>().currentUser.value.outletName}',
          text:
          'Payment Collection Link from ${Get.find<AuthService>().currentUser.value.outletName}',
          uri: Uri.parse(paymentUrl.value),
          subject:
          'Payment Collection Link from ${Get.find<AuthService>().currentUser.value.outletName}',
        )
    );

  }


  // Future<void> shareFile() async {
  //   List<dynamic> docs = await DocumentsPicker.pickDocuments;
  //   if (docs == null || docs.isEmpty) return null;
  //
  //   await FlutterShare.shareFile(
  //     title: 'Example share',
  //     text: 'Example share text',
  //     filePath: docs[0] as String,
  //   );
  // }

  @override
  void refresh() {
    // TODO: implement refresh

    descController.clear();
    amountController.clear();
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    super.refresh();
  }
}
