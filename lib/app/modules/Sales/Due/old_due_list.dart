import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/old_due_detail.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class OldDueListView extends StatefulWidget {
  @override
  State<OldDueListView> createState() => _OldDueListViewState();
}

class _OldDueListViewState extends State<OldDueListView> {
  final _size = Get.size;

  bool isSwitched = false;

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
    //  String _startDate = "${myFormat.format(_selectedDate)}";
    return Scaffold(
      backgroundColor: AppColors.SecondbackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          title: Text('Old Due'.tr),
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
                                            color:
                                                Colors.black12.withOpacity(0.1),
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
                        padding: const EdgeInsets.only(top: 20, right: 15),
                        child: Image.asset(
                          "assets/icons/edit_icon02.png",
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () {
                    Get.to(OldDueDetailView());
                  },
                  child: Container(
                    width: _size.width,
                    color: AppColors.homeCardBg,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15.0, left: 20.0, right: 20.0, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Invoice Number : ",
                                    style: TextStyle(
                                      color: AppColors.homeTextColor3,
                                      fontFamily: "Sofia",
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "958731",
                                    style: TextStyle(
                                      color: AppColors.homeTextColor1,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Sofia",
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "১৫ মে ২০২২",
                                style: TextStyle(
                                  color: AppColors.homeTextColor3,
                                  fontFamily: "Sofia",
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "৳" + "৩০০",
                            style: TextStyle(
                              color: AppColors.homeTextColor1,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sofia",
                              fontSize: 14.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Container(
                  width: _size.width,
                  color: AppColors.homeCardBg,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 20.0, right: 20.0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Invoice Number : ",
                                  style: TextStyle(
                                    color: AppColors.homeTextColor3,
                                    fontFamily: "Sofia",
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "558700",
                                  style: TextStyle(
                                    color: AppColors.homeTextColor1,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Sofia",
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "০৯ মে ২০২২",
                              style: TextStyle(
                                color: AppColors.homeTextColor3,
                                fontFamily: "Sofia",
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "৳" + "৯০০",
                          style: TextStyle(
                            color: AppColors.homeTextColor1,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sofia",
                            fontSize: 14.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
            child: Column(
              children: [
                Container(
                  width: _size.width,
                  color: AppColors.homeCardBg,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 15.0, right: 30.0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Center(
                              child: Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                    print(isSwitched);
                                  });
                                },
                                activeTrackColor: Colors.purple[200],
                                activeColor: AppColors.primaryColor,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Want To Sent SMS?'.tr,
                                  style: TextStyle(
                                    color: AppColors.homeTextColor1,
                                    fontFamily: "Sofia",
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  '0.25tk will deduct for sms'.tr,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: "Sofia",
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 5, right: 10),
                              child: Text(
                                'পরিশোধের তারিখ',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                selectDate(context);
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: Theme.of(context).primaryColor,
                                      size: 14,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3, left: 5, right: 10),
                                      child: Text(
                                        'Date'.tr,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),

                                    // Text(
                                    //   // controller.startDate.value,
                                    //   "00",
                                    //   style: TextStyle(
                                    //       fontSize: 14, color: AppColors.homeTextColor3),
                                    // ),

                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Theme.of(context).primaryColor,
                                      size: 18,
                                    ),
                                  ],
                                ),


                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: _size.width,
                      height: _size.width * .1,
                      decoration: Ui.getBoxDecoration(
                          color: Color(0xFF652981), radius: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'BACK'.tr,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
