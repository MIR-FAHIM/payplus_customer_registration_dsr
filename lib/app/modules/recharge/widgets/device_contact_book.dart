import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ContactsPanel extends GetView<RechargeController> {

  const ContactsPanel({super.key, });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: Container(
        width: Get.width,
        decoration: Ui.getBoxDecoration(
          color: Get.theme.cardColor,
          radius: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(() {
            final state = controller.contactsState.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Contacts',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Get.theme.disabledColor.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),

                // Search field
                TextField(
                  controller: controller.searchController.value,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.searchController.value.text.isNotEmpty
                        ? IconButton(
                      tooltip: 'Clear',
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        controller.searchController.value.clear();
                        controller.setSearchText('');
                      },
                    )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),

                // Content body with states
                SizedBox(
                  height: MediaQuery.of(context).size.height * .7,
                  child: RefreshIndicator(
                    onRefresh: controller.refreshContacts,
                    child: Builder(
                      builder: (_) {
                        switch (state) {
                          case ContactsLoadState.loading:
                            return const Center(
                              child: SizedBox(
                                height: 28,
                                width: 28,
                                child: CircularProgressIndicator(strokeWidth: 2.5),
                              ),
                            );

                          case ContactsLoadState.error:
                            return ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                const SizedBox(height: 40),
                                _StateMessage(
                                  icon: Icons.error_outline,
                                  title: 'Couldn’t load contacts',
                                  subtitle: controller.contactsError.value.isEmpty
                                      ? 'Please check permission and try again.'
                                      : controller.contactsError.value,
                                  actionText: 'Retry',
                                  onAction: controller.loadContactsWithRetry,
                                ),
                              ],
                            );

                          case ContactsLoadState.empty:
                            return ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: const [
                                SizedBox(height: 40),
                                _StateMessage(
                                  icon: Icons.contacts_outlined,
                                  title: 'No contacts found',
                                  subtitle: 'Pull down to refresh or add some contacts.',
                                ),
                              ],
                            );

                          case ContactsLoadState.loaded:
                          case ContactsLoadState.idle:
                          default:
                            final items = controller.filteredContacts;
                            if (items.isEmpty) {
                              // Search returned nothing
                              return ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: const [
                                  SizedBox(height: 40),
                                  _StateMessage(
                                    icon: Icons.search_off,
                                    title: 'No matches',
                                    subtitle: 'Try a different name or number.',
                                  ),
                                ],
                              );
                            }

                            return ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: items.length,
                              separatorBuilder: (_, __) => const Divider(height: 0),
                              itemBuilder: (_, index) {
                                final data = items[index];

                                final hasPhone = data.phones.isNotEmpty;
                                final rawNumber = hasPhone ? (data.phones.first.number ?? '') : '';
                                final normalized = controller.normalizeBdNumber(
                                  hasPhone ? (data.phones.first.normalizedNumber ?? rawNumber) : rawNumber,
                                );

                                return ListTile(
                                  onTap: () {
                                    // Fill the number safely
                                    controller.operatorWiseOfferLoad.value = false;
                                    controller.rechargeNumberController.value.text = normalized;
                                    controller.contactListClicked.value = false;
                                    controller.contactLoad.value = false;

                                    // Detect operator and proceed
                                    controller.detectOperatorFromNumber(normalized);
                                    if (normalized.length == 11 && controller.simOperator.value.isNotEmpty) {
                                      Get.focusScope?.unfocus();
                                      controller.rechargeNumber.value = normalized;
                                      controller.getOfferList(controller.simOperator.value);
                                      controller.number_type.value = 'Prepaid';
                                    }
                                  },
                                  leading: CircleAvatar(
                                    child: Text(
                                      _initialsOf(data.displayName),
                                      style: const TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  title: Text(
                                    data.displayName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    hasPhone ? normalized : 'No Number',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: hasPhone
                                      ? IconButton(
                                    tooltip: 'Use',
                                    icon: const Icon(Icons.arrow_outward_rounded),
                                    onPressed: () {
                                      controller.rechargeNumberController.value.text = normalized;
                                      controller.detectOperatorFromNumber(normalized);
                                    },
                                  )
                                      : null,
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  String _initialsOf(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.characters.take(2).toString().toUpperCase();
    return (parts.first.characters.first + parts.last.characters.first).toUpperCase();
  }
}

class _StateMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onAction;

  const _StateMessage({
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Icon(icon, size: 44, color: theme.hintColor),
          const SizedBox(height: 8),
          Text(title, style: theme.textTheme.titleMedium),
          if (subtitle?.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            ),
          ],
          if (actionText != null && onAction != null) ...[
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onAction, child: Text(actionText!)),
          ],
        ],
      ),
    );
  }
}
