import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/expense/add_new_expense.dart';
import 'package:latest_payplus_agent/app/modules/Sales/expense/expense_detail.dart';
import 'package:latest_payplus_agent/app/modules/Sales/expense/widgets/piecart.dart';

import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';

import 'widgets/tab_bar.dart';

class ExpenseDashBoard extends StatefulWidget {
  const ExpenseDashBoard({Key? key}) : super(key: key);

  @override
  State<ExpenseDashBoard> createState() => _ExpenseDashBoardState();
}

class _ExpenseDashBoardState extends State<ExpenseDashBoard>
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

  DateTime _selectedDate = DateTime.now();
  var myFormat = DateFormat('dd-MM-yyyy');
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

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
            title: Text('Consumption'.tr),
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
              ExpenseTabBar(tabController: tabController!),
              Container(),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      //ব্যক্তিগত
                      Container(
                        child: Column(
                          children: [
                            Container(
                              // width: _size.width * 0.45,
                              // height: 100,
                              // color: AppColors.primaryColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                        margin: EdgeInsets.only(top: 3),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        decoration: BoxDecoration(
                                          color: AppColors.homeCardBg,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              "৳ " + '১৯,৪০৩',
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
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          'Select'.tr,
                                          style: TextStyle(
                                              color: AppColors.homeTextColor3,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          selectDate(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 3),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.42,
                                          decoration: BoxDecoration(
                                            color:
                                                AppColors.primarydeepLightColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(width: 20),
                                                Image.asset(
                                                  'assets/icons/calender.png',
                                                  height: 10,
                                                  width: 10,
                                                  color:
                                                      AppColors.homeTextColor1,
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
                                                SizedBox(width: 20),
                                                Image.asset(
                                                  'assets/icons/down_arrow.png',
                                                  height: 10,
                                                  width: 10,
                                                  color:
                                                      AppColors.homeTextColor1,
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
                            ),
                            Container(
                              height: 210,
                              child: ExpensePerosnalPieChart(),
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
                                            Get.to(ExpenseDetail());
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
                                                          'Education'.tr,
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
                                            Get.to(ExpenseDetail());
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
                                                          'Food'.tr,
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
                                            Get.to(ExpenseDetail());
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
                                                          'Medicine'.tr,
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
                                            Get.to(ExpenseDetail());
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
                                                          'Rent'.tr,
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
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // Get.to(OneMonthReport());
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
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      12,
                                                                      109,
                                                                      151),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                          'Transport'.tr,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      12,
                                                                      109,
                                                                      151),
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
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    109,
                                                                    151),
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
                                                          color: Color.fromARGB(
                                                              255,
                                                              12,
                                                              109,
                                                              151),
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
                                            // Get.to(OneMonthReport());
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
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      36,
                                                                      133,
                                                                      55),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                          'Daily Needs'.tr,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      36,
                                                                      133,
                                                                      55),
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
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    36,
                                                                    133,
                                                                    55),
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
                                                          color: Color.fromARGB(
                                                              255, 36, 133, 55),
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
                                            // Get.to(OneMonthReport());
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
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      157,
                                                                      104,
                                                                      14),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                          'Other'.tr,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      157,
                                                                      104,
                                                                      14),
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
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    157,
                                                                    104,
                                                                    14),
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
                                                          color: Color.fromARGB(
                                                              255,
                                                              157,
                                                              104,
                                                              14),
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
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: () {
                                  Get.to(AddNewExpense());
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
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
                          ],
                        ),
                      ),

                      Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  SizedBox IconGap() {
    return SizedBox(
      width: 4,
    );
  }
}
