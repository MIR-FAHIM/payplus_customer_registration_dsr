import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/Color.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    super.key,
    this.image,
    this.amount,
    this.colors,
    this.title,
    this.padding,
    this.onTap,
    this.width,
    this.backgroundColor,
  });

  final String? image;
  final String? amount;
  final Color? colors;
  final String? title;
  final dynamic padding;
  final VoidCallback? onTap;
  final double? width;
  final Color? backgroundColor;

  double get _verticalGap {
    if (padding == null) return 6;

    if (padding is num) {
      return (padding as num).toDouble();
    }

    return double.tryParse(padding.toString()) ?? 6;
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = colors ?? AppColors.primaryColor;
    final String safeTitle = title?.toString() ?? '';
    final String safeAmount = amount?.toString() ?? '0';

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: width ?? Get.width * 0.44,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: accentColor.withOpacity(0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.10),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.10),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: image == null || image.toString().trim().isEmpty
                    ? Icon(
                  Icons.account_balance_wallet_outlined,
                  color: accentColor,
                  size: 24,
                )
                    : Image.asset(
                  image!,
                  height: 24,
                  width: 24,
                  color: accentColor,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(width: _verticalGap + 4),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    safeTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: AppColors.homeTextColor3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          safeAmount,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            color: accentColor,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                      ),

                      if (onTap != null)
                        Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: accentColor.withOpacity(0.10),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: accentColor,
                            size: 12,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget({
    super.key,
    this.color,
    this.text,
    this.onPressed,
    this.radius = 14,
    this.width,
    this.height = 50,
    this.isLoading = false,
    this.icon,
    this.borderColor,
    this.textColor,
    this.padding,
  });

  final Color? color;
  final Widget? text;
  final double radius;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final bool isLoading;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = color ?? AppColors.primaryColor;
    final bool enabled = onPressed != null && !isLoading;

    return SizedBox(
      width: width ?? Get.width,
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: buttonColor,
          disabledBackgroundColor: Get.theme.focusColor.withOpacity(0.45),
          foregroundColor: textColor ?? Colors.white,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderColor == null ? 0 : 1,
            ),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: isLoading
              ? const SizedBox(
            key: ValueKey('loader'),
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: Colors.white,
            ),
          )
              : Row(
            key: const ValueKey('content'),
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 20,
                  color: textColor ?? Colors.white,
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: DefaultTextStyle(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                  child: text ?? const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}