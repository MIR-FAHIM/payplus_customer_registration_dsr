import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/models/daily_report_model.dart';
import 'package:latest_payplus_agent/app/repositories/daily_report.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class DailyReportController extends GetxController {
  //TODO: Implement DailyReportController
  final touchedIndex = 0.obs;
  //bar
  final touchedGroupIndex = 0.obs;
  final selectedDateIndex = 0.obs;
  //bar end
  //growth bar
  final selectedDate = DateTime.now().obs;
  final myFormat = DateFormat('dd-MM-yyyy').obs;
  final gradientColors = [
    AppColors.primaryColor.withOpacity(.3),
    Colors.green.withOpacity(.3),
  ].obs;

  bool showAvg = false;

  //growth bar end
  final count = 0.obs;
  final monthSelection =0.obs;
  final daySelection = 0.obs;
  final rawBarGroups = <BarChartGroupData>[].obs;
  final  showingBarGroups = <BarChartGroupData>[].obs;
  final List<Color> colorList = [
    Colors.purple.withOpacity(.3),
    Colors.green.withOpacity(.3),
    Colors.blue.withOpacity(.3),

    Colors.lightBlue.withOpacity(.3),
    Colors.tealAccent.withOpacity(.3),




    // Add more colors as needed
  ];
  final dailyReport = [].obs;
  final   dropdownValue = "".obs;
  final yearSelection = 0.obs;
  final dailyReportDetails = DailyReportModel().obs;
  final dailyReportLoaded = false.obs;
  final List<String> yearList = <String>[
    DateTime.now().year.toString(),
    DateTime(DateTime.now().year - 1).toString().substring(0, 4),
    DateTime(DateTime.now().year - 2).toString().substring(0, 4)
  ].obs;
  final List<String> tabs = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ].obs;
  final List<int> dayTab = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ].obs;
  var now = new DateTime.now();

  @override
  Future<void> onInit() async {
    await getDailyReport(startDateC: DateTime.now(), endDateC: DateTime.now());
    monthSelection.value = int.parse(DateTime.now().toString().substring(5, 7));
    daySelection.value = int.parse(DateTime.now().toString().substring(8, 10));
     yearSelection.value = int.parse(DateTime.now().toString().substring(0, 4));
     dropdownValue.value = DateTime.now().year.toString();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);
    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups.value = items;

    showingBarGroups.value = rawBarGroups;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
  Color getRandomColor() {
    Random random = Random();
    return colorList[random.nextInt(colorList.length)];
  }


  getDailyReport({DateTime? startDateC,  DateTime? endDateC}) async {
    var formatter = new DateFormat('yyyy-MM-dd');
    String startDate = formatter.format(startDateC!);
    String endDate = formatter.format(endDateC!);

    DailyReportRepo().getDailyReports(startDate, endDate).then((resp) {
      print("daily report");
      print(resp);

      dailyReportDetails.value = resp;
      dailyReport.value = [
        {
          'title': 'Opening Balance'.tr,
          'image': 'assets/images/Opening_Balance.png',
          'balance': dailyReportDetails.value.opening_balance,
        },
        {
          'title': 'Received Amount'.tr,
          'image': 'assets/images/hand.png',
          'balance': dailyReportDetails.value.receive_balance
        },
        {
          'title': 'Online Received Amount'.tr,
          'image': 'assets/images/online_recived_amount.png',
          'balance': dailyReportDetails.value.online_receive_balance
        },
        {
          'title': 'Total Recharge'.tr,
          'image': 'assets/images/Total_Recharge.png',
          'balance': dailyReportDetails.value.recharge_amount
        },
        {
          'title': 'Commission'.tr,
          'image': 'assets/images/commission.png',
          'balance': dailyReportDetails.value.commission
        },
        {
          'title': 'Bill Pay Amount'.tr,
          'image': 'assets/images/bill_pay.png',
          'balance': dailyReportDetails.value.bill_pay_amount
        },
        {
          'title': 'Bill Pay Commission'.tr,
          'image': 'assets/images/bill+pay_commision.png',
          'balance': dailyReportDetails.value.bill_pay_commission
        },
        {
          'title': 'CashBack'.tr,
          'image': 'assets/images/OTF.png',
          'balance': dailyReportDetails.value.cashbackAmount
        },


        {
          'title': 'Daily Charge'.tr,
          'image': 'assets/images/Daily_Charge.png',
          'balance': dailyReportDetails.value.daily_charge
        },
        {
          'title': 'Closing Balance'.tr,
          'image': 'assets/images/Closing_Balance.png',
          'balance': dailyReportDetails.value.closing_balance
        },
        {
          'title': 'Package Purchase'.tr,
          'image': 'assets/images/Closing_Balance.png',
          'balance': dailyReportDetails.value.packagePurchase
        },
        {
          'title': 'Ticket Purchase'.tr,
          'image': 'assets/images/Closing_Balance.png',
          'balance': dailyReportDetails.value.ticketPurchase
        },

        {
          'title': 'Total add balance'.tr,
          'image': 'assets/images/Closing_Balance.png',
          'balance': dailyReportDetails.value.totalAddBalance
        },


      ];

      dailyReportLoaded.value = true;
    });
  }
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      getDailyReport(startDateC: selectedDate.value, endDateC: selectedDate.value);
    }



  }
  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green.withOpacity(.3),
            value: double.parse(dailyReportDetails.value.commission!),
            title: 'Commission',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue.withOpacity(.3),
            value: double.parse(dailyReportDetails.value.otf!),
            title: 'CashBack',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:Colors.blue,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple.withOpacity(.3),
            value: double.parse(dailyReportDetails.value.bill_pay_commission!),
            title: 'Bill Pay Commission',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.redAccent.withOpacity(.3),
            value: double.parse(dailyReportDetails.value.daily_charge!),
            title: 'Daily Charge',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:Colors.red,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
  List<PieChartSectionData> showingDemoSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green.withOpacity(.3),
            value: 11,
            title: '11',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue.withOpacity(.3),
            value: 16,
            title: '16',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color:Colors.blue,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple.withOpacity(.3),
            value: 19,
            title: '19',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.purple,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.redAccent.withOpacity(.3),
            value: 18,
            title: '18',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:Colors.red,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return  Text(text);
  }
  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return text;
  }
  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: AppColors.primaryColor,
          width: 10,
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.green,
          width: 7,
        ),
      ],
    );
  }
  //growth bar
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return text;
  }
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return  FlLine(
            color: Colors.redAccent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return  FlLine(
            color: Colors.blue,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData:  FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData:  LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return  FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return  FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData:  FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
  // growth bar end
  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
