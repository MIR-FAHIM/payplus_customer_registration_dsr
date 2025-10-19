import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback onTap;

  const OfferButton({
    super.key,
    required this.label,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: loading ? null : onTap,
        child: Container(
          height: 28,
          width: Get.width*.4,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: loading
                  ? const SizedBox(
                key: ValueKey('loading'),
                height: 14, width: 14,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : Text(
                label,
                key: const ValueKey('label'),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}