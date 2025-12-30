import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/app_setting_controller_model.dart';
import 'package:latest_payplus_agent/app/models/notification/popup_image_notification.dart';
import 'package:latest_payplus_agent/app/modules/fav_biller/controller/fav_biller_controller.dart';
import 'package:latest_payplus_agent/app/modules/home/views/profile/profile_view.dart';
import 'package:latest_payplus_agent/app/modules/qr/view/qr_screen.dart';
import 'package:latest_payplus_agent/app/modules/qr/view/qr_tab_screen.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/common/data.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:latest_payplus_agent/app/modules/home/views/home_view.dart';
import 'package:latest_payplus_agent/app/modules/package/controller/package_list_controller.dart';
import 'package:latest_payplus_agent/app/modules/payment_collection/views/payment_history_view.dart';
import 'package:latest_payplus_agent/app/repositories/appinfor_repo.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/notificationlocal.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:latest_payplus_agent/main.dart';
import 'package:latest_payplus_agent/service/shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RootController extends GetxController {
  //TODO: Implement RootController
  final currentIndex = 0.obs;
  final notificationType = ''.obs;
  final popNoti = true.obs;
  final imagePopUrl = "".obs;
  final appSettingList = <AppSettingControllerModel>[].obs;
  final imageUrlPop = "".obs;
  final imageNotificationPopList = <NotiDatum>[].obs;
  @override
  void onInit() {
    super.onInit();
    getAppSetting();

    Get.lazyPut<PackageController>(
      () => PackageController(),
    );

    Get.lazyPut<FavBillerController>(
      () => FavBillerController(),
    );
    //


    updateUserAppVersion();




    notificationType.value = Get.arguments ?? '';
  }

  @override
  void onReady() {
    super.onReady();
    print('HomeController.onReady:${notificationType.value}');
    switch (type) {
      case '1':
        currentIndex.value = 1;
        break;
      case '2':
        Get.toNamed(Routes.RECHARGE_REPORT, arguments: type);
        break;
      case '3':
        Get.toNamed(Routes.TRANSACTION_HISTORY, arguments: type);
        break;

      case '4':
        Get.to(PaymentHistoryView());
        break;
    }

    if (DateTime.parse(SharedPreff.to.prefss.getString("popDate")!).day ==
        DateTime.now().day) {
      print(
          "it will show next day ${SharedPreff.to.prefss.getString("popDate")}");
    } else {
      showPopupForImage();
      print("day is  ${SharedPreff.to.prefss.getString("popDate")}");
    }
  }

  @override
  void onClose() {}

  List<Widget> pages = [
    HomeView(),
    QRView(),
    ProfileView(),
    //   HomeView(),
    //OfferView(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  appUpdateRequest() {
    if (getAgentAppValueByName("version_force_check") == "0") {
      getAppInformation();
    } else {
      advancedStatusCheck();
    }
  }


  getAppSetting() async {
    print("app setting is   ++++++++++");

    BuySellRepository().getAppSettingRep().then((response) {
      appSettingList.value = response;
      appUpdateRequest();
      print("app setting res length is ${appSettingList.value.length}");
    });
  }

  updateUserAppVersion() {
    print("response update version for user 1");
    BuySellRepository().updateUserAppVersion(MyData.appVersion).then((response) {
      print("response update version for user $response");
    });
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
            Colors.green.shade500,
            isBarrierDismiss: false, () async {
          if (!await launchUrl(
            Uri.parse(
                'https://play.google.com/store/apps/details?id=paystation.paypos.reg'),
            mode: LaunchMode.externalNonBrowserApplication,
          )) {
            throw 'Could not launch ${Uri.parse('https://play.google.com/store/apps/details?id=paystation.paypos.reg')}';
          }
        });
      }
    }).catchError((onError) {
      print('error: $onError');
      //var response = json.decode(onError.toString());
      //ScaffoldMessenger.of(Get.context!).showSnackBar(Ui.errorAwesomeSnackBar(message: response['message'], title: 'Error'));

      throw (onError);
    });
  }

  showPopupForReg() {
    SharedPreff.to.prefss.setString("popDate", DateTime.now().toString());
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
                    child: CachedNetworkImage(
                      imageUrl: SharedPreff.to.prefss
                          .getString("popImage")
                          .toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image(
                          image: AssetImage(
                            'assets/number.jpeg',
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image(
                          image: AssetImage(
                            'assets/number.jpeg',
                          ),
                        ),
                      ),
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

  showPopupForImage() {
    SharedPreff.to.prefss.setString("popDate", DateTime.now().toString());
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            //title: Text('Select '),
            content: Stack(
              children: [
                Container(
                  width: double.infinity,
                  //height: Get.height * .45,
                  decoration: BoxDecoration(
                    color: Get.theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: CachedNetworkImage(
                      imageUrl: SharedPreff.to.prefss
                          .getString("popImage")
                          .toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image(
                          image: AssetImage('assets/images/noti.jpeg'),
                        ),
                      ),
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image(
                          image: AssetImage('assets/images/noti.jpeg'),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      )),
                )
              ],
            )
            // actions: <Widget>[

            // ],
            );
      },
    );
  }

  loginDuration() async {
    // String? date = DateTime.now().add(Duration(minutes: -3)).toString();

    String? date = await SharedPreff.to.prefss.getString("logindate");
    return date;
    //  print("login duration bro");
    // int day = DateTime.parse(DateTime.now().toString()).difference(DateTime.parse(date!)).inDays ;
    // print("my login duration $day");
  }

  advancedStatusCheck() async {
    print("hle broooooo");

    final newVersion = NewVersionPlus(
      //iOSId: 'com.google.Vespa',
      androidId: 'paystation.paypos.reg',
    );
    var status = await newVersion.getVersionStatus();
    print("version status ${status!.appStoreLink}");
    if (status.canUpdate == true) {
      print("update av");
      newVersion.showUpdateDialog(
        // launchMode: LaunchMode.externalApplication,
        context: Get.context!,
        versionStatus: status,
        dialogTitle: 'Update Available!',
        dialogText: 'Upgrade  ${status.localVersion} to ${status.storeVersion}',
      );
    }
  }

  Future<void> changePageOutRoot(int _index) async {
    currentIndex.value = _index;
    await Get.offNamedUntil(Routes.ROOT, (Route route) {
      if (route.settings.name == Routes.ROOT) {
        return true;
      }
      return false;
    }, arguments: _index);
  }

  void changePage(int page) {
    currentIndex.value = page;
  }
}
