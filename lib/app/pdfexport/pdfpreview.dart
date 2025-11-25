import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/pdfexport/pdf_save_service.dart';
import 'pdf/pdfexport.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';

class PdfPreviewPage extends StatelessWidget {
  final String? title;
  final dynamic images;
  final dynamic bllr_accno;
  final dynamic bll_no;
  final dynamic bll_mobno;
  final dynamic bll_dt_frm;
  final dynamic bll_dt_to;
  final dynamic bll_dt_due;
  final dynamic charge;
  final dynamic token;
  final dynamic transaction_id;
  final dynamic bll_amnt_ttl;
  final dynamic payment_date;

  PdfPreviewPage({
    Key? key,
    this.title,
    this.images,
    this.bllr_accno,
    this.bll_no,
    this.bll_mobno,
    this.bll_dt_frm,
    this.bll_dt_to,
    this.bll_dt_due,
    this.charge,
    this.token,
    this.transaction_id,
    this.bll_amnt_ttl,
    this.payment_date,
  }) : super(key: key);

  Widget infoRow(String label, String? value) {
    if (value == null || value.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14, color: Color(0xFF652981), fontWeight: FontWeight.w600)),
          Text(value,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final purple = Color(0xFF652981);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: purple,
        centerTitle: true,
        title: Text(title ?? "Bill Summary"),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 48),
                      SizedBox(height: 10),
                      Text(
                        "Payment Successful",
                        style: TextStyle(
                            fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Here is your payment summary",
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Bill Information Section
            Text("Bill Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    infoRow("Bill No", bll_no),
                    infoRow("Biller Account", bllr_accno),
                    infoRow("Mobile No", bll_mobno),
                    infoRow("Billing Period", (bll_dt_frm != null && bll_dt_to != null)
                        ? "$bll_dt_frm to $bll_dt_to"
                        : ""),
                    infoRow("Due Date", bll_dt_due),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Transaction Section
            Text("Transaction Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    infoRow("Transaction ID", transaction_id),
                    infoRow("Payment Date", payment_date),
                    infoRow("Bill Token", token),
                    infoRow("Charge", charge),
                    infoRow("Total Amount", bll_amnt_ttl),
                  ],
                ),
              ),
            ),

            SizedBox(height: 50),
          ],
        ),
      ),

      // Download Button
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: BlockButtonWidget(
          color: purple,
          onPressed: generatePdfAndOpen,
          text: Text(
            "Download PDF",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  /// Save and open PDF with same data
  void generatePdfAndOpen() async {
    final pdfBytes = await makePdf(
      title,
      images,
      bllr_accno,
      bll_no,
      bll_mobno,
      bll_dt_frm,
      bll_dt_to,
      bll_dt_due,
      charge,
      transaction_id,
      bll_amnt_ttl,
      payment_date,
      token,
    );

    final savedPath = await PdfSaveService.saveAndOpenPdf(pdfBytes, "PaySlip");

    debugPrint("PDF saved to: $savedPath");
  }
}
