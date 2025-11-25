
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/eTicket/bus_ticket/controllers/bus_ticket_controller.dart';
import 'package:latest_payplus_agent/app/modules/eTicket/bus_ticket/views/book_ticket_form.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';

import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ReadyTicketView extends GetView<BusTicketController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffac68cd),
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: const Text('Bus Ticket Is Ready'),
        centerTitle: true,
      ),
      body: Obx(
              () {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Card(

                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start ,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Pickup Point", style: TextStyle(fontSize: 12),),
                                      Text("Jessore, Newmarket", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end ,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Drop Point", style: TextStyle(fontSize: 12),),
                                      Text(controller.nameController.value.text,  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start ,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Date", style: TextStyle(fontSize: 12),),
                                      Text("30, May, 2023", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end ,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Time", style: TextStyle(fontSize: 12),),
                                      Text("5.00 PM",  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start ,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Date", style: TextStyle(fontSize: 12),),
                                      Text("30, May, 2023", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end ,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Time", style: TextStyle(fontSize: 12),),
                                      Text("5.00 PM",  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start ,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Date", style: TextStyle(fontSize: 12),),
                                      Text("30, May, 2023", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end ,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Time", style: TextStyle(fontSize: 12),),
                                      Text("5.00 PM",  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start ,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Total Seats",style: TextStyle(fontSize: 12),),
                                      Text("2",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end ,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Mobile No",style: TextStyle(fontSize: 12),),
                                      Text("01782084390", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,


                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start ,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Bus",style: TextStyle(fontSize: 12),),
                                      Text("S.Alam",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end ,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Seats",style: TextStyle(fontSize: 12),),
                                      Text("E1, E2", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              height: Get.height *.15,
                              color: Colors.grey.shade200,
                              child:  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,

                                ),

                              ),

                            ),
                          )

                        ],
                      ),
                    ),
                  ),


















                ],
              ),
            );
          }
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Get.to(BookTicketFormView());
        },
        child: Container(
          height: size.width * .15,
          decoration: Ui.getBoxDecoration(radius: 0),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Save Ticket',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              Icon(Icons.arrow_forward, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}




// seat layout

// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child:  Text('A1'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('A2'),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('A3'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('A4'),
// ),
// ],
// )
// ],
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('B1'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('B2'),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('B3'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('B4'),
// ),
// ],
// )
// ],
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('C1'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('C2'),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('C3'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('C4'),
// ),
// ],
// )
// ],
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('D1'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('D2'),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('D3'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('D4'),
// ),
// ],
// )
// ],
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('E1'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('E2'),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('E3'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('E4'),
// ),
// ],
// )
// ],
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('F1'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('F2'),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('F3'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('F4'),
// ),
// ],
// )
// ],
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('G1'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('G2'),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('G3'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('G4'),
// ),
// ],
// )
// ],
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('H1'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('H2'),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('H3'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('H4'),
// ),
// ],
// )
// ],
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('I1'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('I2'),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('I3'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('I4'),
// ),
// ],
// )
// ],
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('J1'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('J2'),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('J3'),
// ),
// const SizedBox(width: 3),
// Container(
// height: size.width * .1,
// width: size.width * .15,
// decoration: Ui.getBoxDecoration(radius: 5, color: Colors.white, border: Border.all(color: Colors.grey)),
// alignment: Alignment.center,
// child: const Text('J4'),
// ),
// ],
// )
// ],
// ),
// const SizedBox(height: 10),
//
// ],
// ),