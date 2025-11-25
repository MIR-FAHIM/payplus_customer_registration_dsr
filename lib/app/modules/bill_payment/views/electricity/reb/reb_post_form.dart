import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_form_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_payment_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/app/services/settings_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/loader/full_screen_loader.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class RebPostpaidFormView extends GetView {
  BillFormController billpayController = Get.put(BillFormController());
  BillPaymentController billpaymentController = Get.put(BillPaymentController());
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    //  String startMonth = billpayController.myFormat.format(billpayController.selectedDate!.value);
    //  String monthName = billpayController.myFormat.format(billpayController.selectedDate!.value);
    var _title = Get.arguments['title'] ?? "";
    var _images = Get.arguments['images'] ?? "";
    var _bill_no = Get.arguments['bill_no'];

    //   print(_bill_no);
    var bill_number = '';
    var mobile_number = '';
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text("$_title".tr),
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
                            Text("$_title".tr),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        "Bill Period".tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        billpayController.openBottomSheetBill();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 8,top: 8),
                        child: Container(
                          height: Get.height * .08,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                  const Color(0xFF652981).withOpacity(0.2),
                                  blurRadius: 2,
                                  offset: const Offset(0, 2)),
                            ],
                            //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${billpayController.getMonthName(billpayController.selectedMonth.value)}, ${billpayController.selectedYear.value}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),


                    TextFieldWidget(
                      // keyboardType: numberFormatSymbols,
                      labelText: "Account No".tr,
                      hintText: "Enter Account No".tr,
                      onChanged: (value) {
                        bill_number = value;
                        billpayController.billAccountController.value.text =
                            bill_number;
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
                    TextFieldWidget(
                      // keyboardType: numberFormatSymbols,
                      labelText: "Mobile No".tr,
                      hintText: "Enter Mobile No".tr,
                      onChanged: (value) {

                          mobile_number = value;

                          billpayController.mobileController.value.text =
                              mobile_number;


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
                    // _bill_no == ''
                    //     ? Padding(
                    //   padding: const EdgeInsets.only(left: 15, right: 15),
                    //   child: Row(
                    //     children: [
                    //       Checkbox(
                    //         value: billpayController.isChecked.value,
                    //         onChanged: (value) {
                    //           billpayController.isChecked.value = value!;
                    //         },
                    //       ),
                    //       Flexible(
                    //         child: Text(
                    //           'Save the account for future payment'.tr,
                    //           maxLines: 2,
                    //           softWrap: true,
                    //           overflow: TextOverflow.clip,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                    //     : Container(),
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
                      height: 30,
                    ),

                    BlockButtonWidget(
                      onPressed: () {
                        // // Get.to(DescoPostpaidBillView());
                        //
                        // var result;
                        // var data;

                        // var bill_ref;
                        // var Bill_No =
                        // bill_number == '' ? _bill_no : bill_number;
                        //
                        // var res = getBillDetail(
                        //     Bill_No,
                        //     billpayController.isChecked.value,
                        //     billpayController.refName.value);
                        // Ui.customLoaderDialog();
                        // res.then((value) => {
                        //   Get.back(),
                        //   result = value['result'],
                        //   data = value['data'],
                        //   bill_ref = value['bill_ref'],
                        //   if (value['result'] == 'success')
                        //     {
                        //       Ui.SuccessSnackBar(message: value['result']),
                        //       print(data['bllr_accno']),
                        //       datas = {
                        //         "title": _title,
                        //         "images": _images,
                        //         "bill_payment_id":
                        //         bill_ref['bill_payment_id'],
                        //         "bill_refer_id": bill_ref['bill_refer_id'],
                        //         "bll_no": data['bill_no'],
                        //         "bllr_accno": data['biller_acc_no'],
                        //         "bill_address": data['bill_address'],
                        //         "bll_dt_due": data['bill_due_date'],
                        //         "bll_amnt": data['bill_amount'],
                        //         "bll_vat": data['bill_vat'],
                        //         "ekpay_fee": data['ekpay_fee'],
                        //         "bll_amnt_ttl": data['bill_total_amount'],
                        //         "is_bill_paid": data['is_bill_paid'],
                        //       },
                        //       Get.toNamed(
                        //           Routes.Westzone_Postpaid_Bill_View,
                        //           arguments: datas)
                        //     }
                        //   else
                        //     Get.showSnackbar(Ui.ErrorSnackBar(
                        //         message: value['message'],
                        //         title: 'Failed'.tr))
                        // });
                        if(billpayController.mobileController.value.text.length == 11){
                          var result;
                          var data;
                          var bill_ref;
                          var datas;
                          var Bill_No =
                          bill_number == '' ? _bill_no : bill_number;
                          print('bill numer:  $Bill_No');
                          var res = getBillDetail(
                            mobile: mobile_number,
                            billNumber:  bill_number, //1023115691667
                            isBillSave: billpayController.isChecked.value,
                            refName: billpayController.refName.value,
                          );
                          CustomFullScreenLoader.openLoadingDialog(
                              "Loading....", "assets/animation/docer_processing.json");
                          res.then((value) => {

                            CustomFullScreenLoader.stoploader(),
                            result = value['result'],
                            print("hle bro+++++++ ${value['result']}"),
                            if (value['result'] == 'success')

                              {
                                billpaymentController.billPaymentChargePreview(

                                  bill_payment_id:value['bill_ref']['bill_payment_id'],

                                  bill_refer_id: value['bill_ref']['bill_refer_id'],
                                ),
                                data = value['data'],
                                bill_ref = value['bill_ref'],
                                datas = {
                                  "title": _title,
                                  "images": _images,
                                  "bill_payment_id":
                                   bill_ref['bill_payment_id'],
                                  "bill_refer_id": bill_ref['bill_refer_id'],
                                  "bll_no": data['bill_no'],
                                  "bllr_accno": Bill_No,
                                  "bll_mobno": data['biller_mobile'],
                                  "bll_dt_frm": data['bill_from'],
                                  "bll_dt_to": data['bill_to'],
                                  "bll_dt_due": data['bill_due_date'],
                                  "bll_amnt": data['bill_amount'],
                                  "bll_vat": data['bill_vat'],
                                  "bll_late_fee": data['bill_late_fee'],
                                  "ekpay_fee": data['ekpay_fee'],
                                  "is_bill_paid": data['is_bill_paid'],
                                  "bll_amnt_ttl": data['bill_total_amount'],
                                },
                                Get.toNamed(Routes.Reb_Postpaid_Bill_View,
                                    arguments: datas)
                              } else {
                              Get.showSnackbar(Ui.ErrorSnackBar(
                                  message: value['message'],
                                  title: 'error'.tr))
                          }


                          });
                        }else{
                          Get.showSnackbar(Ui.ErrorSnackBar(
                              message: 'Please provide 11 digit number.'.tr, title: 'Error'.tr));
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
          );
        }));
  }

  Future<Map<dynamic, dynamic>> getBillDetail(
      {String? mobile,
      String? billNumber,
      dynamic isBillSave,
      String? refName}) async {
    Map data = {
      'bill_no': billpayController.billAccountController.value.text,
      'bill_month': billpayController.selectedMonth.value.toString(),
      'bill_year': billpayController.selectedYear.value.toString(),
      "biller_mobile_no": billpayController.mobileController.value.text,
    };
    print("my bill details ${data.toString()}");
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    // var headers = {'token': 'IMBkVG1UFCE8VABPg5TI14yY44StEfWqF341OAlh'};

    var url =
        '${ApiClient.v3baseUrl}/billpay/fetch/palli-bidyut-postpaid';

    // var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    print('Bill Detail : $resp');
    return resp;
  }
}

class MonthList extends StatelessWidget {
  final int selectedYear;

  MonthList(this.selectedYear);

  @override
  Widget build(BuildContext context) {
    List<String> months = List.generate(12, (index) {
      DateTime date = DateTime(selectedYear, index + 1, 1);
      return DateFormat('MMMM').format(date);
    });

    return Column(
      children: [
        Text('Months for $selectedYear:'),
        Column(
          children: months
              .map((month) => ListTile(
                    title: Text(month),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
