import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

import 'package:latest_payplus_agent/app/modules/Sales/expenses_report/controllers/expenses_report_controller.dart';

class ExpensePerosnalPieChart extends StatefulWidget {
  const ExpensePerosnalPieChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ExpensePerosnalPieChartState();
}

class ExpensePerosnalPieChartState extends State {
  int touchedIndex = -1;
  final _size = Get.size;

  ExpensesReportController controller = Get.find<ExpensesReportController>();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Obx(() {
        return Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections()),
                  ),
                ),
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        );
      }),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(controller.expensesHistory.value.expensesdata!.length,
        (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 13.0;
      final radius = isTouched ? 60.0 : 50.0;
      return PieChartSectionData(
        color: controller.color[i],
        value: ((controller.expensesHistory.value.expensesdata![i].total!
                        .toDouble() /
                    controller.expensesHistory.value.allTotal!.toDouble()) *
                100)
            .floorToDouble(),
        title:
            '${((controller.expensesHistory.value.expensesdata![i].total!.toInt() / controller.expensesHistory.value.allTotal!.toInt()) * 100).floorToDouble()}%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    });
  }
}
