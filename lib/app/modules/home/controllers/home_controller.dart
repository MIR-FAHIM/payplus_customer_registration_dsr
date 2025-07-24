import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/models/ad_banner_model.dart';
import 'package:latest_payplus_agent/app/models/dashboardReportModel.dart';
import 'package:latest_payplus_agent/app/models/get_permission_model.dart';
import 'package:latest_payplus_agent/app/models/get_profile_info_model.dart';
import 'package:latest_payplus_agent/app/models/notification/popup_image_notification.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/modules/settings/controllers/language_controller.dart';
import 'package:latest_payplus_agent/app/repositories/balance_check_repository.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:latest_payplus_agent/main.dart';
import 'package:latest_payplus_agent/service/shared_pref.dart';

import '../../../models/package model/my_current_package_model.dart';
import '../../../models/package model/package_list_model.dart';
import '../../package/controller/package_list_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final currentPackageModel = CurrentPackageModel().obs;

  final balance = '0.0'.obs;
  final exitApp = false.obs;
  final phoneController = TextEditingController().obs;
   final outletNameController = TextEditingController().obs;
   final ownerController = TextEditingController().obs;
   final addressController = TextEditingController().obs;
  // final phoneController = TextEditingController().obs;
  // final phoneController = TextEditingController().obs;
  final status = false.obs;
  final packageName = "".obs;
  final profileInfoModel = GetProfileInfo().obs;
  final packageLoad = false.obs;
  final ownerName = "".obs;
  final packageListModel = PackageListModel().obs;
  final getPermissionModel = GetPermissionModel().obs;
  final getFeaturePermissionOnCustomerModel = GetPermissionModel().obs;
  final AdBanner = <AdBannerModel>[].obs;
  final AdBannerLoad = false.obs;
  final box = GetStorage().obs;
  final   contactsResult = <Contact>[].obs;
  final   paymentCollectionModel = <PaymentCollectModel>[].obs;
  // PickedFile? imageFile = null.obs as PickedFile?;

  // void _openCamera() async {
  //   final pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //   );
  //   // Ui.customLoaderDialog();

  //   imageFile = pickedFile!;

  //   // Navigator.pop(context);
  // }

  // final isAnimation = false.obs;
  // final isBalanceShown = false.obs;
  // final isBalance = true.obs;

  final dashboardReport = DahsboardReportModel().obs;
  @override
  Future<void> onInit() async {
    getProfileInfo();
    currentPackage();

    getLanguageSwitch();
    getBalance();
    getAdBanner();
    getDashBoardReport();

    getAllDisablePermission();
    getFeaturePermissionOnCustomer();
    if(GetStorage().read<List<Contact>>('contact') == null){
      getPhoneContact();
    }else{
      print("okay");
    }


    super.onInit();
    print('HomeController.onInit');
  }

  Future refreshHome() async {
    getBalance();
    getAdBanner();
    getDashBoardReport();
  }

  forFCM() {
    switch (type) {
      case '1':
        Get.toNamed(Routes.OFFER, arguments: type);
        break;
      case '2':
        Get.toNamed(Routes.RECHARGE_REPORT, arguments: type);
        break;
      case '3':
        Get.toNamed(Routes.TRANSACTION_HISTORY, arguments: type);
        break;
    }
  }
  getPackageName() async {
  packageName.value = Get.find<PackageController>().currentPackageModel.value.data!.packageName;
 }
  getLanguageSwitch() {
    if (Get.find<LanguageController>().locale.value == 'en_US') {
      status.value = true;
    } else {
      status.value = false;
    }
  }

  getPhoneContact()async{
    box.value.remove('contact');
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts = await FlutterContacts.getContacts();

      // Get all contacts (fully fetched)
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      // Get contact with specific ID (fully fetched)

      print("my all contact are $contacts");

      contactsResult.value = contacts;
      await box.value.write('contact', contactsResult);
      print("hlw bro ***********************${GetStorage().read('contact')}");

    }
  }
  currentPackage() async {
    packageLoad.value = true;
    BuySellRepository().currentPackage().then((response) {
      if (response.result == 'success') {
        print("Hlw package ");
        packageLoad.value = false;
        currentPackageModel.value = response;

        //  packageItems.value = response.data!;




      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: "Something wrong", title: 'Error'.tr));
        packageLoad.value = false;
      }
    });
  }

  getDashBoardReport() async {
    BalanceCheckRepository().dashboardData().then((resp) {

      dashboardReport.value = resp;
    });
  }
  // profile info
  getProfileInfo() async {
    BalanceCheckRepository().getProfileInfo().then((resp) {
      print("my profile info is $resp");
      if(resp["message"]== "Invalid token"){
        String number = Get.find<AuthService>()
            .currentUser
            .value
            .mobileNumber!;
        Get.find<AuthService>().removeCurrentUser();
        SharedPreff.to.prefss.remove("logindate");

        Get.offAndToNamed(Routes.SPLASHSCREEN,
            arguments: number);
      }else{
        profileInfoModel.value =   GetProfileInfo.fromJson(resp);


    }});
  }
  getAllDisablePermission() async {
    print("hlw all permission");
    BalanceCheckRepository().getDisablePermission().then((resp) {
      print("My All permission are ${resp.data!.allowMoneyout.toString()}");
      getPermissionModel.value = resp;
    });
  }

  getFeaturePermissionOnCustomer() async {
    print("hlw all permission on customer");
    BalanceCheckRepository().getFeaturePermissionOnCustomer().then((resp) {
      print("My All permission on feature ${resp.data!.allowWithdraw.toString()}");
      getFeaturePermissionOnCustomerModel.value = resp;
    });
  }


  // get permission
  getDashBoardWithoutLoadReport() async {
    BalanceCheckRepository().dashboardData().then((resp) {
      print("hlw data $resp");
      dashboardReport.value = resp;
    });
  }

  getBalance() async {
    BalanceCheckRepository().balanceCheck().then((resp) {
      double bln = double.parse(resp['balance'].toString().replaceAll('tk', '').trim());
      balance.value = double.parse((bln).toStringAsFixed(2)).toString();
      print("sahed");
      print(resp);
    });
  }

  getAdBanner() async {
    BalanceCheckRepository().getBanner().then((resp) {
      AdBanner.value = resp;
      AdBannerLoad.value = true;
    });
  }
  //test
  getAllCompany() async {
    BuySellRepository().getAllCompany().then((resp) {
     print("my all company data are $resp");
    });
  }
  // void changeState() async {
  //   // getBalance();

  //   isAnimation.value = true;
  //   isBalance.value = false;

  //   await Future.delayed(
  //       Duration(milliseconds: 800), () => isBalanceShown.value = true);
  //   await Future.delayed(
  //       Duration(seconds: 3), () => isBalanceShown.value = false);
  //   await Future.delayed(
  //       Duration(milliseconds: 200), () => isAnimation.value = false);
  //   await Future.delayed(
  //       Duration(milliseconds: 800), () => isBalance.value = true);
  // }

  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();
  }
}


class PaymentCollectModel {
  String? title;
  String? amount;
  String? totalUser;
  PaymentCollectModel({this.amount, this.title, this.totalUser});
}