import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/models/app_setting_controller_model.dart';
import 'package:latest_payplus_agent/app/models/user_model.dart';
import 'package:latest_payplus_agent/app/repositories/appinfor_repo.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/app/repositories/number_check_repositories.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/common/data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckPhoneNumberController extends GetxController {
  //TODO: Implement CheckPhoneNumberController
  final checkTerm = false.obs;
  final registeredWithoutPass = 0.obs;
  final forceProfileUpdate = 0.obs;
  final acoountID = "".obs;
  final appSettingList = <AppSettingControllerModel>[].obs;
  late TextEditingController textEditingController;
  final simOperator = ''.obs;
  late GlobalKey<FormState> mobileFormKey;
  final userData = UserModel().obs;
  final isChecked = false.obs;
  final allowDismissAppUpdate = true.obs;
  final isAnySimAvailable = false.obs;
  final imei = ''.obs;
  String mobileNumberSim = '';
  final _simCardInfoPlugin = SimCardInfo();
  final simInfo = <SimInfo>[].obs;
  final imeiLoaded = false.obs;
  final box = GetStorage().obs;
  final contactsResult = <Contact>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();

    mobileFormKey = GlobalKey<FormState>();
    textEditingController = TextEditingController();

    //   getPhoneContact();
  }

  @override
  void onReady() {
    super.onReady();
    showPopupForReg();
  }

  getPhoneContact() async {
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

  getAppSetting() async {
    print("app setting is   ++++++++++");

    BuySellRepository().getAppSettingRep().then((response) {
      appSettingList.value = response;
      print("app setting res length is 1234 ${appSettingList.value.length}");
      appUpdateRequest();
      print("app setting res length is 45678 ${appSettingList.value.length}");
    });
  }

  appUpdateRequest() {
    if (getAgentAppValueByName("version_force_check") == "0") {
      print("i am 8933");
      getAppInformation();
    } else {
      print("i am 4545");
      advancedStatusCheck();
    }
  }

  advancedStatusCheck() async {
    print("hle broooooo");
//09613828482
    final newVersion = NewVersionPlus(
      //iOSId: 'com.google.Vespa',
      androidId: 'paystation.com.bd',
    );
    var status = await newVersion.getVersionStatus();
    print("version status ${status!.appStoreLink}");
    print(
        "version update ${status.canUpdate}, local version is ${status.localVersion}");
    if (status.canUpdate == true) {
      print("update av");
      newVersion.showUpdateDialog(
        // launchMode: LaunchMode.externalApplication,
        context: Get.context!,
        allowDismissal: allowDismissAppUpdate.value,
        versionStatus: status,
        dialogTitle: 'Update Available!',
        dialogText: 'Upgrade  ${status.localVersion} to ${status.storeVersion}',
      );
    }
  }

  String getAgentAppValueByName(String name) {
    final match = appSettingList.value.firstWhere(
      (item) => item.name == name,
      orElse: () => AppSettingControllerModel(), // or a default/empty model
    );
    return match.agentAppValue ?? '';
  }

  getAppInformation() async {
    print("calling App update forced ++++++++++++++");
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppInfoRepository().getAppinfo(packageInfo.version).then((response) async {
      print("working 111 ++++++++++++++");
      print("sponse from app update +++++++++++++ $response");
      if (response[0]['update_required'].toString() == '1') {
        Ui.showAwesomeDialog(
            'INFO',
            'A new version is available.\nPlease update your app.',
            Colors.yellow.shade500,
            isBarrierDismiss: false, () async {
          if (!await launchUrl(
            Uri.parse(
                'https://play.google.com/store/apps/details?id=paystation.com.bd'),
            mode: LaunchMode.externalNonBrowserApplication,
          )) {
            throw 'Could not launch ${Uri.parse('https://play.google.com/store/apps/details?id=paystation.com.bd')}';
          }
        });
      }
    }).catchError((onError) {
      print('error: $onError');

      throw (onError);
    });
  }

  Future<void> initSimInfoState() async {
    await Permission.phone.request();
    List<SimInfo>? simCardInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      simCardInfo = await _simCardInfoPlugin.getSimInfo() ?? [];
    } catch (e) {
      await Permission.phone.request();
      print("error is $e");
    }

    simInfo.value = simCardInfo!;
    print("sim info length ${simInfo!.length}");
    isAnySimAvailable.value = false; // simInfo.value.isNotEmpty;
  }

  Future<void> checkAndroidVersionAndExecute() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    if (androidInfo.version.sdkInt >= 34) {
      // Check if Android version is 14 or higher
      // Execute your function
    } else {
      // Optionally handle versions lower than Android 14
      print('Android version is lower than 14');
    }
  }

  getDeviceInfo() async {
    try {
      var status = Permission.phone;
      if (await Permission.phone.request().isGranted) {
        //print('imei: ${imei.value}');
        imei.value = '12345678';

        //print('imei: ${imei.value}');
      } else {
        Permission.phone.request();
        imei.value = '12345678';

        imei.update((val) {});

        //print('imei: ${imei.value}');
      }
    } on PlatformException catch (e) {
      // Permission.phone.request();
      print('Failed to get platform version: $e');
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  Future checkNumberDuplicacy() async {

    MyData.phone_no = textEditingController.text;

    // Validate phone number form
    if (!mobileFormKey.currentState!.validate()) return;

    mobileFormKey.currentState!.save();

    Ui.customLoaderDialog(); // Show loading dialog

    final resp = await NumberCheckRepository()
        .checkNumberDuplicacy(textEditingController.text);

    print("Result: ${resp['result']}");
    print("Message: ${resp['message']}");

    // If number already registered
    if (resp['result'] == 1) {
      registeredWithoutPass.value = resp['registered_without_password'];

      // Whether the app update popup can be dismissed
      allowDismissAppUpdate.value = resp['is_force_app_update'] == 0;

      Get.back(); // Close loader

      // If the user must force set password (no password exists)
      if (resp["force_pass_set"] == 1) {
        final data = {
          "mobileNumber": textEditingController.text,
          "imeiNumber": Get.find<LocationService>().imei.value,
        };
        Get.toNamed(Routes.Forget_pass_otp, arguments: data);
        return;
      }

      // OTP bypass logic
      final shouldBypassOtp = resp["otp_check"] == 0 ||
          Get.find<AuthService>().alreadyLogged.isTrue ||
          textEditingController.text == "01726315133" ||
          textEditingController.text == "01716536455";

      // If number is registered without password
      if (shouldBypassOtp) {
        if (registeredWithoutPass.value == 1) {
          Get.toNamed(
            Routes.ADD_PASS_REG,
            arguments: [acoountID.value, textEditingController.text],
          );
        } else {
          print("iam here1234");
          Get.offAllNamed(
            Routes.LOGIN,
            arguments: textEditingController.text,
          );
        }
        return;
      }

      // Normal OTP flow
      Get.toNamed(Routes.PHONE_VERIFICATION_WTIH_O_T_P, arguments: {
        'mobileNumber': textEditingController.text,
        'isRegistered': resp['result'].toString(),
        'selectedServiceTypeId': '',
      });
    } else {
      // New signup flow

      Get.toNamed(Routes.PHONE_VERIFICATION_WTIH_O_T_P, arguments: {
        'mobileNumber': textEditingController.text,
        'isRegistered': resp['result'].toString(),
        'selectedServiceTypeId': '',
      });
      // Get.offAllNamed(
      //   Routes.NEWSIGNUP,
      //   arguments: textEditingController.text,
      // );
    }
  }

  showPopupForReg() {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Stack(
              children: [
                Container(
                  // height: Get.size.width + 5,
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/number.jpeg',
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     // Image(
                  //     //   height: Get.size.width * 0.3,
                  //     //   width: Get.size.width * 0.35,
                  //     //   image: const AssetImage(
                  //     //     'assets/Logo.png',
                  //     //   ),
                  //     // ),
                  //
                  //     Image.asset(
                  //       'assets/number.jpeg',
                  //     ),
                  //
                  //     const SizedBox(
                  //       height: 10,
                  //     ),
                  //     // Padding(
                  //     //   padding: const EdgeInsets.symmetric(
                  //     //     horizontal: 25.0,
                  //     //     vertical: 10,
                  //     //   ),
                  //     //   child: BlockButtonWidget(
                  //     //     onPressed: () {
                  //     //       Get.back();
                  //     //     },
                  //     //     color: Get.theme.primaryColor,
                  //     //     radius: 30,
                  //     //     text: const Text(
                  //     //       'Okay',
                  //     //       style: TextStyle(
                  //     //         color: Colors.white,
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     // )
                  //   ],
                  // ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 35,
                      ),
                    )),
              ],
            )
            // actions: <Widget>[

            // ],
            );
      },
    );
  }
}
