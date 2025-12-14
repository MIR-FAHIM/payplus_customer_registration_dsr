
import 'dart:math';
import 'dart:async';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/models/mbanking_gateway_model.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/widgets/error_timer_page.dart';
import 'package:latest_payplus_agent/app/repositories/mfsPayment_type_repositoy.dart';
import 'package:latest_payplus_agent/app/repositories/mobile_banking_repository.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:latest_payplus_agent/app/models/icon_model.dart';
import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import '../../../models/add_balance_model/mfs_list_model.dart';

class MobileBankingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final currentTabIndex = 0.obs;
  final box = GetStorage().obs;
  final mobileNumber = ''.obs;
  final count = 1.obs;
  final alphabetFoundList = [].obs;
  final addNumberWidgets = [].obs;

  final searchStart = false.obs;
  final contactLoad = false.obs;

  final amount = ''.obs;
  final gateWay = ''.obs;

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

  final internetLoaded = false.obs;

  final minuteLoaded = false.obs;

  final specialRateLoaded = false.obs;
  final showButton = false.obs;
  final bundleLoaded = false.obs;
  Timer? timer;
  final timeElapsed = 0.obs; // in seconds
  final interval = 30.obs; // interval in seconds
  final totalTime = 180.obs; // total time in seconds (3 minutes)
  final amountOfferFound = false.obs;
  final contactListClicked = false.obs;
  final loading = false.obs;
  final commission = ''.obs;
  TextEditingController searchController = TextEditingController();
  //TextEditingController pinController = TextEditingController();
  final currentIndex = 0.obs;
  final keyboardText = ''.obs;
  final gateWayID = ''.obs;
  final rocketRefId = ''.obs;
  final searchString = "".obs;
  final keyboardType = ''.obs;
  final contacts = <Contact>[].obs;
  final contactsResult = <Contact>[].obs;
  final contactLoaded = false.obs;
  final cashBackPackageName = ''.obs;
  final imageUrl = ''.obs;
  final devMessage = ''.obs;
  final cashBackValidaity = ''.obs;
  final cashBackAmount = ''.obs;
  final balance = ''.obs;
  final random = Random();
  final numberController = TextEditingController().obs;
  final amountController = TextEditingController().obs;
  final pinController = TextEditingController().obs;
  final remarkController = TextEditingController().obs;
  final otpController = TextEditingController().obs;
  final paymentTypesMFS = <MFSListModel>[].obs;
  final mfsGateWayListCashInOut = <DatumCashINOutGateWay>[].obs;

  TabController? tabController;

  //TODO: Implement MobileBankingController
  List<IconModel> banks = [
    IconModel(
        title: 'Rocket', image: "assets/mobilebank/rocket.png", press: () {}),
    IconModel(title: 'My Cash', image: "assets/mobilebank/1.png", press: () {}),
    IconModel(title: 'Wallet', image: "assets/mobilebank/2.png", press: () {}),
    IconModel(title: 'MFS', image: "assets/mobilebank/3.png", press: () {}),
  ];
  @override
  void onInit() {
    // getPhoneContact();
    getPaymentType();
    getMfsGateway();
    tabController = TabController(length: 3, vsync: this);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getPaymentType() async {
    mfsPaymentTypeRepository().getBusinessType().then((resp) {
      paymentTypesMFS.value = resp;

      return resp;
    });
  }

  getMfsGateway() async {
    mfsPaymentTypeRepository().getMFSGateWayList().then((resp) {
      mfsGateWayListCashInOut.value = resp.data;

      return mfsGateWayListCashInOut.value;
    });
  }

  // cash in function start

  sendRequestForCashin(
    String pin,
    String gateWayId,
  ) async {
    Ui.customLoaderDialog();
    MobileBankingRepository()
        .submitCashIn(
            number: numberController.value.text,
            amount: amountController.value.text,
            pin: pin,
            gateWayID: gateWayId)
        .then((resp) {
      Get.back();
      if (resp['result'] == 'success') {
        Get.toNamed(
          Routes.MBANKINGSUCCESS,
          arguments: [resp['message'], "Cash In"],
        );
        numberController.value.clear();
        amountController.value.clear();
        pinController.value.clear();
        //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
      } else {
//devMessage.value = resp['dev_message']['message'];
        Get.toNamed(
          Routes.MBANKINGFAIL,
          arguments: [resp['message'], "Cash In"],
        );

        print("gateway id is $gateWayId");

        //  Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
        numberController.value.clear();
        amountController.value.clear();
        pinController.value.clear();
      }
    }).catchError((onError) {});
  }

  // check rocket transaction to proceed in timer
  checkRocketTransactionStatus() async {
    print("rocket cjheck started");
    Ui.customLoaderDialog();
    MobileBankingRepository()
        .checkRocketTrans(
      ref: rocketRefId.value,
    )
        .then((resp) {
      Get.back();
      if (resp['result'] == 'success') {
        showButton.value = false;
        Get.offNamed(
          Routes.MBANKINGSUCCESS,
          arguments: [resp['message'], "Cash In"],
        );
        numberController.value.clear();
        amountController.value.clear();
        pinController.value.clear();
        //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
      } else {
        showButton.value = false;
//devMessage.value = resp['dev_message']['message'];
        Get.offNamed(
          Routes.MBANKINGFAIL,
          arguments: [resp['message'], "Cash In"],
        );

        //  Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
        numberController.value.clear();
        amountController.value.clear();
        pinController.value.clear();
      }
    }).catchError((onError) {});
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: interval.value), (timer) {
      timeElapsed.value += interval.value;

      if (timeElapsed.value >= totalTime.value) {
        timer?.cancel();
      }
    });
  }

  sendRequestForCashinRocket(
    String pin,
    String gateWayId,
  ) async {
    Ui.customLoaderDialog();
    MobileBankingRepository()
        .submitCashInRocket(
            number: numberController.value.text,
            amount: amountController.value.text,
            pin: pin,
            gateWayID: gateWayId)
        .then((resp) {
      Get.back();
      if (resp['result'] == 'success') {
        Get.toNamed(
          Routes.MBANKINGSUCCESS,
          arguments: [resp['message'], "Cash In"],
        );
        numberController.value.clear();
        amountController.value.clear();
        pinController.value.clear();
        //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
      } else {
        print("iam in fail timeout");
        if (resp['message'] == "Cash in failed due to timeout") {
          print("iam in fail timeout");
          rocketRefId.value = resp['refId'];
          startTimer();
          Get.to(() => ErrorTimerPage());
        } else {
          Get.toNamed(
            Routes.MBANKINGFAIL,
            arguments: [resp['message'], "Cash In"],
          );

          print("gateway id is $gateWayId");
        }
//devMessage.value = resp['dev_message']['message'];

        //  Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
        numberController.value.clear();
        amountController.value.clear();
        pinController.value.clear();
      }
    }).catchError((onError) {});
  }

//
  sendRequestForCashOut(String pin, String gatewayId, String otp) async {
    Ui.customLoaderDialog();
    if (gatewayId == "3") {
      MobileBankingRepository()
          .submitRocketCashOut(
        number: numberController.value.text,
        amount: amountController.value.text,
        pin: pin,
        gateWayID: gatewayId,
      )
          .then((resp) {
        Get.back();
        if (resp['result'] == 'success') {
          Get.toNamed(
            Routes.MBANKINGSUCCESS,
            arguments: [resp['message'], "Cash Out"],
          );
          numberController.value.clear();
          amountController.value.clear();
          pinController.value.clear();
          otpController.value.clear();

          //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
        } else {
          Get.toNamed(Routes.MBANKINGFAIL,
              arguments: [resp['message'], "Cash Out"]);
          //  Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
          numberController.value.clear();
          amountController.value.clear();
          pinController.value.clear();
          otpController.value.clear();
        }
      }).catchError((onError) {});
    } else {
      MobileBankingRepository()
          .submitCashOut(
              number: numberController.value.text,
              amount: amountController.value.text,
              pin: pin,
              gateWayID: gatewayId,
              otp: otp)
          .then((resp) {
        Get.back();
        if (resp['result'] == 'success') {
          Get.toNamed(
            Routes.MBANKINGSUCCESS,
            arguments: [resp['message'], "Cash Out"],
          );
          numberController.value.clear();
          amountController.value.clear();
          pinController.value.clear();
          otpController.value.clear();

          //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
        } else {
          Get.toNamed(Routes.MBANKINGFAIL,
              arguments: [resp['message'], "Cash Out"]);
          //  Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
          numberController.value.clear();
          amountController.value.clear();
          pinController.value.clear();
          otpController.value.clear();
        }
      }).catchError((onError) {});
    }
  }

  sendRequestForCashOutRocket(String pin, String gatewayId, String otp) async {
    Ui.customLoaderDialog();
    if (gatewayId == "3") {
      MobileBankingRepository()
          .submitRocketCashOut(
        number: numberController.value.text,
        amount: amountController.value.text,
        pin: pin,
        gateWayID: gatewayId,
      )
          .then((resp) {
        Get.back();
        if (resp['result'] == 'success') {
          Get.toNamed(
            Routes.MBANKINGSUCCESS,
            arguments: [resp['message'], "Cash Out"],
          );
          numberController.value.clear();
          amountController.value.clear();
          pinController.value.clear();
          otpController.value.clear();

          //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
        } else {
          Get.toNamed(Routes.MBANKINGFAIL,
              arguments: [resp['message'], "Cash Out"]);
          //  Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
          numberController.value.clear();
          amountController.value.clear();
          pinController.value.clear();
          otpController.value.clear();
        }
      }).catchError((onError) {});
    } else {
      MobileBankingRepository()
          .submitCashOut(
              number: numberController.value.text,
              amount: amountController.value.text,
              pin: pin,
              gateWayID: gatewayId,
              otp: otp)
          .then((resp) {
        Get.back();
        if (resp['result'] == 'success') {
          Get.toNamed(
            Routes.MBANKINGSUCCESS,
            arguments: [resp['message'], "Cash Out"],
          );
          numberController.value.clear();
          amountController.value.clear();
          pinController.value.clear();
          otpController.value.clear();

          //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
        } else {
          Get.toNamed(Routes.MBANKINGFAIL,
              arguments: [resp['message'], "Cash Out"]);
          //  Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
          numberController.value.clear();
          amountController.value.clear();
          pinController.value.clear();
          otpController.value.clear();
        }
      }).catchError((onError) {});
    }
  }

  getCommision({String? type, String? gatewayId, String? amount}) async {
    MobileBankingRepository()
        .getCommision(amount: amount, gateWayID: gatewayId, type: type)
        .then((e) {
      print("my commision is $e");
      commission.value = e['commission'].toString();
      Get.toNamed(Routes.MBANKINGPIN, arguments: [e]);
    });
  }

// money transfer
  moneyTransferController() async {
    Ui.customLoaderDialog();
    MobileBankingRepository()
        .moneyTransfer(numberController.value.text, amountController.value.text,
            gateWay.value, pinController.value.text, remarkController.value.text )
        .then((resp) {
      print("money transfer res is controller ${resp['result']}");

      if (resp['result'] == 'success') {
        Get.toNamed(Routes.MBANKINGSUCCESS,
            arguments: [resp['message'], "Money Out"]);
        numberController.value.clear();
        amountController.value.clear();
        remarkController.value.clear();
        pinController.value.clear();

        //Get.showSnackbar(Ui.SuccessSnackBar(message: resp['message'], title: 'Success'.tr));
      } else {
        Get.toNamed(Routes.MBANKINGFAIL,
            arguments: [resp['message'], "Money Out"]);
        //  Get.showSnackbar(Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
        numberController.value.clear();
        amountController.value.clear();
        pinController.value.clear();
        remarkController.value.clear();

        //Get.toNamed(Routes.MBANKINGNUMAMOUNT);
      }
    }).catchError((onError) {});
  }

  // cash in out transfer end

  showCashinCashoutOption() {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              height: Get.size.width * .6,
              width: Get.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'SELECT OPTION FROM BELOW'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: BlockButtonWidget(
                      width: size.width,
                      onPressed: () {
                        Get.toNamed(Routes.MOBILE_BANK_CASHIN)!.then((value) {
                          Get.back();
                        });
                      },
                      color: Get.theme.primaryColor,
                      radius: 10,
                      text: Text(
                        'Cash In'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: BlockButtonWidget(
                      width: size.width,
                      onPressed: () {
                        Get.toNamed(Routes.MOBILE_BANK_CASHOUT)!.then((value) {
                          Get.back();
                        });
                      },
                      color: Get.theme.primaryColor,
                      radius: 10,
                      text: Text(
                        'Cash Out'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
            // actions: <Widget>[

            // ],
            );
      },
    );

    // return showDialog(
    //   context: Get.context!,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //         contentPadding: EdgeInsets.zero,
    //         //title: Text('Select '),
    //         content: Container(
    //           width: double.infinity,
    //           decoration: BoxDecoration(
    //             color: Get.theme.scaffoldBackgroundColor,
    //             borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    //           ),
    //           child: Wrap(
    //             children: <Widget>[
    //               ListTile(
    //                   title: Text('Cash In'.tr),
    //                   onTap: () {
    //                     Get.toNamed(Routes.MOBILE_BANK_CASHIN);
    //                   }),
    //               ListTile(
    //                 title: Text('Cash Out'.tr),
    //                 onTap: () {
    //                   Get.toNamed(Routes.MOBILE_BANK_CASHOUT);
    //                 },
    //               ),
    //             ],
    //           ),
    //         )
    //         // actions: <Widget>[
    //
    //         // ],
    //         );
    //   },
    // );
  }

  getStoredData() {
    contactsResult.clear();
    print("store data");

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

//
  getPhoneContact() async {
    box.value.remove('contactbook');
    contactLoad.value = true;
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts = await FlutterContacts.getContacts();

      // Get all contacts (fully fetched)
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: false);

      // Get contact with specific ID (fully fetched)

      // print("my all contact are ${jsonDecode(source)}");

      contactsResult.value = contacts;
      await box.value.write('contactbook', contacts);
      print(
          "hlw bro ***********************${GetStorage().read('contactbook')}");
      contactLoad.value = true;

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

  showComingsoonPopup() {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              height: Get.size.width,
              width: Get.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: Get.size.width * .7,
                    width: Get.size.width * .7,
                    child: Text('Comming Soon'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: BlockButtonWidget(
                      width: size.width * .45,
                      onPressed: () {
                        Get.back();
                      },
                      color: Get.theme.primaryColor,
                      radius: 30,
                      text: Text(
                        'Okay'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
            // actions: <Widget>[

            // ],
            );
      },
    );
  }
}
