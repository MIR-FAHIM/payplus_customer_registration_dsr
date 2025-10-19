import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:latest_payplus_agent/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class NotificationWidget extends GetView<InboxController> {
  const NotificationWidget({super.key});

  bool _isRechargeTitle(String? title) {
    if (title == null) return false;
    return title.contains("Recharge Request from PayPos");
  }

  void _handleTap(notiData) {
    // If it has an image, go to detail
    final image = notiData.image ?? "";
    if (image.isNotEmpty) {
      Get.toNamed(Routes.NOTIDETAILS, arguments: [notiData]);
      return;
    }

    // If it’s a recharge request, open the PIN screen with extracted numbers
    if (_isRechargeTitle(notiData.title)) {
      controller.notiId.value = notiData.notiId ?? "";
      final nums = controller.extractNumbersFromString(notiData.message ?? "");
      if (nums.isNotEmpty && nums.length >= 3) {
        Get.toNamed(
          Routes.RECHARGEPINNOTIFICATION,
          arguments: [nums[0], nums[1], nums[2]],
        );
      } else {
        debugPrint("Recharge message didn’t contain expected numbers.");
      }
      return;
    }
    // Fallback: open details if available, else ignore
    Get.toNamed(Routes.NOTIDETAILS, arguments: [notiData]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      if (!controller.notificationLoaded.isTrue) {
        // Loading state
        return SizedBox(
          height: Get.size.height * 0.5,
          child: Center(child: Ui.customLoader()),
        );
      }

      final list = controller.notifications.value.data ?? [];
      if (list.isEmpty) {
        // Friendly empty state
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.notifications_none, size: 64, color: theme.disabledColor),
                const SizedBox(height: 12),
                Text(
                  'No notifications yet'.tr,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'When there’s something new, it’ll show up here.'.tr,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                ),
                const SizedBox(height: 16),
                TextButton(

                  onPressed: () { controller.getNotifications();},
                  child: Text('Refresh'.tr),
                ),
              ],
            ),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          await controller.getNotifications(); // implement if not present
        },
        child: AnimationLimiter(
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = list[index];

              final title = item.title ?? 'Untitled';
              final message = item.message ?? '';
              final dateStr = item.dateTime ?? '';
              final imageUrl = item.image ?? '';
              final isUnread = (item.activityStatus ?? 1) == 0; // 0 = unread as per your code
              final isRecharge = _isRechargeTitle(title);

              // Choose a semantic accent based on type
              final Color accent = isRecharge
                  ? Colors.redAccent
                  : AppColors.primaryColor ?? theme.colorScheme.primary;

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 320),
                child: SlideAnimation(
                  horizontalOffset: 56,
                  child: FadeInAnimation(
                    child: Dismissible(
                      key: ValueKey(item.notiId ?? '$index-$title'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.delete_outline, color: theme.colorScheme.error),
                      ),
                      confirmDismiss: (dir) async {
                        // Optional: add a confirm dialog/snackbar
                        // For now, don’t actually delete; return false or wire to your API.
                        return false;
                      },
                      child: InkWell(
                        onTap: () => _handleTap(item),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: Ui.getBoxDecoration(
                            color: theme.cardColor,
                            radius: 12,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Leading: image or icon
                              _LeadingThumb(
                                imageUrl: imageUrl,
                                accent: accent,
                                isUnread: isUnread,
                              ),
                              const SizedBox(width: 12),
                              // Content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title row with badge and time
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // Time (kept as string fallback)
                                        Text(
                                          dateStr,
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: theme.hintColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    // Badge if recharge
                                    if (isRecharge)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: accent.withOpacity(0.08),
                                          borderRadius: BorderRadius.circular(999),
                                          border: Border.all(color: accent.withOpacity(0.25)),
                                        ),
                                        child: Text(
                                          'Recharge'.tr,
                                          style: theme.textTheme.labelSmall?.copyWith(
                                            color: accent,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    if (isRecharge) const SizedBox(height: 6),
                                    // Message
                                    Text(
                                      message,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class _LeadingThumb extends StatelessWidget {
  final String imageUrl;
  final Color accent;
  final bool isUnread;

  const _LeadingThumb({
    required this.imageUrl,
    required this.accent,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget avatar;
    if (imageUrl.isNotEmpty) {
      avatar = ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 56,
          width: 72,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => _fallbackIcon(theme),
            errorWidget: (_, __, ___) => _fallbackIcon(theme),
          ),
        ),
      );
    } else {
      avatar = Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _fallbackIcon(theme),
      );
    }

    // Unread dot overlay
    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatar,
        if (isUnread)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(0.35),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _fallbackIcon(ThemeData theme) => Center(
    child: Icon(
      Icons.notifications,
      size: 24,
      color: isUnread ? accent : theme.iconTheme.color,
    ),
  );
}
