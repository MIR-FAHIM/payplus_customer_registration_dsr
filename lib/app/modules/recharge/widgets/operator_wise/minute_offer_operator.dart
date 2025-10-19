import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class MinuteOfferOperator extends GetWidget<RechargeController> {
  MinuteOfferOperator({super.key});

  final _size = Get.size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      final offers = controller.specialMinuteOfferList;

      if (offers.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi_tethering_error_rounded,
                    size: 42, color: theme.hintColor),
                const SizedBox(height: 10),
                Text('No Offer Found',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.hintColor)),
              ],
            ),
          ),
        );
      }

      return Container(
        height: Get.height*.8,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          itemCount: offers.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, index) {
            final data = offers[index];

            // convenience
            final priceText = '৳${data.offerPrice}';
            final validity = data.offerValidityHours; // e.g., "7 Days" / "48 Hours"
            final cb = data.retailerCommission; // cashback Tk

            return _OfferCard(
              size: _size,
              title: data.offerDescriptionBangla,
              priceText: priceText,
              validityText: validity,
              cashbackText: cb != null && cb.toString().isNotEmpty
                  ? '${cb}Tk ${'CashBack'.tr}'
                  : null,
              onTap: () {
                // Reset cashback labels in controller (keeping your logic)
                controller.cashBackAmount.value = '';
                controller.cashBackPackageName.value = '';

                // Use the *specialDataOfferList* item, not internetPackage
                controller.amountController.value.text = data.offerPrice.toString();

                // If you want to carry the selected offer object:
                // controller.amountOffer.value = <map to PackageModel if needed>

                controller.getCommission();
              },
            );
          },
        ),
      );
    });
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required Size size,
    required this.title,
    required this.priceText,
    required this.validityText,
    this.cashbackText,
    required this.onTap,
  }) : _size = size;

  final Size _size;
  final String title;
  final String priceText;
  final String validityText;
  final String? cashbackText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.cardColor,
      elevation: 0,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: Ui.getBoxDecoration(
            color: Colors.white,
            radius: 12,
          ),
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Stack(
            children: [
              // Main row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // small leading glyph

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title
                        SizedBox(
                          width:Get.width*.65,
                          child: Text(
                            title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.homeTextColor1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // meta row
                        Wrap(
                          spacing: 16,
                          runSpacing: 6,
                          children: [
                            _Meta(
                              icon: Icons.punch_clock_rounded,
                              label: validityText,
                            ),
                            if (cashbackText != null && cashbackText!.isNotEmpty)
                              _Meta(
                                icon: Icons.local_offer_outlined,
                                label: cashbackText!,
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // CTA row
                        Row(
                          children: [
                            _PriceChip(text: priceText),
                            const Spacer(),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                              ),
                              onPressed: onTap,
                              icon: const Icon(Icons.flash_on, size: 18),
                              label: Text(
                                'Recharge',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Cashback ribbon (top-right)
              if (cashbackText != null && cashbackText!.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE08A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'CashBack',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceChip extends StatelessWidget {
  const _PriceChip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: theme.primaryColor.withOpacity(.9)),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.homeTextColor1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
