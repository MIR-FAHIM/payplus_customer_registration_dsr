import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/operator_model.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';

class MobileNumberCard extends GetView<RechargeController> {

  const MobileNumberCard( {super.key});
  Future showOperatorLogo(context) async {
    return showModalBottomSheet(
        elevation: 50.0,
        //barrierColor: Colors.white54,
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        context: context,
        builder: (builder) {
          return Container(
            padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
            //  height: _size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Operator'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancel'.tr,
                        style: const TextStyle(
                          color: Color(0xFF652981),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Choose the current operator of this number'.tr,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                Expanded(
                  child: Container(
                    child: GridView.count(
                        scrollDirection: Axis.vertical,
                        primary: true,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 1.3,
                        children: List.generate(operatorLogos.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              controller.simOperatorLogo.value =
                              operatorLogos[index].logo!;
                              controller.simOperator.value =
                                  operatorLogos[index].id!.toString();
                              controller
                                  .getOfferList(controller.simOperator.value);
                              Get.back();
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.asset(operatorLogos[index].logo!),
                            ),
                          );
                        })),
                  ),
                ),
              ],
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: SizedBox(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Obx(() {
              final textCtrl = controller.rechargeNumberController.value;
              final numberText = textCtrl.text;

              // derive operator safely
              final has3 = numberText.length >= 3;
              final prefix = has3 ? numberText.substring(0, 3) : '';
              // controller should set these when text changes, but we re-derive UI bits too
              final operatorLogo = controller.simOperatorLogo.value;

              // Offer (if any) from your helper
              final offer = controller.offerForPrefix(numberText);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mobile Number'.tr,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Input field with actions
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.dividerColor.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Contact book button
                        IconButton(
                          tooltip: 'Pick from contacts'.tr,
                          onPressed: controller.contactLoad.value
                              ? null
                              : () {
                            if (controller.box.value.hasData('contactbook')) {
                              controller.getStoredData();
                            } else {
                              controller.getPhoneContact();
                            }
                          },
                          icon: controller.contactLoad.value
                              ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : Image.asset(
                            'assets/icons/phnbk.png',
                            height: 22,
                            width: 22,
                          ),
                        ),

                        // The text field
                        Expanded(
                          child: TextFormField(
                            controller: textCtrl,
                            keyboardType: TextInputType.phone,
                            inputFormatters:  [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            style: const TextStyle(fontSize: 18, color: Colors.black),
                            cursorColor: const Color(0xFF652981),
                            decoration: const InputDecoration(
                              hintText: '01xxxxxxxxx',
                              hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                              border: InputBorder.none,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            onTap: () => controller.keyboardText.value = 'phone',
                            onChanged: (input) {
                              controller.rechargeNumber.value = input;

                              // update operator logo on-the-fly (safe)
                              if (input.length >= 3) {
                                for (var item in operators) {
                                  if (input.startsWith(item.name!)) {
                                    controller.simOperatorLogo.value = item.logo ?? '';
                                    controller.simOperator.value = '${item.id ?? ''}';
                                    break;
                                  }
                                }
                              }

                              // auto-submit logic when 11 digits
                              if (input.length == 11) {
                                Get.focusScope?.unfocus();
                                controller.rechargeNumber.value = input;
                                controller.getOfferList(controller.simOperator.value);
                                controller.number_type.value = 'Prepaid';
                              }
                            },
                            validator: (v) =>
                            (v ?? '').length == 11 ? null : 'Please provide valid phone number',
                          ),
                        ),

                        // Clear button
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 150),
                          child: numberText.isNotEmpty
                              ? IconButton(
                            key: const ValueKey('clear'),
                            tooltip: 'Clear'.tr,
                            onPressed: () {
                              textCtrl.clear();
                              controller.operatorWiseOfferLoad.value = false;
                              controller.simOperatorLogo.value = '';
                              controller.simOperator.value = '';
                            },
                            icon: const Icon(Icons.close_rounded),
                          )
                              : const SizedBox.shrink(key: ValueKey('noclear')),
                        ),

                        // Operator pill (tap to change)
                        AnimatedOpacity(
                          opacity: operatorLogo.isNotEmpty ? 1 : 0,
                          duration: const Duration(milliseconds: 180),
                          child: operatorLogo.isNotEmpty
                              ? Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: GestureDetector(
                              onTap: () => showOperatorLogo(context),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    padding: const EdgeInsets.all(6),
                                    child: Image.asset(
                                      operatorLogo,
                                      height: 28,
                                      width: 28,
                                    ),
                                  ),
                                  const Positioned(
                                    right: 0,
                                    top: 0,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Color(0xFF652981),
                                      child: Icon(Icons.edit, size: 10, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                              : const SizedBox(width: 6),
                        ),
                      ],
                    ),
                  ),

                  // Helper / validation line
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 4),
                    child: Text(
                      numberText.isEmpty
                          ? 'Enter an 11-digit Bangladeshi mobile number.'.tr
                          : numberText.length < 3
                          ? 'Keep typing to detect operator…'.tr
                          : (numberText.length < 11
                          ? '${11 - numberText.length} digits remaining'.tr
                          : 'Looks good ✔'.tr),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: numberText.length == 11
                            ? Colors.green
                            : theme.hintColor,
                      ),
                    ),
                  ),

                  // Offer button (conditional)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: (numberText.isNotEmpty && offer != null)
                        ? Padding(
                      key: const ValueKey('offer'),
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: _OfferButton(
                          label:controller.operatorWiseOfferLoad.value == false? offer.label : 'Cancel'.tr,
                          loading: controller.loading.value == true,
                          onTap:controller.operatorWiseOfferLoad.value == false ? offer.onTap : (){controller.operatorWiseOfferLoad.value = false;},
                        ),
                      ),
                    )
                        : const SizedBox.shrink(key: ValueKey('nooffer')),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// Small, reusable pill button with a loading swap
class _OfferButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback onTap;
  const _OfferButton({
    required this.label,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: loading
                ? const SizedBox(
              key: ValueKey('spinner'),
              height: 16,
              width: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : Text(
              label,
              key: const ValueKey('label'),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
