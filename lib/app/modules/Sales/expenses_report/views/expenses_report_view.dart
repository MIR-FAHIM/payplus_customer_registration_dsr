import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/expenses_report/widgets/piecart.dart';

import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/expenses_report_controller.dart';

class ExpensesReportView extends GetView<ExpensesReportController> {
  ExpensesReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size(65, 65),
          child: AppBar(
            backgroundColor: const Color(0xFF652981),
            centerTitle: true,
            title: Text('Consumption'.tr),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.Notification_View);
                  },
                  icon: const Icon(
                    CupertinoIcons.bell,
                    color: Colors.white70,
                  )),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.expensesHistoryLoaded.isTrue) {
            return Container(
              width: _size.width,
              // margin: EdgeInsets.all(20),
              margin: const EdgeInsets.only(
                  left: 20, top: 5, right: 20, bottom: 20),
              // decoration: Ui.getBoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  SizedBox(
                    // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    height: 50,
                    child: TabBar(
                      controller: controller.tabController,
                      indicatorColor: AppColors.primaryColor,
                      // indicator: ShapeDecoration(
                      //     color: AppColors.primaryColor,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     )),
                      unselectedLabelColor: AppColors.homeTextColor3,
                      labelColor: AppColors.primaryColor,

                      onTap: (int? index) {
                        controller.currentTabIndex.value = index!;
                        controller.getExpensesHistory(isFirstTimeCall: false);
                      },
                      tabs: [
                        Tab(
                            icon: Text(
                          'Personal'.tr,
                          style: const TextStyle(
                            // color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // shadows: [
                            //   Shadow(
                            //       color: Colors.black.withOpacity(0.4),
                            //       offset: Offset(2, 2),
                            //       blurRadius: 1),
                            // ]
                          ),
                        )),
                        Tab(
                            icon: Text(
                          'Commercial'.tr,
                          style: const TextStyle(
                            // color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // shadows: [
                            //   Shadow(
                            //       color: Colors.black.withOpacity(0.4),
                            //       offset: Offset(2, 2),
                            //       blurRadius: 1),
                            // ]
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController!,
                      children: [
                        //ব্যক্তিগত
                        Obx(() {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Text(
                                            'Select Start Date'.tr,
                                            style: TextStyle(
                                                color: AppColors.homeTextColor3,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.selectDate(
                                                context, 'start');
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 3),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.42,
                                            decoration: BoxDecoration(
                                              color: AppColors
                                                  .primarydeepLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(width: 20),
                                                  Image.asset(
                                                    'assets/icons/calender.png',
                                                    height: 10,
                                                    width: 10,
                                                    color: AppColors
                                                        .homeTextColor1,
                                                  ),
                                                  IconGap(),
                                                  Text(
                                                    "তারিখ",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .homeTextColor1,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Image.asset(
                                                    'assets/icons/down_arrow.png',
                                                    height: 10,
                                                    width: 10,
                                                    color: AppColors
                                                        .homeTextColor1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Text(
                                            'Select End Date'.tr,
                                            style: TextStyle(
                                                color: AppColors.homeTextColor3,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.selectDate(
                                                context, 'end');
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 3),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.42,
                                            decoration: BoxDecoration(
                                              color: AppColors
                                                  .primarydeepLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(width: 20),
                                                  Image.asset(
                                                    'assets/icons/calender.png',
                                                    height: 10,
                                                    width: 10,
                                                    color: AppColors
                                                        .homeTextColor1,
                                                  ),
                                                  IconGap(),
                                                  Text(
                                                    "তারিখ",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .homeTextColor1,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Image.asset(
                                                    'assets/icons/down_arrow.png',
                                                    height: 10,
                                                    width: 10,
                                                    color: AppColors
                                                        .homeTextColor1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'Total Expense'.tr,
                                        style: TextStyle(
                                            color: AppColors.homeTextColor3,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 3),
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      decoration: BoxDecoration(
                                        color: AppColors.homeCardBg,
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            "$uniCodeTk ${controller.expensesHistory.value.allTotal}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 210,
                                  child: ExpensePerosnalPieChart(),
                                ),
                                Column(
                                  children: List.generate(
                                      controller.expensesHistory.value
                                          .expensesdata!.length, (index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            Routes.EXPENSES_DETAILS_BY_HEAD,
                                            arguments: [
                                              'Personal',
                                              controller
                                                  .expensesHistory
                                                  .value
                                                  .expensesdata![index]
                                                  .idExpenseHead,
                                              controller
                                                  .expensesHistory
                                                  .value
                                                  .expensesdata![index]
                                                  .expenseHead,
                                            ]);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.95,
                                          // height: 35,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF2F3F3),
                                            // border: Border.all(
                                            //     color: Theme.of(context)
                                            //         .primaryColor,
                                            //     width: 1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 15),
                                                  child: Text(
                                                    controller
                                                        .expensesHistory
                                                        .value
                                                        .expensesdata![index]
                                                        .expenseHead!,
                                                    style: TextStyle(
                                                        color: index < 4
                                                            ? controller
                                                                .color[index]
                                                            : Colors.black38,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                  "${controller.expensesHistory.value.expensesdata![index].total} $uniCodeTk",
                                                  style: TextStyle(
                                                      color: index < 4
                                                          ? controller
                                                              .color[index]
                                                          : Colors.black38,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                          );
                        }),

                        Obx(() {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Text(
                                            'Select Start Date'.tr,
                                            style: TextStyle(
                                                color: AppColors.homeTextColor3,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.selectDate(
                                                context, 'start');
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 3),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.42,
                                            decoration: BoxDecoration(
                                              color: AppColors
                                                  .primarydeepLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(width: 20),
                                                  Image.asset(
                                                    'assets/icons/calender.png',
                                                    height: 10,
                                                    width: 10,
                                                    color: AppColors
                                                        .homeTextColor1,
                                                  ),
                                                  IconGap(),
                                                  Text(
                                                    "তারিখ",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .homeTextColor1,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Image.asset(
                                                    'assets/icons/down_arrow.png',
                                                    height: 10,
                                                    width: 10,
                                                    color: AppColors
                                                        .homeTextColor1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Text(
                                            'Select End Date'.tr,
                                            style: TextStyle(
                                                color: AppColors.homeTextColor3,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.selectDate(
                                                context, 'end');
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 3),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.42,
                                            decoration: BoxDecoration(
                                              color: AppColors
                                                  .primarydeepLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(width: 20),
                                                  Image.asset(
                                                    'assets/icons/calender.png',
                                                    height: 10,
                                                    width: 10,
                                                    color: AppColors
                                                        .homeTextColor1,
                                                  ),
                                                  IconGap(),
                                                  Text(
                                                    "তারিখ",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .homeTextColor1,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Image.asset(
                                                    'assets/icons/down_arrow.png',
                                                    height: 10,
                                                    width: 10,
                                                    color: AppColors
                                                        .homeTextColor1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'Total Expense'.tr,
                                        style: TextStyle(
                                            color: AppColors.homeTextColor3,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 3),
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      decoration: BoxDecoration(
                                        color: AppColors.homeCardBg,
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            "$uniCodeTk ${controller.expensesHistory.value.allTotal}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 210,
                                  child: ExpensePerosnalPieChart(),
                                ),
                                Column(
                                  children: List.generate(
                                      controller.expensesHistory.value
                                          .expensesdata!.length, (index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            Routes.EXPENSES_DETAILS_BY_HEAD,
                                            arguments: [
                                              'Business',
                                              controller
                                                  .expensesHistory
                                                  .value
                                                  .expensesdata![index]
                                                  .idExpenseHead,
                                              controller
                                                  .expensesHistory
                                                  .value
                                                  .expensesdata![index]
                                                  .expenseHead,
                                            ]);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.95,
                                          // height: 35,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF2F3F3),
                                            // border: Border.all(
                                            //     color: Theme.of(context)
                                            //         .primaryColor,
                                            //     width: 1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 15),
                                                  child: Text(
                                                    controller
                                                        .expensesHistory
                                                        .value
                                                        .expensesdata![index]
                                                        .expenseHead!,
                                                    style: TextStyle(
                                                        color: index < 4
                                                            ? controller
                                                                .color[index]
                                                            : Colors.black38,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                  "${controller.expensesHistory.value.expensesdata![index].total} $uniCodeTk",
                                                  style: TextStyle(
                                                      color: index < 4
                                                          ? controller
                                                              .color[index]
                                                          : Colors.black38,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Ui.customLoader());
          }
        }),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.ADD_NEW_EXPENSES);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "+  " + 'Add New Expense'.tr,
                    style: TextStyle(
                        color: AppColors.homeCardBg,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  SizedBox IconGap() {
    return const SizedBox(
      width: 4,
    );
  }
}
