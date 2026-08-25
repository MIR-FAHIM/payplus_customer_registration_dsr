import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/businessTypeModel.dart';
import 'package:latest_payplus_agent/app/models/district_model.dart';
import 'package:latest_payplus_agent/app/models/thana_model.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/repositories/auth_repositories.dart';
import 'package:latest_payplus_agent/app/repositories/business_type_repositoy.dart';
import 'package:latest_payplus_agent/app/repositories/division_districts_repositoy.dart';
import 'package:latest_payplus_agent/app/repositories/number_check_repositories.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class AgentRegisterController extends GetxController {
  final agentRegisterFormKey = GlobalKey<FormState>();

  final isAgentSubmitting = false.obs;
  final isNumberChecking = false.obs;
  final isBusinessTypeLoading = false.obs;
  final isDistrictLoading = false.obs;
  final isThanaLoading = false.obs;

  final businessTypes = <BusinessTypeModel>[].obs;
  final districtsTypes = <DistrictModel>[].obs;
  final thanas = <ThanaModel>[].obs;

  final personalPhoneController = TextEditingController();
  final emailController = TextEditingController();
  final customerNameController = TextEditingController();
  final outletNameController = TextEditingController();
  final outletAddressController = TextEditingController();
  final postCodeController = TextEditingController();

  final selectedBusinessTypeName = ''.obs;
  final selectedDistrictName = ''.obs;
  final selectedThanaName = ''.obs;

  final businessTypeId = ''.obs;
  final selectedCityId = ''.obs;
  final selectedZoneId = ''.obs;
  final selectedAreaId = ''.obs;

  @override
  void onInit() {
    super.onInit();

    _hydrateInitialArguments();
    getBusinessType();
    getDistrictList();
  }

  @override
  void onClose() {
    personalPhoneController.dispose();
    emailController.dispose();
    customerNameController.dispose();
    outletNameController.dispose();
    outletAddressController.dispose();
    postCodeController.dispose();

    super.onClose();
  }

  void _hydrateInitialArguments() {
    final args = Get.arguments;

    if (args is String) {
      personalPhoneController.text = args.trim();
      return;
    }

    if (args is Map) {
      personalPhoneController.text =
          args['mobile_no']?.toString().trim() ??
              args['mobileNumber']?.toString().trim() ??
              '';

      emailController.text = args['email']?.toString().trim() ?? '';

      customerNameController.text =
          args['customer_name']?.toString().trim() ??
              args['customerName']?.toString().trim() ??
              '';

      outletNameController.text =
          args['outlet_name']?.toString().trim() ??
              args['outletName']?.toString().trim() ??
              '';

      outletAddressController.text =
          args['outlet_address']?.toString().trim() ??
              args['address']?.toString().trim() ??
              '';

      postCodeController.text =
          args['post_code']?.toString().trim() ??
              args['postCode']?.toString().trim() ??
              '';
    }
  }

  Future<void> getBusinessType() async {
    if (isBusinessTypeLoading.value) return;

    isBusinessTypeLoading.value = true;

    try {
      final response = await BusinessTypeRepository().getBusinessType();
      businessTypes.assignAll(response);
    } catch (e) {
      debugPrint('getBusinessType error: $e');

      _showError(
        'Failed to load business types'.tr,
        'Please check your connection and try again.'.tr,
      );
    } finally {
      isBusinessTypeLoading.value = false;
    }
  }

  Future<void> getDistrictList() async {
    if (isDistrictLoading.value) return;

    isDistrictLoading.value = true;

    try {
      final response = await DivisionDistrictsRepository().getdistrictType();
      districtsTypes.assignAll(response);
    } catch (e) {
      debugPrint('getDistrictList error: $e');

      _showError(
        'Failed to load districts'.tr,
        'Please check your connection and try again.'.tr,
      );
    } finally {
      isDistrictLoading.value = false;
    }
  }

  Future<void> getThanaUpojila(dynamic id) async {
    final districtIdValue = id?.toString().trim() ?? '';

    if (districtIdValue.isEmpty) return;
    if (isThanaLoading.value) return;

    isThanaLoading.value = true;

    try {
      final response = await DivisionDistrictsRepository().getThana(
        districtIdValue,
      );

      thanas.assignAll(response);

      selectedZoneId.value = '';
      selectedAreaId.value = '';
      selectedThanaName.value = '';

      if (thanas.isEmpty) {
        Get.snackbar(
          'No Upazila Found'.tr,
          'No upazila found for the selected district.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 12,
        );
      }
    } catch (e) {
      debugPrint('getThanaUpojila error: $e');

      thanas.clear();
      selectedZoneId.value = '';
      selectedAreaId.value = '';
      selectedThanaName.value = '';

      _showError(
        'Could not load upazila list'.tr,
        'Please try again.'.tr,
      );
    } finally {
      isThanaLoading.value = false;
    }
  }

  void selectBusinessTypeByName(String? name) {
    try {
      final selected = name?.trim() ?? '';

      if (selected.isEmpty) {
        selectedBusinessTypeName.value = '';
        businessTypeId.value = '';
        return;
      }

      final match = businessTypes.firstWhereOrNull(
            (item) => (item.type ?? '').trim() == selected,
      );

      selectedBusinessTypeName.value = selected;
      businessTypeId.value = match?.id?.toString().trim() ?? '';
    } catch (e) {
      debugPrint('selectBusinessTypeByName error: $e');

      selectedBusinessTypeName.value = '';
      businessTypeId.value = '';

      _showError(
        'Selection Error'.tr,
        'Could not select business type. Please try again.'.tr,
      );
    }
  }

  Future<void> selectDistrictByName(String? input) async {
    try {
      final selectedName = input?.trim() ?? '';

      if (selectedName.isEmpty) {
        selectedCityId.value = '';
        selectedDistrictName.value = '';

        selectedZoneId.value = '';
        selectedAreaId.value = '';
        selectedThanaName.value = '';
        thanas.clear();
        return;
      }

      final selectedDistrict = districtsTypes.firstWhereOrNull(
            (item) => (item.districtName ?? '').trim() == selectedName,
      );

      if (selectedDistrict == null) {
        _showError(
          'Selection Error'.tr,
          'Selected district was not found. Please try again.'.tr,
        );
        return;
      }

      final districtId = selectedDistrict.id?.toString().trim() ?? '';

      if (districtId.isEmpty) {
        _showError(
          'Selection Error'.tr,
          'District ID was not found. Please try again.'.tr,
        );
        return;
      }

      selectedCityId.value = districtId;
      selectedDistrictName.value = selectedDistrict.districtName?.trim() ?? '';

      selectedZoneId.value = '';
      selectedAreaId.value = '';
      selectedThanaName.value = '';
      thanas.clear();

      await getThanaUpojila(districtId);
    } catch (e) {
      debugPrint('selectDistrictByName error: $e');

      _showError(
        'Selection Error'.tr,
        'Could not select district. Please try again.'.tr,
      );
    }
  }

  void selectThanaByName(String? input) {
    try {
      final selectedName = input?.trim() ?? '';

      if (selectedName.isEmpty) {
        selectedZoneId.value = '';
        selectedAreaId.value = '';
        selectedThanaName.value = '';
        return;
      }

      final selectedThana = thanas.firstWhereOrNull(
            (item) => (item.upazilaName ?? '').trim() == selectedName,
      );

      if (selectedThana == null) {
        _showError(
          'Selection Error'.tr,
          'Selected upazila was not found. Please try again.'.tr,
        );
        return;
      }

      final thanaId = selectedThana.id?.toString().trim() ?? '';

      selectedZoneId.value = thanaId;

      // If your API has a separate area selector, set selectedAreaId from there.
      // For now, Agent registration follows the Merchant payload style where
      // zone_id and area_id can use the same selected upazila ID.
      selectedAreaId.value = thanaId;

      selectedThanaName.value = selectedThana.upazilaName?.trim() ?? '';
    } catch (e) {
      debugPrint('selectThanaByName error: $e');

      _showError(
        'Selection Error'.tr,
        'Could not select upazila. Please try again.'.tr,
      );
    }
  }

  String? requiredTextValidator(String? value, String fieldName) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return '$fieldName ${'is required'.tr}';
    }

    return null;
  }

  String? requiredMobileValidator(String? value) {
    final text = value?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';

    if (text.isEmpty) {
      return 'Mobile number is required'.tr;
    }

    if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(text)) {
      return 'Enter a valid 11 digit Bangladeshi mobile number'.tr;
    }

    return null;
  }

  String? requiredEmailValidator(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Email is required'.tr;
    }

    if (!GetUtils.isEmail(text)) {
      return 'Enter a valid email address'.tr;
    }

    return null;
  }

  String? requiredPostCodeValidator(String? value) {
    final text = value?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';

    if (text.isEmpty) {
      return 'Post code is required'.tr;
    }

    if (text.length < 4) {
      return 'Enter a valid post code'.tr;
    }

    return null;
  }

  bool validateBeforeSubmit() {
    final formValid = agentRegisterFormKey.currentState?.validate() ?? false;

    if (!formValid) return false;

    if (selectedCityId.value.trim().isEmpty) {
      _showError(
        'Required'.tr,
        'Please select district/city.'.tr,
      );
      return false;
    }

    if (selectedZoneId.value.trim().isEmpty) {
      _showError(
        'Required'.tr,
        'Please select upazila/zone.'.tr,
      );
      return false;
    }

    return true;
  }

  Map<String, dynamic> buildAgentPayload() {
    final location = _safeLocation();

    final mobile = _text(personalPhoneController);
    final email = _text(emailController);
    final name = _text(customerNameController);
    final outletName = _text(outletNameController);
    final outletAddress = _text(outletAddressController);
    final postCode = _text(postCodeController);

    return {
      // Identity
      'mobile_no': mobile,
      'personal_mobile': mobile,
      'email': email,
      'customer_name': name,

      // Outlet/address
      'outlet_name': outletName,
      'outlet_address': outletAddress,
      'address': outletAddress,

      // Location hierarchy
      'business_type': businessTypeId.value,
      'city_id': selectedCityId.value,
      'zone_id': selectedZoneId.value,
      'area_id': selectedAreaId.value.trim().isNotEmpty
          ? selectedAreaId.value
          : selectedZoneId.value,
      'post_code': postCode,

      // Unused but kept API-compatible with Merchant registration payload
      'password': '',
      'nid': '',
      'dob': '',
      'nid_front': '',
      'nid_back': '',
      'trade_license': '',
      'trade_license2': '',
      'trade_license_number': '',
      'trade_license_expire_date': '',

      // Device/location
      'customer_latitude': location['lat'] ?? '',
      'customer_longitude': location['lng'] ?? '',
      'imei': location['imei'] ?? '',

      // Registration type
      'remark': 'Agent',
    };
  }

  Future<bool> _isNumberAvailableForAgent(String mobile) async {
    if (isNumberChecking.value) return false;

    isNumberChecking.value = true;

    try {
      final response = await NumberCheckRepository().checkNumberDuplicacy(
        mobile,

      );

      debugPrint('Agent number check response: $response');

      if (response is! Map) {
        _showError(
          'Verification Failed'.tr,
          'Invalid number check response. Please try again.'.tr,
        );
        return false;
      }

      final result = _readInt(response['result']);
      final message = response['message']?.toString().trim() ?? '';

      // result == 1 means the number is already registered.
      if (result == 1) {
        _showError(
          'Number Already Exists'.tr,
          message.isNotEmpty
              ? message
              : 'This mobile number is already registered. Please use another number.'
              .tr,
        );
        return false;
      }

      // result == 0 means the number is available for new Agent registration.
      if (result == 0) {
        return true;
      }

      _showError(
        'Verification Failed'.tr,
        'Could not verify this mobile number. Please try again.'.tr,
      );
      return false;
    } catch (e) {
      debugPrint('Agent number check error: $e');

      _showError(
        'Verification Failed'.tr,
        'Could not check this mobile number. Please try again.'.tr,
      );
      return false;
    } finally {
      isNumberChecking.value = false;
    }
  }

  Future<void> addAgentController() async {
    Get.focusScope?.unfocus();

    if (isAgentSubmitting.value || isNumberChecking.value) return;

//    if (!validateBeforeSubmit()) return;

    final mobile = _text(personalPhoneController);

    isAgentSubmitting.value = true;

    bool loaderOpen = false;

    try {
      Ui.customLoaderDialog();
      loaderOpen = true;

      final numberAvailable = await _isNumberAvailableForAgent(mobile);

      if (!numberAvailable) {

        loaderOpen = false;
        return;
      }

      await _ensureLocation();

      final data = buildAgentPayload();

      debugPrint('Agent registration payload: $data');

      final response = await AuthRepository().newUserRegistration(data);

      if (loaderOpen && Get.isDialogOpen == true) {
        Get.back();
        loaderOpen = false;
      }

      final result = response is Map
          ? response['result']?.toString().toLowerCase().trim()
          : '';

      final status = response is Map
          ? response['status']?.toString().toLowerCase().trim()
          : '';

      final message = response is Map
          ? response['message']?.toString().trim() ?? ''
          : '';

      final success = result == 'success' || status == 'success';

      if (!success) {
        Get.showSnackbar(
          Ui.ErrorSnackBar(
            title: 'Registration Failed'.tr,
            message: message.isNotEmpty
                ? message
                : 'Agent registration failed. Please try again.'.tr,
          ),
        );
        return;
      }

      Get.showSnackbar(
        Ui.SuccessSnackBar(
          title: 'Success'.tr,
          message: message.isNotEmpty
              ? message
              : 'Registration Successful'.tr,
        ),
      );

      if (Get.isRegistered<HomeController>()) {
        await Get.find<HomeController>().getAgentList();
      }

      Get.offAndToNamed(Routes.ROOT);
    } catch (e) {
      if (loaderOpen && Get.isDialogOpen == true) {
        Get.back();
        loaderOpen = false;
      }

      debugPrint('addAgentController error: $e');

      Get.showSnackbar(
        Ui.ErrorSnackBar(
          title: 'Error'.tr,
          message: 'Registration failed. Please try again.'.tr,
        ),
      );
    } finally {
      isAgentSubmitting.value = false;
    }
  }

  int _readInt(dynamic value) {
    if (value == null) return -1;

    if (value is int) return value;

    return int.tryParse(value.toString()) ?? -1;
  }

  Future<void> _ensureLocation() async {
    try {
      if (!Get.isRegistered<LocationService>()) return;

      final locationService = Get.find<LocationService>();

      if (locationService.imei.value.toString().trim().isEmpty) {
        try {
          await locationService.getDeviceInfo();
        } catch (_) {}
      }

      if (locationService.currentLocation['lat'] == null) {
        await locationService.determinePosition();
      }
    } catch (e) {
      debugPrint('_ensureLocation error: $e');
      // Location should not crash the registration form.
    }
  }

  Map<String, String> _safeLocation() {
    try {
      if (!Get.isRegistered<LocationService>()) {
        return {
          'imei': '',
          'lat': '',
          'lng': '',
        };
      }

      final locationService = Get.find<LocationService>();

      return {
        'imei': locationService.imei.value.toString(),
        'lat': locationService.currentLocation['lat']?.toString() ?? '',
        'lng': locationService.currentLocation['lng']?.toString() ?? '',
      };
    } catch (_) {
      return {
        'imei': '',
        'lat': '',
        'lng': '',
      };
    }
  }

  void _showError(String title, String message) {
    Get.showSnackbar(
      Ui.ErrorSnackBar(
        title: title,
        message: message,
      ),
    );
  }

  String _text(TextEditingController controller) {
    return controller.text.trim();
  }
}
