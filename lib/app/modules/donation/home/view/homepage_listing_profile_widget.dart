import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/Color.dart';


class HomePageListingProfileWidget extends StatelessWidget {
  const HomePageListingProfileWidget({
    super.key,
    required this.review,
    required this.title,
    required this.listingType,
    required this.guestNum,
    required this.bedNum,
    required this.fullDayPriceSetByUser,
    required this.listingAddress,

    this.isSvg = true,
    this.height = 12,
  });
  final List review;
  final String title;
  final String listingType;
  final String guestNum;
  final String bedNum;

  final String fullDayPriceSetByUser;
  final String listingAddress;
  final bool isSvg;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.7,
                  //height: MediaQuery.of(context).size.height * .05,
                  child: Text(
                    title,
                    maxLines: 3,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(
                      width: 2,
                    ),
                    // FutureBuilder(
                    //   future: ListingRep().getReviewRep(data.listingId),
                    //   builder: (context, snapshot) {
                    //     return snapshot.data == null ? Text("0.0")
                    //         :
                    //     Text(snapshot.data!.averageRating.toString(),
                    //         style: TextStyle(
                    //             fontWeight:
                    //                 FontWeight
                    //                     .bold,
                    //             fontSize:
                    //                 16));
                    //   }
                    // ),
                    review.isEmpty
                        ? const Text(
                            "0.0",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          )
                        : Text("1",
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              listingAddress,
              style: TextStyle(
                color: AppColors.textAlt,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listingType == "Rooms" ? "$guestNum Guests" : "$bedNum Bedrooms | $guestNum Guests",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textAlt,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "৳$fullDayPriceSetByUser ",
                        style: TextStyle(
                          color: AppColors.textColorBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(
                        text: "/night",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
