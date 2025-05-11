import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/Widget/tab_bar.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class OneMonthReport extends StatefulWidget {
  const OneMonthReport({Key? key}) : super(key: key);

  @override
  State<OneMonthReport> createState() => _OneMonthReportState();
}

class _OneMonthReportState extends State<OneMonthReport>
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
            title: Text('Total due'.tr),
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
                                            fontSize: 13),
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
                                            fontSize: 13),
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
                                            Text(
                                              '1 month old'.tr,
                                              style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13),
                                            ),
                                            SizedBox(width: 15),
                                            Image.asset(
                                              'assets/icons/down_arrow.png',
                                              height: 12,
                                              width: 12,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              'date'.tr,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          SizedBox(width: 60),
                                          Text(
                                            'name'.tr,
                                            style: TextStyle(
                                                color: AppColors.homeTextColor1,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Text(
                                              'quantity'.tr,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
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
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              "১০-০৪-২০২২",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Text(
                                            "মো. আবদুল",
                                            style: TextStyle(
                                                color: AppColors.homeTextColor1,
                                                fontSize: 14),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Text(
                                              "০০.০০",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      width: _size.width,
                                      height: 50,
                                      color: AppColors.tableRowColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              "১৩-০৪-২০২২",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Text(
                                            "মো. হানিফ",
                                            style: TextStyle(
                                                color: AppColors.homeTextColor1,
                                                fontSize: 14),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Text(
                                              "০০.০০",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      width: _size.width,
                                      height: 50,
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              "১৪-০৪-২০২২",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Text(
                                            "করিম বেপারি",
                                            style: TextStyle(
                                                color: AppColors.homeTextColor1,
                                                fontSize: 14),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Text(
                                              "০০.০০",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      width: _size.width,
                                      height: 50,
                                      color: AppColors.tableRowColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              "১৯-০৪-২০২২",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Text(
                                            "হাসেম আলী",
                                            style: TextStyle(
                                                color: AppColors.homeTextColor1,
                                                fontSize: 14),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Text(
                                              "০০.০০",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.homeTextColor1,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),

                            //table content

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
                            //     Padding(
                            //   padding: const EdgeInsets.all(25),
                            //   child: SingleChildScrollView(
                            //     child: Table(
                            //       columnWidths: const {
                            //         0: FixedColumnWidth(50),
                            //         1: FlexColumnWidth(),
                            //       },
                            //       children: _users.map((user) {
                            //         return TableRow(children: [
                            //           Container(
                            //               color: _users.indexOf(user) % 2 == 0
                            //                   ? Colors.blue[50]
                            //                   : Colors.amber[50],
                            //               padding: const EdgeInsets.all(15),
                            //               child: Text(user['id'].toString())),
                            //           Container(
                            //               color: _users.indexOf(user) % 2 == 0
                            //                   ? Colors.blue[50]
                            //                   : Colors.amber[50],
                            //               padding: const EdgeInsets.all(15),
                            //               child: Text(user['name']))
                            //         ]);
                            //       }).toList(),
                            //       border: TableBorder.all(width: 1, color: Colors.black),
                            //     ),
                            //   ),
                            // ))
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
