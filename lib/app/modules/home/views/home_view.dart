import 'dart:io';
import 'dart:ui';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/modules/withdraw/controllers/withdraw_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latest_payplus_agent/app/modules/home/widgets/AmountWidget.dart';
import 'package:latest_payplus_agent/app/modules/home/widgets/home_option_widget.dart';
import 'package:latest_payplus_agent/app/modules/home/widgets/home_slider_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final _size = Get.size;

  @override
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (b)  {
       showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Are you sure you want to exit?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    //return true when click on "Yes"
                    child: Text('Yes'),
                  ),
                ],
              );
            });
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size(65, 65),
            child: AppBar(
              backgroundColor: const Color(0xFF652981),
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Row(
                  children: [
                    ProfileImage(),

                    SizedBox(
                      width: 10,
                    ),

                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Get.find<AuthService>()
                                    .currentUser
                                    .value
                                    .outletName ??
                                '',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            Get.find<AuthService>()
                                    .currentUser
                                    .value
                                    .mobileNumber ??
                                '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          // controller.packageLoad.value == true
                          //     ? SizedBox(
                          //         height: 10,
                          //         width: 10,
                          //         child: CircularProgressIndicator())
                          //     : InkWell(
                          //         onTap: () {
                          //           Get.toNamed(Routes.PACKAGELIST);
                          //         },
                          //         child: Text(
                          //           controller.currentPackageModel.value.data!
                          //               .packageName,
                          //           style: const TextStyle(
                          //             fontSize: 12,
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       ),
                        ],
                      );
                    }),
                    // Ui.offsetPopup()
                  ],
                ),
              ),
              elevation: 0,
              actions: [
                Obx(() {
                  return Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.redAccent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        badgeContent: Text(Get.find<InboxController>()
                            .newNotificationNum
                            .toString()),
                        child: IconButton(
                            onPressed: () {
                              Get.lazyPut<RechargeController>(
                                () => RechargeController(),
                              );
                              Get.find<InboxController>().removeNewMsgNum();
                              Get.toNamed(Routes.Notification_View);
                            },
                            icon: const Icon(
                              CupertinoIcons.bell,
                              color: Colors.white70,
                            )),
                      )
                    ],
                  );
                }),
                IconButton(
                    onPressed: () {
                      controller.getAllDisablePermission();
                      Get.put(WithdrawController());
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white70,
                    )),
              ],
            ),
          ),
          body: Obx(() {
            return RefreshIndicator(
              color: const Color(0xFF652981),
              onRefresh: () async {
                controller.refreshHome();
              },
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Get.find<AuthService>().currentUser.value.kyc_status == "none"
                      ? Container()
                      : Get.find<AuthService>().currentUser.value.kyc_status ==
                              "required"
                          ? Card(
                              color: Colors.red.withOpacity(.4),
                              child: ListTile(
                                title: Text(
                                  "আপনার NID'র তথ্য দিয়ে রেজিস্ট্রেশন নিশ্চিত করুন",
                                  style: TextStyle(fontSize: 12),
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    Get.put(SignupController());
                                    Get.find<SignupController>()
                                        .checkCameraPermission();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: _size.width * .2,
                                    decoration:
                                        Ui.getBoxDecoration(radius: 5.0),
                                    child: Center(
                                      child: Text(
                                        "তথ্য দিন",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Get.find<AuthService>()
                                      .currentUser
                                      .value
                                      .kyc_status ==

                                  "rejected"
                              ? Card(
                                  color: Colors.red.withOpacity(.4),
                                  child: ListTile(
                                    title: Text(
                                      "আপনার এনআইডি ও ছবির মিল না থাকায় রেজিষ্ট্রেশন সফল হয়নি। আগামী ৭২ ঘন্টার মধ্যে আমাদের প্রতিনিধি আপনার সাথে যোগাযোগ করবে। বিস্তারিতঃ ০৯৬১৩৮২৮৪৮২",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    trailing: InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.NEWNID);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: _size.width * .2,
                                        decoration:
                                            Ui.getBoxDecoration(radius: 5.0),
                                        child: Center(
                                          child: Text(
                                            "তথ্য দিন",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                  AnimationConfiguration.staggeredList(
                    position: 0,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Container(
                          //height: 180,
                          width: _size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 20, right: 20, bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // controller.changeState();
                                      },
                                      child: Container(
                                        height: 145,
                                        width: 145,
                                        decoration: Ui.getBoxDecoration(
                                          color: const Color(0xFF652981),
                                          radius: 100,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                              height: 145,
                                              width: 145,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color:
                                                      const Color(0xFF652981),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.white)),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: FittedBox(
                                                          fit: BoxFit.fitWidth,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              // const Image(
                                                              //   height: 15,
                                                              //   width: 15,
                                                              //   image: AssetImage('assets/images/taka.png'),
                                                              //   color: Colors.white,
                                                              // ),
                                                              Obx(() {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              2.0,
                                                                          right:
                                                                              5),
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    child: double.parse(controller.balance.value) >
                                                                            0.0
                                                                        ? Text(
                                                                            '$uniCodeTk ' +
                                                                                controller.balance.value.toString().replaceAll('tk', ''),
                                                                            style: const TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.bold),
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          )
                                                                        : Text(
                                                                            '$uniCodeTk ' +
                                                                                "0",
                                                                            style: const TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.bold),
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                  ),
                                                                );
                                                              }),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Balance'.tr,
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .primarydeepLightColor,
                                                          fontSize: 12,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print("hlw add balance");
                                        // FacebookService.logButtonClick();
                                        Get.toNamed(
                                            Routes.Add_Balance_Form_View);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Add Balance'.tr,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF652981),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF652981),
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                //Right Side 3 Item
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AmountWidget(
                                        image: 'assets/images/phone.png',
                                        amount:
                                            '${controller.dashboardReport.value.rechargeAmount}',
                                        title: 'Recharge'.tr,
                                        padding: "10"
                                        // colors: Colors.white,
                                        ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: Get.context!,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              content: Container(
                                                height: Get.size.height * .55,
                                                width: Get.size.width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            Routes
                                                                .MOBILE_BANK_TRANSACTION_HISTORY,
                                                            arguments: ['all']);
                                                      },
                                                      child: Container(
                                                        width: Get.width * .8,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Text(
                                                                'View All Transactions'
                                                                    .tr,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              Icon(
                                                                  Icons.history,
                                                                  color: Colors
                                                                      .deepPurple)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 25.0,
                                                        vertical: 10,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                height:
                                                                    Get.height *
                                                                        .2,
                                                                width:
                                                                    Get.width *
                                                                        .3,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            16),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .purple
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                            padding: EdgeInsets.all(
                                                                                4),
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                            ),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage("assets/mobilebank/bkash.jpg"),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      "Bkash Withdraw"
                                                                          .tr,
                                                                      maxLines:
                                                                          3,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            controller.dashboardReport.value.mbankingTotal == null
                                                                                ? Text(
                                                                                    "0.0",
                                                                                    style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                                  )
                                                                                :controller.dashboardReport.value.mbankingTotal!
                                                                                .where((test) => test.mfsName == "bKash")
                                                                                .toList().isEmpty?  Text(
                                                                              "0.0",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ): Text(
                                                                                    controller.dashboardReport.value.mbankingTotal!
                                                                                        .where((test) => test.mfsName == "bKash")
                                                                                        .toList() // Use an arrow function
                                                                                        .first
                                                                                        .totalAmount
                                                                                        .toString(),
                                                                                    style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                            Text(
                                                                              "Tk",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        // Text(
                                                                        //   "77",
                                                                        //   style: Theme.of(context)
                                                                        //       .textTheme
                                                                        //       .caption!
                                                                        //       .copyWith(color: Colors.white),
                                                                        // ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height:
                                                                    Get.height *
                                                                        .2,
                                                                width:
                                                                    Get.width *
                                                                        .3,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            16),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .deepPurpleAccent
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                            padding: EdgeInsets.all(
                                                                                4),
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                            ),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage("assets/mobilebank/nagad.png"),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      "Nagad Withdraw"
                                                                          .tr,
                                                                      maxLines:
                                                                          3,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            controller.dashboardReport.value.mbankingTotal == null
                                                                                ? Text(
                                                                              "0.0",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            )
                                                                                :controller.dashboardReport.value.mbankingTotal!
                                                                                .where((test) => test.mfsName == "Nagad")
                                                                                .toList().isEmpty?  Text(
                                                                              "0.0",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ):
                                                                            Text(
                                                                              controller.dashboardReport.value.mbankingTotal!
                                                                                  .where((test) => test.mfsName == "Nagad")
                                                                                  .toList() // Use an arrow function
                                                                                  .first
                                                                                  .totalAmount
                                                                                  .toString(),
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              "Tk",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        // Text(
                                                                        //   "77",
                                                                        //   style: Theme.of(context)
                                                                        //       .textTheme
                                                                        //       .caption!
                                                                        //       .copyWith(color: Colors.white),
                                                                        // ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                height:
                                                                    Get.height *
                                                                        .2,
                                                                width:
                                                                    Get.width *
                                                                        .3,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            16),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .purple
                                                                      .withOpacity(.1),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                            padding: EdgeInsets.all(
                                                                                4),
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                            ),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage("assets/mobilebank/rocket.png"),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      "Rocket Withdraw"
                                                                          .tr,
                                                                      maxLines:
                                                                          3,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            controller.dashboardReport.value.mbankingTotal == null
                                                                                ? Text(
                                                                              "0.0",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            )
                                                                                :controller.dashboardReport.value.mbankingTotal!
                                                                                .where((test) => test.mfsName == "rocket")
                                                                                .toList().isEmpty?  Text(
                                                                              "0.0",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ):
                                                                            Text(
                                                                              controller.dashboardReport.value.mbankingTotal!
                                                                                  .where((test) => test.mfsName == "rocket")
                                                                                  .toList() // Use an arrow function
                                                                                  .first
                                                                                  .totalAmount
                                                                                  .toString(),
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              "Tk",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        // Text(
                                                                        //   "77",
                                                                        //   style: Theme.of(context)
                                                                        //       .textTheme
                                                                        //       .caption!
                                                                        //       .copyWith(color: Colors.white),
                                                                        // ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height:
                                                                    Get.height *
                                                                        .2,
                                                                width:
                                                                    Get.width *
                                                                        .3,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            16),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .deepPurpleAccent
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                            padding: EdgeInsets.all(
                                                                                4),
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                            ),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage("assets/mobilebank/meghna.png"),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      "Meghna Withdraw"
                                                                          .tr,
                                                                      maxLines:
                                                                          3,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            controller.dashboardReport.value.mbankingTotal == null
                                                                                ? Text(
                                                                              "0.0",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            )
                                                                                :controller.dashboardReport.value.mbankingTotal!
                                                                                .where((test) => test.mfsName == "meghna")
                                                                                .toList().isEmpty?  Text(
                                                                              "0.0",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ):
                                                                            Text(
                                                                              controller.dashboardReport.value.mbankingTotal!
                                                                                  .where((test) => test.mfsName == "meghna")
                                                                                  .toList() // Use an arrow function
                                                                                  .first
                                                                                  .totalAmount
                                                                                  .toString(),
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              "Tk",
                                                                              style: TextStyle(color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        // Text(
                                                                        //   "77",
                                                                        //   style: Theme.of(context)
                                                                        //       .textTheme
                                                                        //       .caption!
                                                                        //       .copyWith(color: Colors.white),
                                                                        // ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // actions: <Widget>[

                                              // ],
                                            );
                                          },
                                        );
                                      },
                                      child: AmountWidget(
                                          image:
                                              'assets/images/mobile_banking.png',
                                          amount:
                                              '${controller.dashboardReport.value.mbanking}',
                                          colors: const Color(0xFF652981),
                                          title: 'mBanking'.tr,
                                          padding: "3"),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    AmountWidget(
                                        image: 'assets/images/bill_payment.png',
                                        amount:controller.dashboardReport.value.billPayment == null ? "0.0":
                                            '${controller.dashboardReport.value.billPayment}',
                                        colors: const Color(0xFF652981),
                                        title: 'Bill Pay'.tr,
                                        padding: "10"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  AnimationConfiguration.staggeredList(
                      position: 2,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: HomeSliderWidget(),
                          ))),

                  //banner
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //   child: Container(
                  //     width: _size.width,
                  //     color: Color(0xFF652981),
                  //     child: Image(
                  //       image: AssetImage('assets/banner.jpeg'),
                  //       fit: BoxFit.contain,
                  //     ),
                  //   ),
                  // ),
                  // controller.AdBannerLoad.value == true
                  //     ? ImageSlideshow(
                  //         /// Width of the [ImageSlideshow].
                  //         width: double.infinity,
                  //
                  //         /// Height of the [ImageSlideshow].
                  //         height: 110,
                  //
                  //         /// The page to show when first creating the [ImageSlideshow].
                  //         initialPage: 0,
                  //
                  //         /// The color to paint the indicator.
                  //         indicatorColor: Colors.blue,
                  //
                  //         /// The color to paint behind th indicator.
                  //         indicatorBackgroundColor: Colors.grey,
                  //
                  //         /// The widgets to display in the [ImageSlideshow].
                  //         /// Add the sample image file into the images folder
                  //         children: List.generate(controller.AdBanner.length, (index) {
                  //           return Image.network(
                  //             controller.AdBanner[index].advertisementBanner!,
                  //             fit: BoxFit.contain,
                  //           );
                  //         }),
                  //         //     [
                  //         //   Image.asset(
                  //         //     'assets/banner1.jpg',
                  //         //     fit: BoxFit.cover,
                  //         //   ),
                  //         //   // Image.asset(
                  //         //   //   'images/sample_image_3.jpg',
                  //         //   //   fit: BoxFit.cover,
                  //         //   // ),
                  //         // ],
                  //
                  //         /// Called whenever the page in the center of the viewport changes.
                  //         onPageChanged: (value) {
                  //           print('Page changed: $value');
                  //         },
                  //
                  //         /// Auto scroll interval.
                  //         /// Do not auto scroll with null or 0.
                  //         autoPlayInterval: 8000,
                  //
                  //         /// Loops back to first slide.
                  //         isLoop: true,
                  //       )
                  //     : Container(),
                  const SizedBox(
                    height: 20,
                  ),

                  //Card Option Widget
                  AnimationConfiguration.staggeredList(
                      position: 2,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(child: HomeTopOptionWidget()),
                      )),

                  // SizedBox(
                  //   height: 120,
                  // ),
                ],
              ),
            );
          })),
    );
  }
}

class ProfileImage extends StatefulWidget {
  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  PickedFile? imageFile = null;

  String? _imagepath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LoadImage();
  }

  // void _openCamera(BuildContext context) async {
  //   final pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 600,
  //   );

  //   // Ui.customLoaderDialog();

  //   setState(() {
  //     imageFile = pickedFile!;
  //   });

  //   if (pickedFile != null) {
  //     SharedPreferences saveimage = await SharedPreferences.getInstance();
  //     saveimage.setString("imagepath", imageFile!.path);
  //     print("save");
  //   }
  // }

  Future<void> PickImage(String type) async {
    // await DeleteIamge();
    var pickedFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    // Ui.customLoaderDialog();
    setState(() {
      imageFile = pickedFile! as PickedFile?;
    });
    SaveImage();
    await LoadImage();
  }

  Future<void> SaveImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString("imagepath", imageFile!.path);
  }

  Future<void> LoadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveimage.getString("imagepath");
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showPopup(context);
      },
      child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: _imagepath != null
              ? ClipOval(
                  child: Image.file(
                  File(_imagepath!),
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ))
              : (imageFile == null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://thumbs.dreamstime.com/b/default-avatar-profile-flat-icon-vector-contact-symbol-illustration-184752213.jpg',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Image(
                            image: AssetImage('assets/images/user2.png'),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Image(
                            image: AssetImage('assets/images/user2.png'),
                          ),
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Image.file(
                      File(_imagepath!),
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ))),
    );
  }

  showPopup(context) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            //title: Text('Select '),
            content: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text('Photo Library'.tr),
                      onTap: () {
                        PickImage('photo');
                        Get.back();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Camera'.tr),
                    onTap: () {
                      PickImage('camera');
                      Get.back();
                    },
                  ),
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
