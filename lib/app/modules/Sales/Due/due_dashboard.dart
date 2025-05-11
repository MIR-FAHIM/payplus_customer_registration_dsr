import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/Widget/piecart.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/Widget/tab_bar.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/customer_wise_due_list.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/one_month_due_report.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class DueDashBoard extends StatefulWidget {
  const DueDashBoard({Key? key}) : super(key: key);

  @override
  State<DueDashBoard> createState() => _DueDashBoardState();
}

class _DueDashBoardState extends State<DueDashBoard>
    with TickerProviderStateMixin {
  TabController? tabController;
  int currentTabIndex = 0;
  void onTabChange() {
    setState(() {
      currentTabIndex = tabController!.index;
      print(currentTabIndex);
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    // tabController.addListener(() {
    //   onTabChange();
    // });

    super.initState();
  }

  Map<String, double> dataMap = {
    '1 month'.tr: 5,
    '3 month'.tr: 3,
    '6 month'.tr: 2,
    '1 year'.tr: 2,
  };
  final colorList = <Color>[
    Color.fromARGB(201, 10, 199, 73),
    Color.fromARGB(255, 131, 2, 143),
    Color.fromARGB(230, 255, 164, 80),
    Color.fromARGB(221, 250, 87, 87),
  ];

  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text('Transactions'.tr),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.Notification_View);
                  },
                  icon: Icon(
                    CupertinoIcons.bell,
                    color: Colors.white70,
                  )),
            ],
          ),
        ),
        body: Container(
          width: _size.width,
          // margin: EdgeInsets.all(20),
          margin: EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 20),
          // decoration: Ui.getBoxDecoration(color: Colors.white),
          child: Column(
            children: [
              DashBoardTabBar(tabController: tabController!),
              Container(),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      //পাওনা হিসাব
                      Container(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Container(
                                  child: PieChartSample2(),
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                // width: _size.width * 0.45,
                                height: 100,
                                // color: AppColors.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    'Total debit in amount'.tr +
                                        ' ' +
                                        ':' +
                                        ' ' +
                                        '10,500'.tr,
                                    style: TextStyle(
                                        color: AppColors.homeTextColor1,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                  width: _size.width,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(OneMonthReport());
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.95,
                                            // height: 35,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF2F3F3),
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
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 45,
                                                        height: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFE2E2E2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/due/hand.png',
                                                              width: 25,
                                                              height: 25,
                                                              color: Color(
                                                                  0xFF00AEF0),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                          '1 month due'.tr,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF00AEF0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "১০,২০০",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF00AEF0),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5),
                                                        child: Image.asset(
                                                          'assets/due/৳.png',
                                                          height: 13,
                                                          width: 13,
                                                          color:
                                                              Color(0xFF00AEF0),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(OneMonthReport());
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.95,
                                            // height: 35,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF2F3F3),
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
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 45,
                                                        height: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFE2E2E2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/due/hand.png',
                                                              width: 25,
                                                              height: 25,
                                                              color: Color(
                                                                  0xFF00A653),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                          '3 month due'.tr,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF00A653),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "১০,২০০",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF00A653),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5),
                                                        child: Image.asset(
                                                          'assets/due/৳.png',
                                                          height: 13,
                                                          width: 13,
                                                          color:
                                                              Color(0xFF00A653),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(OneMonthReport());
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.95,
                                            // height: 35,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF2F3F3),
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
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 45,
                                                        height: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFE2E2E2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/due/hand.png',
                                                              width: 25,
                                                              height: 25,
                                                              color: Color(
                                                                  0xFF2F3192),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                          '6 month due'.tr,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF2F3192),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "১০,২০০",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF2F3192),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5),
                                                        child: Image.asset(
                                                          'assets/due/৳.png',
                                                          height: 13,
                                                          width: 13,
                                                          color:
                                                              Color(0xFF2F3192),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(OneMonthReport());
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.95,
                                            // height: 35,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF2F3F3),
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
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 45,
                                                        height: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFE2E2E2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/due/hand.png',
                                                              width: 25,
                                                              height: 25,
                                                              color: Color(
                                                                  0xFFE61A23),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                          '6 month due'.tr,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFE61A23),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "১০,২০০",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFE61A23),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5),
                                                        child: Image.asset(
                                                          'assets/due/৳.png',
                                                          height: 13,
                                                          width: 13,
                                                          color:
                                                              Color(0xFFE61A23),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(CustomerWiseDueList());
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'Due according to customer'.tr,
                                          style: TextStyle(
                                              color: AppColors.homeCardBg,
                                              fontWeight: FontWeight.bold),
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

                      Container(),
                      //দেনা হিসাব
                      // Container(
                      //   child: Column(
                      //     children: [
                      //       Expanded(
                      //         flex: 1,
                      //         child: Container(
                      //           // width: _size.width * 0.45,
                      //           height: 100,
                      //           // color: AppColors.primaryColor,
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(top: 15),
                      //             child: Text(
                      //               'Total Credit in amount'.tr,
                      //               style: TextStyle(
                      //                   color: AppColors.homeTextColor2,
                      //                   fontSize: 22,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 3,
                      //         child: Container(
                      //           // width: _size.width * 0.45,
                      //           child: PieChart(
                      //             dataMap: dataMap,
                      //             colorList: colorList,
                      //             legendOptions: LegendOptions(
                      //               showLegendsInRow: false,
                      //               legendPosition: LegendPosition.right,
                      //               showLegends: true,
                      //               legendTextStyle: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //             chartValuesOptions: ChartValuesOptions(
                      //               showChartValueBackground: true,
                      //               showChartValues: true,
                      //               showChartValuesInPercentage: true,
                      //               showChartValuesOutside: false,
                      //               decimalPlaces: 1,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 6,
                      //         child: Container(
                      //             width: _size.width,
                      //             child: Column(
                      //               children: [
                      //                 SizedBox(
                      //                   height: 25,
                      //                 ),
                      //                 InkWell(
                      //                   onTap: () {
                      //                     Get.to(OneMonthCreditReport());
                      //                   },
                      //                   child: Container(
                      //                     width: MediaQuery.of(context)
                      //                             .size
                      //                             .width *
                      //                         0.95,
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.primaryLightColor,
                      //                       border: Border.all(
                      //                           color: Theme.of(context)
                      //                               .primaryColor,
                      //                           width: 1),
                      //                       borderRadius:
                      //                           BorderRadius.circular(10),
                      //                     ),
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child: Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment
                      //                                 .spaceBetween,
                      //                         children: [
                      //                           Text(
                      //                             '1 month debit'.tr,
                      //                             style: TextStyle(
                      //                                 color: AppColors
                      //                                     .primaryColor,
                      //                                 fontWeight:
                      //                                     FontWeight.bold),
                      //                           ),
                      //                           Row(
                      //                             children: [
                      //                               Text(
                      //                                 "১০,২০০/=",
                      //                                 style: TextStyle(
                      //                                     color: Color.fromARGB(
                      //                                         239, 7, 150, 54),
                      //                                     fontWeight:
                      //                                         FontWeight.bold),
                      //                               ),
                      //                               Icon(
                      //                                 Icons.arrow_forward,
                      //                                 size: 25,
                      //                                 color: Color(0xFF652981),
                      //                               ),
                      //                             ],
                      //                           )
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 15,
                      //                 ),
                      //                 InkWell(
                      //                   onTap: () {
                      //                     Get.to(OneMonthCreditReport());
                      //                   },
                      //                   child: Container(
                      //                     width: MediaQuery.of(context)
                      //                             .size
                      //                             .width *
                      //                         0.95,
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.primaryLightColor,
                      //                       border: Border.all(
                      //                           color: Theme.of(context)
                      //                               .primaryColor,
                      //                           width: 1),
                      //                       borderRadius:
                      //                           BorderRadius.circular(10),
                      //                     ),
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child: Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment
                      //                                 .spaceBetween,
                      //                         children: [
                      //                           Text(
                      //                             '3 month debit'.tr,
                      //                             style: TextStyle(
                      //                                 color: AppColors
                      //                                     .primaryColor,
                      //                                 fontWeight:
                      //                                     FontWeight.bold),
                      //                           ),
                      //                           Row(
                      //                             children: [
                      //                               Text(
                      //                                 "৫,৩০০/=",
                      //                                 style: TextStyle(
                      //                                     color: Color.fromARGB(
                      //                                         255,
                      //                                         162,
                      //                                         18,
                      //                                         175),
                      //                                     fontWeight:
                      //                                         FontWeight.bold),
                      //                               ),
                      //                               Icon(
                      //                                 Icons.arrow_forward,
                      //                                 size: 25,
                      //                                 color: Color(0xFF652981),
                      //                               ),
                      //                             ],
                      //                           )
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 15,
                      //                 ),
                      //                 InkWell(
                      //                   onTap: () {
                      //                     Get.to(OneMonthCreditReport());
                      //                   },
                      //                   child: Container(
                      //                     width: MediaQuery.of(context)
                      //                             .size
                      //                             .width *
                      //                         0.95,
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.primaryLightColor,
                      //                       border: Border.all(
                      //                           color: Theme.of(context)
                      //                               .primaryColor,
                      //                           width: 1),
                      //                       borderRadius:
                      //                           BorderRadius.circular(10),
                      //                     ),
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child: Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment
                      //                                 .spaceBetween,
                      //                         children: [
                      //                           Text(
                      //                             '6 month debit'.tr,
                      //                             style: TextStyle(
                      //                                 color: AppColors
                      //                                     .primaryColor,
                      //                                 fontWeight:
                      //                                     FontWeight.bold),
                      //                           ),
                      //                           Row(
                      //                             children: [
                      //                               Text(
                      //                                 "৩,৩২০/=",
                      //                                 style: TextStyle(
                      //                                     color: Color.fromARGB(
                      //                                         230, 230, 114, 7),
                      //                                     fontWeight:
                      //                                         FontWeight.bold),
                      //                               ),
                      //                               Icon(
                      //                                 Icons.arrow_forward,
                      //                                 size: 25,
                      //                                 color: Color(0xFF652981),
                      //                               ),
                      //                             ],
                      //                           )
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 15,
                      //                 ),
                      //                 InkWell(
                      //                   onTap: () {
                      //                     Get.to(OneMonthCreditReport());
                      //                   },
                      //                   child: Container(
                      //                     width: MediaQuery.of(context)
                      //                             .size
                      //                             .width *
                      //                         0.95,
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.primaryLightColor,
                      //                       border: Border.all(
                      //                           color: Theme.of(context)
                      //                               .primaryColor,
                      //                           width: 1),
                      //                       borderRadius:
                      //                           BorderRadius.circular(10),
                      //                     ),
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child: Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment
                      //                                 .spaceBetween,
                      //                         children: [
                      //                           Text(
                      //                             '1 year debit'.tr,
                      //                             style: TextStyle(
                      //                                 color: AppColors
                      //                                     .primaryColor,
                      //                                 fontWeight:
                      //                                     FontWeight.bold),
                      //                           ),
                      //                           Row(
                      //                             children: [
                      //                               Text(
                      //                                 "৩০৫০/=",
                      //                                 style: TextStyle(
                      //                                     color: Color.fromARGB(
                      //                                         221, 250, 87, 87),
                      //                                     fontWeight:
                      //                                         FontWeight.bold),
                      //                               ),
                      //                               Icon(
                      //                                 Icons.arrow_forward,
                      //                                 size: 25,
                      //                                 color: Color(0xFF652981),
                      //                               ),
                      //                             ],
                      //                           )
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 30,
                      //                 ),
                      //                 InkWell(
                      //                   onTap: () {
                      //                     Get.to(CustomerWiseDueList());
                      //                   },
                      //                   child: Container(
                      //                     width: MediaQuery.of(context)
                      //                             .size
                      //                             .width *
                      //                         0.95,
                      //                     height: 50,
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.primaryColor,
                      //                       borderRadius:
                      //                           BorderRadius.circular(10),
                      //                     ),
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child: Center(
                      //                         child: Text(
                      //                           'supplier according to customer'
                      //                               .tr,
                      //                           style: TextStyle(
                      //                               color: AppColors.homeCardBg,
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             )),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
