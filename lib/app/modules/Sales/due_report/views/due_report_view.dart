import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/due_report_controller.dart';

class DueReportView extends GetView<DueReportController> {
  const DueReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DueReportView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DueReportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
