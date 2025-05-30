import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/ad_banner_model.dart';
import 'package:latest_payplus_agent/app/models/app_setting_controller_model.dart';
import 'package:latest_payplus_agent/app/modules/account_setting/controllers/account_setting_controller.dart';
import 'package:latest_payplus_agent/app/modules/qr/view/bangla_qr.dart';
import 'package:latest_payplus_agent/app/modules/qr/view/qr_screen.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/app/repositories/payment_collection.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class QRController extends GetxController {
  // WebView controller
  late InAppWebViewController inAppWebViewController;
  final appSettingList = <AppSettingControllerModel>[].obs;
  // State observables
  final offerBanner = <AdBannerModel>[].obs;
  final offerBannerLoaded = false.obs;
  final progress = 0.0.obs;

  // QR code data
  final qrData = ''.obs;
  final genrateBanglaQrData = ''.obs;
  final qrUrlBangla = ''.obs;
  final isBanglaQR = false.obs;

  // Page views
  final qrPages = [
    QRView(),
    BanglaQRView(),
  ].obs;

  // QR image key
  final globalKey = GlobalKey().obs;

  @override
  void onInit() {
    getAppSetting();
    createBanglaQR();
    Get.put(AccountSettingController());
    super.onInit();
    // getAdBanner();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Open external URLs
  Future<void> launchUrlController(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  getAppSetting() async {
    print("app setting is   ++++++++++");

    BuySellRepository().getAppSettingRep().then((response) {
      appSettingList.value = response;

      print("app setting res length is ${appSettingList.value.length}");
    });
  }

  String getAgentAppValueByName(String name) {
    final match = appSettingList.value.firstWhere(
      (item) => item.name == name,
      orElse: () => AppSettingControllerModel(), // or a default/empty model
    );

    return match.agentAppValue ?? '';
  }

  Future<void> share(qr) async {
    await FlutterShare.share(
      title:
          'Bangla QR Link Generated from ${Get.find<AuthService>().currentUser.value.outletName}',
      text:
          'Bangla QR Link Generated from ${Get.find<AuthService>().currentUser.value.outletName}',
      linkUrl: qr,
      chooserTitle:
          'Bangla QR Link Generated from ${Get.find<AuthService>().currentUser.value.outletName}',
    );
  }

  shareBanglaQR(String qr) {
    share(qr);
  }

  createBanglaQR() async {
    PaymentCollectionRepository().createBanglaQR().then((resp) {
      if (resp['result'] == true) {
        isBanglaQR.value = true;
        genrateBanglaQrData.value = resp['qrData'][0]['QRString'];
        qrData.value = resp['qrData'][0]['QRString'].replaceAll(' ', '%20');
        qrUrlBangla.value = "${resp['qr_url']}${qrData.value}";
        print("my qr data is ${qrData.value}");
      } else {
        isBanglaQR.value = false;
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: resp['message'], title: 'Error'.tr));
      }
    });
  }
}
// Save and share QR image
