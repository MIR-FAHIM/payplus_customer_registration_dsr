import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';

class ProgressSignUp extends GetWidget<SignupController> {
  String? step1;
  String? step2;
  String? step3;
  int? indexP;
  ProgressSignUp({this.step1, this.step2, this.step3, this.indexP});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 17,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: indexP == 0  ? AppColors.primarydeepLightColor : AppColors.primaryColor,
                child: indexP == 0  ? Text("01") : Icon(Icons.check, color: Colors.white,),
              ),
            ),
            Text(step1!)
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 17,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: indexP == 1 ? AppColors.primarydeepLightColor : indexP! > 1 ?AppColors.primaryColor : Colors.grey.shade300,
                child: indexP == 1 ? Text("02") :indexP! > 1 ? Icon(Icons.check,color: Colors.white,):Text("02") ,
              ),
            ),
            Text(step2!)
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 17,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: indexP == 2 ? AppColors.primarydeepLightColor : Colors.grey.shade300,
                child: Text("03"),
              ),
            ),
            Text(step3!)
          ],
        ),
      ],
    );
  }
}
