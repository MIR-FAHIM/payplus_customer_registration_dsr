import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class SingleCustomerDue extends StatefulWidget {
  const SingleCustomerDue({Key? key}) : super(key: key);

  @override
  State<SingleCustomerDue> createState() => _SingleCustomerDueState();
}

class _SingleCustomerDueState extends State<SingleCustomerDue>
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: _size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Container(
                        width: _size.width * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "জনাব " + ":" + " মো. আবদুল",
                              style: TextStyle(
                                  color: AppColors.homeTextColor1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              "মোবাইল নাম্বার: +৮৮০১৪০০০০০০০০",
                              style: TextStyle(
                                  color: AppColors.homeTextColor3,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 3),
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: AppColors.primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Credits'.tr,
                            style: TextStyle(
                                color: AppColors.homeTextColor1,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                Container(
                    height: _size.height * 0.65,
                    width: _size.width,
                    child: Column(
                      children: [
                        //table heading
                        Container(
                          width: _size.width,
                          height: 50,
                          color: AppColors.SectionHighLightCardBg,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'date'.tr,
                                  style: TextStyle(
                                      color: AppColors.homeTextColor1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Reason'.tr,
                                style: TextStyle(
                                    color: AppColors.homeTextColor1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  'quantity'.tr,
                                  style: TextStyle(
                                      color: AppColors.homeTextColor1,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "১০-০৪-২০২২",
                                  style: TextStyle(
                                      color: AppColors.redTextColor,
                                      fontSize: 14),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "চার্জারের জন্য",
                                  style: TextStyle(
                                      color: AppColors.redTextColor,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  child: Text(
                                    "০০.০০ " + " (+)",
                                    style: TextStyle(
                                        color: AppColors.redTextColor,
                                        fontSize: 14),
                                  ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "১৩-০৪-২০২২",
                                  style: TextStyle(
                                      color: AppColors.greenTextColor,
                                      fontSize: 14),
                                ),
                              ),
                              Text(
                                "অর্থ প্রদান",
                                style: TextStyle(
                                    color: AppColors.greenTextColor,
                                    fontSize: 14),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  "০০.০০ " + " (-)",
                                  style: TextStyle(
                                      color: AppColors.greenTextColor,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "১৪-০৪-২০২২",
                                  style: TextStyle(
                                      color: AppColors.redTextColor,
                                      fontSize: 14),
                                ),
                              ),
                              Text(
                                "মোবাইলের জন্য",
                                style: TextStyle(
                                    color: AppColors.redTextColor,
                                    fontSize: 14),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  "০০.০০ " + " (+)",
                                  style: TextStyle(
                                      color: AppColors.redTextColor,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "১৯-০৪-২০২২",
                                  style: TextStyle(
                                      color: AppColors.redTextColor,
                                      fontSize: 14),
                                ),
                              ),
                              Text(
                                "হেডফোনের জন্য",
                                style: TextStyle(
                                    color: AppColors.redTextColor,
                                    fontSize: 14),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  "০০.০০ " + " (+)",
                                  style: TextStyle(
                                      color: AppColors.redTextColor,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "১৯-০৪-২০২২",
                                  style: TextStyle(
                                      color: AppColors.greenTextColor,
                                      fontSize: 14),
                                ),
                              ),
                              Text(
                                "অর্থ প্রদান",
                                style: TextStyle(
                                    color: AppColors.greenTextColor,
                                    fontSize: 14),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  "০০.০০ " + " (-)",
                                  style: TextStyle(
                                      color: AppColors.greenTextColor,
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
                        padding: const EdgeInsets.fromLTRB(10, 0, 15, 10),
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
                                    color: Theme.of(context).primaryColor)),
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
