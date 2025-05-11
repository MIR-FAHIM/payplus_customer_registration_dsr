import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/account_setting/views/deactivate_account_pin.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ConfirmDialog extends StatelessWidget {
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
              new Image.asset(
                'assets/images/qus.png',
                width: 30.0,
                height: 30.0,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  'Are You Sure? you want to deactivate your account'.tr,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
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
                                    color: AppColors.primaryColor,
                                    fontSize: 13)),
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
                        Get.to(DeActivateAccountPinCode());
                      },
                      child: Container(
                        width: 120,
                        height: _size.width * .10,
                        decoration: Ui.getBoxDecoration(
                            color: Color(0xFFE03131), radius: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Confirm'.tr,
                                style: Get.textTheme.bodyMedium!.merge(TextStyle(
                                    color: Colors.white, fontSize: 13)),
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
      ),
    );
  }
}

class BoxOption {
  final String key;
  final String fullName;

  BoxOption(this.key, this.fullName);

  static List<BoxOption> get allBillerType => [
        BoxOption('1', 'Select'.tr),
        BoxOption('M', '%'.tr),
        BoxOption('NM', 'tk'.tr),
      ];
}
