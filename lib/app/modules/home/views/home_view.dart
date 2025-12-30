import 'dart:io';
import 'dart:ui';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/modules/withdraw/controllers/withdraw_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latest_payplus_agent/app/modules/home/widgets/AmountWidget.dart';
import 'package:latest_payplus_agent/app/modules/home/widgets/home_option_widget.dart';
import 'package:latest_payplus_agent/app/modules/home/widgets/home_slider_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final _size = Get.size;

  @override
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(
       () {
        return PopScope(
          canPop: controller.exitApp.value,
          onPopInvoked: (b)  {
           showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Are you sure you want to exit?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          controller.exitApp.value = false;
                          Navigator.of(context).pop(false);
                        },
                        //return false when click on "NO"
                        child: Text('No'),
                      ),
                      ElevatedButton(

                        onPressed: () {
                          controller.exitApp.value = true;
                          Navigator.of(context).pop(true);
                        },
                        //return true when click on "Yes"
                        child: Text('Yes'),
                      ),
                    ],
                  );
                });
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: const Size(65, 65),
                child: AppBar(
                  backgroundColor: const Color(0xFF652981),
                  automaticallyImplyLeading: false,
                  centerTitle: false,
                  title: Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Row(
                      children: [
                        ProfileImage(),

                        SizedBox(
                          width: 10,
                        ),

                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Get.find<AuthService>()
                                    .currentUser
                                    .value
                                    .outletName ??
                                    '',
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                Get.find<AuthService>()
                                    .currentUser
                                    .value
                                    .mobileNumber ??
                                    '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              // controller.packageLoad.value == true
                              //     ? SizedBox(
                              //         height: 10,
                              //         width: 10,
                              //         child: CircularProgressIndicator())
                              //     : InkWell(
                              //         onTap: () {
                              //           Get.toNamed(Routes.PACKAGELIST);
                              //         },
                              //         child: Text(
                              //           controller.currentPackageModel.value.data!
                              //               .packageName,
                              //           style: const TextStyle(
                              //             fontSize: 12,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                            ],
                          );
                        }),
                        // Ui.offsetPopup()
                      ],
                    ),
                  ),
                  elevation: 0,
                  actions: [
                    Obx(() {
                      return Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          badges.Badge(
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: Colors.redAccent,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            badgeContent: Text(Get.find<InboxController>()
                                .newNotificationNum
                                .toString()),
                            child: IconButton(
                                onPressed: () {
                                  Get.lazyPut<RechargeController>(
                                        () => RechargeController(),
                                  );
                                  Get.find<InboxController>().removeNewMsgNum();
                                  Get.toNamed(Routes.Notification_View);
                                },
                                icon: const Icon(
                                  CupertinoIcons.bell,
                                  color: Colors.white70,
                                )),
                          )
                        ],
                      );
                    }),
                    IconButton(
                        onPressed: () {
                          controller.getAllDisablePermission();
                          Get.put(WithdrawController());
                          Scaffold.of(context).openEndDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white70,
                        )),
                  ],
                ),
              ),
              body: Obx(() {
                return RefreshIndicator(
                  color: const Color(0xFF652981),
                  onRefresh: () async {
                    controller.refreshHome();
                  },
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Get.find<AuthService>().currentUser.value.kyc_status == "none"
                          ? Container()
                          : Get.find<AuthService>().currentUser.value.kyc_status ==
                          "required"
                          ? Card(
                        color: Colors.red.withOpacity(.4),
                        child: ListTile(
                          title: Text(
                            "আপনার NID'র তথ্য দিয়ে রেজিস্ট্রেশন নিশ্চিত করুন",
                            style: TextStyle(fontSize: 12),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              Get.put(SignupController());
                              Get.find<SignupController>()
                                  .checkCameraPermission();
                            },
                            child: Container(
                              height: 30,
                              width: _size.width * .2,
                              decoration:
                              Ui.getBoxDecoration(radius: 5.0),
                              child: Center(
                                child: Text(
                                  "তথ্য দিন",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                          : Get.find<AuthService>()
                          .currentUser
                          .value
                          .kyc_status ==

                          "rejected"
                          ? Card(
                        color: Colors.red.withOpacity(.4),
                        child: ListTile(
                          title: Text(
                            "আপনার এনআইডি ও ছবির মিল না থাকায় রেজিষ্ট্রেশন সফল হয়নি। আগামী ৭২ ঘন্টার মধ্যে আমাদের প্রতিনিধি আপনার সাথে যোগাযোগ করবে। বিস্তারিতঃ ০৯৬১৩৮২৮৪৮২",
                            style: TextStyle(fontSize: 12),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.NEWNID);
                            },
                            child: Container(
                              height: 30,
                              width: _size.width * .2,
                              decoration:
                              Ui.getBoxDecoration(radius: 5.0),
                              child: Center(
                                child: Text(
                                  "তথ্য দিন",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                          : Container(),
                      AnimationConfiguration.staggeredList(
                        position: 0,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Container(
                              //height: 180,
                              width: _size.width,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 20, right: 20, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // controller.changeState();
                                          },
                                          child: Container(
                                            height: 145,
                                            width: 145,
                                            decoration: Ui.getBoxDecoration(
                                              color: const Color(0xFF652981),
                                              radius: 100,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Container(
                                                  height: 145,
                                                  width: 145,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                      color:
                                                      const Color(0xFF652981),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Center(
                                                            child: FittedBox(
                                                              fit: BoxFit.fitWidth,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  // const Image(
                                                                  //   height: 15,
                                                                  //   width: 15,
                                                                  //   image: AssetImage('assets/images/taka.png'),
                                                                  //   color: Colors.white,
                                                                  // ),
                                                                  Obx(() {
                                                                    return Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                          2.0,
                                                                          right:
                                                                          5),
                                                                      child:
                                                                      FittedBox(
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                        child: double.parse(controller.balance.value) >
                                                                            0.0
                                                                            ? Text(
                                                                          '$uniCodeTk ' +
                                                                              controller.balance.value.toString().replaceAll('tk', ''),
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.bold),
                                                                          maxLines:
                                                                          2,
                                                                          overflow:
                                                                          TextOverflow.ellipsis,
                                                                        )
                                                                            : Text(
                                                                          '$uniCodeTk ' +
                                                                              "0",
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.bold),
                                                                          maxLines:
                                                                          2,
                                                                          overflow:
                                                                          TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Balance'.tr,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .primarydeepLightColor,
                                                              fontSize: 12,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),

                                      ],
                                    ),
                                    //Right Side 3 Item
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        AmountWidget(
                                            image: 'assets/images/phone.png',
                                            amount:
                                            '${controller.agentList.value.length}',
                                            title: 'Registration'.tr,
                                            padding: "10"
                                          // colors: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        AmountWidget(
                                            image: 'assets/images/bill_payment.png',
                                            amount:
                                            '${controller.dashboardReport.value.billPayment}',
                                            colors: const Color(0xFF652981),
                                            title: 'Balance Transfer'.tr,
                                            padding: "10"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      BlockButtonWidget(
                        onPressed: () {


                          Get.toNamed(Routes.NEWSIGNUP,arguments: ['Agent']);


                        },
                        color: Color(0xFF652981),
                        text: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Register Agent".tr,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ).paddingSymmetric(vertical: 10, horizontal: 20),

                      BlockButtonWidget(
                        onPressed: () {


                          Get.toNamed(Routes.NEWSIGNUP,arguments: ['Merchant']);


                        },
                        color: Color(0xFF652981),
                        text: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Register Merchant".tr,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ).paddingSymmetric(vertical: 10, horizontal: 20),
                      controller.agentList.value.isEmpty ? Container() : Center(
                          child: Text("My Agent & Merchant list:", style: TextStyle(fontWeight: FontWeight.bold),)),
                      SizedBox(height: 5,),
                      controller.agentList.value.isEmpty ? Center(child: Text("No Registration Yet")) :
                      Container(
                        height: Get.height*.35,
                        child: ListView.builder(
                          itemCount: controller.agentList.value.length ,
                          itemBuilder: (context, index){
                            var data = controller.agentList.value[index];
                            return Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: data.remark == "Agent"
                                            ? Theme.of(context).primaryColor
                                            : data.remark == "Merchant"
                                            ? Colors.blue
                                            : Colors.grey, // fallback color
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(4), // optional: for slight rounding
                                      ),
                                      child: Text(
                                        data.remark!.substring(0, 1),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(data.outletName!),
                                    subtitle: InkWell(
                                        onTap: (){
                                          //   launch("tel://${data.mobileNo!}");
                                        },
                                        child: Text(data.mobileNo!)),
                                    trailing: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Shop Status: ${data.status}"),
                                        data.kyc == 0 ? Text("KYC Required", style: TextStyle(fontSize: 11),)
                                            : data.kyc == 1 ? Text("KYC Pending",style: TextStyle(fontSize: 11),)
                                            : data.kyc == 2 ? Text("KYC Verified",style: TextStyle(fontSize: 11),)
                                            : data.kyc == 3 ? Text("KYC Rejected",style: TextStyle(fontSize: 11),)
                                            :Text("") ,
                                        data.regWithoutPass == 1 ? Text("App is not activated Yet",  style: TextStyle(fontSize: 11, color: Colors.red),)
                                            : Text("App activated by user", style: TextStyle(fontSize: 11, color: Colors.green),),
                                      ],
                                    ),


                                  ),

                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // AnimationConfiguration.staggeredList(
                      //     position: 2,
                      //     duration: const Duration(milliseconds: 375),
                      //     child: SlideAnimation(
                      //         horizontalOffset: 50.0,
                      //         child: FadeInAnimation(
                      //           child: HomeSliderWidget(),
                      //         ))),

                      //banner
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      //   child: Container(
                      //     width: _size.width,
                      //     color: Color(0xFF652981),
                      //     child: Image(
                      //       image: AssetImage('assets/banner.jpeg'),
                      //       fit: BoxFit.contain,
                      //     ),
                      //   ),
                      // ),
                      // controller.AdBannerLoad.value == true
                      //     ? ImageSlideshow(
                      //         /// Width of the [ImageSlideshow].
                      //         width: double.infinity,
                      //
                      //         /// Height of the [ImageSlideshow].
                      //         height: 110,
                      //
                      //         /// The page to show when first creating the [ImageSlideshow].
                      //         initialPage: 0,
                      //
                      //         /// The color to paint the indicator.
                      //         indicatorColor: Colors.blue,
                      //
                      //         /// The color to paint behind th indicator.
                      //         indicatorBackgroundColor: Colors.grey,
                      //
                      //         /// The widgets to display in the [ImageSlideshow].
                      //         /// Add the sample image file into the images folder
                      //         children: List.generate(controller.AdBanner.length, (index) {
                      //           return Image.network(
                      //             controller.AdBanner[index].advertisementBanner!,
                      //             fit: BoxFit.contain,
                      //           );
                      //         }),
                      //         //     [
                      //         //   Image.asset(
                      //         //     'assets/banner1.jpg',
                      //         //     fit: BoxFit.cover,
                      //         //   ),
                      //         //   // Image.asset(
                      //         //   //   'images/sample_image_3.jpg',
                      //         //   //   fit: BoxFit.cover,
                      //         //   // ),
                      //         // ],
                      //
                      //         /// Called whenever the page in the center of the viewport changes.
                      //         onPageChanged: (value) {
                      //           print('Page changed: $value');
                      //         },
                      //
                      //         /// Auto scroll interval.
                      //         /// Do not auto scroll with null or 0.
                      //         autoPlayInterval: 8000,
                      //
                      //         /// Loops back to first slide.
                      //         isLoop: true,
                      //       )
                      //     : Container(),
                      const SizedBox(
                        height: 20,
                      ),

                      //Card Option Widget
                      // AnimationConfiguration.staggeredList(
                      //     position: 2,
                      //     duration: const Duration(milliseconds: 375),
                      //     child: SlideAnimation(
                      //       horizontalOffset: 50.0,
                      //       child: FadeInAnimation(child: HomeTopOptionWidget()),
                      //     )),

                      // SizedBox(
                      //   height: 120,
                      // ),
                    ],
                  ),
                );
              })),
        );
      }
    );
  }
}

class ProfileImage extends StatefulWidget {
  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  PickedFile? imageFile = null;

  String? _imagepath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LoadImage();
  }

  // void _openCamera(BuildContext context) async {
  //   final pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 600,
  //   );

  //   // Ui.customLoaderDialog();

  //   setState(() {
  //     imageFile = pickedFile!;
  //   });

  //   if (pickedFile != null) {
  //     SharedPreferences saveimage = await SharedPreferences.getInstance();
  //     saveimage.setString("imagepath", imageFile!.path);
  //     print("save");
  //   }
  // }

  Future<void> PickImage(String type) async {
    // await DeleteIamge();
    var pickedFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    // Ui.customLoaderDialog();
    setState(() {
      imageFile = pickedFile! as PickedFile?;
    });
    SaveImage();
    await LoadImage();
  }

  Future<void> SaveImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString("imagepath", imageFile!.path);
  }

  Future<void> LoadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveimage.getString("imagepath");
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showPopup(context);
      },
      child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: _imagepath != null
              ? ClipOval(
                  child: Image.file(
                  File(_imagepath!),
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ))
              : (imageFile == null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://thumbs.dreamstime.com/b/default-avatar-profile-flat-icon-vector-contact-symbol-illustration-184752213.jpg',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Image(
                            image: AssetImage('assets/images/user2.png'),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Image(
                            image: AssetImage('assets/images/user2.png'),
                          ),
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Image.file(
                      File(_imagepath!),
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ))),
    );
  }

  showPopup(context) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            //title: Text('Select '),
            content: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text('Photo Library'.tr),
                      onTap: () {
                        PickImage('photo');
                        Get.back();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Camera'.tr),
                    onTap: () {
                      PickImage('camera');
                      Get.back();
                    },
                  ),
                ],
              ),
            )
            // actions: <Widget>[

            // ],
            );
      },
    );
  }
}
