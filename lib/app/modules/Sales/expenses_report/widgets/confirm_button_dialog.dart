import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Center(
        child: Material(
      child: Container(
        height: 300,
        width: _size.width * 0.85,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(25)),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Image.asset(
              'assets/icons/qus.png',
              height: 40,
              width: 40,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Are You Sure ?'.tr,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Do you want to edit...'.tr,
              style: TextStyle(
                  color: AppColors.homeTextColor3,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 120,
                      height: _size.width * .10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'No'.tr,
                              style: Get.textTheme.headline6!.merge(TextStyle(
                                  color: AppColors.primaryColor, fontSize: 13)),
                            ),
                          ),
                        ),
                      ),
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
                      width: 120,
                      height: _size.width * .10,
                      decoration: Ui.getBoxDecoration(
                          color: Color(0xFF652981), radius: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Yes'.tr,
                              style: Get.textTheme.headline6!.merge(
                                  TextStyle(color: Colors.white, fontSize: 13)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
