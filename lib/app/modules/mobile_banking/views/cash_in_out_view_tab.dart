import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/widgets/mobile_bank_drawer.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../../../routes/app_pages.dart';
import '../controllers/mobile_banking_controller.dart';

class MobileBankingCashINOutTabView extends GetView<MobileBankingController> {
  const MobileBankingCashINOutTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        endDrawer: MobileBankDrawer(),
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          elevation: 0,
          title:
              Text('Mobile Banking'.tr, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
          width: _size.width,
          height: _size.height,
          // margin: EdgeInsets.all(20),
          // decoration: Ui.getBoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  height: 100,
                  child: TabBar(
                    controller: controller.tabController,
                    indicatorColor: AppColors.primaryColor,
                    indicator: ShapeDecoration(
                        color: AppColors.primaryColor.withOpacity(.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    unselectedLabelColor: AppColors.homeTextColor3,
                    labelColor: AppColors.primaryColor,
                    onTap: (int? index) {
                      controller.currentTabIndex.value = index!;
                    },
                    tabs: [
                      Tab(
                          icon: Container(
                        height: 60,
                        width: _size.width * .25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                                radius: 12, child: Icon(Icons.arrow_downward)),
                            Text(
                              'Cash In'.tr,
                              style: const TextStyle(
                                // color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                // shadows: [
                                //   Shadow(
                                //       color: Colors.black.withOpacity(0.4),
                                //       offset: Offset(2, 2),
                                //       blurRadius: 1),
                                // ]
                              ),
                            ),
                          ],
                        ),
                      )),
                      Tab(
                          icon: Container(
                        height: 60,
                        width: _size.width * .25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                                radius: 12, child: Icon(Icons.arrow_upward)),
                            Text(
                              'Cash Out'.tr,
                              style: const TextStyle(
                                // color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                // shadows: [
                                //   Shadow(
                                //       color: Colors.black.withOpacity(0.4),
                                //       offset: Offset(2, 2),
                                //       blurRadius: 1),
                                // ]
                              ),
                            ),
                          ],
                        ),
                      )),
                      Tab(
                          icon: Container(
                        height: 60,
                        width: _size.width * .25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                                radius: 12, child: Icon(Icons.arrow_upward)),
                            Text(
                              'Money Out'.tr,
                              style: const TextStyle(
                                // color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                // shadows: [
                                //   Shadow(
                                //       color: Colors.black.withOpacity(0.4),
                                //       offset: Offset(2, 2),
                                //       blurRadius: 1),
                                // ]
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController!,
                  children: [
                    // cash in
                    Get.find<HomeController>()
                                .getPermissionModel
                                .value
                                .data!
                                .allowCashin ==
                            0
                        ? Container(
                            height: Get.height * .8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                      "আপনার বর্তমান প্যাকেজটির জন্য এম-ব্যাংকিং Cash In সার্ভিস টি অনুমোদিত নয় ."),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Card(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,

                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                              255, 43, 42, 43)
                                                          .withOpacity(0.2),
                                                      blurRadius: 2,
                                                      offset: Offset(0, -2)),
                                                ],
                                                //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        Routes.PACKAGELIST);

                                                    // controller.newNIDVerificationController();
                                                  },
                                                  child: Container(
                                                    width: _size.width,
                                                    height: _size.width * .1,
                                                    decoration:
                                                        Ui.getBoxDecoration(
                                                            color: Color(
                                                                0xFF652981),
                                                            radius: 10),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          'Upgrade Your Package'
                                                              .tr,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: _size.width,
                            height: _size.height,
                            child: SingleChildScrollView(
                              child: Obx(() {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15),
                                  child: Container(
                                    height: _size.height,
                                    width: _size.width,
                                    color: Colors.white,
                                    child: controller
                                            .mfsGateWayListCashInOut.isEmpty
                                        ? Ui.customLoader()
                                        : GridView.count(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            primary: false,
                                            shrinkWrap: true,
                                            crossAxisCount: 1,
                                            crossAxisSpacing: 18.0,
                                            mainAxisSpacing: 8.0,
                                            childAspectRatio: 4.0,
                                            children: List.generate(
                                                controller
                                                    .mfsGateWayListCashInOut
                                                    .length, (index) {
                                              var data = controller
                                                      .mfsGateWayListCashInOut[
                                                  index];
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.imageUrl.value =
                                                      data.gatewayLogoUrl!;
                                                  controller.gateWayID.value =
                                                      data.gatewayId!
                                                          .toString();
                                                  Get.toNamed(
                                                      Routes.MBANKINGNUMAMOUNT,
                                                      arguments: [
                                                        data.gatewayId
                                                      ]);
                                                },
                                                child: AnimationConfiguration
                                                    .staggeredGrid(
                                                  position: index,
                                                  duration: const Duration(
                                                      milliseconds: 475),
                                                  columnCount: 1,
                                                  child: SlideAnimation(
                                                    horizontalOffset: 50.0,
                                                    child: FadeInAnimation(
                                                      child: Container(
                                                        width: _size.width,
                                                        height:
                                                            _size.height * .02,
                                                        decoration:
                                                            Ui.getBoxDecoration(
                                                          color: Colors.white,
                                                          radius: 5,
                                                        ),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),

                                                                    Container(
                                                                      height:
                                                                          80,
                                                                      width: 80,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              data.gatewayLogoUrl!,
                                                                          imageBuilder: (context, imageProvider) =>
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          placeholder: (context, url) =>
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage('assets/images/default_image.png'),
                                                                            ),
                                                                          ),
                                                                          errorWidget: (context, url, error) =>
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage('assets/images/default_image.png'),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                    Text(
                                                                      data.gatewayName!,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),

                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),

                                                                    // Text(
                                                                    //   Get.find<AuthService>()
                                                                    //           .currentUser
                                                                    //           .value
                                                                    //           .mobileNumber ??
                                                                    //       '',
                                                                    //   style: TextStyle(
                                                                    //     fontSize: 12,
                                                                    //     color: Colors.black,
                                                                    //   ),
                                                                    // ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })),
                                  ),
                                );
                              }),
                            ),
                          ),

                    // Cash Out
                    Get.find<HomeController>()
                                .getPermissionModel
                                .value
                                .data!
                                .allowCashout ==
                            0
                        ? Container(
                            height: Get.height * .8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                      "আপনার বর্তমান প্যাকেজটির জন্য এম-ব্যাংকিং Cash Out সার্ভিস টি অনুমোদিত নয় ."),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Card(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,

                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                              255, 43, 42, 43)
                                                          .withOpacity(0.2),
                                                      blurRadius: 2,
                                                      offset: Offset(0, -2)),
                                                ],
                                                //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        Routes.PACKAGELIST);

                                                    // controller.newNIDVerificationController();
                                                  },
                                                  child: Container(
                                                    width: _size.width,
                                                    height: _size.width * .1,
                                                    decoration:
                                                        Ui.getBoxDecoration(
                                                            color: Color(
                                                                0xFF652981),
                                                            radius: 10),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          'Upgrade Your Package'
                                                              .tr,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: _size.width,
                            height: _size.height,
                            child: SingleChildScrollView(
                              child: Obx(() {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15),
                                  child: Container(
                                    height: _size.height,
                                    width: _size.width,
                                    color: Colors.white,
                                    child: controller
                                            .mfsGateWayListCashInOut.isEmpty
                                        ? Ui.customLoader()
                                        : GridView.count(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            primary: false,
                                            shrinkWrap: true,
                                            crossAxisCount: 1,
                                            crossAxisSpacing: 18.0,
                                            mainAxisSpacing: 8.0,
                                            childAspectRatio: 4.0,
                                            children: List.generate(
                                                controller
                                                    .mfsGateWayListCashInOut
                                                    .length, (index) {
                                              var data = controller
                                                      .mfsGateWayListCashInOut[
                                                  index];
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.imageUrl.value =
                                                      data.gatewayLogoUrl!;
                                                  controller.gateWayID.value =
                                                      data.gatewayId!
                                                          .toString();
                                                  print(
                                                      "hlw gateway ****** ${controller.gateWayID.value}");
                                                  Get.toNamed(
                                                      Routes.MBANKINGNUMAMOUNT,
                                                      arguments: [
                                                        data.gatewayId
                                                      ]);
                                                },
                                                child: AnimationConfiguration
                                                    .staggeredGrid(
                                                  position: index,
                                                  duration: const Duration(
                                                      milliseconds: 475),
                                                  columnCount: 1,
                                                  child: SlideAnimation(
                                                    horizontalOffset: 50.0,
                                                    child: FadeInAnimation(
                                                      child: Container(
                                                        width: _size.width,
                                                        height:
                                                            _size.height * .02,
                                                        decoration:
                                                            Ui.getBoxDecoration(
                                                          color: Colors.white,
                                                          radius: 5,
                                                        ),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),

                                                                    Container(
                                                                      height:
                                                                          80,
                                                                      width: 80,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              data.gatewayLogoUrl!,
                                                                          imageBuilder: (context, imageProvider) =>
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          placeholder: (context, url) =>
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage('assets/images/default_image.png'),
                                                                            ),
                                                                          ),
                                                                          errorWidget: (context, url, error) =>
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage('assets/images/default_image.png'),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                    Text(
                                                                      data.gatewayName!,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),

                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),

                                                                    // Text(
                                                                    //   Get.find<AuthService>()
                                                                    //           .currentUser
                                                                    //           .value
                                                                    //           .mobileNumber ??
                                                                    //       '',
                                                                    //   style: TextStyle(
                                                                    //     fontSize: 12,
                                                                    //     color: Colors.black,
                                                                    //   ),
                                                                    // ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })),
                                  ),
                                );
                              }),
                            ),
                          ),

                    // money out

                    Get.find<HomeController>()
                                .getPermissionModel
                                .value
                                .data!
                                .allowMoneyout ==
                            0
                        ? Container(
                            height: Get.height * .8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                      "আপনার বর্তমান প্যাকেজটির জন্য এম-ব্যাংকিং Money Out সার্ভিস টি অনুমোদিত নয় ."),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Card(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,

                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                              255, 43, 42, 43)
                                                          .withOpacity(0.2),
                                                      blurRadius: 2,
                                                      offset: Offset(0, -2)),
                                                ],
                                                //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        Routes.PACKAGELIST);

                                                    // controller.newNIDVerificationController();
                                                  },
                                                  child: Container(
                                                    width: _size.width,
                                                    height: _size.width * .1,
                                                    decoration:
                                                        Ui.getBoxDecoration(
                                                            color: Color(
                                                                0xFF652981),
                                                            radius: 10),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          'Upgrade Your Package'
                                                              .tr,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: _size.width,
                            height: _size.height,
                            child: SingleChildScrollView(
                              child: Obx(() {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15),
                                  child: Container(
                                    height: _size.height,
                                    width: _size.width,
                                    color: Colors.white,
                                    child: controller.paymentTypesMFS.isEmpty
                                        ? Ui.customLoader()
                                        : GridView.count(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            primary: false,
                                            shrinkWrap: true,
                                            crossAxisCount: 1,
                                            crossAxisSpacing: 18.0,
                                            mainAxisSpacing: 8.0,
                                            childAspectRatio: 4.0,
                                            children: List.generate(
                                                controller.paymentTypesMFS
                                                    .where((p) =>
                                                        p.name == "Nagad" ||
                                                        p.name == "Bkash")
                                                    .length, (index) {
                                              var data = controller
                                                  .paymentTypesMFS
                                                  .where((p) =>
                                                      p.name == "Nagad" ||
                                                      p.name == "Bkash")
                                                  .toList()[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.imageUrl.value =
                                                      data.logo!;
                                                  controller.gateWay.value =
                                                      data.id!.toString();
                                                  Get.toNamed(
                                                      Routes.MBANKINGNUMAMOUNT);
                                                },
                                                child: AnimationConfiguration
                                                    .staggeredGrid(
                                                  position: index,
                                                  duration: const Duration(
                                                      milliseconds: 475),
                                                  columnCount: 1,
                                                  child: SlideAnimation(
                                                    horizontalOffset: 50.0,
                                                    child: FadeInAnimation(
                                                      child: Container(
                                                        width: _size.width,
                                                        height:
                                                            _size.height * .02,
                                                        decoration:
                                                            Ui.getBoxDecoration(
                                                          color: Colors.white,
                                                          radius: 5,
                                                        ),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),

                                                                    Container(
                                                                      height:
                                                                          80,
                                                                      width: 80,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              data.logo!,
                                                                          imageBuilder: (context, imageProvider) =>
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          placeholder: (context, url) =>
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage('assets/images/default_image.png'),
                                                                            ),
                                                                          ),
                                                                          errorWidget: (context, url, error) =>
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage('assets/images/default_image.png'),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                    Text(
                                                                      data.name!,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),

                                                                    const SizedBox(
                                                                      width: 15,
                                                                    ),

                                                                    // Text(
                                                                    //   Get.find<AuthService>()
                                                                    //           .currentUser
                                                                    //           .value
                                                                    //           .mobileNumber ??
                                                                    //       '',
                                                                    //   style: TextStyle(
                                                                    //     fontSize: 12,
                                                                    //     color: Colors.black,
                                                                    //   ),
                                                                    // ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })),
                                  ),
                                );
                              }),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
