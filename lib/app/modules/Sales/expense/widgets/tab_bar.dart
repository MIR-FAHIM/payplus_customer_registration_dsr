import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class ExpenseTabBar extends StatelessWidget {
  const ExpenseTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      height: 50,
      child: TabBar(
        controller: tabController,
        indicatorColor: AppColors.primaryColor,
        // indicator: ShapeDecoration(
        //     color: AppColors.primaryColor,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12),
        //     )),
        unselectedLabelColor: AppColors.homeTextColor3,
        labelColor: AppColors.primaryColor,
        tabs: [
          Tab(
              icon: Text(
            'Personal'.tr,
            style: TextStyle(
              // color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              // shadows: [
              //   Shadow(
              //       color: Colors.black.withOpacity(0.4),
              //       offset: Offset(2, 2),
              //       blurRadius: 1),
              // ]
            ),
          )),
          Tab(
              icon: Text(
            'Commercial'.tr,
            style: TextStyle(
              // color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              // shadows: [
              //   Shadow(
              //       color: Colors.black.withOpacity(0.4),
              //       offset: Offset(2, 2),
              //       blurRadius: 1),
              // ]
            ),
          )),
        ],
      ),
    );
  }
}
