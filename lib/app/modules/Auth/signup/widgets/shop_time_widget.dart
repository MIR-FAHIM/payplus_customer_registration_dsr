import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';


class ShopTimeWidget extends GetWidget<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF652981).withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(0, 2)),
              ],
              //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Opening time of shop".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: Color(0xFF652981),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 2, bottom: 2),
                        child: Center(
                          child: Text(
                            controller.openingHour.value,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF652981)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, top: 2, bottom: 2),
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF652981)),
                      ),
                    ),
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: Color(0xFF652981),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 2, bottom: 2),
                        child: Center(
                          child: Text(
                            controller.openingMin.value,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF652981)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Hour".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                Slider(
                    value: double.parse(controller.openingHour.value),
                    min: 0.0,
                    max: 12.0,
                    divisions: 12,
                    activeColor: Color(0xFF652981),
                    inactiveColor: Color.fromARGB(255, 235, 235, 235),
                    onChanged: (double newValue) {
                      controller.openingHour.value =
                          newValue.toInt().toString().length < 2
                              ? '0${newValue.toInt().toString()}'
                              : newValue.toInt().toString();
                    },
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()} dollars';
                    }),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Minute".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                Slider(
                    value: double.parse(controller.openingMin.value),
                    min: 0.0,
                    max: 59.0,
                    divisions: 11,
                    activeColor: Color(0xFF652981),
                    inactiveColor: Color.fromARGB(255, 235, 235, 235),
                    onChanged: (double newValue) {
                      controller.openingMin.value = newValue.toInt().toString();
                    },
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()} dollars';
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.openingAMPM.value = 'AM';
                        controller.userData.value.openingTime =
                            controller.openingHour.value +
                                ':' +
                                controller.openingMin.value +
                                'AM';
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          color: controller.openingAMPM.value == 'AM'
                              ? Color(0xFF652981)
                              : Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 2, bottom: 2),
                          child: Text(
                            'AM',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: controller.openingAMPM.value == 'AM'
                                    ? Colors.white
                                    : Color(0xFF652981)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.openingAMPM.value = 'PM';
                        controller.userData.value.openingTime =
                            controller.openingHour.value +
                                ':' +
                                controller.openingMin.value +
                                'PM';
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          color: controller.openingAMPM.value == 'PM'
                              ? Color(0xFF652981)
                              : Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 2, bottom: 2),
                          child: Text(
                            'PM',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: controller.openingAMPM.value == 'PM'
                                    ? Colors.white
                                    : Color(0xFF652981)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF652981).withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(0, 2)),
              ],
              //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Closing time of shop".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: Color(0xFF652981),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 2, bottom: 2),
                        child: Center(
                          child: Text(
                            controller.closingHour.value,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF652981)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, top: 2, bottom: 2),
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF652981)),
                      ),
                    ),
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: Color(0xFF652981),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 2, bottom: 2),
                        child: Center(
                          child: Text(
                            controller.closingMin.value,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF652981)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Hour".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                Slider(
                  value: double.parse(controller.closingHour.value),
                  min: 00.0,
                  max: 12.0,
                  divisions: 12,
                  activeColor: Color(0xFF652981),
                  inactiveColor: Color.fromARGB(255, 235, 235, 235),

                  onChanged: (double newValue) {
                    controller.closingHour.value =
                        newValue.toInt().toString().length < 2
                            ? '0${newValue.toInt().toString()}'
                            : newValue.toInt().toString();
                  },
                  // semanticFormatterCallback: (double newValue) {
                  //   return '${newValue.round()} dollars';
                  // }
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Minute".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                Slider(
                  value: double.parse(controller.closingMin.value),
                  min: 00.0,
                  max: 59.0,
                  divisions: 11,
                  activeColor: Color(0xFF652981),
                  inactiveColor: Color.fromARGB(255, 235, 235, 235),

                  onChanged: (double newValue) {
                    controller.closingMin.value = newValue.toInt().toString();
                  },
                  // semanticFormatterCallback: (double newValue) {
                  //   return '${newValue.round()} dollars';
                  // }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.closingAMPM.value = 'AM';
                        controller.userData.value.closingTime =
                            controller.closingHour.value +
                                ':' +
                                controller.closingMin.value +
                                'AM';
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          color: controller.closingAMPM.value == 'AM'
                              ? Color(0xFF652981)
                              : Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 2, bottom: 2),
                          child: Text(
                            'AM',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: controller.closingAMPM.value == 'AM'
                                    ? Colors.white
                                    : Color(0xFF652981)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.closingAMPM.value = 'PM';
                        controller.userData.value.closingTime =
                            controller.closingHour.value +
                                ':' +
                                controller.closingMin.value +
                                'PM';
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          color: controller.closingAMPM.value == 'PM'
                              ? Color(0xFF652981)
                              : Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 2, bottom: 2),
                          child: Text(
                            'PM',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: controller.closingAMPM.value == 'PM'
                                    ? Colors.white
                                    : Color(0xFF652981)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
