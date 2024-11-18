import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/widgets/sales_options_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/sales_controller.dart';

class SalesView extends GetView<SalesController> {
  final _size = Get.size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(65, 65),
        child: AppBar(
          backgroundColor: const Color(0xFF652981),
          centerTitle: true,
          title: Text('Sales'.tr,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.ROOT);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.buysellLoaded.isTrue) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Get.height * .4,
                  child: Column(
                    children: [
                      // Today Sale Section with Gradient and Shadow
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Container(
                          width: _size.width,
                          height: _size.width * .25,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor,
                                Color(0xFF7B1FA2)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Today Sale'.tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '৳ ${controller.buysellReport['sell']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Earnings, Payout, Buy Section
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: _size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatisticCard(
                                icon: Icons.monetization_on,
                                title: 'Today Earnings'.tr,
                                amount: '৳ ${controller.buysellReport['sell']}',
                                color: const Color(0xFF4CAF50),
                              ),
                              _buildStatisticCard(
                                icon: Icons.payment,
                                title: 'Today Payout'.tr,
                                amount:
                                    '৳ ${controller.buysellReport['expense']}',
                                color: const Color(0xFFEF5350),
                              ),
                              _buildStatisticCard(
                                icon: Icons.shopping_cart,
                                title: 'Buy'.tr,
                                amount: '৳ ${controller.buysellReport['buy']}',
                                color: const Color(0xFF42A5F5),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Business Statistic Chart (Pie Chart)
                    ],
                  ),
                ),
                SalesOptionWidget(),
              ],
            ),
          );
        } else {
          return Center(child: Ui.customLoader());
        }
      }),
    );
  }

  Widget _buildBarChart() {
    return AspectRatio(
      aspectRatio: 1.3,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxY(), // Adjust max Y value according to data
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const months = [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec'
                  ];
                  return Text(months[value.toInt()],
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14));
                },
                reservedSize: 28,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: _getYInterval(), // Dynamic Y-axis interval
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text('${value.toInt()}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14));
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: _buildBarGroups(),
        ),
      ),
    );
  }

  // Helper function to create bar groups for each month
  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(12, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: 4000, // Get sales data per month
            color: const Color(0xFF7B1FA2),
            width: 20,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    });
  }

  // Get maximum Y value dynamically based on sales data
  double _getMaxY() {
    final maxSales = controller.buysellReport['monthlySales']
        .reduce((a, b) => a > b ? a : b);
    return maxSales.toDouble() * 1.2; // Add 20% buffer for the max Y value
  }

  // Dynamic Y-axis interval based on maximum sales
  double _getYInterval() {
    final maxSales = controller.buysellReport['monthlySales']
        .reduce((a, b) => a > b ? a : b);
    return (maxSales / 5)
        .roundToDouble(); // Divide max sales by 5 for an interval
  }

  // Helper function to build individual statistic cards
  Widget _buildStatisticCard({
    required IconData icon,
    required String title,
    required String amount,
    required Color color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 22, color: color),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
              color: color, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Text(
          amount,
          style: TextStyle(
              color: color, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Pie chart sections (statistics)
  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched =
          false; // Handle touch interactions for future enhancements
      final double fontSize = isTouched ? 18 : 16;
      final double radius = isTouched ? 70 : 60;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFF4CAF50),
            value: 55,
            title: 'transactions',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFFEF5350),
            value: 20,
            title: 'profit',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFF42A5F5),
            value: 15,
            title: 'expense',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xFFFFA726),
            value: 35,
            title: 'pending',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }

  // Legend to explain the pie chart colors
  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem('Transactions', Color(0xFF4CAF50)),
        _buildLegendItem('Profit', Color(0xFFEF5350)),
        _buildLegendItem('Expense', Color(0xFF42A5F5)),
        _buildLegendItem('Pending', Color(0xFFFFA726)),
      ],
    );
  }

  // Helper for legend item
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // Today Sales Card Widget
  Widget _buildTodaySalesCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Container(
        width: _size.width,
        height: _size.width * .25,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFAB47BC), Color(0xFF7B1FA2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.attach_money, size: 30, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  'Today Sale'.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '৳ ${controller.buysellReport['sell']}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Earnings, Payout, Buy Card Widget
  Widget _buildEarningsPayoutBuyCard() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: _size.width,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatisticCard(
              icon: Icons.monetization_on,
              title: 'Earnings'.tr,
              amount: '৳ ${controller.buysellReport['earnings']}',
              color: const Color(0xFF4CAF50),
            ),
            _buildStatisticCard(
              icon: Icons.payment,
              title: 'Payout'.tr,
              amount: '৳ ${controller.buysellReport['payout']}',
              color: const Color(0xFFEF5350),
            ),
            _buildStatisticCard(
              icon: Icons.shopping_cart,
              title: 'Buy'.tr,
              amount: '৳ ${controller.buysellReport['buy']}',
              color: const Color(0xFF42A5F5),
            ),
          ],
        ),
      ),
    );
  }
}
