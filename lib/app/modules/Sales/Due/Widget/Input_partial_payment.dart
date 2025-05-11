import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';


class InputPartialPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Center(
        child: Container(
      height: _size.height * 0.3,
      width: _size.width * 0.85,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25)),
      alignment: Alignment.center,
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Give Parital Amount'.tr,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            TextFieldWidget(
              labelText: "Parital Amount".tr,
              hintText: "Enter Parital Amount".tr,
              onChanged: (value) {},

              // onSaved: (input) =>
              // controller.currentUser.value.email = input,
              // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
              iconData: null,
              imageData: 'assets/collection/2.png',
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
                              'Cancel'.tr,
                              style: Get.textTheme.bodyMedium!.merge(TextStyle(
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
                              'Confirm'.tr,
                              style: Get.textTheme.bodyMedium!.merge(
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
