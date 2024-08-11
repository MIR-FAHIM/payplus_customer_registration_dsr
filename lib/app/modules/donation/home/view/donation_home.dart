import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/modules/donation/home/controller/donation_home_controller.dart';
import 'package:latest_payplus_agent/app/modules/donation/home/view/homepage_listing_profile_widget.dart';
import 'package:latest_payplus_agent/app/modules/donation/home/view/my_drawer.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIzMDA5MSIsImV4cCI6MTc0ODc2NjQzMX0.38ZnQO4hi50hFp_tQTSBrRaaeR4Ttk9TboCLAeaq6Ew
class DonationHomeView extends GetView<DonationHomeController> {
  const DonationHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donation"),
      ),
      endDrawer: MyDrawer(),
      // appBar: AppBar(
      //   backgroundColor: AppColors.jaygaAppBackGroundWhite,
      //   elevation: 0,
      //   title: homeController.profileData.value.userData != null
      //       ? Text(
      //           "Hello, ${homeController.profileData.value.userData!.first.name.split(" ").first}",
      //           style: const TextStyle(color: AppColors.mainBlack, fontSize: 16),
      //         )
      //       : const Text("Welcome!",
      //           style: TextStyle(color: AppColors.mainBlack, fontSize: 16)),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Get.toNamed(Routes.NOTIFICATIONLIST);
      //       },
      //       icon: Image.asset(
      //         'assets/drive/bell.png',
      //         height: Get.height * .12,
      //         width: Get.width * .06,
      //       ),
      //     ),
      //     Builder(
      //       builder: (context) => IconButton(
      //         onPressed: () {
      //           Scaffold.of(context).openEndDrawer();
      //         },
      //         icon: const Icon(
      //           Icons.person,
      //           color: AppColors.mainBlack,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      backgroundColor: AppColors.backgroundColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 10,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // new
          scrollDirection: Axis.vertical,
          itemCount: 5,

          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      controller.getDonationProjectList();
                    },
                    child: HomePageListingProfileWidget(
                      review: ["1", "2"],
                      title: "listingTitle",
                      listingType: "listingType",
                      guestNum: "1",
                      bedNum: "1",
                      fullDayPriceSetByUser: "1",
                      listingAddress: "listingAddress!",
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
