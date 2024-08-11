import 'dart:math';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/add_balance_model/add_balance_history_model.dart';
import 'package:latest_payplus_agent/app/models/add_balance_model/mfs_list_model.dart';
import 'package:latest_payplus_agent/app/models/get_collection_details_model.dart';
import 'package:latest_payplus_agent/app/models/mfsPaymentType.dart';
import 'package:latest_payplus_agent/app/repositories/mfsPayment_type_repositoy.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/material.dart';

import '../../../../common/Color.dart';

class AddbalanceController extends GetxController {
  //TODO: Implement DailyReportController

  final grpValue = 1.obs;
  final cardId = 1.obs;
  // final mfsLogo = "".obs;
  // final mfsCode = "".obs;
  final paymentUrl = ''.obs;
  final paymentURlLoaded = false.obs;
  final selectStatus = "All".obs;
  final kyc = false.obs;

  final dailyReportLoaded = false.obs;
  final bankData = {}.obs;
  final random = Random();
  final bankName = "".obs;
  final amount = ''.obs;
  final gateway = ''.obs;
  final paymentMethodId = ''.obs;
  final paymentMethodCode = ''.obs;
  final paymentOptionId = ''.obs;
  final functionIsBank = false.obs;
  final paymentTypes = <MFSPaymentTypeModel>[].obs;
  final paymentTypesBnk = <BankkPaymentTypeModel>[].obs;
  final paymentTypesMFS = <MFSListModel>[].obs;
  final paymentTypesVisaMast = <MFSListModel>[].obs;
  final bankChargeList = <BankChargeListModel>[].obs;
  final collectionDetailsList = <DatumCollection>[].obs;
  final addBalanceHistoryList = <DatumHistory>[].obs;
  final List colorList = [
    const Color(0xffB85252),
    const Color(0xffB4C6A6),
    const Color(0xffF4ABC4),
    const Color(0xff346751),
    const Color(0xffFFC947),
    const Color(0xff3282B8),
  ].obs;
  @override
  Future<void> onInit() async {
    //await getPaymentTypeController();
    getAddBalanceHistory();
    getCollectionDetailsController();
    // mfsName.value = Get.arguments['name'] ?? "";
    // mfsLogo.value = Get.arguments['images'] ?? "";
    // mfsCode.value = Get.arguments['code'] ?? "";
    getPaymentType();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getPaymentType() async {
    mfsPaymentTypeRepository().getBusinessType().then((resp) {
      paymentTypesMFS.value = resp;
      paymentTypesVisaMast.value = resp.where((element) => element.code == "visa" || element.code == "mastercard" ).toList();
      print("hlw pay plus 1 ________________${paymentTypesMFS.value.length}");
      print(
          "hlw pay plus 1 ________________${paymentTypesMFS.value[0].charge}");
      // userData.value.businessType = businessTypes[0].id!.toString();

      dailyReportLoaded.value = true;
      return resp;
    });
  }

  getPaymentUrlProceed() async {
    //  Ui.customLoaderDialog();

    mfsPaymentTypeRepository()
        .getPaymentCollectionUrlProceed(
            amount: amount.value,
            paymentMethodId: paymentMethodId.value,
            paymentOptionId: paymentOptionId.value)
        .then((resp) {
      if (resp['data']['status'] == 'success') {
        Get.back();
        functionIsBank.value = false;
        paymentUrl.value = resp["data"]['payment_url'];
        paymentURlLoaded.value = true;
        print("+++++++ HLW BRO +++++++${paymentUrl.value}");

        if (Uri.parse(paymentUrl.value).isAbsolute) {
          var data = {
            "paymentURL": paymentUrl.value,
            "title": "Add Balance",
          };
          Get.toNamed(Routes.WEBVIEW, arguments: data);
        }
      } else {
        functionIsBank.value = true;
        //paymentURlLoaded.value = true;
        bankData.value = resp['data'];
        print("hlw +++++++++ bank ++++ ${bankData.value['req_amount']}");
      }
    });
    return functionIsBank.value;
  } 
  


  getAddPaymentUrl() async {
    Ui.customLoaderDialog();

    mfsPaymentTypeRepository()
        .getPaymentCollectionUrl(amount.value, paymentMethodCode.value)
        .then((resp) {
      Get.back();
      if (resp['status'] == 'success') {
        paymentUrl.value = resp['payment_url'];
        paymentURlLoaded.value = true;
        print("+++++++ HLW BRO +++++++${paymentUrl.value}");

        if (Uri.parse(paymentUrl.value).isAbsolute) {
          var data = {
            "paymentURL": paymentUrl.value,
            "title": "Add Balance",
          };
          Get.toNamed(Routes.WEBVIEW, arguments: data);
        }
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    });
  }

  getAddPaymentUrlVisa(String cardId) async {
    Ui.customLoaderDialog();

    mfsPaymentTypeRepository()
        .getPaymentCollectionUrl(amount.value, paymentMethodCode.value)
        .then((resp) {
      Get.back();
      if (resp['status'] == 'success') {
        paymentUrl.value = resp['payment_url'];
        paymentURlLoaded.value = true;
        print("+++++++ HLW BRO +++++++${paymentUrl.value}");
        String   cusToken = paymentUrl.value.split("/").last;
        String   cusUrl = "https://api.paystation.com.bd/checkout/card/$cardId/$cusToken";
        if (Uri.parse(cusUrl).isAbsolute) {
          var data = {
            "paymentURL":cusUrl,
            "title": "Add Balance",
          };
          Get.toNamed(Routes.WEBVIEW, arguments: data);
        }
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    });
  }

  // new function
  getPaymentTypeController(int type) async {
    print("hlw boss just called getPaymentTypeController");
    mfsPaymentTypeRepository().getPaymentType(type).then((resp) {
      paymentTypes.value = resp;
      print("hlw boss ++++++${paymentTypes.value.toString()}");

      // userData.value.businessType = businessTypes[0].id!.toString();

      dailyReportLoaded.value = true;
      print("hlw boss my paymment type are $resp");
      return resp;
    });
  }
//for bank

  getBankChargeListController(int type) async {
    mfsPaymentTypeRepository().getBankChargeList(type).then((resp) {
      bankChargeList.value = resp;
      print(paymentTypes.value.length);

      // userData.value.businessType = businessTypes[0].id!.toString();
      Get.toNamed(Routes.Add_Balance_Dashboard_View);
      dailyReportLoaded.value = true;
      return resp;
    });
  }

  getCollectionDetailsController() {
    print("get collection details ++++++++++++++ working ++++++ started");
    //Ui.customLoaderDialog();
    mfsPaymentTypeRepository().getCollectionDetails().then((resp) {
      print("get collection details ++++++++++++++ working ++++++ 3started");
      var data = CollectionDetailsModel.fromJson(resp);

      collectionDetailsList.value = data.data!;
      print(
          "jjjjjjj_++++++++++ +++++++ bro +++++++ ^^^^ ${collectionDetailsList.value.length}");
    });
  }

  confirmBankPayController() async {
    //  Ui.customLoaderDialog();

    mfsPaymentTypeRepository()
        .confirmBankPay(
      amount: amount.value,
      reference: bankData["reference"].toString(),
      paymentOptionId: paymentOptionId.value,
      invoice: bankData["invoice_id"],
      charge: bankData["charge"],
    )
        .then((resp) {
      print("my response $resp");
      if (resp["message"] == "Your collection request has been recorded.") {
        // Get.showSnackbar(Ui.SuccessSnackBar(message: resp["message"], title: 'success'.tr));
        Map data = {
          "message": resp['message'].toString(),
          "data": resp['data'].toString(),
        };
        Get.offAndToNamed(Routes.ADDBALANCESUCCESS, arguments: data);
      }
    });
  }

  getAddBalanceHistory() {
    print("get add balance history ++++++++++++++ working ++++++ started");
    //Ui.customLoaderDialog();
    mfsPaymentTypeRepository().getAddBalanceHistory().then((resp) {
      print(
          "get add balance history ++++++++++++++ working ++++++ 3started $resp");
      var data = AddBalanceHistoryModel.fromJson(resp);

      addBalanceHistoryList.value = data.data!;
      print("my logo in haddbalance his${addBalanceHistoryList.value[1].logoLink}");
      print(
          "get add balance history ^^^^ ${addBalanceHistoryList.value.length}");
    });
  }
}

class StickyColors {
  static final List colors = [
    const Color(0xffd8c6e0),
    const Color(0xffB4C6A6),
    const Color(0xff9c43bb),
    const Color(0xff346751),
    const Color(0xffdbceae),
    const Color(0xff3282B8),
  ];
}
