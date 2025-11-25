import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
//import 'package:printing/printing.dart';

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makePdfWestZone(
    {
      title,
      images,
      billPaymentId,
      billReferId,
      bllNo,
      bllDtDue,
      bllAmnt
    }
      ) async {
  final pdf = pw.Document();
  List<pw.Widget> widgets = [];
  widgets.add(pw.SizedBox(height: 5));
 // var font = await PdfGoogleFonts.bangersRegular();
  final fontData = await rootBundle.load('assets/font/Kalpurush.ttf');
  final ttf = pw.Font.ttf(fontData.buffer.asByteData());

  widgets.add(
    Column(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Text(
                    "Printed on: ${DateFormat.yMd().format(DateTime.now())}," +
                        " ${DateFormat.jm().format(DateTime.now())}",
                    style: TextStyle(
                        fontWeight: pw.FontWeight.normal, fontSize: 8),
                  ),
                ]),
            SizedBox(height: 05),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        pw.SizedBox(height: 05),
        Container(
            height: 40,
            width: 140,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                ),
                shape: BoxShape.rectangle),
            child: Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  Text(title,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  PaddedText("${DateFormat.yMMM().format(DateTime.now())}"),
                ])),
        SizedBox(height: 05),
        Row(children: [
          Container(
              child: Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bill Account: ",
                    ),
                    Text(bllNo),
                  ])),
          Spacer(),
        ]),
        pw.SizedBox(height: 20),
      ],
    ),
  );
  widgets.add(
    Table(
      border: TableBorder.all(color: PdfColors.black),
      children: [
        TableRow(
          children: [
            Padding(
              child: Text('Due Date',
                  textAlign: TextAlign.center,
                  style: pw.TextStyle(fontSize: 8)),
              padding: EdgeInsets.only(top: 10),
            ),
            Padding(
              child: Text('Payment Status',
                  textAlign: TextAlign.center,
                  style: pw.TextStyle(fontSize: 8)),
              padding: EdgeInsets.only(top: 10),
            ),
            Padding(
              child: Text('Bill  Amount',
                  textAlign: TextAlign.center,
                  style: pw.TextStyle(fontSize: 8)),
              padding: EdgeInsets.only(top: 10),
            ),
            Padding(
              child: Text('Online Charge',
                  textAlign: TextAlign.center,
                  style: pw.TextStyle(fontSize: 8)),
              padding: EdgeInsets.only(top: 10),
            ),
          ],
        ),
        TableRow(
          children: [
            PaddedText(bllDtDue),
            PaddedText("status"),
            PaddedText(bllAmnt),
            PaddedText(bllAmnt),
            // '\$${(invoice.totalCost() * 1).toStringAsFixed(2)}')
          ],
        ),
        TableRow(
          children: [
            PaddedText('TOTAL', align: TextAlign.right),
            PaddedText(''),
            PaddedText(''),
            PaddedText(""),
            // '\$${(invoice.totalCost() * 1).toStringAsFixed(2)}')
          ],
        )
      ],
    ),
  );
  widgets.add(
    pw.SizedBox(height: 60),
  );
  widgets
      .add(Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
    Column(children: [
      Container(
        width: 100,
        child: Divider(thickness: 1),
      ),
      Text("User Signature & Date"),
      pw.SizedBox(width: 10),
    ]),
    Column(children: [
      Container(
        width: 100,
        child: Divider(thickness: 1),
      ),
      Text("Admin Checked"),
      pw.SizedBox(width: 10),
    ]),
    Column(children: [
      Container(
        width: 100,
        child: Divider(thickness: 1),
      ),
      Text("Approved by"),
      pw.SizedBox(width: 10),
    ]),
  ]));

  // final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
  pdf.addPage(
    pw.MultiPage(build: (context) {
      return widgets;
    }),
  );
  return pdf.save();
}

Widget PaddedText(
    final String text, {
      final TextAlign align = TextAlign.left,
    }) =>
    Padding(
      padding: EdgeInsets.all(2),
      child: Text(text, textAlign: align, style: pw.TextStyle(fontSize: 8)),
    );
