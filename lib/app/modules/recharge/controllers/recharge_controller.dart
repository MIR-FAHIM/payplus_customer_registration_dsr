//import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
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
import 'package:flutter_contacts/flutter_contacts.dart';
import '../../../../main.dart';
import '../../../services/auth_service.dart';
import 'package:get_storage/get_storage.dart';

class RechargeController extends GetxController {
  //TODO: Implement RechargeController

  final count = 1.obs;
  final alphabetFoundList = [].obs;
  final addNumberWidgets = [].obs;
  final seeOffer = false.obs;
  final searchStart = false.obs;
  final rechargeNumber = ''.obs;
  final amount = ''.obs;
  final pinNumber = ''.obs;
  final simOperator = ''.obs;
  final simOperatorLogo = ''.obs;
  final robiOfferAmount = ''.obs;
  final robiOfferCusComission = ''.obs;
  final robiOfferName = ''.obs;
  final robiOfferID = ''.obs;
  final robiOfferAdminComission = ''.obs;
  final robiOfferComission = ''.obs;
  final robiRechargeCom = ''.obs;

  final number_type = 'Prepaid'.obs;

  final internetPackage = <PackageModel>[].obs;
  final internetLoaded = false.obs;
  final minutePackage = <PackageModel>[].obs;
  final minuteLoaded = false.obs;
  final specialRatePackage = <PackageModel>[].obs;
  final specialRateLoaded = false.obs;
  final bundlePackage = <PackageModel>[].obs;
  final bundleLoaded = false.obs;
  final box = GetStorage().obs;

  final cashBackOffer = CashBackReportModel().obs;
  final contacts = <Contact>[].obs;
  final contactsResult = <Contact>[].obs;
  final contactLoaded = false.obs;
  final cashBackPackageName = ''.obs;
  final cashBackValidaity = ''.obs;
  final cashBackAmount = ''.obs;

  final cashBackOfferLoaded = true.obs;

  final autoFocus = true.obs;
  final alphabetList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ].obs;

  final mobileNumberFocus = FocusNode().obs;
  final amountFocusFocus = FocusNode().obs;
  final pinFocusFocus = FocusNode().obs;

  final amountOfferList = <PackageModel>[].obs;
  final robiAirtelOfferList = <Datumm>[].obs;
  final amountOfferListLoaded = true.obs;
  final selected = false.obs;
  final rechargeLoad = false.obs;
  final pinPage = false.obs;
  final prepaid = true.obs;

  final contactLoad = false.obs;

  final amountOffer = PackageModel().obs;
  final amountOfferFound = false.obs;
  final contactListClicked = false.obs;
  final loading = false.obs;
  final commission = ''.obs;
  final amountController = TextEditingController().obs;
  final rechargeNumberController = TextEditingController().obs;
  final simLogoController = TextEditingController().obs;
  final pinController = TextEditingController().obs;
  final searchController = TextEditingController().obs;
  //TextEditingController pinController = TextEditingController();
  final currentIndex = 0.obs;

  final keyboardText = ''.obs;
  final searchString = "".obs;
  final keyboardType = ''.obs;

  final pages = [
    AmountRechargeWidget(),
    CashBackPackageWidget(),
    InternetPackageWidget(),
    MinutePackageWidget(),
    BundlePackageWidget(),
    SpecialRatePackageWidget(),
    RobiAirtelPackageWidget(),
  ];
  @override
  void onInit() {
    // getPhoneContact();


    getCashBackOffer();

    cashBackAmount.value = '';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    mobileNumberFocus.value.dispose();
    amountFocusFocus.value.dispose();
    pinFocusFocus.value.dispose();
    amountOfferListLoaded.value = false;

    rechargeNumberController.value.clear();
    simLogoController.value.clear();
    pinController.value.clear();

    rechargeNumber.value = '';
    rechargeNumber.update((val) {});
    amountController.value.text = '';
    simOperator.value = '';
    simOperator.update((val) {});
    simOperatorLogo.value = '';
    simOperatorLogo.update((val) {});
    number_type.value = '';
    pinNumber.value = '';

    super.dispose();
  }

  @override
  void onClose() {}

  void increment() {
    if (count.value < 5) {
      count.value++;
    }
  }

  getOperatorId(code) {
    operatorLogos.forEach((element) {
      if (element.name == code) {
        simOperator.value = element.id!.toString();
        print("my sim operator id is ${simOperator.value}");
      }
    });
    return simOperator.value;
  }

  onKeyboardTap(String value) {
    keyboardText.value = keyboardText.value + value;
  }

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int page) {
    currentIndex.value = page;
  }

  // addAlphabet() {
  //   for (int index = 0; index < alphabetList.length; index++) {
  //     for (var item in contacts) {
  //       //  print(item);
  //       if (item.displayName[0].toUpperCase() == alphabetList[index]) {
  //         alphabetFoundList.add(alphabetList[index]);
  //         break;
  //       }
  //     }
  //   }
  // }
  RobiAirtelOfferModel getRobiAir(resp) {
    return RobiAirtelOfferModel.fromJson(resp);
  }

  List<String?> extractNumbersFromString(String input) {
    RegExp regExp = RegExp(r'\d+');
    return regExp.allMatches(input).map((match) => match.group(0)).toList();
  }

  getRobiAndAirtelOfferList() async {
    print(
        "robi ++++++++${simOperator.value} token +++++++++++${Get.find<AuthService>().currentUser.value.token}");
    pinPage.value = false;
    loading.value = true;
    amountFocusFocus.value.requestFocus();

    var oparetor = simOperator.value;
    RechargeRepository()
        .getRobiAirtelOffer(oparetor, rechargeNumber.value)
        .then((resp) {
      print("fhwruuw $resp");
      if (resp["result"] == "success") {
        robiAirtelOfferList.value = getRobiAir(resp).data;
        print("+++++++++ ${robiAirtelOfferList.length.toString()}");
        amountOfferListLoaded.value = true;
        loading.value = false;
        selected.value = true;
        Get.to(RobiAirtelPackageWidget());
      } else {
        loading.value = false;
        print("fhwruuw ");
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: 'No Offer Available'.tr, title: 'Error'.tr));
      }
    });
  }

  getOfferList(String operatorId) async {
    amountFocusFocus.value.requestFocus();
    // Ui.customLoaderDialog();
    RechargeRepository().getAmountOffer(operatorId).then((resp) {
      amountOfferList.value = resp;
      amountOfferListLoaded.value = true;
      // Get.back();
    });
  }

  getPhoneContact() async {
    contactLoad.value = true;
    box.value.remove('contactbook');
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts = await FlutterContacts.getContacts();

      // Get all contacts (fully fetched)
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: false);

      // Get contact with specific ID (fully fetched)

      print("my all contact are $contacts");

      contactsResult.value = contacts;
      await box.value.write('contactbook', contacts);
      print(
          "hlw bro ***********************${GetStorage().read('contactbook')}");
      contactLoad.value = false;

      contactListClicked.value = true;
    }
  }

  void setSearchText(String text) {
    searchString.value = text;
  }

  getStoredData() {
    print("hlw contact");
    contactsResult.clear();
    try {
      contactsResult.value = GetStorage()
          .read('contactbook')
          .map((e) => Contact.fromJson(e))
          .toList()
          .cast<Contact>();
    } catch (e) {
      contactsResult.value = GetStorage().read('contactbook');
    }

    contactListClicked.value = true;
  }

  List<Contact> get filteredContacts {
    return contactsResult.value.where((contact) {
      final name = contact.displayName.toLowerCase();
      final number = contact.phones.isEmpty
          ? "000"
          : contact.phones.first.toString().toLowerCase();
      final searchTerm = searchString.value.toLowerCase();
      if (searchString.value.isNum) {
        return number.contains(searchTerm);
      } else {
        return name.contains(searchTerm);
      }
    }).toList();
  }

  getContacts() async {
    print("hlw bro contact");
    try {
      // Request contact permission
      if (await FlutterContacts.requestPermission()) {
        // Get all contacts (lightly fetched)
        // contacts.value = await FlutterContacts.getContacts();
        print("contact list working here");

        // Get all contacts (fully fetched)
        contacts.value = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);

        // Get contact with specific ID (fully fetched)
        //  Contact? contact = await FlutterContacts.getContact(contacts.first.id);

        print('MobileRechargeController.getContacts: ${contacts.first.phones}');

        //  await addAlphabet();
        // print('MobileRechargeController.alphabet: ${alphabetFoundList[0].contacts!.length}');

        contactLoaded.value = true;
        contactsResult.value = contacts.value;
      }
    } catch (e) {
      rethrow;
    }
  }

  amountCheck() {
    amountOfferFound.value = false;
    amountOffer.value = PackageModel();
    for (var item in amountOfferList) {
      if (item.offerAmount.toString() == amountController.value.text) {
        amountOfferFound.value = true;
        amountOffer.value = item;
      }
    }
    print(amountOfferFound.value);
  }

  getCashBackOffer() async {
    var oparetor = simOperator.value;
    cashBackOfferLoaded.value = false;
    RechargeRepository().getCashBackOffer(oparetor).then((resp) {
      cashBackOffer.value = resp;
      cashBackOfferLoaded.value = true;
    });
  }

  rechargeRobiAirtelOffer() async {
    rechargeLoad.value = true;

    RechargeRepository()
        .rechargeRobiAirtel(
            amount: amount.value,
            operatorId: simOperator.value,
            number: rechargeNumber.value,
            pin: pinController.value.text,
            adminCom: robiOfferAdminComission.value,
            cusCom: robiOfferCusComission.value,
            com: robiOfferComission.value,
            packageId: robiOfferID.value,
            rechargeCom: robiRechargeCom.value)
        .then((resp) {
      if (resp['result'] == 'success') {
        Get.find<InboxController>().changeNotiStatus(Get.find<InboxController>().notiId);
        rechargeLoad.value = false;
        // Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
        pinPage.value = false;
        rechargeLoad.value = false;
        Map data = {"result": resp['result'], "message": resp['message']};

        // NotificationLocal.showBigTextNotification(title: "Recharge Success", body: resp['message'], fln: flutterLocalNotificationsPlugin);
        Get.offNamed(Routes.ROBIRECHARGESUCCESS, arguments: data);
      } else {
        rechargeLoad.value = false;
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    });
  }

  getCommission() async {
    RechargeRepository()
        .getCommission(amountController.value.text, simOperator.value)
        .then((resp) {
      if (resp['result'] == 'success') {
        commission.value = resp['commission'].toString();
        print("commission.value");
        print(commission.value);

        if (rechargeNumber.value.length == 11) {
          Get.toNamed(Routes.RECHARGEPIN);
        } else {
          Get.showSnackbar(Ui.ErrorSnackBar(
              message: 'Please provide valid phone number'.tr,
              title: 'Error'.tr));
        }
      }
    });
  }

  rechargeFromNotification(String num, String amount ) async {
    // print(number_type.value);
    // print(rechargeNumberController.value.text);
    // print(amountController.value.text);
    // print(simOperator.value);
    // print(pinNumber.value);
    // print("my num code is ${rechargeNumber.value.substring(0, 3)}");
    getOperatorId(num.substring(0, 3));
    // Get.focusScope!.unfocus();
    // pinFocusFocus.dispose();
    Ui.customLoaderDialog();

    RechargeRepository()
        .recharge(num, amount, simOperator.value,
            number_type.value, pinNumber.value)
        .then((resp) {
      print('Recharge Response :  $resp');

      if (resp['result'] == 'failed') {
      //  Get.back();
        Get.toNamed(Routes.RECHARGE);

        // NotificationLocal.showBigTextNotification(title: "Recharge Failed", body: resp['message'], fln: flutterLocalNotificationsPlugin);

        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      } else {
        Get.find<InboxController>().changeNotiStatus(Get.find<InboxController>().notiId);
        // refresh();
        Map data = {
          "status_code": resp['status_code'].toString(),
          "result": resp['result'],
          "message": resp['message']
        };
        // NotificationLocal.showBigTextNotification(title: "Recharge Success", body: resp['message'], fln: flutterLocalNotificationsPlugin);
        Get.offNamed(Routes.RECHARGESUCCESS, arguments: data);
      }

      Get.find<HomeController>().getBalance();
      Get.find<HomeController>().getDashBoardWithoutLoadReport();
    });
  }

  recharge() async {
    print(number_type.value);
    print(rechargeNumberController.value.text);
    print(amountController.value.text);
    print(simOperator.value);
    print(pinNumber.value);
    // Get.focusScope!.unfocus();
    // pinFocusFocus.dispose();
    Ui.customLoaderDialog();

    RechargeRepository()
        .recharge(
            rechargeNumberController.value.text,
            amountController.value.text,
            simOperator.value,
            number_type.value,
            pinNumber.value)
        .then((resp) {
      print('Recharge Response :  $resp');

      if (resp['result'] == 'failed') {
        Get.back();

        // NotificationLocal.showBigTextNotification(title: "Recharge Failed", body: resp['message'], fln: flutterLocalNotificationsPlugin);

        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      } else {
        // refresh();
        Map data = {
          "status_code": resp['status_code'].toString(),
          "result": resp['result'],
          "message": resp['message']
        };
        // NotificationLocal.showBigTextNotification(title: "Recharge Success", body: resp['message'], fln: flutterLocalNotificationsPlugin);
        Get.offNamed(Routes.RECHARGESUCCESS, arguments: data);
      }

      Get.find<HomeController>().getBalance();
      Get.find<HomeController>().getDashBoardWithoutLoadReport();
    });
  }

  getInternet(String packageId) async {
    internetLoaded.value = false;
    RechargeRepository().getPackages(simOperator.value, packageId).then((resp) {
      internetPackage.value = resp;
      internetLoaded.value = true;
    });
  }

  getMinute(String packageId) async {
    minuteLoaded.value = false;
    RechargeRepository().getPackages(simOperator.value, packageId).then((resp) {
      minutePackage.value = resp;
      minuteLoaded.value = true;
    });
  }

  getSpecialRate(String packageId) async {
    specialRateLoaded.value = false;
    RechargeRepository().getPackages(simOperator.value, packageId).then((resp) {
      specialRatePackage.value = resp;
      specialRateLoaded.value = true;
    });
  }

  getBundle(String packageId) async {
    bundleLoaded.value = false;
    RechargeRepository().getPackages(simOperator.value, packageId).then((resp) {
      bundlePackage.value = resp;
      bundleLoaded.value = true;
    });
  }

  @override
  void refresh() {
    // TODO: implement refresh

    autoFocus.value = true;
    autoFocus.update((val) {});
    rechargeNumberController.value.clear();

    amountController.value.text = '';
    simOperator.value = '';
    simOperatorLogo.value = '';
    number_type.value = '';
    pinNumber.value = '';
    super.refresh();
  }
}
