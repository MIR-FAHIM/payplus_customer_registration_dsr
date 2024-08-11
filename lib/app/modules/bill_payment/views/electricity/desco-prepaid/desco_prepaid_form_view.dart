import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_form_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_payment_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class DescoPrepaidFormView extends GetView {
  BillFormController billpayController = Get.put(BillFormController());
  BillPaymentController billpaymentController = Get.put(BillPaymentController());
  @override
  Widget build(BuildContext context) {
    var _title = Get.arguments['title'];
    var _images = Get.arguments['images'];
    final _size = Get.size;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text("$_title".tr),
            elevation: 0,

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$_title'.tr,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF652981),
                      ),
                    ),
                  ),
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
                    onChanged: (value) {
                      billpayController.accountID.value = value;
                    },
                    labelText: "Account Number".tr,
                    hintText: "Enter Account Number".tr,
                    // onSaved: (input) =>
                    // controller.currentUser.value.email = input,
                    // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                    iconData: null,
                    imageData: 'assets/bill/account.png',
                  ),
                  TextFieldWidget(
                    onChanged: (value) {
                      billpayController.amount.value = value;
                    },
                    labelText: "Recharge Amount".tr,
                    hintText: "Enter Recharge Amount".tr,
                    keyboardType: TextInputType.number,
                    // onSaved: (input) =>
                    // controller.currentUser.value.email = input,
                    // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                    iconData: null,
                    imageData: 'assets/collection/2.png',
                  ),
                  TextFieldWidget(
                    onChanged: (value) {
                      billpayController.mobile.value = value;
                    },
                    labelText: "Mobile No".tr,
                    hintText: "Enter Mobile No.".tr,
                    keyboardType: TextInputType.number,

                    // onSaved: (input) =>
                    // controller.currentUser.value.email = input,
                    // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                    iconData: CupertinoIcons.device_phone_portrait,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  BlockButtonWidget(
                    onPressed: () {
                      //acc num - 21000135
                      //meter - 66110007244
                      //


                      var result;
                      var data;
                      var bill_ref;
                      var datas;

                      if (billpayController.amount.value.isNotEmpty &&
                          billpayController.accountID.value.isNotEmpty) {

                        if(billpayController.mobile.value.length != 11){
                          Get.showSnackbar(Ui.ErrorSnackBar(
                              message: "Phone no not valid", title: 'Failed'.tr));
                        }else{
                          var res = getBillDetail(
                              meterNo: billpayController.meterNo.value,
                              amount: billpayController.amount.value,
                              mobileNo: billpayController.mobile.value,
                              billNumber: billpayController.accountID.value);
                          Ui.customLoaderDialog();
                          res.then((value) => {
                            Get.back(),
                            result = value['result'],
                            print("hle bro+++++++ ${value['result']}"),
                            if (value['result'] == 'success')
                              {
                                billpaymentController.billPaymentChargePreview(

                                  bill_payment_id:value['bill_ref']['bill_payment_id'],

                                  bill_refer_id: value['bill_ref']['bill_refer_id'],
                                ),
                                {
                                  data = value['data'],
                                  bill_ref = value['bill_ref'],
                                  // Ui.SuccessSnackBar(message: value['result']),
                                  // print(data['bllr_accno']),
                                  datas = {
                                    "title": _title,
                                    "images": _images,
                                    "bill_payment_id":
                                    bill_ref['bill_payment_id'],
                                    "bill_refer_id": bill_ref['bill_refer_id'],
                                    "bll_no": data['bill_no'],
                                    "bill_name": data['bill_name'],
                                    "bllr_accno": data['biller_acc_no'],
                                    "bll_mobno": data['biller_mobile'],
                                    "charge": data['charge'],
                                    "bll_vat": data['bill_vat'],
                                    "bll_late_fee": data['bill_late_fee'],
                                    "ekpay_fee": data['ekpay_fee'],
                                    "is_bill_paid": data['is_bill_paid'],
                                    "bll_amnt_ttl": data['bill_total_amount'],
                                    "customer_name": data['customer_name'],
                                    "meter_type": data['meter_type'],
                                    "tariff_program": data['tariff_program'],
                                  },
                                  Get.toNamed(Routes.DESCOPREPAIDDETAILS,
                                      arguments: datas)
                                }
                          }

                            else{
                              Get.showSnackbar(Ui.ErrorSnackBar(
                                  message: value['message'],
                                  title: 'Error'.tr))
                            }

                          });
                        }

                      } else {
                        Get.showSnackbar(Ui.ErrorSnackBar(
                            message: "Fill all the field", title: 'Failed'.tr));
                      }
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
        ));

  }

  Future<Map<dynamic, dynamic>> getBillDetail(
      {String? billNumber,
      String? meterNo,
      String? mobileNo,
      String? amount}) async {
    print(billNumber);
    print(meterNo);
    print(amount);

    Map data = {
      // "33041338", //
      'biller_acc_no': billNumber,

      'biller_mobile_no': mobileNo,
      "amount": amount,
    };

    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};
    // var headers = {'token': 'IMBkVG1UFCE8VABPg5TI14yY44StEfWqF341OAlh'};

    var url = 'https://shl.com.bd/api/appapi/billpay/fetch/desco-prepaid';

    // var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    print('Bill Detail : $resp');
    return resp;
  }
}
