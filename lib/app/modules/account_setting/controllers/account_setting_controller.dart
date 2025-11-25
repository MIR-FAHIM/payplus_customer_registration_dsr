import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/app/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latest_payplus_agent/app/models/district_model.dart';
import 'package:latest_payplus_agent/app/models/divisionsTypeModel.dart';
import 'package:latest_payplus_agent/app/models/thana_model.dart';
import 'package:latest_payplus_agent/app/models/union_model.dart';
import 'package:latest_payplus_agent/app/repositories/account_setting_repository.dart';
import 'package:latest_payplus_agent/app/repositories/location_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class AccountSettingController extends GetxController {
  //TODO: Implement AccountSettingController

  final name = ''.obs;
  final id = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final profileDataFromAPi = DataPro().obs;
  final divisionId = ''.obs;
  final districtId = ''.obs;
  final thanaId = ''.obs;
  final unionId = ''.obs;
  final wordNo = ''.obs;

  final permanentAddress = ''.obs;
  final presentAddress = ''.obs;

  final divisions = <DivisionModel>[].obs;
  final divisionLoaded = false.obs;

  final districts = <DistrictModel>[].obs;

  final thanas = <ThanaModel>[].obs;

  final unions = <UnionModel>[].obs;

  final isChecked = false.obs;

  final pinNumber = ''.obs;
  final kycStatus = 0.obs;
  final msg = ''.obs;

  late FocusNode pinFocusFocus;
  late TextEditingController pinController;

  @override
  Future<void> onInit() async {
    pinController = TextEditingController();
    getAccountData();
    pinFocusFocus = FocusNode();
    await getDivisions();

    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    pinFocusFocus.dispose();

    pinController.clear();

    pinNumber.value = '';

    super.dispose();
  }

  // @override
  // Future<void> onInit() async {
  //   //await getAccountData();

  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
  }
  getAccountData() async {
    divisionLoaded.value = false;
    AccountSettingRepository().accountInfo().then((resp) {
      print(resp);
      if (resp['status'] == "success") {
        print("kyc is ${resp['data']['kyc']}");

        kycStatus.value = resp['data']['kyc'];
        ProfileModel model = ProfileModel.fromJson(resp);
        profileDataFromAPi.value = model.data!;
        print("profile data are ${profileDataFromAPi.value.nid}");
      }
    });
  }
  getDivisions() async {
    LocationRepository().getDivisions().then((resp) {
      divisions.value = resp;
      divisionLoaded.value = true;
    });
  }

  getDistrict() async {
    Ui.customLoaderDialog();
    LocationRepository().getDistrict(divisionId.value).then((resp) {
      Get.back();
      districts.value = resp;
    });
  }

  getThana() async {
    Ui.customLoaderDialog();
    LocationRepository().getThana(districtId.value).then((resp) {
      Get.back();
      thanas.value = resp;
    });
  }

  getUnion() async {
    Ui.customLoaderDialog();
    LocationRepository().getUnion(thanaId.value).then((resp) {
      Get.back();
      unions.value = resp;
    });
  }

  DeactivateAccount() async {
    print("done");
    print(pinNumber.value);
    print(msg.value);
    Ui.customLoaderDialog();
    AccountSettingRepository()
        .deactivateAccount(pinNumber.value, msg.value)
        .then((resp) async {
      Get.back();
      if (resp['result'] == 'success') {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
        SharedPreferences saveimage = await SharedPreferences.getInstance();
        final success = await saveimage.remove('imagepath');

        Get.find<AuthService>().logOutApi(true);

      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    });
  }

  saveInfoo() async {
    Ui.customLoaderDialog();
    AccountSettingRepository()
        .saveAccountInfo(
      name.value,
      id.value,
      email.value,
      phone.value,
      divisionId.value,
      districtId.value,
      thanaId.value,
      unionId.value,
      wordNo.value,
      permanentAddress.value,
      presentAddress.value,
    )
        .then((resp) {
      Get.back();
      if (resp['result'] == 'success') {
        Get.showSnackbar(Ui.SuccessSnackBar(
            message: 'Information Saved Successfully'.tr, title: 'Success'.tr));
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: "Information Couldn't Saved".tr, title: 'Error'.tr));
      }
    });
  }


}
