import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_payment_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/WestZone_Postpaid/westzone_pdf_preview.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/reb/reb_pdf_preview.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/widgets/bill_payment-success_view.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class RebPostpaidBillView extends GetView<BillPaymentController> {
  final _size = Get.size;

  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    var _title = Get.arguments["title"] ?? "";
    var _bll_no = Get.arguments["bll_no"] ?? "";
    var biller_mobile = Get.arguments["bll_mobno"] ?? "";
    var _bill_address =Get.arguments["bll_no"] ?? "";
    //bill_payment_id
    var _images = Get.arguments['images'];
    var _bllr_accno = Get.arguments['bllr_accno'];
    var _bill_payment_id = Get.arguments['bill_payment_id'];
    var _bill_refer_id = Get.arguments['bill_refer_id'];
    var _bll_dt_due = Get.arguments["bll_dt_due"] ?? "";
    var _bll_amnt = Get.arguments["bll_no"] ?? "";
    var _bll_vat = Get.arguments["bll_vat"] ?? "";
    var _bll_late_fee= Get.arguments['bill_late_fee'];
    var _ekpay_fee =Get.arguments["bll_no"] ?? "";
    var is_bill_paid = Get.arguments["bll_no"] ?? "";
    var bill_amount = Get.arguments["bll_amnt"] ?? "";

    var bll_amnt_ttl = Get.arguments["bll_amnt_ttl"] ?? "";

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text(_title),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Get.offAllNamed(Routes.BILL_PAYMENT),
            ),
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         Get.offAllNamed(Routes.BILL_PAYMENT);
            //       },
            //       icon: Icon(
            //         CupertinoIcons.bell,
            //         color: Colors.white70,
            //       )),
            // ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            Get.offAllNamed(Routes.BILL_PAYMENT);
            return Future.value(false);
          },
          child: Obx(() {
            if (controller.billpayLoaded.isTrue) {
              var _total = double.parse(bll_amnt_ttl) +
                  double.parse(controller.online_charge.value) +
                  double.parse(controller.servic_fee.value);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
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
                    //1023115691667
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
                              image: NetworkImage(_images),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(_title),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bill No.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  _bll_no,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   width: _size.width,
                          //   height: 1,
                          //   color: AppColors.SectionHighLightCardBg,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8, bottom: 8),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         "Biller Acc No.",
                          //         style: TextStyle(
                          //           fontSize: 16,
                          //           color: AppColors.primaryColor,
                          //         ),
                          //       ),
                          //       // Text(
                          //       //   _bllr_accno,
                          //       //   style: TextStyle(
                          //       //     fontSize: 16,
                          //       //     color: AppColors.homeTextColor3,
                          //       //   ),
                          //       // ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: _size.width,
                          //   height: 1,
                          //   color: AppColors.SectionHighLightCardBg,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8, bottom: 8),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         "Biller Address",
                          //         style: TextStyle(
                          //           fontSize: 16,
                          //           color: AppColors.primaryColor,
                          //         ),
                          //       ),
                          //       Text(
                          //         _bill_address,
                          //         style: TextStyle(
                          //           fontSize: 16,
                          //           color: AppColors.homeTextColor3,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            width: _size.width,
                            height: 1,
                            color: AppColors.SectionHighLightCardBg,
                          ),
                          Container(
                            width: _size.width,
                            height: 1,
                            color: AppColors.SectionHighLightCardBg,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bill Due Date",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  _bll_dt_due,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: _size.width,
                            height: 1,
                            color: AppColors.SectionHighLightCardBg,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bill Payment Status",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  is_bill_paid == 'Y' ? "Paid" : "Not Paid",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: _size.width,
                            height: 15,
                            // color: AppColors.SectionHighLightCardBg,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Customer Mobile",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  biller_mobile,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bill Amount",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  '৳ ' + bll_amnt_ttl,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Platform Fee",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  '৳ ' + controller.servic_fee.value,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Online Balance Charge",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  '৳ ' + controller.online_charge.value,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),


                          _bll_late_fee == null ? Container():  Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Late Fee",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  '৳ ' + _bll_late_fee,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: _size.width,
                            height: 1,
                            color: AppColors.SectionHighLightCardBg,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total : ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.homeTextColor1,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '৳ ' + _total.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    is_bill_paid == 'Y'
                        ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "আপনার বিলটি ইতিমধ্যে পরিশোধ করা হয়েছে",
                          style: TextStyle(
                              color: AppColors.greenTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                        : BlockButtonWidget(
                      onPressed: () {
                        var result;
                        var data;
                        var current_balance;
                        var bill_amount;
                        var service_charge;
                        var charge_for_online_balance_received;
                        var grand_total_amount;
                        print(_bill_payment_id);
                        print(_bill_refer_id);
                        var res = BillPaymentChargePreview(_bill_payment_id, _bill_refer_id);
                        Ui.customLoaderDialog();
                        res.then((value) => {
                          Get.back(),
                          result = value['result'],
                          data = value['data'],
                          if (value['result'] == 'success')
                            {
                              data = value['data'],
                              current_balance = data['current_balance'],
                              bill_amount = data['bill_amount'],
                              service_charge = data['service_charge'],
                              charge_for_online_balance_received = data['charge_for_online_balance_received'],
                              grand_total_amount = data['grand_total_amount'],
                              openBottomSheetBill(current_balance, bill_amount, service_charge, charge_for_online_balance_received,
                                  grand_total_amount, _bllr_accno, _title, _images, _bill_payment_id, _bill_refer_id)
                            }
                          else
                            Get.showSnackbar(Ui.ErrorSnackBar(message: value['message'], title: 'error'.tr))
                        });
                      },
                      color: Color(0xFF652981),
                      text: Text(
                        "Pay Bill".tr,
                        style:
                        TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ).paddingSymmetric(vertical: 10, horizontal: 20),
                    SizedBox(height: 20,),

                    // GestureDetector(
                    //     onTap: () {
                    //       Navigator.of(context).push(
                    //         MaterialPageRoute(
                    //           builder: (builder) =>
                    //
                    //               REBPdfPreviewPage(
                    //                 title : _title,
                    //                 images : _images,
                    //
                    //                 billPaymentId : _bill_payment_id,
                    //                 billReferId : _bill_refer_id,
                    //
                    //                 bllNo : _bll_no,
                    //
                    //
                    //
                    //                 bllDtDue : _bll_dt_due,
                    //                 bllAmnt : bll_amnt_ttl,
                    //
                    //               ),
                    //         ),
                    //       );
                    //     },
                    //     child: Row(
                    //       mainAxisAlignment:
                    //       MainAxisAlignment.center,
                    //       children: [
                    //         Container(
                    //           height: 50,
                    //           width: 50,
                    //           decoration: BoxDecoration(
                    //               image: DecorationImage(
                    //                   image: AssetImage(
                    //                     'assets/icons/utility_expense.png',
                    //                   ))),
                    //         ),
                    //         Text(
                    //           "View PDF",
                    //           style: TextStyle(
                    //               color: Colors.black54),
                    //         ),
                    //       ],
                    //     )),
                  ],
                ),
              );
            } else {
              return Container(
                  height: _size.height,
                  width: _size.width,
                  child: Center(child: Ui.customLoader()));
            }
          }),
        ));
  }

  Future<Map<dynamic, dynamic>> BillPaymentChargePreview(
      int billPaymentID, String billRefId) async {
    // print(billNumber);
    Map data = {
      'bill_payment_id': billPaymentID.toString(),
      'bill_refer_id': billRefId,
    };

    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};

    var url = 'https://shl.com.bd/api/appapi/billpay/charge/preview';

    // var body = json.encode(data);

    var response =
    await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    print('Bill Charge : $resp');
    return resp;
  }

  Future<Map<dynamic, dynamic>> BillPayment(
      int billPaymentID,
      String billRefId,
      String billAmount,
      String serviceCharge,
      String onlineCharge,
      String totalAmount,
      dynamic pin,
      ) async {
    // print(billNumber);
    Map data = {
      'bill_payment_id': billPaymentID.toString(),
      'bill_refer_id': billRefId,
      'bill_amount': billAmount,
      'service_charge': serviceCharge,
      'charge_for_online_balance_received': onlineCharge,
      'grand_total_amount': totalAmount,
      'pin': pin.toString(),
    };

    print("calling these data $data");

    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};

    var url = '${ApiClient.v3baseUrl}/billpay/pay/app-bill-payment-common';

    // var body = json.encode(data);

    var response =
    await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    print('Bill payment : $resp');
    return resp;
  }

  void openBottomSheetBill(
      String currentBalance,
      String billAmount,
      String serviceCharge,
      String onlineCharge,
      String totalAmount,
      dynamic accountNumber,
      dynamic title,
      dynamic image,
      dynamic paymentId,
      dynamic referId) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 3),
                            child: Center(
                              child: Text(
                                'Recipient'.tr,
                                style: TextStyle(
                                    color: AppColors.homeTextColor3,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      double.parse(totalAmount) > double.parse(currentBalance)
                          ? Text(
                        'insufficient funds'.tr,
                        style: TextStyle(
                            color: AppColors.redTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: IconButton(
                          icon: Icon(Icons.cancel_rounded),
                          iconSize: 30,
                          color: Colors.grey,
                          splashColor: Colors.purple,
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        Image.network(
                          image,
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 22, top: 15, right: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Account Number'.tr,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              accountNumber,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            //Amount
                            const SizedBox(height: 12),
                            Text(
                              'Amount'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ ' + billAmount,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Present Balance'.tr,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ ' + currentBalance,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            //Amount
                            const SizedBox(height: 12),
                            Text(
                              'Online Charge'.tr,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ ' + onlineCharge,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            //Amount
                            const SizedBox(height: 12),
                            Text(
                              'Total'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ ' + totalAmount,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            double.parse(totalAmount) > double.parse(currentBalance)
                ? Container()
                : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  width: _size.width,
                  //  height: 50,
                  decoration: Ui.getBoxDecoration(radius: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: TextFormField(
                      // controller: controller.pinController,
                      cursorColor: Color(0xFF652981),
                      textAlign: TextAlign.center,
                      maxLength: 6,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: 'Enter PIN here'.tr,
                        hintStyle: TextStyle(
                            color: Color(0xFF652981), fontSize: 15),
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          color: Color(0xFF652981),
                        ),
                        focusColor: Color(0xFF652981),
                      ),
                      // focusNode: controller.pinFocusFocus,
                      keyboardType: TextInputType.phone,
                      // validator: (String? value) {
                      //
                      // },
                      onChanged: (input) {
                        controller.pin.value = input;
                      },
                    ),
                  )),
            ),
            double.parse(totalAmount) > double.parse(currentBalance)
                ? BlockButtonWidget(
              onPressed: () {
                Get.toNamed(
                    Routes.Add_Balance_Form_View);
                //Get.toNamed(Routes.Add_Balance_Dashboard_View);
              },
              color: Color(0xFF652981),
              text: Text(
                "Add Your Balance".tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ).paddingSymmetric(vertical: 10, horizontal: 10)
                : controller.disable.value == false
                ? BlockButtonWidget(
              onPressed: () {
                var result;
                var data;
                var datas;
                print(controller.pin.value);


                if (double.parse(totalAmount) >
                    double.parse(currentBalance)) {
                  print("disable");
                } else {
                  controller.disable.value = true;
                  print("enable");
                  var res = BillPayment(
                      paymentId,
                      referId,
                      billAmount,
                      serviceCharge,
                      onlineCharge,
                      totalAmount,
                      controller.pin.value);
                  Ui.customLoaderDialog();
                  res.then((value) => {

                    Get.back(),
                    result = value['result'],
                    data = value['data'],
                    if (value['result'] == 'success')
                      {
                      controller.disable.value = false,
                        data = value['data'],
                        datas = {
                          "title": title,
                          "images": image,
                          "bll_no": data['bill_no'],
                          "bllr_accno": data['biller_acc_no'],
                          "bll_mobno": data['biller_mobile'],
                          "bll_dt_frm": data['bill_from'],
                          "bll_dt_to": data['bill_to'],
                          "bill_due_date": data['bill_due_date'],
                          "bill_total_amount": data['bill_total_amount'],
                          "charge": data['charge'],
                          "transaction_id": data['transaction_id'],
                          "payment_date": data['payment_date'],
                        },
                        Get.offAll(BillPaymentSuccessView(),
                            arguments: datas)
                        // print(data['bllr_accno'])
                      }
                    else
                      controller.disable.value = false,
                      Get.showSnackbar(Ui.ErrorSnackBar(
                          message: value['message'],
                          title: 'error'.tr))
                  });
                }
              },
              color:
              double.parse(totalAmount) > double.parse(currentBalance)
                  ? Colors.grey
                  : Color(0xFF652981),
              text: double.parse(totalAmount) >
                  double.parse(currentBalance)
                  ? Text(
                "insufficient Funds".tr,
                style: TextStyle(color: Colors.red, fontSize: 16),
              )
                  : Text(
                "Confirm Bill Payment".tr,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ).paddingSymmetric(vertical: 10, horizontal: 20) : Container(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
