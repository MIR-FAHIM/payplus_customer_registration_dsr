import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latest_payplus_agent/app/Page/sale_payment_system.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class AddNewContact extends StatefulWidget {
  @override
  State<AddNewContact> createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  XFile? imageFile = null;
  final _size = Get.size;

  String? _imagepath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LoadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          title: Text('Add New Contact'.tr),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.bell,
                  color: Colors.white70,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: _size.width,
                    height: _size.height * 0.3,
                    color: AppColors.SecondbackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     // _openCamera(context);
                        //   },
                        //   child: Container(
                        //     height: 130,
                        //     width: 130,
                        //     decoration: BoxDecoration(
                        //       color: AppColors.primaryColor,
                        //       borderRadius: BorderRadius.circular(99),
                        //       border: Border.all(
                        //           color: Color.fromARGB(255, 192, 192, 192),
                        //           width: 5),
                        //     ),
                        //     child: (imageFile == null)
                        //         ? Icon(Icons.camera_alt,
                        //             color: Colors.white, size: 35)
                        //         : ClipOval(
                        //             child: Image.file(
                        //             File(imageFile!.path),
                        //             width: 130,
                        //             height: 130,
                        //             fit: BoxFit.cover,
                        //           )),
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            // _openCamera(context);
                          },
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(
                                  color: Color.fromARGB(255, 192, 192, 192),
                                  width: 5),
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
                                    ? Icon(Icons.camera_alt,
                                        color: Colors.white, size: 35)
                                    : ClipOval(
                                        child: Image.file(
                                        File(imageFile!.path),
                                        width: 130,
                                        height: 130,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ),

                        Row(
                          children: [
                            BlockButtonWidget(
                              onPressed: () {
                                PickImage();
                              },
                              color: Color(0xFF652981),
                              text: Text(
                                "pick".tr,
                                style: Get.textTheme.bodyMedium!
                                    .merge(TextStyle(color: Colors.white)),
                              ),
                            ).paddingSymmetric(vertical: 10, horizontal: 5),
                            BlockButtonWidget(
                              onPressed: () {
                                SaveImage(imageFile!.path);
                              },
                              color: Color(0xFF652981),
                              text: Text(
                                "save".tr,
                                style: Get.textTheme.bodyMedium!
                                    .merge(TextStyle(color: Colors.white)),
                              ),
                            ).paddingSymmetric(vertical: 10, horizontal: 5),
                            BlockButtonWidget(
                              onPressed: () {
                                DeleteIamge();
                              },
                              color: Color(0xFF652981),
                              text: Text(
                                "delete".tr,
                                style: Get.textTheme.bodyMedium!
                                    .merge(TextStyle(color: Colors.white)),
                              ),
                            ).paddingSymmetric(vertical: 10, horizontal: 5),
                          ],
                        ),
                        // :
                        //  Container(
                        //     height: 140,
                        //     width: 140,
                        //     decoration: BoxDecoration(
                        //       // color: AppColors.primaryColor,
                        //       borderRadius: BorderRadius.circular(99),
                        //       border: Border.all(
                        //           color:
                        //               Color.fromARGB(255, 192, 192, 192),
                        //           width: 5),
                        //     ),
                        //     child: ClipOval(
                        //         child: Image.file(
                        //       File(imageFile!.path),
                        //       width: 130,
                        //       height: 130,
                        //       fit: BoxFit.cover,
                        //     )),
                        //   ),
                      ],
                    ),
                  ),
                  // Card(
                  //   child: (imageFile == null)
                  //       ? Text("Choose Image")
                  //       : Image.file(File(imageFile!.path)),
                  // ),
                  TextFieldWidget(
                    labelText: "Mobile No".tr,
                    hintText: "Enter Mobile No.".tr,

                    // onSaved: (input) =>
                    // controller.currentUser.value.email = input,
                    // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                    iconData: CupertinoIcons.device_phone_portrait,
                  ),
                  TextFieldWidget(
                    labelText: "Name".tr,
                    hintText: "Enter Account Number".tr,
                    // onSaved: (input) =>
                    // controller.currentUser.value.email = input,
                    // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                    iconData: null,
                    imageData: 'assets/images/user.png',
                  ),
                  TextFieldWidget(
                    labelText: "Address".tr,
                    hintText: "Enter Address".tr,
                    // onSaved: (input) =>
                    // controller.currentUser.value.email = input,
                    // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                    iconData: CupertinoIcons.location_solid,
                    // imageData: 'assets/collection/2.png',
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 43, 42, 43).withOpacity(0.2),
                      blurRadius: 2,
                      offset: Offset(0, -2)),
                ],
                //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () {
                    Get.to(SalePaymentSystem());
                  },
                  child: Container(
                    width: _size.width,
                    height: _size.width * .1,
                    decoration: Ui.getBoxDecoration(
                        color: Color(0xFF652981), radius: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Add'.tr,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    // Ui.customLoaderDialog();
    setState(() {
      imageFile = pickedFile!;
    });

    // Navigator.pop(context);
  }

  Future<void> PickImage() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    // Ui.customLoaderDialog();
    setState(() {
      imageFile = pickedFile!;
    });
  }

  Future<void> SaveImage(path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString("imagepath", path);
  }

  Future<void> LoadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveimage.getString("imagepath");
    });
  }

  Future<void> DeleteIamge() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    final success = await saveimage.remove('imagepath');
  }
}
