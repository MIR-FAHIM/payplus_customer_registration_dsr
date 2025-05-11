import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/bill_payment_view.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/widgets/bill_payment_pdf.dart';
import 'package:latest_payplus_agent/app/pdfexport/pdf/pdfexport.dart';
import 'package:latest_payplus_agent/app/pdfexport/pdfpreview.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class BillPaymentSuccessView extends GetView {
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    var _title = Get.arguments['title'];
    var _images = Get.arguments['images'];

    var _bill_payment_id = Get.arguments['bill_payment_id'];
    var _bill_refer_id = Get.arguments['bill_refer_id'];

    var _bll_no = Get.arguments['bll_no'];
    var _bllr_accno = Get.arguments['bllr_accno'];
    var _bll_mobno = Get.arguments['bll_mobno'];
    var _bll_dt_frm = Get.arguments['bll_dt_frm'];
    var _bll_dt_to = Get.arguments['bll_dt_to'];
    var _bll_dt_due = Get.arguments['bill_due_date'];
    var charge = Get.arguments['charge'];
    var transaction_id = Get.arguments['transaction_id'];
    var bll_amnt_ttl = Get.arguments['bill_total_amount'];
    var payment_date = Get.arguments['payment_date'];

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: const Size(65, 65),
          child: AppBar(
            backgroundColor: const Color(0xFF652981),
            centerTitle: true,
            title: Text(_title),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Get.off(BillPaymentView()),
            ),
            elevation: 0,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
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
              const SizedBox(
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
                      const SizedBox(
                        width: 10,
                      ),
                      Text(_title),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  "Payment Successful",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.greenTextColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration:
                      Ui.getBoxDecoration(color: Colors.white, radius: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bill Information : ",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.homeTextColor1,
                              fontWeight: FontWeight.bold),
                        ),
                        _bll_no == null || _bll_no == ""
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Bill No.",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      _bll_no,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.homeTextColor3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        _bllr_accno == null || _bllr_accno == ""
                            ? Container()
                            : Column(
                                children: [
                                  Container(
                                    width: _size.width,
                                    height: 1,
                                    color: AppColors.SectionHighLightCardBg,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Biller Acc No.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          _bllr_accno == null
                                              ? ""
                                              : _bllr_accno,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.homeTextColor3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        _bll_mobno == null || _bll_mobno == ""
                            ? Container()
                            : Column(
                                children: [
                                  Container(
                                    width: _size.width,
                                    height: 1,
                                    color: AppColors.SectionHighLightCardBg,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Biller Mobile No.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          _bll_mobno == null ? "" : _bll_mobno,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.homeTextColor3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        _bll_dt_frm == null ||
                                _bll_dt_frm == "" ||
                                _bll_dt_to == null ||
                                _bll_dt_to == ''
                            ? Container()
                            : Column(
                                children: [
                                  Container(
                                    width: _size.width,
                                    height: 1,
                                    color: AppColors.SectionHighLightCardBg,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Biller For",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          _bll_dt_frm + " to " + _bll_dt_to,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.homeTextColor3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        _bll_dt_due == null || _bll_dt_due == ""
                            ? Container()
                            : Column(
                                children: [
                                  Container(
                                    width: _size.width,
                                    height: 1,
                                    color: AppColors.SectionHighLightCardBg,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Bill Due Date",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          _bll_dt_due,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.homeTextColor3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          width: _size.width,
                          height: 30,
                          // color: AppColors.SectionHighLightCardBg,
                        ),
                        Text(
                          "Transaction Information :",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.homeTextColor1,
                              fontWeight: FontWeight.bold),
                        ),
                        transaction_id == null || transaction_id == ""
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Transaction Id",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      transaction_id,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.homeTextColor3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        payment_date == null || payment_date == ""
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Payment Date",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      payment_date == null ? "" : payment_date,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.homeTextColor3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        charge == null || charge == ""
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Charge",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      charge,
                                      style: TextStyle(
                                        fontSize: 14,
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
                                "Total Amount ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Text(
                                bll_amnt_ttl,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.homeTextColor3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () async {
                    print('BillPaymentSuccessView.build');
                    final pdfFile = await BillPaymentPdf.generateCenteredText(
                        _title,
                        _images,
                        _bllr_accno,
                        _bll_no,
                        _bll_mobno,
                        _bll_dt_frm,
                        _bll_dt_to,
                        _bll_dt_due,
                        charge,
                        transaction_id,
                        bll_amnt_ttl,
                        payment_date);
                    // makePdf(
                    //     'DPDC Postpaid', '', _bllr_accno, _bll_no, _bll_mobno, _bll_dt_frm, _bll_dt_to, _bll_dt_due, charge, transaction_id, bll_amnt_ttl, payment_date);
                    //

                    Get.to(PdfPreviewPage(
                      title: _title,
                      images: '',
                      bllr_accno: _bllr_accno,
                      bll_no: _bll_no,
                      bll_mobno: _bll_mobno,
                      bll_dt_frm: _bll_dt_frm,
                      bll_dt_to: _bll_dt_to,
                      bll_dt_due: _bll_dt_due,
                      charge: charge,
                      transaction_id: transaction_id,
                      bll_amnt_ttl: bll_amnt_ttl,
                      payment_date: _bll_dt_due,
                    ));
                  },
                  child: Container(
                    width: _size.width,
                    height: _size.width * .12,
                    decoration: Ui.getBoxDecoration(
                        color: Color(0xFF652981), radius: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.print,
                              color:
                                  Colors.white, //The color which you want set.
                            ),
                            // Image.asset(
                            //   "assets/sales/sale_from_list.png",
                            //   width: 20,
                            //   height: 20,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Print/Share',
                                style: Get.textTheme.bodyMedium!
                                    .merge(TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // Future<Map<dynamic, dynamic>> BillPayment(
  //     int billPaymentID, String billRefId) async {
  //   // print(billNumber);
  //   Map data = {
  //     'bill_payment_id': billPaymentID.toString(),
  //     'bill_refer_id': billRefId,
  //   };

  //   var url = 'https://shl.com.bd/api/appapi/billpay/pay/bill-payment-common';

  //   // var body = json.encode(data);

  //   var response = await http.post(Uri.parse(url),
  //       headers: {"token": "fixedTokenForSahedToTestEkpayBill"}, body: data);
  //   var resp = json.decode(response.body);
  //   print('Bill Detail : $resp');
  //   return resp;
  // }
}
