import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class OneMonthCreditReport extends StatefulWidget {
  const OneMonthCreditReport({Key? key}) : super(key: key);

  @override
  State<OneMonthCreditReport> createState() => _OneMonthCreditReportState();
}

class _OneMonthCreditReportState extends State<OneMonthCreditReport> {
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
            title: Text('1 month debit'.tr),
            elevation: 0,
          ),
        ),
        body: Container(
          width: _size.width,
          height: _size.height,
          margin: EdgeInsets.all(20),
          // decoration: Ui.getBoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightColor,
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Total Credits'.tr,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            "১০,২০০/=",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 530,
                    width: _size.width,
                    child: DataTable(columns: [
                      DataColumn(
                        label: Text('Date'),
                      ),
                      DataColumn(
                        label: Text('Name'),
                      ),
                      DataColumn(
                        label: Text('Amount'),
                      ),
                    ], rows: [
                      DataRow(cells: [
                        DataCell(Text('12-3-2022')),
                        DataCell(Text('Ashik')),
                        DataCell(Text('4100 tk')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('10-3-2022')),
                        DataCell(Text('Moin')),
                        DataCell(Text('2580 tk')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('11-3-2022')),
                        DataCell(Text('Ali')),
                        DataCell(Text('3520 tk')),
                      ])
                    ])),
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
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.payment,
                              color: AppColors.primaryColor,
                              size: 15,
                            ),
                            IconGap(),
                            Text("Total : ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor)),
                            Text("10,200 Tk",
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
