import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart' as badges;
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';

import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/home/views/home_view.dart';
import 'package:latest_payplus_agent/app/modules/home/widgets/AmountWidget.dart' hide BlockButtonWidget;
import 'package:latest_payplus_agent/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/color_constant_custom.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/custom_widget/custom_widget.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class CollectorHomePage extends GetView<HomeController> {
  const CollectorHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text("Add Collection".tr),
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: _size.width,
            height: _size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  SizedBox(
                    height: 10,
                  ),


                  TextFieldWidget(
                    onChanged: (value) {

                    },
                    labelText: "Collection Title".tr,
                    hintText: "Enter Title".tr,
                    // onSaved: (input) =>
                    // controller.currentUser.value.email = input,
                    // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                    iconData: null,
                    imageData: 'assets/bill/account.png',
                  ),
                  TextFieldWidget(
                    onChanged: (value) {

                    },
                    labelText: "Amount".tr,
                    hintText: "Enter Amount".tr,
                    keyboardType: TextInputType.number,
                    // onSaved: (input) =>
                    // controller.currentUser.value.email = input,
                    // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                    iconData: null,
                    imageData: 'assets/collection/2.png',
                  ),
                  TextFieldWidget(
                    onChanged: (value) {

                    },
                    labelText: "Mobile No".tr,
                    hintText: "Enter Mobile No.".tr,
                    keyboardType: TextInputType.number,

                    // onSaved: (input) =>
                    // controller.currentUser.value.email = input,
                    // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                    iconData: CupertinoIcons.device_phone_portrait,
                  ),
                  // Container(
                  //   child: CheckBoxWidget(
                  //     title: 'Save the account'.tr,
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  BlockButtonWidget(
                    onPressed: () {
                      controller.paymentCollectionModel.add(PaymentCollectModel(amount:"400", totalUser: "7", title: "Internet Bill"));

                    },
                    color: Color(0xFF652981),
                    text: Text(
                      "Add New Collection".tr,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                ],
              ),
            ),
          ),
        ));
  }


}
