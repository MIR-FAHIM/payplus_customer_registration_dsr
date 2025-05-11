import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Due/Widget/indicator.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/daily_report_controller.dart';
import 'package:flutter/cupertino.dart';

class DailyReportAnalyticView extends GetView<DailyReportController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text('Report Analytic'.tr),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        body: Obx(() {
          if (controller.dailyReportLoaded.isTrue) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Container(
                  height: _size.height * 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // DefaultTabController(
                      //   initialIndex: controller.monthSelection.value - 1,
                      //   length: 12,
                      //   child: Container(
                      //     height: 30,
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 8),
                      //           child: Container(
                      //             width: 70,
                      //             child: DropdownButton<String>(
                      //               value: controller.dropdownValue.value,
                      //               isExpanded: true,
                      //               icon:
                      //               Icon(Icons.arrow_drop_down_outlined),
                      //               elevation: 16,
                      //               style: const TextStyle(
                      //                   color: Colors.deepPurple),
                      //               underline: Container(
                      //                 height: 2,
                      //                 color: Colors.transparent,
                      //               ),
                      //               onChanged: (String? value) {
                      //                 // This is called when the user selects an item.
                      //
                      //                 controller.dropdownValue.value = value!;
                      //                   controller.yearSelection.value =
                      //                       int.parse(controller.dropdownValue.value );
                      //                   controller.getDailyReport(date:DateTime.now());
                      //
                      //               },
                      //               items: controller.yearList
                      //                   .map<DropdownMenuItem<String>>(
                      //                       (String value) {
                      //                     return DropdownMenuItem<String>(
                      //                       value: value,
                      //                       child: Text(value),
                      //                     );
                      //                   }).toList(),
                      //             ),
                      //           ),
                      //         ),
                      //         Container(
                      //           width:
                      //           MediaQuery.of(context).size.width - 150,
                      //           child: DefaultTabController(
                      //             initialIndex: controller.monthSelection.value - 1,
                      //             length: 12,
                      //             child: TabBar(
                      //               indicator: BoxDecoration(
                      //                   borderRadius:
                      //                   BorderRadius.circular(10),
                      //                   color: Get.theme.primaryColorLight),
                      //               isScrollable: true,
                      //               indicatorColor: Colors.black,
                      //               labelColor: Colors.black,
                      //               onTap: (index) {
                      //
                      //                   controller.monthSelection.value = index + 1;
                      //
                      //               },
                      //               tabs: controller.tabs
                      //                   .map((tab) => Tab(
                      //                 icon: Padding(
                      //                   padding:
                      //                   const EdgeInsets.all(4.0),
                      //                   child: Text(
                      //                     tab,
                      //                     style:
                      //                     TextStyle(fontSize: 12),
                      //                   ),
                      //                 ),
                      //               ))
                      //                   .toList(),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      //   child: DefaultTabController(
                      //     initialIndex: controller.daySelection.value - 1,
                      //     length: 31,
                      //     child: Column(
                      //       children: [
                      //         TabBar(
                      //           isScrollable: true,
                      //           indicatorColor: Colors.black38,
                      //           labelColor: Colors.black,
                      //           onTap: (index) {
                      //
                      //             controller.daySelection.value = index + 1;
                      //
                      //           },
                      //           tabs: controller.dayTab
                      //               .map((tab) => Tab(
                      //             icon: Padding(
                      //               padding:
                      //               const EdgeInsets.all(8.0),
                      //               child: Text(
                      //                 tab.toString(),
                      //                 style: TextStyle(
                      //                   fontSize: 12,
                      //                 ),
                      //               ),
                      //             ),
                      //           ))
                      //               .toList(),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      Text(
                        "Earned Report",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: Get.height * .18,
                            width: Get.width * .5,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        controller.touchedIndex.value = -1;
                                        return;
                                      }
                                      controller.touchedIndex.value =
                                          pieTouchResponse.touchedSection!
                                              .touchedSectionIndex;
                                    },
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: "0" == "0"
                                      ? controller.showingDemoSections()
                                      : controller.showingSections(),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Indicator(
                                color: Colors.green.withOpacity(.3),
                                text: 'Recharge Commission',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(
                                color: Colors.blue.withOpacity(.3),
                                text: 'Bill Pay Commission',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(
                                color: Colors.purple.withOpacity(.3),
                                text: 'E Ticket Commission',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(
                                color: Colors.red.withOpacity(.3),
                                text: 'M Banking Commission',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 18,
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          height: Get.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Text(
                                'Transactions',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                              Container(
                                height: Get.height * .3,
                                child: BarChart(
                                  BarChartData(
                                    maxY: 20,
                                    barTouchData: BarTouchData(
                                      touchTooltipData: BarTouchTooltipData(
                                      //  tooltipBgColor: Colors.grey,
                                        getTooltipItem: (a, b, c, d) => null,
                                      ),
                                      touchCallback:
                                          (FlTouchEvent event, response) {
                                        if (response == null ||
                                            response.spot == null) {
                                          controller.touchedGroupIndex.value =
                                              -1;
                                          controller.showingBarGroups.value =
                                              List.of(controller
                                                  .rawBarGroups.value);

                                          return;
                                        }

                                        controller.touchedGroupIndex.value =
                                            response.spot!.touchedBarGroupIndex;

                                        if (!event
                                            .isInterestedForInteractions) {
                                          controller.touchedGroupIndex.value =
                                              -1;
                                          controller.showingBarGroups.value =
                                              List.of(controller
                                                  .rawBarGroups.value);
                                          return;
                                        }
                                        controller.showingBarGroups.value =
                                            List.of(
                                                controller.rawBarGroups.value);
                                        if (controller
                                                .touchedGroupIndex.value !=
                                            -1) {
                                          var sum = 0.0;
                                          for (final rod in controller
                                              .showingBarGroups[controller
                                                  .touchedGroupIndex.value]
                                              .barRods) {
                                            sum += rod.toY;
                                          }
                                          final avg = sum /
                                              controller
                                                  .showingBarGroups[controller
                                                      .touchedGroupIndex.value]
                                                  .barRods
                                                  .length;

                                          controller.showingBarGroups[controller
                                                  .touchedGroupIndex.value] =
                                              controller.showingBarGroups[
                                                      controller
                                                          .touchedGroupIndex
                                                          .value]
                                                  .copyWith(
                                            barRods: controller
                                                .showingBarGroups[controller
                                                    .touchedGroupIndex.value]
                                                .barRods
                                                .map((rod) {
                                              return rod.copyWith(
                                                  toY: avg, color: Colors.blue);
                                            }).toList(),
                                          );
                                        }
                                      },
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget:
                                              controller.bottomTitles,
                                          reservedSize: 42,
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 28,
                                          interval: 1,
                                          getTitlesWidget:
                                              controller.leftTitles,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    barGroups:
                                        controller.showingBarGroups.value,
                                    gridData: FlGridData(show: false),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    elevation: 15,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(.3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        height: Get.height * .1,
                                        width: Get.width * .25,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                controller.dailyReportDetails
                                                    .value.total_commision!,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "Total Earning",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Card(
                                    elevation: 15,
                                    child: Container(
                                        height: Get.height * .1,
                                        width: Get.width * .25,
                                        decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(.3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                controller.dailyReportDetails
                                                    .value.recharge_amount!,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "Total Recharge Amount",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Card(
                                    elevation: 15,
                                    child: Container(
                                        height: Get.height * .1,
                                        width: Get.width * .25,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(.3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                controller.dailyReportDetails
                                                    .value.recharge_commission!,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "Total Recharge Commission",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 18,
                                  left: 12,
                                  top: 24,
                                  bottom: 12,
                                ),
                                child: Container(
                                  height: Get.height * .3,
                                  child: LineChart(
                                    controller.showAvg
                                        ? controller.avgData()
                                        : controller.mainData(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 60,
                                height: 34,
                                child: TextButton(
                                  onPressed: () {
                                    controller.showAvg = !controller.showAvg;
                                  },
                                  child: Text(
                                    'avg',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: controller.showAvg
                                          ? Colors.white.withOpacity(0.5)
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
                height: _size.height,
                width: _size.width,
                child: Center(child: Ui.customLoader()));
          }
        }));
  }
}

// Obx(() {
//   if (controller.dailyReportLoaded.isTrue) {
//     return

//   } else {
//     return Container(
//         height: _size.height,
//         width: _size.width,
//         child: Center(child: Ui.customLoader()));
//   }
// })
