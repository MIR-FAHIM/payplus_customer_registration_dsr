import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_form_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_payment_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class WestZonePostpaidFormView extends GetView {
  BillFormController billpayController = Get.put(BillFormController());
  BillPaymentController billpaymentController = Get.put(BillPaymentController());

  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    var _title = Get.arguments['title'];
    var _images = Get.arguments['images'];
    var _bill_no = Get.arguments['bill_no'];

    print(_bill_no);
    var bill_number = '';
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text(_title),
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
            child: Container(
              width: _size.width,
              height: _size.height,
              child: SingleChildScrollView(
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
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              height: 40,
                              width: 50,
                              image: NetworkImage(_images == null
                                  ? "https://shl.com.bd/uploads/billers/dwasa.png"
                                  : _images),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(_title),
                          ],
                        ),
                      ),
                    ),
                    TextFieldWidget(
                      // keyboardType: numberFormatSymbols,
                      labelText: "Account No".tr,
                      hintText: "Enter Account No".tr,
                      onChanged: (value) {
                        bill_number = value;
                      },
                      initialValue: _bill_no,
                      // onSaved: (input) =>
                      // controller.currentUser.value.email = input,
                      // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                      keyboardType: TextInputType.number,
                      iconData: null,
                      imageData: 'assets/bill/account.png',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _bill_no == ''
                        ? Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: billpayController.isChecked.value,
                                  onChanged: (value) {
                                    billpayController.isChecked.value = value!;
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    'Save the account for future payment'.tr,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
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
                        // Get.to(DescoPostpaidBillView());

                        var result;
                        var data;
                        var datas;
                        var bill_ref;
                        var Bill_No =
                            bill_number == '' ? _bill_no : bill_number;

                        var res = getBillDetail(
                            Bill_No,
                            billpayController.isChecked.value,
                            billpayController.refName.value);
                        Ui.customLoaderDialog();
                        res.then((value) => {
                              Get.back(),
                              result = value['result'],
                              data = value['data'],
                              bill_ref = value['bill_ref'],
                              if (value['result'] == 'success')
                                {
                                  billpaymentController.billPaymentChargePreview(

                                    bill_payment_id:value['bill_ref']['bill_payment_id'],

                                    bill_refer_id: value['bill_ref']['bill_refer_id'],
                                  ),
                                  Ui.SuccessSnackBar(message: value['result']),
                                  print(data['bllr_accno']),
                                  datas = {
                                    "title": _title,
                                    "images": _images,
                                    "bill_payment_id":
                                        bill_ref['bill_payment_id'],
                                    "bill_refer_id": bill_ref['bill_refer_id'],
                                    "bll_no": data['bill_no'],
                                    "bllr_accno": data['biller_acc_no'],
                                    "bill_address": data['bill_address'],
                                    "bll_dt_due": data['bill_due_date'],
                                    "bll_amnt": data['bill_amount'],
                                    "bll_vat": data['bill_vat'],
                                    "ekpay_fee": data['ekpay_fee'],
                                    "bll_amnt_ttl": data['bill_total_amount'],
                                    "is_bill_paid": data['is_bill_paid'],
                                  },
                                  Get.toNamed(
                                      Routes.Westzone_Postpaid_Bill_View,
                                      arguments: datas)
                                }
                              else{
                                Get.showSnackbar(Ui.ErrorSnackBar(
                                    message: value['message'],
                                    title: 'Failed'.tr))
                              }

                            });
                      },
                      color: Color(0xFF652981),
                      text: Text(
                        "SHOW BILL".tr,
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

  Future<Map<dynamic, dynamic>> getBillDetail(
      String billNumber, dynamic isBillSave, String refName) async {
    print(billNumber);
    print(isBillSave);
    print(refName);
    var billSave = isBillSave.toString();
    Map data = {
      'biller_acc_no': billNumber,
      'is_bill_save': billSave,
      'bill_save_nick_name': refName,
    };

    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    // var headers = {'token': 'IMBkVG1UFCE8VABPg5TI14yY44StEfWqF341OAlh'};

    var url =
        '${ApiClient.v3baseUrl}/billpay/fetch/westzonepower-postpaid';

    // var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    print('Bill Detail : $resp');
    return resp;
  }
}
