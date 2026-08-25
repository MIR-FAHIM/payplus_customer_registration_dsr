import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
import 'package:latest_payplus_agent/app/services/nid_ocr_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

const int merchantRegisterLastStep = 5;

enum MerchantRegisterDocType {
  nidFront,
  nidBack,
  tradeLicense,
  userImage,

}

class MerchantRegisterController extends GetxController {
  final pageController = PageController();
  final nidFound = '0'.obs;
  final merchantCurrentStep = 0.obs;
  final isMerchantSubmitting = false.obs;
  final isFilePicking = false.obs;
  final isBusinessTypeLoading = false.obs;
  final isDistrictLoading = false.obs;
  final isThanaLoading = false.obs;
  final isNumberChecking = false.obs;
  final isOcrReading = false.obs;

  final registerErrorMsg = ''.obs;
  final ocrStatusMsg = ''.obs;
  final ocrRawText = ''.obs;
  final ocrAccuracy = 0.0.obs;
  final isClearImage = true.obs;

  final businessTypes = <BusinessTypeModel>[].obs;
  final districtsTypes = <DistrictModel>[].obs;
  final thanas = <ThanaModel>[].obs;

  final verifyFormKey = GlobalKey<FormState>();
  final nidInfoFormKey = GlobalKey<FormState>();
  final tradeLicenseFormKey = GlobalKey<FormState>();
  final addressFormKey = GlobalKey<FormState>();

  final mobileNoController = TextEditingController();
  final customerNameController = TextEditingController();
  final emailController = TextEditingController();
  final personalMobileController = TextEditingController();
  final nidController = TextEditingController();
  final dobController = TextEditingController();

  final tradeLicenseExpireDateController = TextEditingController();
  final tradeLicenseNumberController = TextEditingController();

  final outletNameController = TextEditingController();
  final outletAddressController = TextEditingController();
  final businessTypeController = TextEditingController();
  final districtIdController = TextEditingController();
  final thanaIdController = TextEditingController();
  final unionIdController = TextEditingController();
  final postCodeController = TextEditingController();
  final serviceFeeTypeController = TextEditingController();
  final passwordController = TextEditingController();

  final nidFrontBase64 = ''.obs;
  final userBase64 = ''.obs;
  final nidBackBase64 = ''.obs;
  final tradeLicenseBase64 = ''.obs;

  final nidFrontFileName = ''.obs;
  final userFileName = ''.obs;
  final nidBackFileName = ''.obs;
  final tradeLicenseFileName = ''.obs;

  final nidFrontFilePath = ''.obs;
  final nidBackFilePath = ''.obs;
  final tradeLicenseFilePath = ''.obs;
  final userFilePath = ''.obs;

  final businessTypeId = ''.obs;
  final districtId = ''.obs;
  final upozelaId = ''.obs;

  final isNumberExist = false.obs;
  final isEmailExist = false.obs;

  final selectedBusinessTypeName = ''.obs;
  final selectedDistrictName = ''.obs;
  final selectedThanaName = ''.obs;

  final NIDOcrService ocrService = NIDOcrService(
    clearThreshold: 0.55,
  );

  bool get hasNidFront => nidFrontBase64.value.trim().isNotEmpty;
  bool get hasUserFront => userBase64.value.trim().isNotEmpty;
  bool get hasNidBack => nidBackBase64.value.trim().isNotEmpty;
  bool get hasTradeLicense => tradeLicenseBase64.value.trim().isNotEmpty;

  @override
  void onInit() {
    super.onInit();

    _hydrateInitialArguments();
    getDistrictList();
    getBusinessType();
  }

  @override
  void onClose() {
    pageController.dispose();

    mobileNoController.dispose();
    customerNameController.dispose();
    emailController.dispose();
    personalMobileController.dispose();
    nidController.dispose();
    dobController.dispose();

    tradeLicenseExpireDateController.dispose();
    tradeLicenseNumberController.dispose();

    outletNameController.dispose();
    outletAddressController.dispose();
    businessTypeController.dispose();
    districtIdController.dispose();
    thanaIdController.dispose();
    unionIdController.dispose();
    postCodeController.dispose();
    serviceFeeTypeController.dispose();
    passwordController.dispose();

    super.onClose();
  }

  void _hydrateInitialArguments() {
    final args = Get.arguments;

    if (args is String) {
      mobileNoController.text = args.trim();
      personalMobileController.text = args.trim();
      return;
    }

    if (args is Map) {
      mobileNoController.text = args['mobile_no']?.toString().trim() ?? '';
      personalMobileController.text =
          args['personal_mobile']?.toString().trim() ?? '';
      customerNameController.text =
          args['customer_name']?.toString().trim() ?? '';
      emailController.text = args['email']?.toString().trim() ?? '';
    }
  }

  Future<void> nextStep() async {
    clearStepError();

    if (!validateCurrentStep()) return;

    if (merchantCurrentStep.value >= merchantRegisterLastStep) return;

    // Step 0 is the verification step:
    // Mobile No, Email, and Outlet Name must be verified before NID upload.
    if (merchantCurrentStep.value == 0) {
      await checkNumberAndEmailBeforeContinue();
      return;
    }
 if (merchantCurrentStep.value == 2) {
    bool data =  await duplicateNIDCheck();
    if(data == false){
      merchantCurrentStep.value++;
      _animateToStep();
    }
    return;
    }

    merchantCurrentStep.value++;
    _animateToStep();
  }

  void previousStep() {
    clearStepError();

    if (merchantCurrentStep.value > 0) {
      merchantCurrentStep.value--;
      _animateToStep();
      return;
    }

    Get.back();
  }

  void goToStep(int index) {
    if (index < 0 || index > merchantRegisterLastStep) return;

    merchantCurrentStep.value = index;
    _animateToStep();
  }

  void _animateToStep() {
    if (!pageController.hasClients) return;

    pageController.animateToPage(
      merchantCurrentStep.value,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  bool validateCurrentStep() {
    switch (merchantCurrentStep.value) {
      case 0:
        return verifyFormKey.currentState?.validate() ?? false;

      case 1:
        return _validateDocumentStep();

      case 2:
        return nidInfoFormKey.currentState?.validate() ?? false;

      case 3:
        final formValid = tradeLicenseFormKey.currentState?.validate() ?? false;
        final documentValid = _validateTradeLicenseDocument();
        return formValid && documentValid;

      case 4:
        final formValid = addressFormKey.currentState?.validate() ?? false;
        final selectionValid = _validateAddressSelections();
        return formValid && selectionValid;

      default:
        return true;
    }
  }

  bool validateAllBeforeSubmit() {
    for (int step = 0; step < merchantRegisterLastStep; step++) {
      merchantCurrentStep.value = step;
      _animateToStep();

      if (!validateCurrentStep()) {
        return false;
      }
    }

    merchantCurrentStep.value = merchantRegisterLastStep;
    _animateToStep();

    return true;
  }

  bool _validateDocumentStep() {
    if (!hasNidFront) {
      showStepError('Please upload NID front image.'.tr);
      return false;
    }

    if (!hasNidBack) {
      showStepError('Please upload NID back image.'.tr);
      return false;
    }

    // OCR is helpful only. It must not block the user from continuing.
    // If OCR fails, the user can continue and manually enter the NID number
    // on the next page.
    return true;
  }

  bool _validateTradeLicenseDocument() {
    if (!hasTradeLicense) {
      showStepError('Please upload trade license document.'.tr);
      return false;
    }

    return true;
  }

  bool _validateAddressSelections() {
    if (businessTypeId.value.trim().isEmpty) {
      showStepError('Please select business type.'.tr);
      return false;
    }

    if (districtId.value.trim().isEmpty) {
      showStepError('Please select district.'.tr);
      return false;
    }

    if (upozelaId.value.trim().isEmpty) {
      showStepError('Please select upazila.'.tr);
      return false;
    }

    return true;
  }

  void showStepError(String message) {
    registerErrorMsg.value = message;

    Get.snackbar(
      'Required'.tr,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  void clearStepError() {
    registerErrorMsg.value = '';
  }

  Future<void> getBusinessType() async {
    if (isBusinessTypeLoading.value) return;

    isBusinessTypeLoading.value = true;

    try {
      final response = await BusinessTypeRepository().getBusinessType();
      businessTypes.assignAll(response);
    } catch (e) {
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

      // Keep upazila blank after district change. User should select manually.
      upozelaId.value = '';
      selectedThanaName.value = '';
      thanaIdController.clear();

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
      thanas.clear();
      upozelaId.value = '';
      selectedThanaName.value = '';
      thanaIdController.clear();

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
      clearStepError();

      final selected = name?.trim() ?? '';

      if (selected.isEmpty) {
        selectedBusinessTypeName.value = '';
        businessTypeController.clear();
        businessTypeId.value = '';
        return;
      }

      final match = businessTypes.firstWhereOrNull(
            (item) => (item.type ?? '').trim() == selected,
      );

      if (match == null) {
        selectedBusinessTypeName.value = '';
        businessTypeController.clear();
        businessTypeId.value = '';
        return;
      }

      selectedBusinessTypeName.value = selected;
      businessTypeController.text = selected;
      businessTypeId.value = match.id?.toString().trim() ?? '';
    } catch (e) {
      selectedBusinessTypeName.value = '';
      businessTypeController.clear();
      businessTypeId.value = '';

      _showError(
        'Selection Error'.tr,
        'Could not select business type. Please try again.'.tr,
      );
    }
  }

  Future<void> selectDistrictByName(String? input) async {
    try {
      clearStepError();

      final selectedName = input?.trim() ?? '';

      if (selectedName.isEmpty) {
        districtId.value = '';
        selectedDistrictName.value = '';
        districtIdController.clear();

        upozelaId.value = '';
        selectedThanaName.value = '';
        thanaIdController.clear();
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

      final newDistrictId = selectedDistrict.id?.toString().trim() ?? '';

      if (newDistrictId.isEmpty) {
        _showError(
          'Selection Error'.tr,
          'District ID was not found. Please try again.'.tr,
        );
        return;
      }

      districtId.value = newDistrictId;
      selectedDistrictName.value = selectedDistrict.districtName?.trim() ?? '';
      districtIdController.text = newDistrictId;

      // Reset old upazila before loading new list.
      upozelaId.value = '';
      selectedThanaName.value = '';
      thanaIdController.clear();
      thanas.clear();

      await getThanaUpojila(newDistrictId);
    } catch (e) {
      _showError(
        'Selection Error'.tr,
        'Could not select district. Please try again.'.tr,
      );
    }
  }

  void selectThanaByName(String? input) {
    try {
      clearStepError();

      final selectedName = input?.trim() ?? '';

      if (selectedName.isEmpty) {
        upozelaId.value = '';
        selectedThanaName.value = '';
        thanaIdController.clear();
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

      upozelaId.value = selectedThana.id?.toString().trim() ?? '';
      selectedThanaName.value = selectedThana.upazilaName?.trim() ?? '';
      thanaIdController.text = selectedThana.id?.toString().trim() ?? '';
    } catch (e) {
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

  String? requiredNidValidator(String? value) {
    final text = value?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';

    if (text.isEmpty) {
      return 'NID number is required'.tr;
    }

    if (!(text.length == 10 || text.length == 13 || text.length == 17)) {
      return 'NID must be 10, 13, or 17 digits'.tr;
    }


    return null;
  }
  Future<bool> duplicateNIDCheck() async {

    final nid = nidController.value.text ?? '';
    if (nid.isEmpty) return true;
    try {
      final response = await AuthRepository().duplicateNIDCheck(nid, 'Merchant');
      nidFound.value = response['result'].toString();
      if (nidFound.value == '1') {
        registerErrorMsg.value = response['message']?.toString() ?? '';
        Get.showSnackbar(Ui.ErrorSnackBar(message: registerErrorMsg.value, title: 'Error'.tr));
        return true;
      }
      return false;
    } catch (_) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Could not verify NID'.tr, title: 'Error'.tr));
      return true;
    }
  }
  String? requiredDobValidator(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Date of birth is required'.tr;
    }

    if (_tryParseDate(text) == null) {
      return 'Date of birth must be yyyy-MM-dd'.tr;
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

  Future<void> checkNumberAndEmailBeforeContinue() async {
    if (isNumberChecking.value) return;

    final formValid = verifyFormKey.currentState?.validate() ?? false;
    if (!formValid) return;

    final mobile = mobileNoController.text.trim();
    final email = emailController.text.trim();
    final outletName = outletNameController.text.trim();

    if (mobile.isEmpty ||  outletName.isEmpty) {
      showStepError(
        'Please enter mobile number, email and outlet name.'.tr,
      );
      return;
    }

    isNumberChecking.value = true;

    try {
      final numberResponse = await NumberCheckRepository().checkNumberDuplicacyForRegister(
        mobile,
        'Merchant'
      );

      final numberResult = _readInt(
        numberResponse is Map ? numberResponse['result'] : null,
      );

      // result == 1 means number already exists, so merchant registration must stop.
      if (numberResult == 1) {
        isNumberExist.value = true;

        showStepError(
          'This mobile number already exists. Please enter a new number.'.tr,
        );
        return;
      }

      final emailResponse = await NumberCheckRepository().checkPgwEmail(email);

      final emailMessage = emailResponse is Map
          ? emailResponse['message']?.toString().trim() ?? ''
          : '';

      if (emailMessage.toLowerCase() == 'email already exists.') {
        isEmailExist.value = true;

        showStepError(
          'This email already exists. Please enter a new email.'.tr,
        );
        return;
      }

      isNumberExist.value = false;
      isEmailExist.value = false;

      merchantCurrentStep.value++;
      _animateToStep();
    } catch (e) {
      showStepError(
        'Could not verify mobile number and email. Please try again.'.tr,
      );
    } finally {
      isNumberChecking.value = false;
    }
  }

  int _readInt(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value;

    return int.tryParse(value.toString()) ?? 0;
  }

  Future<void> pickDob() async {
    final context = Get.context;
    if (context == null) return;

    final initialDate = _tryParseDate(dobController.text) ??
        DateTime(DateTime.now().year - 25, 1, 1);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1940, 1, 1),
      lastDate: DateTime.now(),
      helpText: 'Select Date of Birth'.tr,
    );

    if (picked == null) return;

    dobController.text = DateFormat('yyyy-MM-dd').format(picked);
  }

  Future<void> pickTradeLicenseExpiryYear() async {
    final now = DateTime.now();
    final june30ThisYear = DateTime(now.year, 6, 30, 23, 59, 59);
    final startYear = now.isAfter(june30ThisYear) ? now.year + 1 : now.year;
    final selectedYear = _selectedTradeLicenseYear();

    final pickedYear = await Get.bottomSheet<int>(
      Container(
        height: Get.height * 0.55,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Select Expiry Year'.tr,
                    style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.4,
                ),
                itemBuilder: (context, index) {
                  final year = startYear + index;
                  final isSelected = selectedYear == year;

                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Get.back(result: year),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Text(
                        year.toString(),
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );

    if (pickedYear == null) return;

    tradeLicenseExpireDateController.text = '$pickedYear-06-30';
  }

  int? _selectedTradeLicenseYear() {
    final text = tradeLicenseExpireDateController.text.trim();

    if (text.length < 4) return null;

    return int.tryParse(text.substring(0, 4));
  }

  Future<void> showDocumentPickerSheet(MerchantRegisterDocType type) async {
    if (isFilePicking.value) return;

    await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Wrap(
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: Text('Camera'.tr),
                onTap: () {
                  Get.back();
                  pickImage(type, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text('Gallery'.tr),
                onTap: () {
                  Get.back();
                  pickImage(type, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_file_rounded),
                title: Text('Choose File'.tr),
                subtitle: Text(
                  'JPG, PNG or PDF'.tr,
                ),
                onTap: () {
                  Get.back();
                  pickFile(type);
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> pickImage(
      MerchantRegisterDocType type,
      ImageSource source,
      ) async {
    if (isFilePicking.value) return;

    isFilePicking.value = true;

    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(
        source: source,
        imageQuality: 78,
        maxWidth: 1600,
      );

      if (file == null) return;

      final bytes = await File(file.path).readAsBytes();

      await _processSelectedDocument(
        type: type,
        base64Value: base64Encode(bytes),
        fileName: file.name,
        filePath: file.path,
      );
    } catch (e) {
      _showError(
        'File selection failed'.tr,
        'Please select a clear image and try again.'.tr,
      );
    } finally {
      isFilePicking.value = false;
    }
  }

  Future<void> pickFile(MerchantRegisterDocType type) async {
    if (isFilePicking.value) return;

    isFilePicking.value = true;

    try {
      final allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf'];

      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result == null || result.files.isEmpty) return;

      final picked = result.files.first;
      final path = picked.path;

      if (path == null || path.trim().isEmpty) {
        _showError(
          'Invalid file'.tr,
          'Could not read the selected file path.'.tr,
        );
        return;
      }

      final bytes = await File(path).readAsBytes();

      await _processSelectedDocument(
        type: type,
        base64Value: base64Encode(bytes),
        fileName: picked.name,
        filePath: path,
      );
    } catch (e) {
      _showError(
        'File selection failed'.tr,
        'Please select a valid file and try again.'.tr,
      );
    } finally {
      isFilePicking.value = false;
    }
  }

  Future<void> _processSelectedDocument({
    required MerchantRegisterDocType type,
    required String base64Value,
    required String fileName,
    required String filePath,
  }) async {
    _assignDocument(
      type: type,
      base64Value: base64Value,
      fileName: fileName,
      filePath: filePath,
    );

    if (type == MerchantRegisterDocType.nidFront) {
      if (_isImageFile(fileName)) {
        await readNidFrontImage(filePath);
      } else {
        // Non-image NID front files are accepted for upload, but OCR will not run.
        isClearImage.value = true;
        ocrStatusMsg.value =
            'OCR auto-read works only for JPG or PNG. You can continue and enter NID manually.'
                .tr;
      }
    }
  }

  void _assignDocument({
    required MerchantRegisterDocType type,
    required String base64Value,
    required String fileName,
    required String filePath,
  }) {
    clearStepError();

    switch (type) {
      case MerchantRegisterDocType.nidFront:
        nidFrontBase64.value = base64Value;
        nidFrontFileName.value = fileName;
        nidFrontFilePath.value = filePath;
        break;

      case MerchantRegisterDocType.nidBack:
        nidBackBase64.value = base64Value;
        nidBackFileName.value = fileName;
        nidBackFilePath.value = filePath;
        break;

      case MerchantRegisterDocType.tradeLicense:
        tradeLicenseBase64.value = base64Value;
        tradeLicenseFileName.value = fileName;
        tradeLicenseFilePath.value = filePath;
        break;

        case MerchantRegisterDocType.userImage:
        userBase64.value = base64Value;
        userFileName.value = fileName;
        userFilePath.value = filePath;
        break;
    }
  }

  Future<void> readNidFrontImage(String filePath) async {
    if (filePath.trim().isEmpty) return;

    isOcrReading.value = true;
    registerErrorMsg.value = '';
    ocrStatusMsg.value = 'Reading NID front image...'.tr;
    ocrRawText.value = '';
    ocrAccuracy.value = 0.0;

    // Do not make OCR status block navigation.
    isClearImage.value = true;

    try {
      final result = await ocrService.readAndParseNid(
        File(filePath),
        debugPrint: false,
      );

      final extractedNid = result.nid?.trim() ?? '';

      ocrRawText.value = result.fullText;
      ocrAccuracy.value = result.textAccuracy;

      if (extractedNid.isNotEmpty) {
        nidController.text = extractedNid;
        ocrStatusMsg.value =
            'NID number detected successfully. Please review it on the next page.'
                .tr;
        return;
      }

      // OCR could not detect NID, but user can still continue and type manually.
      ocrStatusMsg.value =
          'Could not auto-read NID number. You can continue and enter it manually.'
              .tr;
    } catch (e) {
      // OCR failure must not block registration.
      isClearImage.value = true;
      ocrStatusMsg.value =
          'Could not auto-read NID number. You can continue and enter it manually.'
              .tr;
    } finally {
      isOcrReading.value = false;
    }
  }

  DateTime? _tryParseDate(String value) {
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(value.trim());
    } catch (_) {
      return null;
    }
  }

  bool _isImageFile(String fileName) {
    final lower = fileName.toLowerCase();

    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png');
  }

  Map<String, dynamic> buildMerchantPayload() {
    final location = _safeLocation();

    return {
      'mobile_no': _text(mobileNoController),
      'customer_name': _text(customerNameController),
      'email': _text(emailController),
      'personal_mobile': _text(personalMobileController),
      'nid': _text(nidController),
      'dob': _text(dobController),
      'trade_license_expire_date': _text(tradeLicenseExpireDateController),
      'trade_license_number': _text(tradeLicenseNumberController),
      'outlet_name': _text(outletNameController),
      'outlet_address': _text(outletAddressController),
      'business_type': businessTypeId.value,
      'city_id': districtId.value,
      'zone_id': upozelaId.value,
      'area_id': upozelaId.value,
      'post_code': _text(postCodeController),
      'password': _text(passwordController),
      'customer_latitude': location['lat'] ?? '',
      'customer_longitude': location['lng'] ?? '',
      'imei': location['imei'] ?? '',
      'nid_front': nidFrontBase64.value,
      'nid_back': nidBackBase64.value,
      'trade_license': tradeLicenseBase64.value,
      'trade_license2': tradeLicenseBase64.value,
      'trade_license2': tradeLicenseBase64.value,
      'image': userBase64.value,
      'remark': 'Merchant',
    };
  }

  Future<void> submitMerchantRegistration() async {
    if (isMerchantSubmitting.value) return;

    clearStepError();

    //if (!validateAllBeforeSubmit()) return;

    isMerchantSubmitting.value = true;

    try {
      await _ensureLocation();

      final response = await _submitToApi(buildMerchantPayload());

      final result = response is Map
          ? response['result']?.toString().toLowerCase().trim()
          : null;

      final status = response is Map
          ? response['status']?.toString().toLowerCase().trim()
          : null;

      final message = response is Map
          ? (response['message']?.toString().trim().isNotEmpty == true
          ? response['message'].toString()
          : 'Merchant registration submitted')
          : 'Merchant registration submitted';

      final success = result == 'success' || status == 'success';

      if (!success) {
        _showError('Failed'.tr, message.tr);
        return;
      }

      Get.snackbar(
        'Success'.tr,
        message.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );

      if (Get.isRegistered<HomeController>()) {
        await Get.find<HomeController>().getAgentList();
      }

      Get.offAndToNamed(Routes.ROOT);
    } catch (e) {
      _showError(
        'Error'.tr,
        'Merchant registration failed. Please try again.'.tr,
      );
    } finally {
      isMerchantSubmitting.value = false;
    }
  }

  Future<dynamic> _submitToApi(Map<String, dynamic> dataMap) async {
    Get.focusScope?.unfocus();
    return AuthRepository().newUserRegistration(dataMap);
  }

  Future<void> _ensureLocation() async {
    try {
      if (!Get.isRegistered<LocationService>()) return;

      final locationService = Get.find<LocationService>();

      if (locationService.currentLocation['lat'] == null) {
        await locationService.determinePosition();
      }
    } catch (_) {}
  }

  Map<String, String> _safeLocation() {
    try {
      if (!Get.isRegistered<LocationService>()) {
        return {'imei': '', 'lat': '', 'lng': ''};
      }

      final locationService = Get.find<LocationService>();

      return {
        'imei': locationService.imei.value.toString(),
        'lat': locationService.currentLocation['lat']?.toString() ?? '',
        'lng': locationService.currentLocation['lng']?.toString() ?? '',
      };
    } catch (_) {
      return {'imei': '', 'lat': '', 'lng': ''};
    }
  }

  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  String _text(TextEditingController controller) {
    return controller.text.trim();
  }
}
