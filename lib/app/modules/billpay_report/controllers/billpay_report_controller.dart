import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/billpayhistorymodel.dart';
import 'package:latest_payplus_agent/app/repositories/bill_pay_report_repo.dart';
import 'package:pdf/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class BillpayReportController extends GetxController {
  //TODO: Implement BillpayReportController
  final billReport = <BillPayHistoryData>[].obs;
  final billReportLoaded = false.obs;
  final now = DateTime.now();

  @override
  void onInit() {

    final lastMonth = now.subtract(const Duration(days: 30));
    getBillHistory(
        dateTo: DateFormat('yyyy-MM-dd').format(
            now),
        dateFrom: DateFormat('yyyy-MM-dd').format(
            lastMonth)
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
  void downloadPdf(String filePath) async {
    final File file = File(filePath);
    if (await file.exists()) {
      print("download file is ${file.path}");
      downloadAndSaveFile(file, filePath);
      // Trigger the download action
      // You can use any method suitable for your app to handle the download,
      // for example, opening the file or sharing it
    }
  }
  Future<void> downloadAndSaveFile(File filee, String path) async {
    try {
      // Read the bytes from the file
      final List<int> bytes = await filee.readAsBytes();

      // Get the temporary directory to save the file


      // Save the file
      final filePath = path;
      final File file = File(filePath);
      await file.writeAsBytes(bytes);
      print('File saved at: $filePath');
    } catch (e) {
      print('Error saving file: $e');
    }
  }
  Future<String> makePdf(
      {dynamic title,
      dynamic images,
      dynamic bllr_accno,
      dynamic bll_no,
      dynamic bll_mobno,
      dynamic bll_dt_frm,
      dynamic bll_dt_to,
      dynamic bll_dt_due,
      dynamic charge,
      dynamic transaction_id,
      dynamic bll_amnt_ttl,
      dynamic payment_date}) async {
    final pdf = Document();
    // Your PDF generation code here

    // Get the document directory using path_provider
    final directory = await getDownloadsDirectory();
    final path = '${directory!.path}/payment_receipt.pdf';

    // Save the PDF to the file
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());

    print("my pdf path is $path");

    // Return the file path
    return path;
  }
  getBillHistory({String? dateTo, String?dateFrom, bool? fromNoti}) async {

    print("calling bill pay report controller");
    BillPayReportRepo().getBillHistory(dateTo:  dateTo!, dateFrom: dateFrom!,  ).then((resp) {
      print("calling bill pay report controller 123");

      BillPayHistory model = BillPayHistory.fromJson(resp);
       billReport.value = model.data!;
      billReportLoaded.value = true;
    });
  }
}
