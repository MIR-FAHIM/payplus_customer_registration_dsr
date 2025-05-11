import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hotline_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HotlineView extends GetView<HotlineController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(65, 65),
          child: AppBar(
            backgroundColor: const Color(0xFF652981),
            centerTitle: true,
            title: Text(
              'Hotline'.tr,
              style: const TextStyle(fontSize: 16),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Get.back(),
            ),
            elevation: 0,
          ),
        ),
        body: Obx(() {
          if (controller.hotlineLoaded.isTrue) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/hotline/top.png'),
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    'Welcome to Pay Plus App'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF652981),
                    ),
                    maxLines: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Contact us for any information or assistance.'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF652981).withOpacity(0.2), blurRadius: 2, offset: const Offset(0, 2)),
                      ],
                      //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Call".tr,
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Get.size.width * .7,
                              child: Text(controller.hotline.value.phone!),
                            ),
                            GestureDetector(
                              onTap: () {
                                launch("tel://${controller.hotline.value.phone!}");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Image(
                                    image: AssetImage('assets/hotline/call.png'),
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF652981).withOpacity(0.2), blurRadius: 2, offset: const Offset(0, 2)),
                      ],
                      //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Email Address".tr,
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Get.size.width * .7,
                              child: Text(controller.hotline.value.email!),
                            ),
                            GestureDetector(
                              onTap: () {
                                launch('mailto:${controller.hotline.value.email!}?subject=&body=');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Image(
                                    image: AssetImage('assets/hotline/mail.png'),
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      print(controller.hotline.value.link!);
                      Uri url = Uri.parse(controller.hotline.value.link!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        print("can not load this url");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: const Color(0xFF652981).withOpacity(0.2), blurRadius: 2, offset: const Offset(0, 2)),
                        ],
                        //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Social Network".tr,
                            style: Get.textTheme.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Get.size.width * .7,
                                child: Text(controller.hotline.value.link!),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  print(controller.hotline.value.link!);
                                  String url = controller.hotline.value.link!;
                                  if (await canLaunch(url)) {
                                    await launch(url, forceSafariVC: false);
                                  } else {
                                    print("can not load this url");
                                  }
                                  // print("object");
                                  // if (!await launch(
                                  //     controller.hotline.value.link!))
                                  //   throw 'Could not launch ${controller.hotline.value.link!}';
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image(
                                      image: AssetImage('assets/hotline/fb.png'),
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Color(0xFF652981).withOpacity(0.2), blurRadius: 2, offset: Offset(0, 2)),
                      ],
                      //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Address".tr,
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Get.size.width * .7,
                              child: Text("DevoTech Technology Park, Plot#11, Road#113/A, Gulshan-2, Dhaka, Bangladesh."),
                            ),
                            GestureDetector(
                              onTap: () async {
                                launchURL();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.location_on, color: Get.theme.primaryColor,)
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
  launchURL() async {

    const String homeLat = "23.788598";
    const String homeLng = "90.418556";

    final String googleMapslocationUrl = "https://www.google.com/maps/search/?api=1&query=${homeLat},${homeLng}";



    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }
}
