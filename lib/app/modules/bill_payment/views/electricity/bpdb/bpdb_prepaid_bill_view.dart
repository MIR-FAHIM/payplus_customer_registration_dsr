import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/electricity/bpdb_fetch_model.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_payment_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/bill_payment_view.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/widgets/bill_payment-success_view.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class BPDBPrepaidBillView extends GetView<BillPaymentController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    FetchBpdbModel data = Get.arguments[0];
    String _title = Get.arguments[1];
    String _images = Get.arguments[2];

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
            //       onPressed: () {
            //         Get.offAllNamed(Routes.BILL_PAYMENT);
            //       },
            //       icon: Icon(
            //         CupertinoIcons.bell,
            //         color: Colors.white70,
            //       )),
            // ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Get.off(BillPaymentView()),
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            Get.offAllNamed(Routes.BILL_PAYMENT);
            return Future.value(false);
          },
          child: Obx(() {
            if (controller.billpayLoaded.isTrue) {
             var _total = double.parse(data.data!.billTotalAmount) + double.parse(controller.online_charge.value) + double.parse(controller.servic_fee.value);

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
                                  "Biller Acc No.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  data.data!.billNo!,
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
                                  "Biller Name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  data.data!.customerName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //
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
                                  "Biller Mobile No.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  data.data!.billerMobile,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.homeTextColor3,
                                  ),
                                ),
                              ],
                            ),
                          ),




                          //
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
                                  data.data!.isBillPaid == 'Y' ? "Paid" : "Not Paid",
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
                                  "Amount",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  '৳ ' + data.data!.billAmount!,
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
                                  "Online Charge",
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

                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Service Fee",
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
                                  style: TextStyle(fontSize: 16, color: AppColors.homeTextColor1, fontWeight: FontWeight.bold),
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
                    SizedBox(height: 20),
                    data.data!.isBillPaid == 'Y'
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "আপনার বিলটি ইতিমধ্যে পরিশোধ করা হয়েছে",
                                style: TextStyle(color: AppColors.greenTextColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : BlockButtonWidget(
                            onPressed: () {
                              var result;
                              var preview;

                              var current_balance;
                              var bill_amount;
                              var service_charge;
                              var charge_for_online_balance_received;
                              var grand_total_amount;

                              var res = BillPaymentChargePreview(data.billRef!.billPaymentId, data!.billRef!.billReferId);
                              Ui.customLoaderDialog();
                              res.then((value) => {
                                Get.back(),
                                result = value['result'],
                                preview = value['data'],
                                if (value['result'] == 'success')
                                  {
                                    preview = value['data'],
                                    current_balance = preview['current_balance'],
                                    bill_amount = preview['bill_amount'],
                                    service_charge = preview['service_charge'],
                                    charge_for_online_balance_received = preview['charge_for_online_balance_received'],
                                    grand_total_amount = preview['grand_total_amount'],
                                    openBottomSheetBill(currentBalance: current_balance,billAmount: bill_amount,
                                      serviceCharge: service_charge,onlineCharge: charge_for_online_balance_received,
                                      totalAmount:   grand_total_amount, title:  _title,
                                      image:   _images, paymentID: data.billRef!.billPaymentId, referId: data!.billRef!.billReferId, meterNum: "" ),
                                  }
                                else
                                  Get.showSnackbar(Ui.ErrorSnackBar(message: value['message'], title: 'error'.tr))
                              });
                            },
                            color: Color(0xFF652981),
                            text: Text(
                              "Pay Bill".tr,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ).paddingSymmetric(vertical: 10, horizontal: 20),


                  ],
                ),
              );
            } else {
              return Container(height: _size.height, width: _size.width, child: Center(child: Ui.customLoader()));
            }
          }),
        ));
  }

  Future<Map<dynamic, dynamic>> BillPaymentChargePreview(int billPaymentID, String billRefId) async {
    // print(billNumber);
    Map data = {
      'bill_payment_id': billPaymentID.toString(),
      'bill_refer_id': billRefId,
    };

    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};

    var url = 'https://shl.com.bd/api/appapi/billpay/charge/preview';

    // var body = json.encode(data);

    var response = await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    print('Bill Charge : $resp');
    return resp;
  }

  Future<Map<dynamic, dynamic>> BillPayment(
      {int? billPaymentID,
      String? billRefId,
      String? billAmount,
      String? serviceCharge,
      String? onlineCharge,
      String? totalAmount,
      String? pin}) async {
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

    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};

    var url = 'https://shl.com.bd/api/appapi/billpay/pay/bill-payment-common';

    // var body = json.encode(data);

    var response = await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    print('Bill Detail : $resp');
    return resp;
  }

  void openBottomSheetBill(
      {String? currentBalance, String? billAmount, String? serviceCharge, String? onlineCharge, String? totalAmount,
         dynamic title, dynamic image, dynamic paymentID, dynamic referId, String? meterNum}) {
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
                                style: TextStyle(color: AppColors.homeTextColor3, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      double.parse(totalAmount!) > double.parse(currentBalance!)
                          ? Text(
                              'insufficient funds'.tr,
                              style: TextStyle(color: AppColors.redTextColor, fontWeight: FontWeight.bold, fontSize: 16),
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
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, top: 15, right: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meter Number'.tr,
                              style: TextStyle(fontSize: 13, color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              meterNum!,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                              '৳ ' + billAmount!,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            //Amount
                            const SizedBox(height: 12),
                            Text(
                              'Service Fee'.tr,
                              style: TextStyle(fontSize: 13, color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ ' + serviceCharge!,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Present Balance'.tr,
                              style: TextStyle(fontSize: 13, color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ ' + currentBalance,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            //Amount
                            const SizedBox(height: 12),
                            Text(
                              'Online Charge'.tr,
                              style: TextStyle(fontSize: 13, color: AppColors.homeTextColor3),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ ' + onlineCharge!,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                            obscureText: true,
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              hintText: 'Enter PIN here'.tr,
                              hintStyle: TextStyle(color: Color(0xFF652981), fontSize: 15),
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
                      Get.toNamed(Routes.Add_Balance_Dashboard_View);
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
                : BlockButtonWidget(
                    onPressed: () {
                      var result;
                      var data;
                      var datas;
                      print(controller.pin.value);
                      if (double.parse(totalAmount) > double.parse(currentBalance)) {
                        print("disable");
                      } else {
                        print("enable");

                        var res = BillPayment(
                          billPaymentID: paymentID,
                          billRefId: referId,
                          billAmount:  billAmount,
                          serviceCharge: serviceCharge,
                          onlineCharge: onlineCharge,
                          totalAmount:  totalAmount,
                         pin: controller.pin.value,
                        );
                        Ui.customLoaderDialog();
                        res.then((value) => {
                              Get.back(),
                              result = value['result'],
                              data = value['data'],
                              if (value['result'] == 'success')
                                {
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
                                  Get.offAll(BillPaymentSuccessView(), arguments: datas)
                                  // print(data['bllr_accno'])
                                }
                              else
                                Get.showSnackbar(Ui.ErrorSnackBar(message: value['message'], title: 'error'.tr))
                            });
                      }
                    },
                    color: double.parse(totalAmount) > double.parse(currentBalance) ? Colors.grey : Color(0xFF652981),
                    text: double.parse(totalAmount) > double.parse(currentBalance)
                        ? Text(
                            "insufficient Funds".tr,
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          )
                        : Text(
                            "Confirm Bill Payment".tr,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ).paddingSymmetric(vertical: 10, horizontal: 20)


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
