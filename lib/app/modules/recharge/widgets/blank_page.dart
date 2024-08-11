import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/package_model.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/num_pad.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class BlankPageWidget extends GetWidget<RechargeController> {
  HomeController homeController = Get.put(HomeController());
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {

      return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [



            ],
          ));

  }


}
