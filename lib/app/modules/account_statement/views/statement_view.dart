// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:latest_payplus_agent/app/modules/account_statement/controllers/statement_controller.dart';
// import 'package:latest_payplus_agent/app/modules/account_statement/widgets/statement_tab_bar.dart';
// import 'package:latest_payplus_agent/app/modules/account_statement/widgets/statement_widget.dart';
// import 'package:latest_payplus_agent/app/routes/app_pages.dart';
// import 'package:latest_payplus_agent/common/Color.dart';
// import 'package:latest_payplus_agent/common/ui.dart';
//
// class AccountStatementView extends StatefulWidget {
//   const AccountStatementView({Key? key}) : super(key: key);
//
//   @override
//   State<AccountStatementView> createState() => _AccountStatementViewState();
// }
//
// class _AccountStatementViewState extends State<AccountStatementView>
//     with TickerProviderStateMixin {
//   TabController? tabController;
//   int currentTabIndex = 0;
//   void onTabChange() {
//     setState(() {
//       currentTabIndex = tabController!.index;
//       print(currentTabIndex);
//     });
//   }
//
//   // DateTime initialDate = DateTime.now();
//   // DateTime? selectedDate;
//   var myFormat = DateFormat('yyyy-MM');
//   var myFormat1 = DateFormat('MMMM, y');
//
//   late AccountStatementController controller;
//
//   @override
//   void initState() {
//     controller = Get.put(AccountStatementController());
//
//
//
//     super.initState();
//   }
//
//   // selectMonth(BuildContext context) {
//   //   showMonthPicker(
//   //     context: context,
//   //     firstDate: DateTime(DateTime.now().year - 1, 5),
//   //     lastDate: DateTime(DateTime.now().year + 1, 9),
//   //     initialDate: controller.selectedDate.value ?? controller.initialDate.value,
//   //     // locale: Locale("en"),
//   //   ).then((date) {
//   //     if (date != null) {
//   //       setState(() {
//   //         selectedDate = date;
//   //       });
//   //     }
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final _size = Get.size;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: PreferredSize(
//           preferredSize: Size(65, 65),
//           child: AppBar(
//             backgroundColor: Color(0xFF652981),
//             centerTitle: true,
//             title: Text('Account Statement'.tr),
//             elevation: 0,
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back_ios),
//               onPressed: () => Get.back(),
//             ),
//           ),
//         ),
//         body: Container(
//           width: _size.width,
//           // margin: EdgeInsets.all(20),
//           margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10),
//           // decoration: Ui.getBoxDecoration(color: Colors.white),
//           child: Column(
//             children: [
//               Obx(() {
//               if (controller.notificationLoaded.isTrue) {
//                 String _startMonth =
//                     "${myFormat.format(controller.selectedDate.value)}";
//                 String monthName =
//                     "${myFormat1.format(controller.selectedDate.value)}";
//
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 5, bottom: 8, left: 20, right: 20),
//                         child: Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                               monthName,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: AppColors.primaryColor,
//                               ),
//                             ),
//                             Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.fromLTRB(
//                                     0, 0, 0, 0),
//                                 child: InkWell(
//                                   onTap: (){
//                                     controller.selectMonth(context);
//                                   },
//                                   child: Container(
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Text(
//                                           'Select Month'.tr,
//                                           style:
//                                           TextStyle(fontSize: 12),
//                                         ),
//                                         Icon(
//                                           Icons.arrow_drop_down,
//                                           color: Theme.of(context)
//                                               .primaryColor,
//                                           size: 15,
//                                         ),
//                                       ],
//                                     ),
//
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Container(
//                           width: Get.size.width,
//                           height: Get.size.height * 0.15,
//                           decoration: Ui.getBoxDecoration(
//                             color: Colors.white,
//                             radius: 10,
//                           ),
//                           child: Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment:
//                             CrossAxisAlignment.center,
//                             children: [
//                               Column(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Start Balance".tr,
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color:
//                                         AppColors.homeTextColor3),
//                                   ),
//                                   Text(
//                                     "৳ " +
//                                         controller
//                                             .accountStatementSummery
//                                             .value
//                                             .opening_balance
//                                             .toString(),
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                 width: 2,
//                                 height: 30,
//                                 color:
//                                 AppColors.SectionHighLightCardBg,
//                               ),
//
//                               Column(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "End Balance".tr,
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color:
//                                         AppColors.homeTextColor3),
//                                   ),
//                                   Text(
//                                     "৳ " +
//                                         controller
//                                             .accountStatementSummery
//                                             .value
//                                             .closing_balance
//                                             .toString(),
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Obx(() {
//                         if (controller.notificationLoaded.isTrue) {
//                           if (controller.accountStatementSummery.value
//                               .data!.length >
//                               0) {
//                             return SingleChildScrollView(
//                               child: Column(
//                                 children: List.generate(
//                                     controller.accountStatementSummery
//                                         .value.data!.length, (index) {
//                                   var name_color = controller
//                                       .accountStatementSummery
//                                       .value
//                                       .data![index]
//                                       .transaction_name_color!;
//
//                                   var amount_color = controller
//                                       .accountStatementSummery
//                                       .value
//                                       .data![index]
//                                       .amount_color!;
//                                   return InkWell(
//                                     onTap: (){
//                                       Get.toNamed(Routes.STATEMENTDETAILS, arguments: [controller
//                                           .accountStatementSummery
//                                           .value
//                                           .data![index].transaction_name]);
//                                     },
//                                     child: Padding(
//                                       padding:
//                                       const EdgeInsets.all(10.0),
//                                       child: Container(
//                                         width: Get.size.width,
//                                         decoration: Ui.getBoxDecoration(
//                                           color: Colors.white,
//                                           radius: 10,
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(
//                                               10.0),
//                                           child: Container(
//                                               width: _size.width,
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment
//                                                     .start,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Expanded(
//                                                         flex: 1,
//                                                         child:
//                                                         Container(
//                                                           height: _size
//                                                               .width *
//                                                               .15,
//                                                           width: _size
//                                                               .width *
//                                                               .15,
//                                                           decoration:
//                                                           BoxDecoration(
//                                                             // color: Colors
//                                                             //     .grey
//                                                             //     .shade100,
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 50),
//                                                           ),
//                                                           child:
//                                                           Padding(
//                                                             padding:
//                                                             const EdgeInsets.all(
//                                                                 8.0),
//                                                             child: Image
//                                                                 .network(
//                                                               controller
//                                                                   .accountStatementSummery
//                                                                   .value
//                                                                   .data![
//                                                               index]
//                                                                   .icon!,
//                                                               height:
//                                                               30,
//                                                               width: 30,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 4,
//                                                         child: Padding(
//                                                           padding: const EdgeInsets
//                                                               .only(
//                                                               left:
//                                                               10.0,
//                                                               right:
//                                                               10),
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                             children: [
//                                                               FittedBox(
//                                                                 fit: BoxFit
//                                                                     .fitWidth,
//                                                                 child:
//                                                                 Text(
//                                                                   controller
//                                                                       .accountStatementSummery
//                                                                       .value
//                                                                       .data![index]
//                                                                       .transaction_name!,
//                                                                   style: TextStyle(
//                                                                       fontSize: 14,
//                                                                       fontWeight: FontWeight.w600,
//                                                                       color: AppColors.primaryColor),
//                                                                 ),
//                                                               ),
//                                                               Text(
//                                                                 controller.accountStatementSummery.value.data![index].number_of_trx.toString() +
//                                                                     " Times",
//                                                                 style: TextStyle(
//                                                                     fontSize:
//                                                                     12),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Padding(
//                                                           padding: const EdgeInsets
//                                                               .only(
//                                                               left: 0.0,
//                                                               right: 0),
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .end,
//                                                             children: [
//                                                               FittedBox(
//                                                                 fit: BoxFit
//                                                                     .fitWidth,
//                                                                 child:
//                                                                 Center(
//                                                                   child:
//                                                                   Text(
//                                                                     "৳ " +
//                                                                         controller.accountStatementSummery.value.data![index].amount!,
//                                                                     style: TextStyle(
//                                                                         fontSize: 12,
//                                                                         fontWeight: FontWeight.w600,
//                                                                         color: Color(int.parse(amount_color))),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               // SizedBox(
//                                                               //     height:
//                                                               //         10),
//                                                               // Text(
//                                                               //   controller
//                                                               //       .accountStatement
//                                                               //       .value
//                                                               //       .data![index]
//                                                               //       .new_balance!,
//                                                               //   maxLines:
//                                                               //       3,
//                                                               //   style: TextStyle(
//                                                               //       fontSize: 12,
//                                                               //       color: AppColors.greenTextColor),
//                                                               // ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                   // Padding(
//                                                   //   padding: EdgeInsets.only(
//                                                   //     left: _size.width * .15,
//                                                   //   ),
//                                                   //   child: Text(
//                                                   //     controller.accountStatement.value.data![index]
//                                                   //         .transaction_time!,
//                                                   //     style: TextStyle(fontSize: 12),
//                                                   //   ),
//                                                   // ),
//                                                 ],
//                                               )),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                               ),
//                             );
//                           } else {
//                             return Container(
//                                 height: Get.size.width,
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'No Transaction found for you'
//                                           .tr,
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     GestureDetector(
//                                         onTap: () {
//                                           Get.offAndToNamed(
//                                               Routes.ROOT);
//                                         },
//                                         child: Text(
//                                           'Back To Home'.tr,
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: Color(0xFF652981),
//                                           ),
//                                         )),
//                                   ],
//                                 ));
//                           }
//                         } else {
//                           return Container(
//                             height: Get.size.width,
//                             child: Center(
//                               child: Ui.customLoader(),
//                             ),
//                           );
//                         }
//                       }),
//                     ],
//                   ),
//                 );
//               } else {
//                 return Container(
//                   height: Get.size.width,
//                   child: Center(
//                     child: Ui.customLoader(),
//                   ),
//                 );
//               }
//             })
//               // Container(),
//               // StatementTabBar(tabController: tabController!),
//               // Expanded(
//               //   child: Container(
//               //     child: TabBarView(
//               //       controller: tabController,
//               //       children: [
//               //         //General Notifications
//               //         SingleChildScrollView(
//               //           child: Column(
//               //             children: [
//               //               StatementWidget(),
//               //             ],
//               //           ),
//               //         ),
//               //
//               //         //Rechrage Notifications
//               //         // StatementSummeryWidget(),
//               //
//               //         // Obx(() {
//               //         //   if (controller.rechargeReportLoaded.isTrue) {
//               //         //     return SingleChildScrollView(
//               //         //       child: Column(
//               //         //         children: List.generate(
//               //         //             controller.rechargeReport.value.data!.length,
//               //         //             (index) {
//               //         //           return Padding(
//               //         //             padding: const EdgeInsets.all(8.0),
//               //         //             child: Card(
//               //         //               elevation: 5,
//               //         //               child: Container(
//               //         //                 height: _size.width * 0.22,
//               //         //                 width: _size.width,
//               //         //                 child: Padding(
//               //         //                   padding: const EdgeInsets.all(5.0),
//               //         //                   child: Row(
//               //         //                     mainAxisAlignment:
//               //         //                         MainAxisAlignment.spaceBetween,
//               //         //                     children: [
//               //         //                       Expanded(
//               //         //                         child: SingleChildScrollView(
//               //         //                           scrollDirection:
//               //         //                               Axis.horizontal,
//               //         //                           child: Row(
//               //         //                             children: [
//               //         //                               Logo(index),
//               //         //                               SizedBox(
//               //         //                                 width: 10,
//               //         //                               ),
//               //         //                               Column(
//               //         //                                 crossAxisAlignment:
//               //         //                                     CrossAxisAlignment
//               //         //                                         .start,
//               //         //                                 children: [
//               //         //                                   // Text(
//               //         //                                   //   'Recharge'.tr,
//               //         //                                   //   style: TextStyle(
//               //         //                                   //     fontSize: 16,
//               //         //                                   //   ),
//               //         //                                   // ),
//               //         //                                   SizedBox(
//               //         //                                     height: 25,
//               //         //                                   ),
//               //         //                                   Text(
//               //         //                                     controller
//               //         //                                         .rechargeReport
//               //         //                                         .value
//               //         //                                         .data![index]
//               //         //                                         .rechargeMobileNumber!,
//               //         //                                     style: TextStyle(
//               //         //                                         fontSize: 12,
//               //         //                                         fontWeight:
//               //         //                                             FontWeight
//               //         //                                                 .bold),
//               //         //                                   ),
//               //         //                                   SizedBox(
//               //         //                                     height: 5,
//               //         //                                   ),
//               //         //                                   Text(
//               //         //                                     controller
//               //         //                                         .rechargeReport
//               //         //                                         .value
//               //         //                                         .data![index]
//               //         //                                         .transactionId!,
//               //         //                                     style: TextStyle(
//               //         //                                       fontSize: 12,
//               //         //                                     ),
//               //         //                                   ),
//               //         //                                 ],
//               //         //                               ),
//               //         //                             ],
//               //         //                           ),
//               //         //                         ),
//               //         //                       ),
//               //         //                       Expanded(
//               //         //                         child: SingleChildScrollView(
//               //         //                           child: Column(
//               //         //                             crossAxisAlignment:
//               //         //                                 CrossAxisAlignment.end,
//               //         //                             children: [
//               //         //                               Text(
//               //         //                                 DateFormat.yMMMd().format(
//               //         //                                         DateTime.parse(controller
//               //         //                                             .rechargeReport
//               //         //                                             .value
//               //         //                                             .data![index]
//               //         //                                             .rechargeTime!)) +
//               //         //                                     ' ' +
//               //         //                                     DateFormat.jm().format(
//               //         //                                         DateTime.parse(controller
//               //         //                                             .rechargeReport
//               //         //                                             .value
//               //         //                                             .data![index]
//               //         //                                             .rechargeTime!)),
//               //         //                                 style: TextStyle(
//               //         //                                   fontSize: 12,
//               //         //                                 ),
//               //         //                               ),
//               //         //                               SizedBox(
//               //         //                                 height: 5,
//               //         //                               ),
//               //         //                               Text(
//               //         //                                 controller
//               //         //                                             .rechargeReport
//               //         //                                             .value
//               //         //                                             .data![index]
//               //         //                                             .status!
//               //         //                                             .toLowerCase() ==
//               //         //                                         'failed'
//               //         //                                     ? '- ৳ ${controller.rechargeReport.value.data![index].rechargeAmount!}'
//               //         //                                     : '৳ ${controller.rechargeReport.value.data![index].rechargeAmount!}',
//               //         //                                 style: TextStyle(
//               //         //                                   fontSize: 18,
//               //         //                                   color:
//               //         //                                       Color(0xFF652981),
//               //         //                                 ),
//               //         //                               ),
//               //         //                               Text(
//               //         //                                 '${controller.rechargeReport.value.data![index].status!}',
//               //         //                                 style: TextStyle(
//               //         //                                   fontSize: 18,
//               //         //                                   color: controller
//               //         //                                               .rechargeReport
//               //         //                                               .value
//               //         //                                               .data![
//               //         //                                                   index]
//               //         //                                               .status!
//               //         //                                               .toLowerCase() ==
//               //         //                                           'failed'
//               //         //                                       ? Colors.red
//               //         //                                       : controller
//               //         //                                                   .rechargeReport
//               //         //                                                   .value
//               //         //                                                   .data![
//               //         //                                                       index]
//               //         //                                                   .status!
//               //         //                                                   .toLowerCase() ==
//               //         //                                               'success'
//               //         //                                           ? Colors.green
//               //         //                                           : Colors.yellow,
//               //         //                                 ),
//               //         //                               ),
//               //         //                             ],
//               //         //                           ),
//               //         //                         ),
//               //         //                       ),
//               //         //                     ],
//               //         //                   ),
//               //         //                 ),
//               //         //               ),
//               //         //             ),
//               //         //           );
//               //         //         }),
//               //         //       ),
//               //         //     );
//               //         //   } else {
//               //         //     return Container(
//               //         //       height: Get.size.width,
//               //         //       child: Center(
//               //         //         child: Ui.customLoader(),
//               //         //       ),
//               //         //     );
//               //         //   }
//               //         // }),
//               //       ],
//               //     ),
//               //   ),
//               // )
//             ],
//           ),
//         ));
//   }
// }
