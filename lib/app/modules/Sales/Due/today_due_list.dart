import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class TodayDueListView extends StatelessWidget {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SecondbackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          title: Text('Todays Due'.tr),
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
                                    'মো. আবদুল',
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
                          "৳" + "0.00",
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
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: _size.width,
                  color: AppColors.homeCardBg,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      'Today Due List'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: "Sofia",
                          color: AppColors.homeTextColor3,
                          fontSize: 18),
                    ),
                  ),
                ),
                //product
                Container(
                  width: _size.width,
                  color: AppColors.homeCardBg,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                                'assets/images/hand.png')),
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
                                                'assets/images/hand.png')),
                                      ),
                                    ))),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Column(
                                /// Text Information Item
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Oppo Mobile',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Sans",
                                        color: Colors.black87,
                                        fontSize: 14.0),
                                    overflow: TextOverflow.clip,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    ' x ১',
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
                          child: Row(
                            children: <Widget>[
                              Text(
                                "৳" + '15',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Sofia",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                "assets/icons/right_arrow.png",
                                width: 15,
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                //Price
                Container(
                  width: _size.width,
                  color: AppColors.homeCardBg,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 20.0, right: 20.0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Price'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Sofia",
                            fontSize: 14.5,
                          ),
                        ),
                        Text(
                          "৳" + "0.00",
                          style: TextStyle(
                            color: AppColors.homeTextColor3,
                            fontFamily: "Sofia",
                            fontSize: 14.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Discount
                Container(
                  width: _size.width,
                  color: AppColors.homeCardBg,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 20.0, right: 20.0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              'Discount'.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Sofia",
                                fontSize: 14.5,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              color: AppColors.SecondbackgroundColor,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  "১০%",
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "৳" + "0.00",
                          style: TextStyle(
                            color: AppColors.homeTextColor3,
                            fontFamily: "Sofia",
                            fontSize: 14.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  height: 0.2,
                  color: Colors.black,
                ),

                //Total
                Container(
                  width: _size.width,
                  color: AppColors.homeCardBg,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 20.0, right: 20.0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total'.tr,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Sofia",
                              fontSize: 16.5,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "৳" + "35",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Sofia",
                              fontSize: 16.5,
                              fontWeight: FontWeight.w700),
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Get.back();
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
          ),
        ],
      ),
    );
  }
}
