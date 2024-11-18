import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:latest_payplus_agent/app/modules/Sales/expense/add_new_expense.dart';
import 'package:latest_payplus_agent/app/modules/Sales/expense/widgets/confirm_button_dialog.dart';

import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ExpenseDetail extends StatelessWidget {
  final _size = Get.size;

  DateTime _selectedDate = DateTime.now();
  var myFormat = DateFormat('dd-MM-yyyy');
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    // if (picked != null && picked != _selectedDate)
    //   setState(() {
    //     _selectedDate = picked;
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          title: Text('Education'.tr),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  // width: _size.width * 0.45,
                  // height: 100,
                  // color: AppColors.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              width: MediaQuery.of(context).size.width * 0.42,
                              decoration: BoxDecoration(
                                color: AppColors.homeCardBg,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "Select Section".tr,
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13),
                                    ),
                                    SizedBox(width: 8),
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
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  color: AppColors.primarydeepLightColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            color: AppColors.homeTextColor1,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 15),
                      child: InkWell(
                        onTap: () {
                          openBottomSheet();

                          // Get.bottomSheet(InputPartialPayment());
                        },
                        child: Container(
                          width: _size.width,
                          decoration: Ui.getBoxDecoration(
                            color: Colors.white,
                            radius: 8,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.all(10.0),

                                        /// Image item
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0)),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/collection/dummy.png')),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12
                                                          .withOpacity(0.1),
                                                      blurRadius: 0.5,
                                                      spreadRadius: 0.1)
                                                ]),
                                            child: Container(
                                              height: 50.0,
                                              width: 50.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0)),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/collection/dummy.png')),
                                              ),
                                            ))),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: Column(
                                        /// Text Information Item
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Tution Fee',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Sans",
                                                color: Colors.black87,
                                                fontSize: 12.0),
                                            overflow: TextOverflow.clip,
                                          ),
                                          SizedBox(
                                            height: 3.0,
                                          ),
                                          Text(
                                            'সময় : ১১:০৯ PM',
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                color: AppColors.homeTextColor3,
                                                fontSize: 10),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 3.0,
                                          ),
                                          Text(
                                            'তারিখ : ১১ মে, ২০২২',
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                color: AppColors.homeTextColor3,
                                                fontSize: 10),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '৳ ৯০০০',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Sofia",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      // Image.asset(
                                      //   "assets/icons/edit_icon02.png",
                                      //   width: 12,
                                      //   height: 12,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
                  child: InkWell(
                    onTap: () {
                      openBottomSheet();
                    },
                    child: Container(
                      width: _size.width,
                      decoration: Ui.getBoxDecoration(
                        color: Colors.white,
                        radius: 8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(10.0),

                                    /// Image item
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/collection/dummy.png')),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12
                                                      .withOpacity(0.1),
                                                  blurRadius: 0.5,
                                                  spreadRadius: 0.1)
                                            ]),
                                        child: Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/collection/dummy.png')),
                                          ),
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: Column(
                                    /// Text Information Item
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Exam Fee',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Sans",
                                            color: Colors.black87,
                                            fontSize: 12.0),
                                        overflow: TextOverflow.clip,
                                      ),
                                      SizedBox(
                                        height: 3.0,
                                      ),
                                      Text(
                                        'সময় : ১১:০৯ PM',
                                        style: TextStyle(
                                            fontFamily: "Sofia",
                                            color: AppColors.homeTextColor3,
                                            fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 3.0,
                                      ),
                                      Text(
                                        'তারিখ : ১১ মে, ২০২২',
                                        style: TextStyle(
                                            fontFamily: "Sofia",
                                            color: AppColors.homeTextColor3,
                                            fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '৳ ৯০০০',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Sofia",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  // Image.asset(
                                  //   "assets/icons/edit_icon02.png",
                                  //   width: 12,
                                  //   height: 12,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Get.to(AddNewExpense());
                },
                child: Container(
                  width: _size.width,
                  height: _size.width * .1,
                  decoration:
                      Ui.getBoxDecoration(color: Color(0xFF652981), radius: 10),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "+ " + 'Add New Expense'.tr,
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
    );
  }

  void openBottomSheet() {
    Get.bottomSheet(
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.cancel_rounded),
                    iconSize: 30,
                    color: Colors.grey,
                    splashColor: Colors.purple,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              Center(
                child: Image.asset(
                  "assets/collection/dummy.png",
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'কারণ :  স্কুলের বেতন',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'সময় : ১১:০৯ PM',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const Center(
                child: Text(
                  'তারিখ : ১১ মে, ২০২২',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(ConfirmDialog());
                    // Get.to(SalePaymentSystem());
                  },
                  child: Container(
                    width: _size.width * 0.4,
                    height: _size.width * .12,
                    decoration: Ui.getBoxDecoration(
                        color: Color(0xFF652981), radius: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: AppColors.homeCardBg,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Edit'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.homeCardBg,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    // Get.to(SalePaymentSystem());
                  },
                  child: Container(
                    width: _size.width * 0.4,
                    height: _size.width * .12,
                    decoration: Ui.getBoxDecoration(
                        color: Color(0xFF652981), radius: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: AppColors.homeCardBg,
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Delete'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.homeCardBg,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // OutlinedButton(
          //   onPressed: () {
          //     Get.back();
          //   },
          //   child: const Text('Close'),
          // ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  SizedBox IconGap() {
    return SizedBox(
      width: 4,
    );
  }
}
