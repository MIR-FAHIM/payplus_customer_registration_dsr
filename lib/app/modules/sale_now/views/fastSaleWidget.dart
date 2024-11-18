import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/Page/all_item_list.dart';
import 'package:latest_payplus_agent/app/Page/sale_payment_system.dart';
import 'package:latest_payplus_agent/app/modules/contacts_list/contact_list_view.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/modules/sale_now/controllers/sale_now_controller.dart';
import 'package:latest_payplus_agent/app/modules/sale_now/views/scan_product_view.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/cupertino.dart';

class FastSaleWidget extends GetWidget<SaleNowController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 18, right: 15),
                child: InkWell(
                  onTap: () => Get.to(AllItemListView()),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Total Item'.tr + "${controller.cartList.length}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: List.generate(controller.cartList.length, (index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),

                      /// Image item
                      child: CachedNetworkImage(
                        height: 60,
                        width: 60,
                        imageUrl: controller.cartList[index].image ?? '',
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
                            image: AssetImage('assets/Logo.png'),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Image(
                            image: AssetImage('assets/Logo.png'),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 5.0, right: 5.0),
                        child: Column(
                          /// Text Information Item
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 180.0,
                                  child: Text(
                                    controller.cartList[index].name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Sans",
                                        color: Colors.black87,
                                        fontSize: 14.0),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      controller.cartList.removeWhere(
                                          (element) =>
                                              element.id ==
                                              controller.cartList[index].id);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 25,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Stock ${controller.cartList[index].stockAlert} pcs',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 0.0),
                                  child: Container(
                                    width: 140.0,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        /// Decrease of value item
                                        InkWell(
                                          onTap: () {
                                            // setState(() {
                                            //   value =
                                            //       value - 1;
                                            //   value =
                                            //       (value > 0
                                            //           ? value
                                            //           : 0);
                                            //   pay = items[position]
                                            //           .price *
                                            //       value;
                                            //   total = pay +
                                            //       delivery;
                                            // });
                                          },
                                          child: Container(
                                            height: 20.0,
                                            width: 20.0,
                                            decoration: BoxDecoration(
                                                color: Colors.black12
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5.0))),
                                            child: const Center(
                                                child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18.0),
                                            )),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18.0),
                                          child: Text(
                                            "${controller.cartList[index].quantity}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: "Sofia",
                                                fontSize: 14.0),
                                          ),
                                        ),

                                        /// Increasing value of item
                                        InkWell(
                                          onTap: () {
                                            // setState(() {
                                            //   value =
                                            //       value + 1;
                                            //   pay = items[position]
                                            //           .price *
                                            //       value *
                                            //       2;
                                            //   total = pay +
                                            //       delivery;
                                            // });
                                          },
                                          child: Container(
                                            height: 20.0,
                                            width: 20.0,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFF652981),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            child: const Center(
                                                child: Text(
                                              "+",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18.0),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 5.0, right: 15),
                                  child: Text(
                                    "$uniCodeTk"
                                    ' ${controller.cartList[index].sellingPrice}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Sofia",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              width: _size.width,
              // height: _size.height * 0.5,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: InkWell(
                  //     onTap: () {
                  //       Get.to(FastSaleViewScreen());
                  //     },
                  //     child: Container(
                  //       width: _size.width,
                  //       height: _size.width * .12,
                  //       decoration: Ui.getBoxDecoration(
                  //           color: Color(0xFF652981), radius: 10),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Center(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Image.asset(
                  //                 "assets/images/shopping-cart.png",
                  //                 width: 30,
                  //                 height: 30,
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 5),
                  //                 child: Text(
                  //                   'মোট ৳',
                  //                   style: Get.textTheme.headline6!
                  //                       .merge(TextStyle(color: Colors.white)),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        if (controller.cartList.isNotEmpty) {
                          Get.to(SalePaymentSystem());
                        }
                      },
                      child: Container(
                        width: _size.width,
                        height: _size.width * .12,
                        decoration: Ui.getBoxDecoration(
                            color: Color(0xFF652981), radius: 10),
                        child: Stack(
                          children: [
                            Container(
                              width: Get.size.width,
                              height: 60,
                              decoration: Ui.getBoxDecoration(
                                  color: Color(0xFF652981), radius: 10),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'মোট $uniCodeTk ${controller.calculateTotalPrice()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: AppColors.homeCardBg,
                                    ),
                                  ),
                                )),
                            Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.homeCardBg,
                                      size: 25,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 14, left: 20, right: 20),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF652981).withOpacity(0.4),
                            blurRadius: 2,
                            offset: Offset(1, 2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Customer Name".tr + ' *',
                          style: Get.textTheme.bodyText1,
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          // controller: controller.nameController,
                          keyboardType: TextInputType.text,
                          style: Get.textTheme.bodyText2,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          // validator: (input) {
                          //   if (controller.nameController.text.isEmpty) {
                          //     return 'This field is required'.tr;
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          cursorColor: Color(0xFF652981),
                          decoration: Ui.getInputDecoration(
                            hintText: "Enter Customer Name".tr,
                            iconData: null,
                            imageData: 'assets/collection/6.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 14, left: 20, right: 20),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF652981).withOpacity(0.4),
                            blurRadius: 2,
                            offset: Offset(1, 2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Mobile".tr + ' *',
                          style: Get.textTheme.bodyText1,
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          // controller: controller.nameController,
                          keyboardType: TextInputType.text,
                          style: Get.textTheme.bodyText2,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          // validator: (input) {
                          //   if (controller.nameController.text.isEmpty) {
                          //     return 'This field is required'.tr;
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          cursorColor: Color(0xFF652981),
                          decoration: Ui.getInputDecoration(
                            hintText: "Enter Mobile".tr,
                            iconData: null,
                            imageData: 'assets/collection/2.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: InkWell(
            //     onTap: () {
            //       Get.to(() => ScanProductView());
            //     },
            //     child: Container(
            //       width: _size.width,
            //       height: _size.width * .12,
            //       decoration: Ui.getBoxDecoration(color: const Color(0xFF652981), radius: 10),
            //       child: Padding(
            //         padding: const EdgeInsets.all(10.0),
            //         child: Center(
            //           child: Padding(
            //             padding: const EdgeInsets.only(left: 5),
            //             child: Text(
            //               'Scan Product'.tr,
            //               style: Get.textTheme.headline6!.merge(const TextStyle(color: Colors.white, fontSize: 15)),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            TextFieldWidget(
              keyboardType: TextInputType.text,

              initialValue: '',
              labelText: "Product Name".tr,
              hintText: "Enter product Name".tr,
              onChanged: (value) {
                controller.productName.value = value;
              },

              // onSaved: (input) =>
              // controller.currentUser.value.email = input,
              // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,

              imageData: 'assets/product.png',
            ),
            TextFieldWidget(
              keyboardType: TextInputType.number,

              initialValue: '',
              labelText: "Enter Price".tr,
              hintText: "Enter product price".tr,
              onChanged: (value) {
                controller.productPrice.value = value;
              },

              // onSaved: (input) =>
              // controller.currentUser.value.email = input,
              // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,

              // iconData: CupertinoIcons.location_solid,
              imageData: 'assets/tk.png',
            ),
            CheckboxListTile(
              title: Text(
                'Do You Want to Add this customer?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              value: controller.addThisCutomer.value,
              activeColor: Colors.green,
              checkColor: Colors.white,
              onChanged: (bool? value) {
                controller.addThisCutomer.value = value!;
              },
              secondary: Icon(
                controller.addThisCutomer.value
                    ? Icons.check_circle
                    : Icons.error,
                color:
                    controller.addThisCutomer.value ? Colors.green : Colors.red,
              ),
              controlAffinity: ListTileControlAffinity
                  .leading, // Aligns the checkbox to the left
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => ScanProductView());
                    },
                    child: Container(
                      width: 120,
                      height: _size.width * .10,
                      decoration: Ui.getBoxDecoration(
                          color: const Color(0xFF652981), radius: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Barcode Scan'.tr,
                              style: Get.textTheme.headline6!.merge(
                                  const TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      // ProductData product = controller.productItems[index];
                      // product.quantity = 1;
                      // controller.cartList
                      //     .removeWhere((element) => element.id == product.id);
                      // controller.cartList.add(product);

                      if (controller.productName.value.isEmpty &&
                          controller.productPrice.value.isEmpty) {
                        Get.showSnackbar(Ui.ErrorSnackBar(
                            message: "Please Check Product Name and Price",
                            title: 'Error'.tr));
                      } else {}
                    },
                    child: Container(
                      width: 120,
                      height: _size.width * .10,
                      decoration: Ui.getBoxDecoration(
                          color: const Color(0xFF652981), radius: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Add'.tr,
                              style: Get.textTheme.headline6!.merge(
                                  TextStyle(color: Colors.white, fontSize: 13)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
