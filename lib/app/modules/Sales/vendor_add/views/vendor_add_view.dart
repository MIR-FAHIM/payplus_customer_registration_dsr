import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';

import '../controllers/vendor_add_controller.dart';

class VendorAddView extends GetView<VendorAddController> {
  const VendorAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF652981),
        title: const Text('Vendor Add', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: controller.addvendorFormKey,
          child: Column(
            children: [
              // Container(
              //   height: Get.size.width * .5,
              //   width: Get.size.width,
              //   color: Colors.white24,
              //   child: Center(
              //     child: Container(
              //       height: Get.size.width * .3,
              //       width: Get.size.width * .3,
              //       decoration: BoxDecoration(
              //         color: const Color(0xFF652981),
              //         borderRadius: BorderRadius.circular(100),
              //       ),
              //       child: const Center(
              //         child: Icon(
              //           Icons.camera_alt,
              //           size: 30,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              TextFieldWidget(
                keyboardType: TextInputType.number,
                labelText: "Mobile No.".tr,
                onChanged: (input) => controller.customer.value.mobile = input,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'This field cannot be empty.';
                  } else {
                    return null;
                  }
                },
                readOnly: false,
                initialValue: '',
                iconData: null,
                imageData: 'assets/images/user.png',
              ),
              TextFieldWidget(
                labelText: "Name".tr,
                onChanged: (input) => controller.customer.value.name = input,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'This field cannot be empty.';
                  } else {
                    return null;
                  }
                },
                readOnly: false,
                initialValue: '',
                iconData: null,
                imageData: 'assets/images/user.png',
              ),
              TextFieldWidget(
                labelText: "Address".tr,
                onChanged: (input) => controller.customer.value.address = input,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'This field cannot be empty.';
                  } else {
                    return null;
                  }
                },
                readOnly: false,
                initialValue: '',
                iconData: null,
                imageData: 'assets/images/user.png',
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 30),
                  child: BlockButtonWidget(
                    onPressed: () {
                      controller.addVendor();
                    },
                    color: Color(0xFF652981),
                    radius: 30,
                    text: Center(
                      child: Text(
                        'Submit'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
