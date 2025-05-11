import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/Widget/tab_bar.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/customer_update_payment.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/single_customer_due.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class CustomerWiseDueList extends StatefulWidget {
  const CustomerWiseDueList({Key? key}) : super(key: key);

  @override
  State<CustomerWiseDueList> createState() => _CustomerWiseDueListState();
}

class _CustomerWiseDueListState extends State<CustomerWiseDueList>
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

  final List<Map> _users = [
    {'id': 1, 'name': 'John'},
    {'id': 2, 'name': 'Bob'},
    {'id': 3, 'name': 'Trump'},
    {'id': 4, 'name': 'Joe Biden'},
    {'id': 5, 'name': 'Superman'},
    {'id': 6, 'name': 'Wonder Lady'},
    {'id': 7, 'name': 'Ronaldo'},
    {'id': 8, 'name': 'Ben'}
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
            title: Text('Due according to customer'.tr),
            elevation: 0,
          ),
        ),
        body: Container(
          width: _size.width,
          height: _size.height,
          // margin: EdgeInsets.all(20),
          // decoration: Ui.getBoxDecoration(color: Colors.white),
          child: Column(
            children: [
              DashBoardTabBar(tabController: tabController!),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 30),
                                      child: Text(
                                        'Total debit in amount'.tr,
                                        style: TextStyle(
                                            color: AppColors.homeTextColor3,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 20, top: 3),
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      decoration: BoxDecoration(
                                        color: AppColors.SectionCardBg,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            '10,500'.tr,
                                            style: TextStyle(
                                                color: AppColors.homeTextColor1,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, top: 30),
                                      child: Text(
                                        'Select'.tr,
                                        style: TextStyle(
                                            color: AppColors.homeTextColor3,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(right: 20, top: 3),
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      decoration: BoxDecoration(
                                        color: AppColors.SectionCardBg,
                                        borderRadius: BorderRadius.circular(10),
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
                                              color: AppColors.homeTextColor1,
                                            ),
                                            IconGap(),
                                            Text(
                                              "তারিখ",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13),
                                            ),
                                            SizedBox(width: 20),
                                            Image.asset(
                                              'assets/icons/down_arrow.png',
                                              height: 10,
                                              width: 10,
                                              color: AppColors.homeTextColor1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30),

                            Container(
                                height: 430,
                                width: _size.width,
                                child: Column(
                                  children: [
                                    //table heading
                                    Container(
                                      width: _size.width,
                                      height: 50,
                                      color: AppColors.SectionHighLightCardBg,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Container(
                                              width: _size.width * 0.66,
                                              // color: Colors.blue,
                                              child: Text(
                                                'By Customer'.tr,
                                                style: TextStyle(
                                                    color: AppColors
                                                        .homeTextColor1,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Due'.tr,
                                            style: TextStyle(
                                                color: AppColors.homeTextColor1,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //table content
                                    Container(
                                      width: _size.width,
                                      height: 50,
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(SingleCustomerDue());
                                            },
                                            child: Container(
                                              width: _size.width * 0.85,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Container(
                                                      width: _size.width * 0.55,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "মো. আবদুল",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .homeTextColor1,
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            "+৮৮০১৪০০০০০০০০",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .homeTextColor3,
                                                                fontSize: 11),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: Text(
                                                      "০০.০০",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .homeTextColor1,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(CustomerPaymentUpdate());
                                              },
                                              child: Container(
                                                height: 15,
                                                width: _size.width * 0.14,
                                                // color: Colors.blue,
                                                child: Image.asset(
                                                  'assets/icons/edit_icon.png',
                                                  height: 15,
                                                  width: 15,
                                                  color:
                                                      AppColors.homeTextColor1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        Get.to(SingleCustomerDue());
                                      },
                                      child: Container(
                                        width: _size.width,
                                        height: 50,
                                        color: AppColors.tableRowColor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Container(
                                                width: _size.width * 0.55,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "মো. হানিফ",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .homeTextColor1,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "+৮৮০১৪০০০০০০০০",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .homeTextColor3,
                                                          fontSize: 11),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "০০.০০",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18),
                                              child: Image.asset(
                                                'assets/icons/edit_icon.png',
                                                height: 15,
                                                width: 15,
                                                color: AppColors.homeTextColor1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        Get.to(SingleCustomerDue());
                                      },
                                      child: Container(
                                        width: _size.width,
                                        height: 50,
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Container(
                                                width: _size.width * 0.55,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "করিম বেপারি",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .homeTextColor1,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "+৮৮০১৪০০০০০০০০",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .homeTextColor3,
                                                          fontSize: 11),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "০০.০০",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18),
                                              child: Image.asset(
                                                'assets/icons/edit_icon.png',
                                                height: 15,
                                                width: 15,
                                                color: AppColors.homeTextColor1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        Get.to(SingleCustomerDue());
                                      },
                                      child: Container(
                                        width: _size.width,
                                        height: 50,
                                        color: AppColors.tableRowColor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Container(
                                                width: _size.width * 0.55,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "হাসেম আলী",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .homeTextColor1,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "+৮৮০১৪০০০০০০০০",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .homeTextColor3,
                                                          fontSize: 11),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "০০.০০",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18),
                                              child: Image.asset(
                                                'assets/icons/edit_icon.png',
                                                height: 15,
                                                width: 15,
                                                color: AppColors.homeTextColor1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),

                            //Total

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              color: Colors.grey,
                            ),
                            lineGap(),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 15, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.payment,
                                          color: AppColors.primaryColor,
                                          size: 15,
                                        ),
                                        IconGap(),
                                        Text('Total due'.tr + ' : ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        Text('10,500'.tr,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  SizedBox lineGap() {
    return SizedBox(
      height: 10,
    );
  }

  SizedBox IconGap() {
    return SizedBox(
      width: 4,
    );
  }
}
