import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/Page/Transaction_successful.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/Widget/Input_partial_payment.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/old_due_list.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/today_due_list.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class DueByContact extends StatelessWidget {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          title: Text('Payment Method'.tr),
          elevation: 0,
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         CupertinoIcons.bell,
          //         color: Colors.white70,
          //       )),
          // ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: _size.width,
                  color: AppColors.homeCardBg,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 15, top: 10, bottom: 10, right: 10),

                                /// Image item
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/collection/1.png')),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12
                                                  .withOpacity(0.1),
                                              blurRadius: 0.5,
                                              spreadRadius: 0.1)
                                        ]),
                                    child: Container(
                                      height: 40.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/collection/1.png')),
                                      ),
                                    ))),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 5.0, right: 5.0),
                              child: Column(
                                /// Text Information Item
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'খন্দকার সুজাদ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Sans",
                                          color: Colors.black87,
                                          fontSize: 14.0),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Text(
                                    '+৮৮০১৪০০০০০০০০',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Sofia",
                                        color: Colors.black,
                                        fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25, right: 15),
                          child: Image.asset(
                            "assets/icons/right_arrow.png",
                            width: 15,
                            height: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: _size.width,
                  height: _size.height * 0.25,
                  color: Colors.black12,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, right: 15, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.dialog(InputPartialPayment());
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Partial Payment'.tr,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/collection/2.png',
                            height: 25,
                            width: 25,
                            color: Color(0xFF652981),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '১৫৬০',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Total'.tr,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.25,
                        decoration: Ui.getBoxDecoration(
                          color: Colors.white,
                          radius: 8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Old Due'.tr,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.primaryColor),
                              ),
                              Text(
                                '৳ ৪০৫',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(OldDueListView());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3, left: 3),
                                      child: Text(
                                        'Detail'.tr,
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    Image.asset(
                                      'assets/icons/right_double_arrow.png',
                                      height: 8,
                                      width: 8,
                                      color: Color(0xFF652981),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.25,
                        decoration: Ui.getBoxDecoration(
                          color: Colors.white,
                          radius: 8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Todays Due'.tr,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.primaryColor),
                              ),
                              Text(
                                '৳  ১০৫',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(TodayDueListView());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3, left: 3),
                                      child: Text(
                                        'Detail'.tr,
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    Image.asset(
                                      'assets/icons/right_double_arrow.png',
                                      height: 8,
                                      width: 8,
                                      color: Color(0xFF652981),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Container(
                    width: _size.width,
                    height: 60,
                    decoration: Ui.getBoxDecoration(
                      color: Colors.white,
                      radius: 8,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3, left: 3),
                            child: Text(
                              'See Selling List'.tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                          SizedBox(width: 3),
                          Image.asset(
                            'assets/icons/right_arrow.png',
                            height: 15,
                            width: 15,
                            color: Color(0xFF652981),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,

              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 43, 42, 43).withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(0, -2)),
              ],
              //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Get.to(TransactionSuccessful());
                },
                child: Container(
                  width: _size.width,
                  height: _size.width * .1,
                  decoration:
                      Ui.getBoxDecoration(color: Color(0xFF652981), radius: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          'Complete'.tr,
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
        ],
      ),
    );
  }
}
