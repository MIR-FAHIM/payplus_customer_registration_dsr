//import 'package:contacts_service/contacts_service.dart';
import 'dart:math';

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
import 'package:latest_payplus_agent/app/modules/recharge/widgets/blank_page.dart';
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
  final st = 1.obs;
  final alphabetFoundList = [].obs;
  final addNumberWidgets = [].obs;
  final seeOffer = false.obs;
  final isExpanaded = false.obs;
  final isPackage = false.obs;
  final selectedContext = BuildContext;
  final formKey = GlobalKey<FormState>().obs;
  final searchStart = false.obs;
  final rechargeNumber = ''.obs;
  final searchAmount = ''.obs;
  //final searchAmount = ''.obs;
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
  final selectedIndex = 0.obs;
  final number_type = 'Prepaid'.obs;
  final internetPackage = <PackageModel>[].obs;
  final internetLoaded = false.obs;
  final minutePackage = <PackageModel>[].obs;
  final rechargeNumberObjectList = <RechargeViewModel>[].obs;
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
  final cashBackOfferType = 'Internet'.obs;
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
  var listOfNumberFocus = <Rx<FocusNode>>[].obs;
  final showButton = false.obs;
  final mobileNumberFocus = FocusNode().obs;
  final amountFocusFocus = FocusNode().obs;
  final listOfFocusNodeAmount = <Rx<FocusNode>>[].obs;
  final pinFocusFocus = FocusNode().obs;
  final selectedRobiOfferType = "I".obs;
  final amountOfferList = <PackageModel>[].obs;
  final robiAirtelOfferList = <Datumm>[].obs;
  final amountOfferListLoaded = true.obs;
  final selected = false.obs;
  final rechargeLoad = false.obs;
  final pinPage = false.obs;
  final prepaid = true.obs;
  final contactLoad = false.obs;
  final random = Random();
  final amountOffer = PackageModel().obs;
  final amountOfferFound = false.obs;
  final contactListClicked = false.obs;
  final loading = false.obs;
  final commission = ''.obs;
  final amountController = TextEditingController().obs;
  final amountControllerList = <Rx<TextEditingController>>[].obs;

  final numberControllerList = <Rx<TextEditingController>>[].obs;
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
    BlankPageWidget(),
    // AmountRechargeWidget(),
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
    amountControllerList.add(Rx(TextEditingController()));
    numberControllerList.add(Rx(TextEditingController()));
    rechargeNumberObjectList.value.add(RechargeViewModel(
      number: "",
      logo: "",
      package: "",
      validity: "",
      operatorID: "",
      amount: "",
      commision: "",
      readOnly: false,
      isExpanded: false,
    ));
    listOfNumberFocus.add(Rx(FocusNode()));
    listOfFocusNodeAmount.add(Rx(FocusNode()));

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
for (var focusNode in listOfNumberFocus) {
      focusNode.value.dispose();
    }
    for (var focusNode in listOfFocusNodeAmount) {
      focusNode.value.dispose();
    }
    super.dispose();
  }

  @override
  void onClose() {
    // for (var focusNode in listOfNumberFocus) {
    //   focusNode.value.dispose();
    // }
    super.onClose();
  }

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

  bool toggleExpanded(bool isExpanded) {
    return !isExpanded;
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

  //       }
  void validateAndSubmit() {
    if (formKey.value.currentState!.validate()) {
      // Perform your submission logic here
      print("Form submitted successfully!");
    }
  }

  RobiAirtelOfferModel getRobiAir(resp) {
    return RobiAirtelOfferModel.fromJson(resp);
  }

  List<String?> extractNumbersFromString(String input) {
    RegExp regExp = RegExp(r'\d+');
    return regExp.allMatches(input).map((match) => match.group(0)).toList();
  }

  getRobiAndAirtelOfferList(number, operator, index, context) async {
    print(
        "robi ++++++++${simOperator.value} token +++++++++++${Get.find<AuthService>().currentUser.value.token}");
    pinPage.value = false;
    loading.value = true;
    amountFocusFocus.value.requestFocus();
    //  var oparetor = simOperator.value;
    RechargeRepository().getRobiAirtelOffer(operator, number).then((resp) {
      print("fhwruuw $resp");
      if (resp["result"] == "success") {
        robiAirtelOfferList.value = getRobiAir(resp).data;
        print("+++++++++ ${robiAirtelOfferList.length.toString()}");
        amountOfferListLoaded.value = true;
        loading.value = false;
        selected.value = true;
        Get.to(RobiAirtelPackageWidget(), arguments: [index, number, context]);
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
  getStoredData() {
    print("hlw contact");
    contactsResult.clear();
    try {
      contactsResult.value = GetStorage()
          .read('contactbook')
          .map((e) => Contact.fromJson(e))
          .toList()
          .cast<Contact>();
      print("contact list ---${contactsResult.value.length}");
    } catch (e) {
      contactsResult.value = GetStorage().read('contactbook');
    }

    contactListClicked.value = true;
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
      print("operator id is $operators and resp is $resp");

      cashBackOffer.value = resp;
      cashBackOfferLoaded.value = true;
    });
  }

  rechargeRobiAirtelOffer(index) async {
    rechargeLoad.value = true;
    print("multi number index is $index");

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
        Get.find<InboxController>()
            .changeNotiStatus(Get.find<InboxController>().notiId);
        rechargeLoad.value = false;
        // Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
        pinPage.value = false;
        rechargeLoad.value = false;
        Map data = {"result": resp['result'], "message": resp['message']};
        rechargeNumberObjectList.value.removeAt(index);
        numberControllerList.value.removeAt(index);
        amountControllerList.value.removeAt(index);
        listOfNumberFocus.value.removeAt(index);
        listOfFocusNodeAmount.value.removeAt(index);

        currentIndex.value = 0;
        if (index == 0) {
          refresh();
          rechargeNumberObjectList.value.clear();
          numberControllerList.value.forEach((element) {element.value.clear();});
          amountControllerList.value.forEach((element) {element.value.clear();});
          listOfNumberFocus.clear();
          listOfFocusNodeAmount.clear();

          rechargeNumberObjectList.value.add(RechargeViewModel(
            number: "",
            logo: "",
            package: "",
            validity: "",
            operatorID: "",
            amount: "",
            commision: "",
            readOnly: false,
            isExpanded: false,
          ));
          listOfNumberFocus.add(Rx(FocusNode()));
          listOfFocusNodeAmount.add(Rx(FocusNode()));
          currentIndex.value = 0;
        }

        update();

        // NotificationLocal.showBigTextNotification(title: "Recharge Success", body: resp['message'], fln: flutterLocalNotificationsPlugin);
        Get.offNamed(Routes.ROBIRECHARGESUCCESS, arguments: data);
      } else {
        rechargeLoad.value = false;
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    });
  }

  void updateNumberAtIndex(int index, String newNumber) {
    if (index >= 0 && index < rechargeNumberObjectList.length) {
      rechargeNumberObjectList[index] =
          rechargeNumberObjectList[index].copyWith(number: newNumber);
      print("Updated index $index with number $newNumber");
    }
  }

  void updateAmountAtIndex(int index, String amount) {
    if (index >= 0 && index < rechargeNumberObjectList.length) {
      rechargeNumberObjectList[index] =
          rechargeNumberObjectList[index].copyWith(amount: amount.toString());
      print("Updated index $index with amount $amount");
    }
  }

  void updateMessageAtIndex(int index, String msg) {
    if (index >= 0 && index < rechargeNumberObjectList.length) {
      rechargeNumberObjectList[index] =
          rechargeNumberObjectList[index].copyWith(message: msg.toString());
      print("Updated index $index with amount $msg");
    }
  }

  void updateLogoAtIndex(int index, String logo) {
    if (index >= 0 && index < rechargeNumberObjectList.length) {
      rechargeNumberObjectList[index] =
          rechargeNumberObjectList[index].copyWith(logo: logo);
      print("Updated index $index with logo $logo");
    }
  }

  void updateOperatorIDAtIndex(int index, String operatorID) {
    if (index >= 0 && index < rechargeNumberObjectList.length) {
      rechargeNumberObjectList[index] =
          rechargeNumberObjectList[index].copyWith(operatorID: operatorID);
      print("Updated index $index with operator $operatorID");
    }
  }

  void updateExpandedAtIndex(int index, bool isExpand) {
    if (index >= 0 && index < rechargeNumberObjectList.length) {
      rechargeNumberObjectList[index] =
          rechargeNumberObjectList[index].copyWith(isExpanded: isExpand);
      print("Updated index $index with operator $isExpand");
    }
  }
  void removeNumberObject(RechargeViewModel recharge, index) {
    print("data is ${recharge.number}");
    print("data is ${recharge.amount}");
    print("data is ${recharge.operatorID}");
    if (rechargeNumberObjectList.contains(recharge)) {
      print("data is deleted ${recharge.number}");
      print("data is deleted ${recharge.amount}");
      print("data is  deleted${recharge.operatorID}");
      print("data is  deleted${recharge.logo}");
      // Dispose of the focus node
      listOfNumberFocus[index].value.dispose();
      listOfFocusNodeAmount[index].value.dispose();
      amountControllerList.value.removeAt(index);
      numberControllerList.value.removeAt(index);
      // Remove the number from the list

      listOfNumberFocus.removeAt(index);
      listOfFocusNodeAmount.removeAt(index);
      rechargeNumberObjectList.remove(recharge);
      rechargeNumberObjectList.refresh();
      listOfNumberFocus.refresh();
      listOfFocusNodeAmount.refresh();
      moveFocus(listOfNumberFocus.last.value);
      print("number list ${rechargeNumberObjectList.length} and focus length is ${listOfNumberFocus.length}");
      update();

    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: 'The number is not in the list.'.tr,
          title: 'Error'.tr));
    }
  }
  addNewNumber(context) {
    if (rechargeNumberObjectList.length == 5) {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: 'You can not add more than 5 numbers.'.tr,
          title: 'Error'.tr));
    } else {
      if (rechargeNumberObjectList.length == 5) {
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: 'You can not add more than 5 numbers.'.tr,
            title: 'Error'.tr));
      } else {
        if (!rechargeNumberObjectList.any((recharge) => recharge.number == "77")) {
          amountControllerList.value.add(TextEditingController().obs);
          numberControllerList.value.add(TextEditingController().obs);
          rechargeNumberObjectList.value.add(
            RechargeViewModel(
              number: "",
              amount: "",
              logo: "",
              operatorID: "",
              package: "",
              validity: "0",
              commision: "",
              readOnly: false,
              isExpanded: false,
            ),
          );
          listOfNumberFocus.add(Rx(FocusNode()));
          listOfFocusNodeAmount.add(Rx(FocusNode()));
          update();
          print("my total number ${rechargeNumberObjectList.length} and focus list is ${listOfNumberFocus.length}");

          FocusScope.of(context).requestFocus(listOfNumberFocus.last.value);
        } else {
          Get.showSnackbar(Ui.ErrorSnackBar(
              message: 'This number is already in the list.'.tr,
              title: 'Error'.tr));
        }
      }
    }
  }

  getCommission(bool readOnly) async {
    RechargeRepository()
        .getCommission(amountController.value.text, simOperator.value)
        .then((resp) {
      if (resp['result'] == 'success') {
        commission.value = resp['commission'].toString();
        print("commission.value");
        print(commission.value);

        if (rechargeNumber.value.length == 11) {
          if (rechargeNumberObjectList.length == 5) {
            Get.showSnackbar(Ui.ErrorSnackBar(
                message: 'You can not add more than 5 numbers.'.tr,
                title: 'Error'.tr));
          } else {
            if (!rechargeNumberObjectList.any((recharge) =>
                recharge.number == rechargeNumberController.value.text)) {
              rechargeNumberObjectList.value.add(RechargeViewModel(
                number: rechargeNumberController.value.text,
                logo: simOperatorLogo.value,
                package: cashBackPackageName.value,
                validity: amountOffer.value.offerValidity,
                amount: amountController.value.text,
                commision: commission.value,
                readOnly: readOnly,
              ));
              print("recharge list is ${rechargeNumberObjectList.length}");
              Get.toNamed(Routes.RECHARGEPIN);
            } else {
              Get.showSnackbar(Ui.ErrorSnackBar(
                  message: 'This number is already in the list.'.tr,
                  title: 'Error'.tr));



            }
          }
        } else {
          Get.showSnackbar(Ui.ErrorSnackBar(
              message: 'Please provide valid phone number'.tr,
              title: 'Error'.tr));
        }
      }
    });
  }

  rechargeFromNotification(String num, String amount) async {
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
        .recharge(
            num, amount, simOperator.value, number_type.value, pinNumber.value)
        .then((resp) {
      print('Recharge Response :  $resp');

      if (resp['result'] == 'failed') {
        //  Get.back();
        Get.toNamed(Routes.RECHARGE);

        // NotificationLocal.showBigTextNotification(title: "Recharge Failed", body: resp['message'], fln: flutterLocalNotificationsPlugin);

        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      } else {
        Get.find<InboxController>()
            .changeNotiStatus(Get.find<InboxController>().notiId);
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
  getBackToRecharge(){
    refresh();
    rechargeNumberObjectList.value.clear();
    listOfNumberFocus.value.clear();
    listOfFocusNodeAmount.value.clear();
    numberControllerList.value.clear();
    amountControllerList.value.clear();

    rechargeNumberObjectList.value.add(RechargeViewModel(
      number: "",
      logo: "",
      package: "",
      validity: "",
      operatorID: "",
      amount: "",
      commision: "",
      readOnly: false,
      isExpanded: false,
    ));
    numberControllerList.value.add(Rx(TextEditingController()));
    amountControllerList.value.add(Rx(TextEditingController()));
    listOfNumberFocus.add(Rx(FocusNode()));
    listOfFocusNodeAmount.add(Rx(FocusNode()));
    moveFocus(listOfNumberFocus.first.value);
    refresh();
    currentIndex.value = 0;
    print("num controller list is ${numberControllerList.length} and amount is ${amountControllerList.length}");
    Get.offNamed(Routes.RECHARGE);
  }
  void moveFocus(FocusNode focusNode) {
    FocusScope.of(Get.context!).requestFocus(focusNode);
  }
  void rechargeNumbersFromList(numberType) async {
    for (int i = 0; i < rechargeNumberObjectList.length; i++) {
      var item = rechargeNumberObjectList[i];
      RechargeRepository()
          .recharge(item.number.toString(), item.amount.toString(),
              item.operatorID.toString(), numberType, pinNumber.value)
          .then((resp) {
        print('Recharge Response :  $resp');

        // refresh();
        Map data = {
          "status_code": resp['status_code'].toString(),
          "result": resp['result'],
          "message": resp['message']
        };

        updateMessageAtIndex(i, data['message']);

        // NotificationLocal.showBigTextNotification(title: "Recharge Success", body: resp['message'], fln: flutterLocalNotificationsPlugin);

      });
    }

      Get.toNamed(Routes.MULTIRECHARGESUCCESS);


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

  double calculateTotalAmount(List<RechargeViewModel> rechargeList) {
    double totalAmount = 0.0;
    for (var recharge in rechargeList) {
      // Parse the amount as a double and add it to the total
      totalAmount += double.tryParse(recharge.amount ?? '0.0') ?? 0.0;
    }
    return totalAmount;
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

class RechargeViewModel {
  String? logo;
  String? number;
  String? package;
  String? amount;
  String? commision;
  String? validity;
  String? message;
  String? numberType;
  String? operatorID;
  bool? readOnly;
  bool? isExpanded;
  RechargeViewModel(
      {this.logo,
      this.number,
      this.package,
      this.amount,
      this.commision,
      this.validity,
      this.readOnly,
      this.message,
      this.isExpanded,
      this.numberType,
      this.operatorID});

  RechargeViewModel copyWith({
    String? number,
    String? logo,
    String? package,
    String? validity,
    String? amount,
    String? commision,
    String? message,
    String? numberType,
    String? operatorID,
    bool? isExpanded,
    bool? readOnly,
  }) {
    return RechargeViewModel(
      number: number ?? this.number,
      logo: logo ?? this.logo,
      package: package ?? this.package,
      validity: validity ?? this.validity,
      amount: amount ?? this.amount,
      commision: commision ?? this.commision,
      message: message ?? this.message,
      operatorID: operatorID ?? this.operatorID,
      readOnly: readOnly ?? this.readOnly,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
