import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_form_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_payment_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/akash/controller/controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class AkashFormView extends GetView<AkashBillPaymentController> {
  BillFormController billpayController = Get.put(BillFormController());
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    String subs_id = "";
    String amount ="";





    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text("Akash Payment".tr),
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
        body: Obx(() {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Container(
                width: _size.width,
                height: _size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     _title,
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       color: Color(0xFF652981),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),

                    TextFieldWidget(
                      // keyboardType: numberFormatSymbols,
                      labelText: "Subscription ID".tr,
                      hintText: "Type Subscription ID".tr,
                      onChanged: (value) {
                        subs_id = value;
                      },



                      // onSaved: (input) =>
                      // controller.currentUser.value.email = input,
                      // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                      keyboardType: TextInputType.number,
                      iconData: null,
                      imageData: 'assets/bill/account.png',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      // keyboardType: numberFormatSymbols,
                      labelText: "Amount".tr,
                      hintText: "Enter Amount".tr,
                      onChanged: (value) {
                          amount = value;
                      },
                      initialValue: "0.0",

                      // onSaved: (input) =>
                      // controller.currentUser.value.email = input,
                      // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                      keyboardType: TextInputType.number,
                      iconData: null,
                      imageData: 'assets/bill/account.png',
                    ),
                    billpayController.isChecked.value == true
                        ? TextFieldWidget(
                      // keyboardType: numberFormatSymbols,
                      labelText: "Reference Name".tr,
                      hintText: "Enter Reference Name".tr,
                      onChanged: (value) {
                        billpayController.refName.value = value;
                      },

                      // keyboardType: TextInputType.,
                      iconData: null,
                      imageData: 'assets/bill/Rosid.png',
                    )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    BlockButtonWidget(
                      onPressed: () {
controller.akashPayment(subs_id, amount);
                      },
                      color: Color(0xFF652981),
                      text: Text(
                        "Pay Bill".tr,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ).paddingSymmetric(vertical: 10, horizontal: 20),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Future<Map<dynamic, dynamic>> getBillDetail(String billNumber, dynamic isBillSave, String refName) async {
    print(billNumber);
    print(isBillSave);
    print(refName);

    var billSave = isBillSave.toString();
    Map data = {
      'bill_no': billNumber,
      'is_bill_save': billSave,
      'bill_save_nick_name': refName,
    };

    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};
    // var headers = {'token': 'IMBkVG1UFCE8VABPg5TI14yY44StEfWqF341OAlh'};

    var url = 'https://shl.com.bd/api/appapi/billpay/fetch/nesco-postpaid';

    // var body = json.encode(data);

    var response = await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    print('Bill Detail : $resp');
    return resp;
  }
}
