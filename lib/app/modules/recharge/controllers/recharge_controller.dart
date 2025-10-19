import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:latest_payplus_agent/app/models/special_offer_model.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/operator_wise/combo_offer_operator.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/operator_wise/data_offer_operator.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/operator_wise/minute_offer_operator.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/operator_wise/p_l_offer.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:latest_payplus_agent/app/models/cashback_offer_model.dart';
import 'package:latest_payplus_agent/app/models/operator_model.dart';
import 'package:latest_payplus_agent/app/models/package_model.dart';
import 'package:latest_payplus_agent/app/models/recharge/robiairtelmodel.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/amount_recharge_widget.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/bundle_widget.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/cash_back_widget.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/internet_packages_widget.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/minute_packages_widget.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/robiAirtelOfferList.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/special_rate_widget.dart';
import 'package:latest_payplus_agent/app/repositories/recharge_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/notificationlocal.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../../../../main.dart';
import '../../../services/auth_service.dart';

enum ContactsLoadState { idle, loading, loaded, empty, error }

class RechargeController extends GetxController {
  // -------------------- core reactive state --------------------
  final count = 1.obs;

  final rechargeClick = false.obs;
  final searchStart = false.obs;

  final rechargeNumber = ''.obs;
  final amount = ''.obs;
  final pinNumber = ''.obs;

  final simOperator = ''.obs;
  final specialSImNumber = ''.obs;
  final simOperatorLogo = ''.obs;

  final robiOfferAmount = ''.obs;
  final robiOfferCusComission = ''.obs;
  final robiOfferName = ''.obs;
  final robiOfferID = ''.obs;
  final specialOfferID = ''.obs;
  final robiOfferAdminComission = ''.obs;
  final robiOfferComission = ''.obs;
  final robiRechargeCom = ''.obs;
  final specialOptInKeyword = ''.obs;

  final number_type = 'Prepaid'.obs;

  final internetPackage = <PackageModel>[].obs;
  final internetLoaded = false.obs;
  final minutePackage = <PackageModel>[].obs;
  final minuteLoaded = false.obs;
  final specialRatePackage = <PackageModel>[].obs;
  final specialRateLoaded = false.obs;
  final bundlePackage = <PackageModel>[].obs;
  final bundleLoaded = false.obs;

  final amountOfferList = <PackageModel>[].obs;
  final robiAirtelOfferList = <Datumm>[].obs;
  final specialDataOfferList = <Combo>[].obs;
  final specialMinuteOfferList = <Combo>[].obs;
  final specialComboOfferList = <Combo>[].obs;
  final amountOfferListLoaded = true.obs;
  final selected = false.obs;
  final rechargeLoad = false.obs;
  final pinPage = false.obs;
  final prepaid = true.obs;

  final amountOffer = PackageModel().obs;
  final amountOfferFound = false.obs;

  final loading = false.obs;
  final operatorWiseOfferLoad = false.obs;
  final commission = ''.obs;

  final cashBackOffer = CashBackReportModel().obs;
  final cashBackPackageName = ''.obs;
  final cashBackValidaity = ''.obs;
  final cashBackAmount = ''.obs;
  final specialSessionContext = ''.obs;
  final specialCampaignID = ''.obs;
  final cashBackOfferLoaded = true.obs;

  final autoFocus = true.obs;

  final box = GetStorage().obs;

  // -------------------- UI controls --------------------
  final mobileNumberFocus = FocusNode().obs;
  final amountFocusFocus = FocusNode().obs;
  final pinFocusFocus = FocusNode().obs;

  final amountController = TextEditingController().obs;
  final rechargeNumberController = TextEditingController().obs;
  final simLogoController = TextEditingController().obs;
  final pinController = TextEditingController().obs;
  final searchController = TextEditingController().obs;

  final currentIndex = 0.obs;
  final currentIndexOfOperator = 0.obs;
  final keyboardText = ''.obs;
  final searchString = "".obs;
  final keyboardType = ''.obs;

  // -------------------- Contacts (robust) --------------------
  final contacts = <Contact>[].obs;            // master list (fully-fetched)
  final contactsResult = <Contact>[].obs;      // current source list (cache/device)
  final contactLoad = false.obs;               // kept for compatibility
  final contactListClicked = false.obs;               // kept for compatibility

  final contactsState = ContactsLoadState.idle.obs;
  final contactsError = ''.obs;

  Timer? _searchDebounce;

  // keep your UI pages
  final pages =  [
    AmountRechargeWidget(),
    CashBackPackageWidget(),
    InternetPackageWidget(),
    MinutePackageWidget(),
    BundlePackageWidget(),
    SpecialRatePackageWidget(),
    RobiAirtelPackageWidget(),
  ];

final offerPageOperator =  [
    DataOfferOperator(),
    ComboOfferOperator(),
  MinuteOfferOperator(),
  PLOffer(),

  ];

  // -------------------- lifecycle --------------------
  @override
  void onInit() {
    super.onInit();
    getCashBackOffer();
    cashBackAmount.value = '';

    // Debounce search text field -> filtered list
    searchController.value.addListener(() {
      _searchDebounce?.cancel();
      _searchDebounce = Timer(const Duration(milliseconds: 250), () {
        setSearchText(searchController.value.text);
      });
    });

    // Preload contacts (with cache+permission handling)
    loadContactsWithRetry();
  }

  @override
  void onClose() {
    // dispose safely
    try {
     // mobileNumberFocus.value.dispose();
     // amountFocusFocus.value.dispose();
     // pinFocusFocus.value.dispose();

     // amountController.value.dispose();
    //  rechargeNumberController.value.dispose();
     // simLogoController.value.dispose();
      //pinController.value.dispose();
     // searchController.value.dispose();
    } catch (_) {}

    _searchDebounce?.cancel();
    super.onClose();
  }

  // -------------------- navigation helpers --------------------
  Widget get currentPage => pages[currentIndex.value];
  void changePage(int page) => currentIndex.value = page;
  void increment() {
    if (count.value < 5) count.value++;
  }

  // -------------------- operator helpers --------------------
  getOperatorId(String code) {
    for (final element in operatorLogos) {
      if (element.name == code) {
        simOperator.value = element.id?.toString() ?? '';
        break;
      }
    }
    return simOperator.value;
  }

  void detectOperatorFromNumber(String raw) {
    final number = normalizeBdNumber(raw); // 01XXXXXXXXX
    if (number.length < 3) {
      simOperatorLogo.value = '';
      simOperator.value = '';
      return;
    }
    final prefix3 = number.substring(0, 3);
    for (final item in operators) {
      if ((item.name ?? '') == prefix3) {
        simOperatorLogo.value = item.logo ?? '';
        simOperator.value = '${item.id ?? ''}';
        return;
      }
    }
    simOperatorLogo.value = '';
    simOperator.value = '';
  }

  // -------------------- text keyboard --------------------
  void onKeyboardTap(String value) {
    keyboardText.value = keyboardText.value + value;
  }

  // -------------------- offers / API --------------------
  RobiAirtelOfferModel getRobiAir(resp) => RobiAirtelOfferModel.fromJson(resp);

  List<String?> extractNumbersFromString(String input) {
    final regExp = RegExp(r'\d+');

    return regExp.allMatches(input).map((m) => m.group(0)).toList();
  }

  Future<void> getRobiAndAirtelOfferList() async {

    pinPage.value = false;
    loading.value = true;

    amountFocusFocus.value.requestFocus();

    final operatorId = simOperator.value;
    try {
      final resp = await RechargeRepository()
          .getRobiAirtelOffer(operatorId, rechargeNumber.value);

      if (resp["result"] == "success") {
        operatorWiseOfferLoad.value = true;
        robiAirtelOfferList.value = getRobiAir(resp).data;
        amountOfferListLoaded.value = true;
        selected.value = true;
        Get.to( RobiAirtelPackageWidget());
      } else {
        operatorWiseOfferLoad.value = false;
        Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'No Offer Available'.tr, title: 'Error'.tr),
        );
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> getSpecialOfferList() async {

    loading.value = true;

    amountFocusFocus.value.requestFocus();

    final operatorId = simOperator.value;
    try {
      final resp = await RechargeRepository()
          .getSpecialOffer(operatorId, rechargeNumber.value);

      if (resp["status"] == "success") {
        operatorWiseOfferLoad.value = true;
        print('I am here 9999');
        SpecialOfferModel model = SpecialOfferModel.fromJson(resp);
        specialSessionContext.value = model.sessionContext!;
        print("special iffer length is ${model.data!.dataOffer!.length}");
        specialDataOfferList.value = model.data!.dataOffer!;
        specialMinuteOfferList.value = model.data!.minute!;
        specialComboOfferList.value = model.data!.combo!;


      } else {
        operatorWiseOfferLoad.value = false;
        loading.value = false;
        Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'No Offer Available'.tr, title: 'Error'.tr),
        );
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> getOfferList(String operatorId) async {
    amountFocusFocus.value.requestFocus();
    final resp = await RechargeRepository().getAmountOffer(operatorId);
    amountOfferList.value = resp;
    amountOfferListLoaded.value = true;
  }

  // -------------------- CONTACTS: robust loader + cache + refresh --------------------
  /// Normalize BD numbers to 11 digits: 01XXXXXXXXX (handles +880 / 880 / 01…)
  String normalizeBdNumber(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return '';

    if (digits.startsWith('880')) {
      final tail = digits.substring(3);
      return tail.startsWith('0') ? tail : '0$tail';
    }
    if (digits.startsWith('01') && digits.length >= 11) {
      return digits.substring(0, 11);
    }
    if (digits.length == 11 && digits.startsWith('01')) {
      return digits;
    }
    // fallback: last 11 digits if present
    return digits.length >= 11 ? digits.substring(digits.length - 11) : digits;
  }

  /// For quick peeks
  String firstDigits(String raw, int n) {
    final d = raw.replaceAll(RegExp(r'\D'), '');
    return d.length >= n ? d.substring(0, n) : d;
  }

  /// PUBLIC: used by UI; sets search string and filters list
  void setSearchText(String text) {
    searchString.value = text;
    _applyFilter();
  }

  /// PUBLIC: original function name retained. Loads from device and caches.
  Future<void> getPhoneContact() async {
    contactLoad.value = true;
    contactsState.value = ContactsLoadState.loading;
    contactsError.value = '';
    try {
      // Always refresh from device and rewrite cache
      final hasPerm = await FlutterContacts.requestPermission();
      if (!hasPerm) throw 'Contacts permission denied';

      // fully fetched
      final list = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );

      contacts.assignAll(list);
      contactsResult.assignAll(list);

      // write lightweight cache
      final serialized = list.map((c) => c.toJson()).toList();
      await box.value.write('contactbook', serialized);

      contactsState.value = list.isEmpty
          ? ContactsLoadState.empty
          : ContactsLoadState.loaded;
    } catch (e) {
      contactsError.value = e.toString();
      contactsState.value = ContactsLoadState.error;
    } finally {
      contactLoad.value = true;
      _applyFilter();
    }
  }

  /// PUBLIC: original function name retained. Loads from cache if present.
  void getStoredData() {
    contactLoad.value = true;
    contactsResult.clear();
    try {
      final raw = box.value.read('contactbook');
      if (raw is List) {
        final mapped = raw.map((e) => Contact.fromJson(Map<String, dynamic>.from(e))).toList();
        contactsResult.assignAll(mapped);
        // also keep master in sync if empty (first boot)
        if (contacts.isEmpty) contacts.assignAll(mapped);
        contactsState.value = mapped.isEmpty
            ? ContactsLoadState.empty
            : ContactsLoadState.loaded;
      } else {
        contactsState.value = ContactsLoadState.empty;
      }
    } catch (e) {
      contactsError.value = e.toString();
      contactsState.value = ContactsLoadState.error;
    } finally {
      _applyFilter();
    }
  }

  /// NEW: unified entry that prefers cache, then device; shows states and errors
  Future<void> loadContactsWithRetry() async {
    contactLoad.value = true;
    contactsError.value = '';
    contactsState.value = ContactsLoadState.loading;

    try {
      if (box.value.hasData('contactbook') == true) {
        getStoredData();
        // also kick a silent refresh from device in background
        unawaited(_silentRefreshFromDevice());
      } else {
        await getPhoneContact();
      }
    } catch (e) {
      contactsError.value = e.toString();
      contactsState.value = ContactsLoadState.error;
    } finally {
      contactLoad.value = false;
    }
  }

  /// Pull-to-refresh: forces device re-fetch and overwrites cache
  Future<void> refreshContacts() async {
    await box.value.remove('contactbook');
    await getPhoneContact();
  }

  Future<void> _silentRefreshFromDevice() async {
    try {
      final status = await Permission.contacts.request();
      if (!status.isGranted) return;
      final list = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );
      if (list.isNotEmpty) {
        contacts.assignAll(list);
        contactsResult.assignAll(list);
        await box.value.write('contactbook', list.map((c) => c.toJson()).toList());
        if (contactsState.value != ContactsLoadState.loaded) {
          contactsState.value = ContactsLoadState.loaded;
        }
        _applyFilter();
      }
    } catch (_) {
      // silent
    }
  }

  void _applyFilter() {
    final q = searchString.value.trim().toLowerCase();
    if (q.isEmpty) {
      // contactsResult already reflects current source list
      return;
    }
    // in-place filtering view: keep contactsResult as source; UI uses filtered getter
  }

  /// Backward-compatible getter used by your UI (no .value needed)
  List<Contact> get filteredContacts {
    final q = searchString.value.trim().toLowerCase();
    final src = contactsResult.toList();
    if (q.isEmpty) return src;

    final isNumeric = RegExp(r'^\d+$').hasMatch(q);
    return src.where((c) {
      final name = (c.displayName).toLowerCase();
      final phone = c.phones.isEmpty ? '' : (c.phones.first.number ?? '');
      if (isNumeric) {
        final norm = normalizeBdNumber(phone);
        return norm.contains(q) || phone.replaceAll(RegExp(r'\D'), '').contains(q);
      }
      return name.contains(q);
    }).toList();
  }

  // -------------------- amount helpers --------------------
  void amountCheck() {
    amountOfferFound.value = false;
    amountOffer.value = PackageModel();
    final target = amountController.value.text;
    for (final item in amountOfferList) {
      if ((item.offerAmount ?? '').toString() == target) {
        amountOfferFound.value = true;
        amountOffer.value = item;
        break;
      }
    }
  }

  // -------------------- cashback --------------------
  Future<void> getCashBackOffer() async {
    final operatorId = simOperator.value;
    cashBackOfferLoaded.value = false;
    try {
      final resp = await RechargeRepository().getCashBackOffer(operatorId);
      cashBackOffer.value = resp;
    } finally {
      cashBackOfferLoaded.value = true;
    }
  }

  // -------------------- recharge flows --------------------
  Future<void> rechargeRobiAirtelOffer() async {
    rechargeLoad.value = true;

    try {
      final resp = await RechargeRepository().rechargeRobiAirtel(
        amount: amount.value,
        operatorId: simOperator.value,
        number: rechargeNumber.value,
        pin: pinController.value.text,
        adminCom: robiOfferAdminComission.value,
        cusCom: robiOfferCusComission.value,
        com: robiOfferComission.value,
        packageId: robiOfferID.value,
        rechargeCom: robiRechargeCom.value,
      );

      if (resp['result'] == 'success') {
        Get.find<InboxController>().changeNotiStatus(Get.find<InboxController>().notiId);
        pinPage.value = false;
        final data = {"result": resp['result'], "message": resp['message']};
        Get.offNamed(Routes.ROBIRECHARGESUCCESS, arguments: data);
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    } finally {
      rechargeLoad.value = false;
    }
  }

  Future<void> rechargeSpecialOffer() async {
    rechargeLoad.value = true;

    try {
      final resp = await RechargeRepository().rechargeSpecialOffer(
        amount: amount.value,
        operatorId: simOperator.value,
        number: rechargeNumber.value,
        pin: pinController.value.text,
        simNUmber: specialSImNumber.value,
        optInKeyword: specialOptInKeyword.value,
        commision: robiOfferComission.value,
        packageId: specialOfferID.value,
        rechargeCom: robiRechargeCom.value,
        campaignID: specialCampaignID.value,
        sessionContext: specialSessionContext.value,
      );

      if (resp['result'] == 'success') {

        pinPage.value = false;
        final data = {"result": resp['result'], "message": resp['message']};
        Get.offNamed(Routes.ROBIRECHARGESUCCESS, arguments: data);
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    } finally {
      rechargeLoad.value = false;
    }
  }

  Future<void> getCommission() async {
    final resp = await RechargeRepository()
        .getCommission(amountController.value.text, simOperator.value);

    if (resp['result'] == 'success') {
      commission.value = resp['commission'].toString();
      if (rechargeNumber.value.length == 11) {
        if(operatorWiseOfferLoad.value==true){
          Get.toNamed(Routes.RECHARGE_PIN_SPECIAL);
        }else{
          Get.toNamed(Routes.RECHARGEPIN);
        }

      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(
          message: 'Please provide valid phone number'.tr,
          title: 'Error'.tr,
        ));
      }
    }
  }

  Future<void> rechargeFromNotification(String num, String amount) async {
    // Safe operator derivation
    final normalized = normalizeBdNumber(num);
    if (normalized.length >= 3) getOperatorId(normalized.substring(0, 3));

    Ui.customLoaderDialog();
    final resp = await RechargeRepository()
        .recharge(num, amount, simOperator.value, number_type.value, pinNumber.value);

    if (resp['result'] == 'failed') {
      Get.toNamed(Routes.RECHARGE);
      Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
    } else {
      Get.find<InboxController>().changeNotiStatus(Get.find<InboxController>().notiId);
      final data = {
        "status_code": resp['status_code'].toString(),
        "result": resp['result'],
        "message": resp['message'],
      };
      Get.offNamed(Routes.RECHARGESUCCESS, arguments: data);
    }

    Get.find<HomeController>().getBalance();
    Get.find<HomeController>().getDashBoardWithoutLoadReport();
  }

  Future<void> recharge() async {
    rechargeClick.value = true;
    Ui.customLoaderDialog();

    final resp = await RechargeRepository().recharge(
      rechargeNumberController.value.text,
      amountController.value.text,
      simOperator.value,
      number_type.value,
      pinNumber.value,
    );

    if (resp['result'] == 'failed') {
      rechargeClick.value = false;
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
    } else {
      rechargeClick.value = false;
      final data = {
        "status_code": resp['status_code'].toString(),
        "result": resp['result'],
        "message": resp['message'],
      };
      Get.offNamed(Routes.RECHARGESUCCESS, arguments: data);
    }

    Get.find<HomeController>().getBalance();
    Get.find<HomeController>().getDashBoardWithoutLoadReport();
  }

  // -------------------- package fetchers --------------------
  Future<void> getInternet(String packageId) async {
    internetLoaded.value = false;
    final resp = await RechargeRepository().getPackages(simOperator.value, packageId);
    internetPackage.value = resp;
    internetLoaded.value = true;
  }

  Future<void> getMinute(String packageId) async {
    minuteLoaded.value = false;
    final resp = await RechargeRepository().getPackages(simOperator.value, packageId);
    minutePackage.value = resp;
    minuteLoaded.value = true;
  }

  Future<void> getSpecialRate(String packageId) async {
    specialRateLoaded.value = false;
    final resp = await RechargeRepository().getPackages(simOperator.value, packageId);
    specialRatePackage.value = resp;
    specialRateLoaded.value = true;
  }

  Future<void> getBundle(String packageId) async {
    bundleLoaded.value = false;
    final resp = await RechargeRepository().getPackages(simOperator.value, packageId);
    bundlePackage.value = resp;
    bundleLoaded.value = true;
  }

  // -------------------- prefix → offer mapping --------------------
  PrefixOffer? offerForPrefix(String text) {
    final digits = text.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 3) return null;
    final prefix = normalizeBdNumber(digits).substring(0, 3);

    switch (prefix) {
      case '018':
        return PrefixOffer(label: 'Get Ghechang Offer'.tr, onTap: getRobiAndAirtelOfferList);
      case '016':
        return PrefixOffer(label: 'Get Tong Offer'.tr, onTap: getRobiAndAirtelOfferList);
      case '017':
        return PrefixOffer(label: 'Get Powerload Offer'.tr, onTap: getSpecialOfferList);
      case '019':
        return PrefixOffer(label: 'Get Amar Offer'.tr, onTap: getRobiAndAirtelOfferList);
      default:
        return null;
    }
  }

  // -------------------- controller reset --------------------
  @override
  void refresh() {
    autoFocus.value = true;

    rechargeNumberController.value.clear();
    amountController.value.text = '';
    simOperator.value = '';
    simOperatorLogo.value = '';
    number_type.value = '';
    pinNumber.value = '';

    super.refresh();
  }
}

// -------------------- tiny model for prefix offers --------------------
class PrefixOffer {
  final String label;
  final VoidCallback onTap;
  const PrefixOffer({required this.label, required this.onTap});
}
