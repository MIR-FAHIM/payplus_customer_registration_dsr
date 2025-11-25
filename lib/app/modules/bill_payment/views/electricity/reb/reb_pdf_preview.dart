import 'package:flutter/material.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/reb/reb_make_pdf.dart';
//import 'package:printing/printing.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/WestZone_Postpaid/westzone_make_pdf.dart';
import 'package:latest_payplus_agent/common/Color.dart';


class REBPdfPreviewPage extends StatelessWidget {
  String? title;
  var images ;

  int? billPaymentId ;
  String? billReferId ;

  String? bllNo ;



  String? bllDtDue ;
  String? bllAmnt;
  var bllVat ;
  String? ekpayFee ;
  bool? isBillPaid ;

  String? bllAmntTtl ;

  REBPdfPreviewPage({ this.title,  this.images, this.billPaymentId, this.billReferId,   this.bllAmnt, this.bllDtDue, this.bllNo,   this.bllAmntTtl, this.bllVat, this.ekpayFee, this.isBillPaid}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('PDF Previeww'),
      ),
      // body: PdfPreview(
      //   build: (context) => makePdfReb(
      //       title:  title ,
      //       images: images,
      //
      //       billPaymentId:billPaymentId ,
      //       billReferId: billReferId ,
      //
      //       bllNo:  bllNo ,
      //
      //       bllDtDue: bllDtDue ,
      //       bllAmnt: bllAmnt ),
      // ),
    );
  }

}