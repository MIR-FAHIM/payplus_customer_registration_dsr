import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/due_by_contact_list.dart';
import 'package:latest_payplus_agent/app/modules/contacts_list/add_new_contact.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ContactListView extends StatelessWidget {
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
          title: Text('Contact List'.tr),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(DueByContact());
                  },
                  child: Container(
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
                ),
                SizedBox(
                  height: 5.0,
                ),
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
                                      'মো. আসাদ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Sans",
                                          color: Colors.black87,
                                          fontSize: 14.0),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Text(
                                    '+৮৮০১৪০০০০০০০১',
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
                  Get.to(AddNewContact());
                  // Get.to(TestPic());
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
                          "+ " + 'Add New Contact'.tr,
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
