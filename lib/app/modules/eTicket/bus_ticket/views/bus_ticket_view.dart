// import 'dart:ui';
//
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:latest_payplus_agent/app/modules/eTicket/bus_ticket/views/bus_ticket_search_result_view.dart';
// import 'package:latest_payplus_agent/common/Color.dart';
// import 'package:latest_payplus_agent/common/custom_data.dart';
// import 'package:latest_payplus_agent/common/ui.dart';
//
// import '../controllers/bus_ticket_controller.dart';
//
// class BusTicketView extends GetView<BusTicketController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Get.theme.primaryColor,
//         leading: IconButton(
//             onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
//         title: const Text('Bus Ticket'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Container(
//             //   height: size.width * .3,
//             //   width: size.width,
//             //   padding: const EdgeInsets.only(left: 10, right: 10),
//             //   decoration: Ui.getBoxDecoration(color: const Color(0xffac68cd).withOpacity(.1)),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     children: [
//             //       const Text(
//             //         'Get Up to 50%\nDiscount at All \nBus Ticket!',
//             //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             //       ),
//             //       Container(
//             //         height: size.width * .15,
//             //         width: size.width * .15,
//             //         decoration: Ui.getBoxDecoration(radius: 100, color: Colors.white),
//             //         child: const Icon(Icons.arrow_forward),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             Center(
//               child: Text(
//                 'Search and Buy Bus Tickets',
//                 style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor),
//               ),
//             ),
//             // const SizedBox(height: 10),
//             // const Text(
//             //   'Where would you like to go?',
//             //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             // ),
//             const SizedBox(height: 10),
//             Container(
//               width: size.width,
//               padding: const EdgeInsets.only(
//                   left: 20, right: 20, top: 10, bottom: 10),
//               decoration: Ui.getBoxDecoration(color: Colors.white),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           CircleAvatar(
//                             radius: 8,
//                             backgroundColor: AppColors.primaryColor.withOpacity(.7),
//                             child: CircleAvatar(
//                                 radius: 2, backgroundColor: Colors.white),
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                   height: 70,
//                                   width: 15,
//                                   child: Image.asset("assets/icons/up.png",)
//                               ),
//                               Container(
//                                   height: 70,
//                                   width: 15,
//                                   child:  RotatedBox(
//                                     quarterTurns: 2,
//                                     child: Image.asset("assets/icons/up.png",)
//                                   )
//                               ),
//
//
//                             ],
//                           ),
//                           CircleAvatar(
//                             radius: 8,
//                             backgroundColor: AppColors.primaryColor.withOpacity(.7),
//                             child: CircleAvatar(
//
//                                 radius: 2, backgroundColor: Colors.white),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: 10),
//                       Obx(() {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text('From'),
//                             const SizedBox(height: 5),
//                             controller.loadFrom.value == false
//                                 ? CircularProgressIndicator(
//                                     strokeWidth: 1,
//                                   )
//                                 : Container(
//                                     width: size.width * .6,
//                                     height: size.width * .1,
//                                     color: Colors.white,
//                                     child: DropdownSearch<String>(
//
//                                       // mode: Mode.MENU,
//                                       // dropdownSearchDecoration:
//                                       //     Ui.getInputDecoration(
//                                       //   hintText: '',
//                                       // ),
//                                       // showSearchBox: true,
//                                      // showSelectedItems: true,
//                                       items: controller
//                                           .fromLocationList.value.data!
//                                           .map((item) => item.stationName!)
//                                           .toList(),
//                                       onChanged: (input) {
//                                         for (var item in controller
//                                             .fromLocationList.value.data!) {
//                                           if (item.stationName == input) {
//                                             controller.fromStation.value =
//                                                 input!;
//                                             // controller.userData.value.districts = item.id!.toString();
//                                           }
//                                         }
//                                       },
//                                       // selectedItem: "Pickup Point ".tr,
//                                     ),
//                                   ),
//                             const SizedBox(height: 10),
//                             Container(
//                               width: size.width * .58,
//                               height: 1,
//                               color: Colors.grey,
//                             ),
//                             const SizedBox(height: 5),
//                             const Text('To'),
//                             const SizedBox(height: 5),
//                             Obx(() {
//                               return controller.loadFrom.value == false
//                                   ? CircularProgressIndicator(
//                                       strokeWidth: 1,
//                                     )
//                                   : Container(
//                                       width: size.width * .6,
//                                       height: size.width * .1,
//                                       color: Colors.white,
//                                       child: DropdownSearch<String>(
//                                         // mode: Mode.MENU,
//                                         // dropdownSearchDecoration:
//                                         //     Ui.getInputDecoration(
//                                         //   hintText: '',
//                                         // ),
//                                         // showSearchBox: true,
//                                         // showSelectedItems: true,
//                                         items: controller
//                                             .fromLocationList.value.data!
//                                             .map((item) => item.stationName!)
//                                             .toList(),
//                                         onChanged: (input) {
//                                           for (var item in controller
//                                               .fromLocationList.value.data!) {
//                                             if (item.stationName == input) {
//                                               controller.toStation.value =
//                                                   input!;
//                                               // controller.userData.value.districts = item.id!.toString();
//                                             }
//                                           }
//                                         },
//                                         // selectedItem: "Pickup Point ".tr,
//                                       ),
//                                     );
//                             }),
//                           ],
//                         );
//                       }),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             GestureDetector(
//               onTap: () {
//                 controller.chooseDate();
//               },
//               child: Container(
//                 height: size.width * .3,
//                 width: size.width,
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 decoration: Ui.getBoxDecoration(color: Colors.white),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(Icons.calendar_today_sharp,
//                               color: Color(0xffac68cd)),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Journey Date"),
//
//                               ],
//                             ),
//                           ),
//
//                           Spacer(),
//                           Icon(Icons.arrow_forward_ios_outlined,
//                               color: AppColors.primaryColor,
//                           size: 14,),
//
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 30,
//                           ),
//                           Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Obx(() => Text(
//                                   DateFormat.yMMMMd('en_US')
//                                       .format(controller.journeyDate.value)
//                                       .toString(),
//                                   style: TextStyle(
//                                       fontSize: 15, color: AppColors.primaryColor),
//                                 )),
//                                 Obx(() => Text(
//                                   DateFormat('EEEE')
//                                       .format(controller.journeyDate.value)
//                                       .toString(),
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                               ],
//                             ),
//                           ),
//
//
//                         ],
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Obx(() {
//               return GestureDetector(
//                 onTap: () {
//                   if (controller.fromStation.value == "") {
//                     Get.showSnackbar(Ui.ErrorSnackBar(
//                         message: "Please Add Pickup Point", title: 'Error'.tr));
//                   }
//                   if (controller.toStation.value == "") {
//                     Get.showSnackbar(Ui.ErrorSnackBar(
//                         message: "Please Add Drop Point", title: 'Error'.tr));
//                   } else {
//                     controller.getAllCoachList(DateTime.now(),
//                         "5ffbf0485a79fb15bab64c66", "5ffbf0485a79fb15bab64c87");
//                   }
//                 },
//                 child: Container(
//                     height: size.width * .12,
//                     width: size.width,
//                     decoration: Ui.getBoxDecoration(radius: 5),
//                     child: controller.searchTicket.value == true
//                         ? Container(
//                             height: 10,
//                             width: 10,
//                             child: Center(child: CircularProgressIndicator()))
//                         : Center(
//                             child: Text(
//                             "Search",
//                             style: TextStyle(color: Colors.white),
//                           ))),
//               );
//             }),
//             Obx(() {
//               print("hlw bro ${controller.searchTicket.value}");
//               return controller.searchTicket.value == false
//                   ? BusTicketSearchResultView()
//                   : Container();
//             })
//
//             // TextFieldWidget(
//             //   hintText: 'Passenger name',
//             //   keyboardType: TextInputType.text,
//             //   radius: 8,
//             //   onChanged: (input) {},
//             //   onSaved: (input) {},
//             // ),
//             // const SizedBox(height: 10),
//             // TextFieldWidget(
//             //   hintText: 'Total passenger',
//             //   keyboardType: TextInputType.number,
//             //   radius: 8,
//             //   onChanged: (input) {},
//             //   onSaved: (input) {},
//             // ),
//             // const SizedBox(height: 10),
//             // TextFieldWidget(
//             //   hintText: 'Phone number',
//             //   keyboardType: TextInputType.number,
//             //   radius: 8,
//             //   onChanged: (input) {},
//             //   onSaved: (input) {},
//             // ),
//           ],
//         ),
//       ),
//       // bottomNavigationBar: GestureDetector(
//       //   onTap: () => Get.to(BusTicketSearchResultView()),
//       //   child: Container(
//       //     height: size.width * .15,
//       //     decoration: Ui.getBoxDecoration(radius: 0),
//       //     alignment: Alignment.center,
//       //     child: const Text(
//       //       'Search',
//       //       style: TextStyle(color: Colors.white, fontSize: 15),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
