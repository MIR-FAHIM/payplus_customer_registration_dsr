import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/eTicket/bus_ticket/views/pdf_bus/make_pdf.dart';
//import 'package:printing/printing.dart';


class PdfPreviewPageBus extends StatelessWidget {
  String? journeyRoute;
  DateTime? journeyDate;
  String? busName;
  String? amount;
  int? id;
  String? status;

  PdfPreviewPageBus({
    Key? key,
    this.journeyDate,
    this.journeyRoute,
    this.busName,
    this.amount,
    this.status,
    this.id

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF652981),
        centerTitle: true,
        title: Text("Ticket Purchase"),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      // body: PdfPreview(
      //   useActions: true,
      //   allowSharing: true,
      //   canChangeOrientation: false,
      //   canChangePageFormat: false,
      //   canDebug: false,
      //
      //   build: (context) => makePdfBus(
      //  journeyRoute:  journeyRoute,
      //  journeyDate: journeyDate,
      //  busName: busName,
      //     amount:amount,
      //  id:id,
      //    status:status,
      //       ),
      // ),
    );
  }
}
