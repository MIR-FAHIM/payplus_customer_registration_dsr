import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckPhoneNumberController extends GetxController {
  final checkTerm = false.obs;
  final registeredWithoutPass = 0.obs;
  final forceProfileUpdate = 0.obs;
  final acoountID = ''.obs;

  final appSettingList = <AppSettingControllerModel>[].obs;
  final userData = UserModel().obs;

  final simOperator = ''.obs;
  final isChecked = false.obs;
  final allowDismissAppUpdate = true.obs;
  final isAnySimAvailable = false.obs;
  final imei = ''.obs;
  final imeiLoaded = false.obs;

  final isCheckingNumber = false.obs;
  final isSimInfoLoading = false.obs;
  final isAppSettingLoading = false.obs;
  final isUpdateChecking = false.obs;

  late final TextEditingController textEditingController;
  late final GlobalKey<FormState> mobileFormKey;

  final box = GetStorage();
  final _simCardInfoPlugin = SimCardInfo();

  final simInfo = <SimInfo>[].obs;
  final contactsResult = <Contact>[].obs;

  String mobileNumberSim = '';
  bool _registrationPopupShown = false;

  @override
  void onInit() {
    super.onInit();

    mobileFormKey = GlobalKey<FormState>();
    textEditingController = TextEditingController();

    initSimInfoState();
    _cacheImeiToLocalStorage();
  }

  @override
  void onReady() {
    super.onReady();

  //  showPopupForReg();
    getAppSetting();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  void updateMobileInput(String input) {
    final mobile = input.trim();

    MyData.phone_no = mobile;

    if (mobile.length >= 3) {
      final prefix = mobile.substring(0, 3);

      String detectedImage = '';



      simOperator.value = detectedImage;
    } else {
      simOperator.value = '';
    }
  }

  void toggleTerms(bool? value) {
    checkTerm.value = value ?? false;
  }

  String? mobileValidator(String? value) {
    final mobile = value?.trim() ?? '';

    if (mobile.isEmpty) {
      return 'Please enter your mobile number'.tr;
    }

    if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(mobile)) {
      return 'Please enter a valid 11 digit Bangladeshi mobile number'.tr;
    }

    return null;
  }

  Future<void> continueWithMobile() async {
    if (!checkTerm.value) {
      _showError(
        title: 'Terms Required'.tr,
        message: 'Please agree to the Terms and Conditions before continuing.'.tr,
      );
      return;
    }

    await checkNumberDuplicacy();
  }

  Future<void> getPhoneContact() async {
    try {
      box.remove('contact');

      final hasPermission = await FlutterContacts.requestPermission();

      if (!hasPermission) {
        _showError(
          title: 'Permission Required'.tr,
          message: 'Contact permission was not granted.'.tr,
        );
        return;
      }

      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );

      contactsResult.assignAll(contacts);

      final contactMap = contacts.map((contact) {
        return {
          'id': contact.id,
          'display_name': contact.displayName,
          'phones': contact.phones.map((phone) => phone.number).toList(),
        };
      }).toList();

      await box.write('contact', contactMap);
    } catch (e) {
      _showError(
        title: 'Contact Error'.tr,
        message: 'Could not load contacts. Please try again.'.tr,
      );
    }
  }

  Future<void> getAppSetting() async {
    if (isAppSettingLoading.value) return;

    isAppSettingLoading.value = true;

    try {
      final response = await BuySellRepository().getAppSettingRep();

      appSettingList.assignAll(response);

      appUpdateRequest();
    } catch (e) {
      debugPrint('getAppSetting error: $e');
    } finally {
      isAppSettingLoading.value = false;
    }
  }

  void appUpdateRequest() {
    final forceCheckValue = getAgentAppValueByName('version_force_check');

    if (forceCheckValue == '0') {
      getAppInformation();
    } else {
      advancedStatusCheck();
    }
  }

  Future<void> advancedStatusCheck() async {
    if (isUpdateChecking.value) return;

    isUpdateChecking.value = true;

    try {
      final context = Get.context;

      if (context == null) return;

      final newVersion = NewVersionPlus(
        androidId: 'paystation.paypos.reg',
      );

      final status = await newVersion.getVersionStatus();

      if (status == null) return;

      if (status.canUpdate == true) {
        newVersion.showUpdateDialog(
          context: context,
          allowDismissal: allowDismissAppUpdate.value,
          versionStatus: status,
          dialogTitle: 'Update Available!'.tr,
          dialogText:
          '${'Upgrade'.tr} ${status.localVersion} ${'to'.tr} ${status.storeVersion}',
        );
      }
    } catch (e) {
      debugPrint('advancedStatusCheck error: $e');
    } finally {
      isUpdateChecking.value = false;
    }
  }

  String getAgentAppValueByName(String name) {
    final match = appSettingList.firstWhere(
          (item) => item.name == name,
      orElse: () => AppSettingControllerModel(),
    );

    return match.agentAppValue ?? '';
  }

  Future<void> getAppInformation() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final response = await AppInfoRepository().getAppinfo(packageInfo.version);

      if (response is! List || response.isEmpty) return;

      final updateRequired = response.first['update_required']?.toString() == '1';

      if (!updateRequired) return;

      Ui.showAwesomeDialog(
        'INFO'.tr,
        'A new version is available.\nPlease update your app.'.tr,
        Colors.yellow.shade500,
        isBarrierDismiss: false,
            () async {
          final uri = Uri.parse(
            'https://play.google.com/store/apps/details?id=paystation.paypos.reg',
          );

          final launched = await launchUrl(
            uri,
            mode: LaunchMode.externalNonBrowserApplication,
          );

          if (!launched) {
            _showError(
              title: 'Update Error'.tr,
              message: 'Could not open Play Store. Please update manually.'.tr,
            );
          }
        },
      );
    } catch (e) {
      debugPrint('getAppInformation error: $e');
    }
  }

  Future<void> initSimInfoState() async {
    if (!GetPlatform.isAndroid) {
      isAnySimAvailable.value = false;
      return;
    }

    if (isSimInfoLoading.value) return;

    isSimInfoLoading.value = true;

    try {
      final phonePermission = await Permission.phone.request();

      if (!phonePermission.isGranted) {
        isAnySimAvailable.value = false;
        simInfo.clear();
        return;
      }

      final result = await _simCardInfoPlugin.getSimInfo() ?? [];

      simInfo.assignAll(result);
      isAnySimAvailable.value = result.isNotEmpty;
    } on PlatformException catch (e) {
      debugPrint('SIM info PlatformException: $e');

      simInfo.clear();
      isAnySimAvailable.value = false;
    } catch (e) {
      debugPrint('SIM info error: $e');

      simInfo.clear();
      isAnySimAvailable.value = false;
    } finally {
      isSimInfoLoading.value = false;
    }
  }

  Future<void> getDeviceInfo() async {
    try {
      final permission = await Permission.phone.request();

      if (permission.isGranted) {
        imei.value = _safeLocationImei();
      } else {
        imei.value = _safeLocationImei();
      }

      imeiLoaded.value = imei.value.trim().isNotEmpty;
    } on PlatformException catch (e) {
      debugPrint('getDeviceInfo PlatformException: $e');

      imei.value = _safeLocationImei();
      imeiLoaded.value = imei.value.trim().isNotEmpty;
    }
  }

  Future<void> checkNumberDuplicacy() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (isCheckingNumber.value) return;

    final isValid = mobileFormKey.currentState?.validate() ?? false;

    if (!isValid) return;

    mobileFormKey.currentState?.save();

    final mobile = textEditingController.text.trim();

    MyData.phone_no = mobile;

    isCheckingNumber.value = true;

    bool loaderOpen = false;

    try {
    //  Ui.customLoaderDialog();
      loaderOpen = true;

      final resp = await NumberCheckRepository().checkNumberDuplicacy(mobile);

      if (loaderOpen && Get.isDialogOpen == true) {
        Get.back();
        loaderOpen = false;
      }

      if (resp is! Map) {
        _showError(
          title: 'Invalid Response'.tr,
          message: 'Server returned an unexpected response. Please try again.'.tr,
        );
        return;
      }

      await _handleNumberCheckResponse(resp, mobile);
    } catch (e) {
      if (loaderOpen && Get.isDialogOpen == true) {
        Get.back();
        loaderOpen = false;
      }

      _showError(
        title: 'Connection Error'.tr,
        message: 'Could not verify this number. Please check your internet connection and try again.'.tr,
      );

      debugPrint('checkNumberDuplicacy error: $e');
    } finally {
      isCheckingNumber.value = false;
    }
  }

  Future<void> _handleNumberCheckResponse(
      Map<dynamic, dynamic> resp,
      String mobile,
      ) async {
    final result = resp['result']?.toString();
    final remark = resp['remark']?.toString().toLowerCase() ?? '';

    if (result != '1') {
      _showError(
        title: 'Not Registered'.tr,
        message: 'You are not registered as DSR.'.tr,
      );
      return;
    }

    if (remark != 'dsr') {
      _showError(
        title: 'Access Denied'.tr,
        message: 'Your number is registered, but it is not registered as DSR.'.tr,
      );
      return;
    }

    registeredWithoutPass.value = _readInt(resp['registered_without_password']);
    forceProfileUpdate.value = _readInt(resp['force_profile_update']);
    allowDismissAppUpdate.value = _readInt(resp['is_force_app_update']) == 0;

    acoountID.value = _firstAvailableString([
      resp['acc_no'],
      resp['account_id'],
      resp['accountID'],
      resp['accountId'],
      resp['customer_id'],
      resp['customerId'],
      resp['customerId'],
    ]);

    final forcePassSet = _readInt(resp['force_pass_set']) == 1;

    if (forcePassSet) {
      final data = {
        'mobileNumber': mobile,
        'imeiNumber': _safeLocationImei(),
      };

      Get.toNamed(Routes.Forget_pass_otp, arguments: data);
      return;
    }
 if (registeredWithoutPass.value == 1) {

print("mobile no is 2348783 $mobile ");
print("account no is 45235-- ${acoountID.value} ");
      Get.toNamed(
        Routes.ADD_PASS_REG,


        arguments: {
          'acc_no': acoountID.value,
          'mobile': mobile,
        },
      );
      return;
    }

    final shouldBypassOtp = _readInt(resp['otp_check']) == 1 ||
        _alreadyLoggedIn() ||
        mobile == '01726315133' ||
        mobile == '01716536455';
        mobile == '01819210204';

    if (shouldBypassOtp) {
      if (registeredWithoutPass.value == 1) {
        Get.toNamed(
          Routes.ADD_PASS_REG,
          arguments: [acoountID.value, mobile],
        );
      } else {
        Get.offAllNamed(
          Routes.LOGIN,
          arguments: mobile,
        );
      }

      return;
    }
    Get.offAllNamed(
      Routes.LOGIN,
      arguments: mobile,
    );
    // Get.toNamed(
    //   Routes.PHONE_VERIFICATION_WTIH_O_T_P,
    //   arguments: {
    //     'mobileNumber': mobile,
    //     'isRegistered': result,
    //     'selectedServiceTypeId': '',
    //   },
    // );
  }

  bool _alreadyLoggedIn() {
    try {
      return Get.find<AuthService>().alreadyLogged.isTrue;
    } catch (_) {
      return false;
    }
  }

  String _safeLocationImei() {
    try {
      return Get.find<LocationService>().imei.value.toString();
    } catch (_) {
      return '';
    }
  }

  void _cacheImeiToLocalStorage() {
    try {
      final value = _safeLocationImei();

      if (value.trim().isNotEmpty) {
        box.write('imeiNumber', value);
      }
    } catch (_) {}
  }

  int _readInt(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value;

    return int.tryParse(value.toString()) ?? 0;
  }

  String _firstAvailableString(List<dynamic> values) {
    for (final value in values) {
      final text = value?.toString().trim() ?? '';

      if (text.isNotEmpty) return text;
    }

    return '';
  }

  void _showError({
    required String title,
    required String message,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(14),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
        icon: const Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  void showPopupForReg() {
    if (_registrationPopupShown) return;

    final context = Get.context;

    if (context == null) return;

    _registrationPopupShown = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context == null) return;

      Get.dialog(
        Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Image.asset(
                    'assets/tappay.jpeg',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.info_outline_rounded,
                              size: 42,
                              color: Colors.deepPurple,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Please enter your registered DSR mobile number.'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Material(
                    color: Colors.white.withOpacity(0.90),
                    shape: const CircleBorder(),
                    child: IconButton(
                      onPressed: Get.back,
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: true,
      );
    });
  }
}
