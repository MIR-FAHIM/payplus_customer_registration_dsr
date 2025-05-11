import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class CustomerPaymentUpdate extends StatefulWidget {
  const CustomerPaymentUpdate({Key? key}) : super(key: key);

  @override
  State<CustomerPaymentUpdate> createState() => _CustomerPaymentUpdateState();
}

class _CustomerPaymentUpdateState extends State<CustomerPaymentUpdate> {
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

                //table content

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
