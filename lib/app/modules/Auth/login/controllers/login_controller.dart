import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:device_information/device_information.dart';

import 'package:latest_payplus_agent/app/models/buysell/customer_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:latest_payplus_agent/app/repositories/auth_repositories.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/firebase_messaging_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:latest_payplus_agent/service/shared_pref.dart';
import 'package:flutter_sim_data/sim_data.dart';
import 'package:flutter_sim_data/sim_data_model.dart';

class LoginController extends GetxController {
  final mobileNumber = ''.obs;
  final imeiNumber = ''.obs;
  final phoneName = ''.obs;
  final phoneModel = ''.obs;
  final _simDataPlugin = SimData();
  final password = ''.obs;
  final deviceToken = ''.obs;

  final hidePassword = true.obs;
  final loginTime = DateTime.now().obs;
  bool isSupported = true;
  late GlobalKey<FormState> loginFormKey;
  @override
  void onInit() {
    mobileNumber.value = Get.arguments ?? '';
    loginFormKey = GlobalKey<FormState>();
    imeiNumber.value = Get.find<LocationService>().imei.value;

    askingPhonePermission();
    super.onInit();
  }
  Future<void> printSimCardsData() async {
    print("i amn here 123");
    final List<SimDataModel> simData = await _simDataPlugin.getSimData();
    print("sim data is ${simData.length}");
  }
  Future<String> askingPhonePermission() async {
    final PermissionStatus permissionStatus = await _getPhonePermission();
    return permissionStatus.name;
  }
  Future<PermissionStatus> _getPhonePermission() async {
    final PermissionStatus permission = await Permission.phone.status;

    print(
        "kaj ekhane hocche location service permissioon status  ${PermissionStatus.granted}");
    if (permission != PermissionStatus.granted &&
        permission == PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.phone].request();
      return permissionStatus[Permission.phone] ?? PermissionStatus.restricted;
    } else {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.phone].request();
      print("device info is coming from login controller");
      getDeviceInfo();
      printSimCardsData();
      return permissionStatus[Permission.phone] ?? PermissionStatus.restricted;
    }
  }
  getDeviceInfo() async {
    try {
      phoneName.value = await DeviceInformation.deviceName;
     phoneModel.value = await DeviceInformation.deviceModel;
      print("hlw bro imie${imeiNumber.value}---name -${phoneName.value}-- model====${phoneModel.value}=");
    } on PlatformException {
      print('Failed to get platform version.');
    }
  }
  // getSimNumber()async{
  //  bool isPermissionGranted = await MobileNumber.hasPhonePermission;
  //  if (isPermissionGranted) {
  //    final List<SimCard>? simCards = await MobileNumber.getSimCards;
  //    print("numbe are ${simCards!.first.number}");
  //    return simCards;
  //  } else {
  //    //Request Phone Permission
  //  }
  // }
  // void printSimCardsData() async {
  //   print("phone info is start");
  //   try {
  //
  //     final List<SimDataModel> simData = await _simData.getSimData();
  //     print("sim data info is ${simData.first.countryCode}");
  //     print("sim data info is ${simData.first.phoneNumber}");
  //   } on PlatformException catch (e) {
  //     debugPrint("error! code: ${e.code} - message: ${e.message}");
  //   }
  // }

  void login() async {
    print("my device token is bro ++++++++++++++++++++++"
        " ${imeiNumber.value}");
    if (loginFormKey.currentState!.validate()) {
      Get.find<AuthService>().setFirstLoggedOrNot();
      loginFormKey.currentState!.save();
      await Get.find<FireBaseMessagingService>().setDeviceToken();
      Ui.customLoaderDialog();
      //351811075916820\
      print("here 22");
      AuthRepository()
          .userLogin(mobileNumber.value, password.value, imeiNumber.value)
          .then((resp) {
        print("resp is $resp");
        if (resp['result'] == 'success') {
          CustomerModel model = CustomerModel.fromJson(resp);
          Get.find<AuthService>().setUser(model);
          AuthRepository().sendDeviceToken(
              model.customerCode.toString(), deviceToken.value);
          print('deviceToken : ${deviceToken.value}');
          SharedPreff.to.prefss
              .setString("logindate", DateTime.now().toString());
          print("token resp is ${model.token}");
          Get.offAllNamed(Routes.ROOT);

          customerCheck(model.token, model.customerCode);
        } else {
          Get.back();
          Get.showSnackbar(
              Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
        }
      }).catchError((onError) {
        Get.back();
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: "Please check your mobile number and PIN".tr,
            title: 'Error'.tr));
      });
    }
  }


  void customerCheck(token, cusCode) async {
    print("resp is start");
      AuthRepository()
          .customerCheck(phoneName.value, phoneModel.value,
          Get.find<LocationService>().currentLocation['lat'].toString(), Get.find<LocationService>().currentLocation['lng'].toString(), token, cusCode)
          .then((resp) {
      print("resp is check $resp");
      }).catchError((onError) {
      });
  }

  // void printSimCardsData() async {
  //   try {
  //     SimData simData = await SimDataPlugin.getSimData();
  //     for (var s in simData.cards) {
  //       print('Serial number: ${s.serialNumber}');
  //       print('Serial number: ${s.subscriptionId}');
  //       print('Serial number: ${s.carrierName}');
  //     }
  //   } on PlatformException catch (e) {
  //     print("error! code: ${e.code} - message: ${e.message}");
  //   }
  // }

  // makeMyRequest() async {
  //   int subscriptionId = 2; // sim card subscription ID
  //   String code = "*2#"; // ussd code payload
  //   try {
  //     String ussdResponseMessage = await UssdService.makeRequest(
  //       subscriptionId,
  //       code,
  //       Duration(seconds: 10), // timeout (optional) - default is 10 seconds
  //     );
  //     print("succes! message: $ussdResponseMessage");
  //   } catch (e) {
  //     debugPrint("error! code: ${e} - message: ${e}");
  //   }
  // }

  // Future<void> sendUssdRequest() async {
  //   String _requestCode = "*2#";
  //   String _responseCode = "";
  //   String _responseMessage = "";
  //   try {
  //     String responseMessage;
  //     await Permission.phone.request();
  //     if (!await Permission.phone.isGranted) {
  //       throw Exception("permission missing");
  //     }

  //     SimData simData = await SimDataPlugin.getSimData();
  //     for (var s in simData.cards) {
  //       print('Serial number: ${s.serialNumber}');
  //       print('Serial number: ${s.subscriptionId}');
  //       print('Serial number: ${s.carrierName}');
  //       responseMessage =
  //           await UssdService.makeRequest(s.subscriptionId, '*2#');

  //       print('ussd: ${responseMessage}');
  //       _responseMessage = responseMessage;
  //     }
  //   } on PlatformException catch (e) {
  //     _responseCode = e is PlatformException ? e.code : "";
  //     _responseMessage = e.message ?? '';
  //   }
  // }
}
