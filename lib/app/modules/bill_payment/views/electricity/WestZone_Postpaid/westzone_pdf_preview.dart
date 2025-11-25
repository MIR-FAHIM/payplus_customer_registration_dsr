import 'package:flutter/material.dart';
//import 'package:printing/printing.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/WestZone_Postpaid/westzone_make_pdf.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class WestZonePdfPreviewPage extends StatelessWidget {
  String? title;
  var images;

  int? billPaymentId;
  String? billReferId;

  String? bllNo;
  String? bllrAccno;
  String? billAddress;

  String? bllDtDue;
  String? bllAmnt;
  var bllVat;
  String? ekpayFee;
  bool? isBillPaid;

  String? bllAmntTtl;

  WestZonePdfPreviewPage(
      {this.title,
      this.images,
      this.billPaymentId,
      this.billReferId,
      this.billAddress,
      this.bllAmnt,
      this.bllDtDue,
      this.bllNo,
      this.bllrAccno,
      this.bllAmntTtl,
      this.bllVat,
      this.ekpayFee,
      this.isBillPaid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('PDF Previeww'),
      ),
      // body: PdfPreview(
      //   build: (context) => makePdfWestZone(
      //       title: title,
      //       images: images,
      //       billPaymentId: billPaymentId,
      //       billReferId: billReferId,
      //       bllNo: bllNo,
      //       bllDtDue: bllDtDue,
      //       bllAmnt: bllAmnt),
      // ),
    );
  }
}
