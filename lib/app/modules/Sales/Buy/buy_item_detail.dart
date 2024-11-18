import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/widgets/product_detail_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class BuyItemDetail extends StatelessWidget {
  String largeText =
      "পণ্যের বিস্তারিত তথ্য: চশমা মানুষের চোখের রক্ষাকবচ হিসেবে ব্যবহৃত যেটি চোখের সংবেদনশীল অংশকে রক্ষা করে যেকোনো ধরনের অনিষ্ট থেকে সাধারণত কাচ দিয়ে তৈরি করা হয় এবং সেটা নাকের উপর এবং দুই কানের সাথে লাগানো থাকে. সত্যিকারের চশমা বলতে যা বোঝায়, তা প্রথম প্রচলিত হয় ইতালিতে দ্বাদশ খ্রিষ্টাব্দের দিকে। ওই সময় চোখে আতশী কাচ লাগিয়ে ছোট জিনিসকে দৃষ্টিসীমায় নিয়ে আসার জন্য চোখে চশমা ব্যবহার করার নজির রয়েছে ইতিহাসে ১২৮৬ সালের দিকে ইতালিতে প্রথম চশমা তৈরি হয়েছিল।";
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          title: Text('Product Detail'.tr),
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
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: _size.height * 0.17,
              color: AppColors.SecondbackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      // openBottomSheet();
                      openBottomSheetBill();
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15, top: 15, bottom: 15),

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
                                            color:
                                                Colors.black12.withOpacity(0.1),
                                            blurRadius: 0.5,
                                            spreadRadius: 0.1)
                                      ]),
                                  child: Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/hand.png')),
                                    ),
                                  ))),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        'Oppo Mobile',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Sans",
                                            color: Colors.black87,
                                            fontSize: 14.0),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Text(
                                        '৳ ৫০০',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Sans",
                                            color: Colors.black87,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                    Container(
                                      width: 140.0,
                                      height: 50,
                                      child: Text(
                                        'পণ্যের বিস্তারিত তথ্য: চশমা মানুষের চোখের রক্ষাকবচ হিসেবে ব্যবহৃত যেটি চোখের সংবেদনশীল.রক্ষাকবচ হিসেবে ..',
                                        style: TextStyle(
                                            fontFamily: "Sans",
                                            color: AppColors.homeTextColor3,
                                            fontSize: 10.0),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 20),
                          //   child: Image.asset(
                          //     "assets/icons/right_arrow.png",
                          //     width: 15,
                          //     height: 15,
                          //   ),
                          // ),
                          Row(
                            children: [
                              Icon(Icons.edit,
                                  color: AppColors.primaryColor, size: 18.0
                                  //The color which you want set.
                                  ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(Icons.delete,
                                    color: AppColors.redTextColor,
                                    size: 18.0 //The color which you want set.
                                    ),
                              ),
                            ],
                          ),
                          Container(
                            // width:
                            //     MediaQuery.of(context).size.width * 0.4,
                            // height: 25,
                            decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              border: Border.all(color: Colors.red, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 3, bottom: 3),
                              child: Center(
                                child: Text(
                                  'Deactive',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
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
              height: _size.height * 0.63,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      width: _size.width,
                      color: AppColors.primarydeepLightColor,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 8, bottom: 8),
                        child: Text(
                          "পণ্যের তথ্য",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ProductDetailWidget(),
                    SizedBox(height: 10),
                    Container(
                      width: _size.width,
                      color: AppColors.primarydeepLightColor,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 8, bottom: 8),
                        child: Text(
                          "পণ্যের ধরণ",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ProductDetailWidget(),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
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
                    Get.toNamed(Routes.Add_New_Product);
                  },
                  child: Container(
                    width: _size.width,
                    decoration: Ui.getBoxDecoration(
                        color: Color(0xFF652981), radius: 10),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          'স্টকের ইতিহাস দেখুন'.tr,
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
    );
  }

  void openBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 3, bottom: 3),
                            child: Center(
                              child: Text(
                                'Deactive',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Image.asset(
                        "assets/collection/dummy.png",
                        width: 130,
                        height: 130,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Name'.tr + " : " + "চশমা",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Sell Price'.tr + " : " + "৳ ৫০০",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            "Active Your Product".tr,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 5),
                              child: Center(
                                child: Text(
                                  'Active',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 15, right: 15, bottom: 10),
                    child: Text(
                      largeText,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 15),
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
                      left: 15, right: 15, top: 15, bottom: 15),
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

            // OutlinedButton(
            //   onPressed: () {
            //     Get.back();
            //   },
            //   child: const Text('Close'),
            // ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void openBottomSheetBill() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 22, top: 3),
                            child: Center(
                              child: Text(
                                'Recipient'.tr,
                                style: TextStyle(
                                    color: AppColors.homeTextColor3,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        Image.asset(
                          "assets/collection/dummy.png",
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 22, top: 15, right: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Account Number'.tr,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '33072190',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            //Amount
                            const SizedBox(height: 12),
                            Text(
                              'Amount'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ 00.00',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            //Amount
                            const SizedBox(height: 12),
                            Text(
                              'Service Fee'.tr,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ 00.00',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Present Balance'.tr,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ 00.00',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            //Amount
                            const SizedBox(height: 12),
                            Text(
                              'Online Charge'.tr,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ 00.00',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            //Amount
                            const SizedBox(height: 12),
                            Text(
                              'Total'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ 00.00',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  width: _size.width,
                  //  height: 50,
                  decoration: Ui.getBoxDecoration(radius: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: TextFormField(
                      // controller: controller.pinController,
                      cursorColor: Color(0xFF652981),
                      textAlign: TextAlign.center,

                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: 'Enter PIN here'.tr,
                        hintStyle:
                            TextStyle(color: Color(0xFF652981), fontSize: 15),
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          color: Color(0xFF652981),
                        ),

                        // suffixIcon: IconButton(
                        //   onPressed: () {
                        //     // controller.recharge();
                        //     // print("sahed");
                        //     // controller.pinController.clear();
                        //   },
                        //   icon: Icon(
                        //     CupertinoIcons.arrow_right,
                        //     color: Color(0xFF652981),
                        //     size: 35,
                        //   ).marginOnly(right: 14),
                        // ),
                        // floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusColor: Color(0xFF652981),
                      ),
                      // focusNode: controller.pinFocusFocus,
                      keyboardType: TextInputType.phone,
                      // validator: (String? value) {
                      //
                      // },
                      onChanged: (input) {
                        // controller.pinNumber.value = input;
                      },
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, bottom: 15),
              child: GestureDetector(
                onTap: () {
                  // Get.to(SalePaymentSystem());
                },
                child: Container(
                  width: _size.width * 0.6,
                  height: _size.width * .12,
                  decoration:
                      Ui.getBoxDecoration(color: Color(0xFF652981), radius: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Confirm Bill Payment'.tr,
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
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
