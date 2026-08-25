import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/modules/withdraw/controllers/withdraw_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const Color _primary = Color(0xFF652981);
  static const Color _dark = Color(0xFF21112C);
  static const Color _softBg = Color(0xFFF7F3FA);
  static const Color _border = Color(0xFFE8DFF0);
  static const Color _yellow = Color(0xFFFFD84D);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _showExitDialog(context);
      },
      child: Obx(
       () {
          return Scaffold(
            backgroundColor: _softBg,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(76),
              child: _HomeAppBar(controller: controller),
            ),
            body: SafeArea(
              child: RefreshIndicator(
                color: _primary,
                onRefresh: () async {
                  controller.refreshHome();
                  await Future.delayed(const Duration(milliseconds: 450));
                },
                child:
                   ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [


                      AnimationConfiguration.staggeredList(
                        position: 0,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 24,
                          child: FadeInAnimation(
                            child: _BalanceOverviewCard(controller: controller),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),
                      controller.profileInfoModel.value.data == null ? Container():
                      _RegisterActionSection(kyc: controller.profileInfoModel.value.data!.kyc_status,),

                      const SizedBox(height: 14),

                      _AgentMerchantSection(controller: controller),
                    ],
                  ),

              ),
            ),
          );
        }
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Text(
          'Exit App?',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: _dark,
          ),
        ),
        content: const Text(
          'Are you sure you want to exit?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'No',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black54,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              SystemNavigator.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: const Text(
              'Yes',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar({
    required this.controller,
  });

  final HomeController controller;

  static const Color _primary = Color(0xFF652981);
  static const Color _yellow = Color(0xFFFFD84D);

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthService>();

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: _primary,
      elevation: 0,
      titleSpacing: 14,
      title: Row(
        children: [
          const ProfileImage(),

          const SizedBox(width: 10),

          Expanded(
            child: Obx(() {
              final user = auth.currentUser.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.outletName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    user.mobileNumber ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.78),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
      actions: [
        Obx(() {
          final count = _readNotificationCount();

          return badges.Badge(
            showBadge: count != '0',
            position: badges.BadgePosition.topEnd(top: 4, end: 4),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.redAccent,
            ),
            badgeContent: Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w900,
              ),
            ),
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
                color: Colors.white,
              ),
            ),
          );
        }),

        // Builder(
        //   builder: (scaffoldContext) {
        //     return IconButton(
        //       onPressed: () {
        //         controller.getAllDisablePermission();
        //         Get.put(WithdrawController());
        //
        //         try {
        //           Scaffold.of(scaffoldContext).openEndDrawer();
        //         } catch (_) {
        //           Scaffold.of(scaffoldContext).openDrawer();
        //         }
        //       },
        //       icon: const Icon(
        //         Icons.menu_rounded,
        //         color: Colors.white,
        //       ),
        //     );
        //   },
        // ),

        const SizedBox(width: 4),
      ],
    );
  }

  String _readNotificationCount() {
    try {
      final dynamic value = Get.find<InboxController>().newNotificationNum;
      final dynamic readValue = value.value;

      return readValue.toString();
    } catch (_) {
      try {
        return Get.find<InboxController>().newNotificationNum.toString();
      } catch (_) {
        return '0';
      }
    }
  }
}

class _KycNoticeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthService>();
    final status = auth.currentUser.value.kyc_status ?? 'none';

    if (status == 'none') return const SizedBox.shrink();

    if (status == 'required') {
      return _NoticeCard(
        color: Colors.orange,
        icon: Icons.verified_user_outlined,
        title: "KYC Required",
        message: "আপনার NID'র তথ্য দিয়ে রেজিস্ট্রেশন নিশ্চিত করুন",
        buttonText: "তথ্য দিন",
        onTap: () {
          Get.put(SignupController());
          Get.find<SignupController>().checkCameraPermission();
        },
      );
    }

    if (status == 'rejected') {
      return _NoticeCard(
        color: Colors.redAccent,
        icon: Icons.error_outline_rounded,
        title: "KYC Rejected",
        message:
        "আপনার এনআইডি ও ছবির মিল না থাকায় রেজিষ্ট্রেশন সফল হয়নি। আগামী ৭২ ঘন্টার মধ্যে আমাদের প্রতিনিধি আপনার সাথে যোগাযোগ করবে। বিস্তারিতঃ ০৯৬১৩৮২৮৪৮২",
        buttonText: "তথ্য দিন",
        onTap: () {
          Get.toNamed(Routes.NEWNID);
        },
      );
    }

    return const SizedBox.shrink();
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onTap,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.20),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.tr,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceOverviewCard extends StatelessWidget {
  const _BalanceOverviewCard({
    required this.controller,
  });

  final HomeController controller;

  static const Color _primary = Color(0xFF652981);
  static const Color _dark = Color(0xFF21112C);
  static const Color _yellow = Color(0xFFFFD84D);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF652981),
            Color(0xFF8C3CB2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _primary.withOpacity(0.22),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  final balance = _formatBalance(controller.balance.value);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Balance'.tr,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.78),
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        balance,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _yellow.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Balance'.tr,
                          style: const TextStyle(
                            color: _yellow,
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),

              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.28),
                    width: 1.2,
                  ),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: _yellow,
                  size: 36,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Obx(() {
                  return _MiniStatCard(
                    icon: Icons.person_add_alt_1_rounded,
                    title: 'Registration'.tr,
                    value: '${controller.agentList.value.length}',
                  );
                }),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Obx(() {
                  return _MiniStatCard(
                    icon: Icons.groups_2_outlined,
                    title: 'Active'.tr,

                    value: '${controller.agentList.value.where((e)=>e.regWithoutPass == 0).toList().length}',
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatBalance(String raw) {
    final cleaned = raw
        .replaceAll('tk', '')
        .replaceAll('Tk', '')
        .replaceAll('TK', '')
        .trim();

    final amount = double.tryParse(
      cleaned.replaceAll(RegExp(r'[^0-9.]'), ''),
    ) ??
        0;

    if (amount <= 0) return '$uniCodeTk 0';

    return '$uniCodeTk ${amount.toStringAsFixed(amount % 1 == 0 ? 0 : 2)}';
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  static const Color _primary = Color(0xFF652981);
  static const Color _yellow = Color(0xFFFFD84D);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 11),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.13),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.16),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: _yellow,
              size: 21,
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.72),
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterActionSection extends StatelessWidget {
  const _RegisterActionSection({
    required this.kyc,
  });

  final String kyc;

  static const Color _primary = Color(0xFF652981);
  static const Color _dark = Color(0xFF21112C);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            title: 'Quick Registration',
            subtitle: 'Register new Agent or Merchant from here',
            icon: Icons.app_registration_rounded,
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child:

                _ActionButton(
                  title: 'Register Agent'.tr,
                  icon: Icons.person_add_alt_1_rounded,
                  onTap: () {
                    if(kyc== 'required'){
                      Get.showSnackbar(Ui.ErrorSnackBar(
                          message:
                          "You are not approved for KYC yet",
                          title: 'Error'.tr));
                    }else{
                      Get.toNamed(
                        Routes.Agent_REGISTER,
                        arguments: ['Agent'],
                      );
                    }

                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionButton(
                  title: 'Register Merchant'.tr,
                  icon: Icons.storefront_rounded,
                  onTap: () {

                    if(kyc== 'required'){
                      Get.showSnackbar(Ui.ErrorSnackBar(
                          message:
                          "You are not approved for KYC yet",
                          title: 'Error'.tr));
                    }else{
                      Get.toNamed(
                        Routes.MERCHANT_REGISTER,
                        arguments: ['Merchant'],
                      );
                    }

                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  static const Color _primary = Color(0xFF652981);
  static const Color _yellow = Color(0xFFFFD84D);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: 78,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _primary.withOpacity(0.07),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _primary.withOpacity(0.12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: _primary, size: 25),
            const SizedBox(height: 7),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _primary,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AgentMerchantSection extends StatelessWidget {
  const _AgentMerchantSection({
    required this.controller,
  });

  final HomeController controller;

  static const Color _primary = Color(0xFF652981);
  static const Color _dark = Color(0xFF21112C);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = controller.agentList.value;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        padding: const EdgeInsets.all(14),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(
              title: 'My Agent & Merchant List',
              subtitle: '${list.length} registration found',
              icon: Icons.groups_2_outlined,
            ),

            const SizedBox(height: 12),

            if (controller.isAgentListLoading.value == true)
              const _AgentListLoadingState()
            else if (list.isEmpty)
              const _EmptyAgentState()
            else
              ListView.separated(
                itemCount: list.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final data = list[index];

                  return _AgentMerchantCard(data: data);
                },
              ),
          ],
        ),
      );
    });
  }
}
class _AgentListLoadingState extends StatelessWidget {
  const _AgentListLoadingState();

  static const Color _primary = Color(0xFF652981);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFAFD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8DFF0),
        ),
      ),
      child: const Column(
        children: [
          SizedBox(
            height: 28,
            width: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: _primary,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Loading registrations...',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
class _AgentMerchantCard extends StatelessWidget {
  const _AgentMerchantCard({
    required this.data,
  });

  final dynamic data;

  static const Color _primary = Color(0xFF652981);
  static const Color _dark = Color(0xFF21112C);

  @override
  Widget build(BuildContext context) {
    final remark = data.remark?.toString() ?? '';
    final outletName = data.outletName?.toString() ?? 'Unknown Outlet';
    final code = data.accNo?.toString() ?? 'Unknown Outlet';
    final mobile = data.mobileNo?.toString() ?? '';
    final status = data.status?.toString() ?? 'N/A';

    final isAgent = remark == 'Agent';
    final avatarColor = isAgent ? _primary : Colors.blue;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFAFD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8DFF0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: avatarColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              remark.isEmpty ? 'U' : remark.substring(0, 1),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  outletName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _dark,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  mobile,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _StatusChip(
                      label: remark.isEmpty ? 'User' : remark,
                      color: avatarColor,
                    ),
                    Row(
                      children: [
                        _StatusChip(
                          label: 'Code: $code',
                          color: Colors.indigo,
                        ),

                        _StatusChip(
                          label: 'Shop: $status',
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                    _StatusChip(
                      label: _kycText(data.kyc),
                      color: _kycColor(data.kyc),
                    ),
                    _StatusChip(
                      label: data.regWithoutPass == 1
                          ? 'Not Activated'
                          : 'Activated',
                      color: data.regWithoutPass == 1
                          ? Colors.redAccent
                          : Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _kycText(dynamic value) {
    if (value == 0) return 'KYC Required';
    if (value == 1) return 'KYC Pending';
    if (value == 2) return 'KYC Verified';
    if (value == 3) return 'KYC Rejected';

    return 'KYC N/A';
  }

  static Color _kycColor(dynamic value) {
    if (value == 0) return Colors.orange;
    if (value == 1) return Colors.blue;
    if (value == 2) return Colors.green;
    if (value == 3) return Colors.redAccent;

    return Colors.grey;
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 9.5,
        ),
      ),
    );
  }
}

class _EmptyAgentState extends StatelessWidget {
  const _EmptyAgentState();

  static const Color _primary = Color(0xFF652981);
  static const Color _dark = Color(0xFF21112C);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFAFD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8DFF0),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.person_search_rounded,
            color: _primary.withOpacity(0.6),
            size: 44,
          ),
          const SizedBox(height: 10),
          const Text(
            'No Registration Yet',
            style: TextStyle(
              color: _dark,
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Your registered Agent and Merchant list will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  static const Color _primary = Color(0xFF652981);
  static const Color _dark = Color(0xFF21112C);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: _primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: _primary,
            size: 22,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.tr,
                style: const TextStyle(
                  color: _dark,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle.tr,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: const Color(0xFFE8DFF0),
    ),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF652981).withOpacity(0.06),
        blurRadius: 16,
        offset: const Offset(0, 7),
      ),
    ],
  );
}

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _pickImage(String type) async {
    final pickedFile = await _picker.pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 900,
    );

    if (pickedFile == null) return;

    setState(() {
      _imageFile = pickedFile;
      _imagePath = pickedFile.path;
    });

    await _saveImage(pickedFile.path);
    await _loadImage();
  }

  Future<void> _saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagepath', path);
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _imagePath = prefs.getString('imagepath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: _showImagePickerSheet,
      child: Container(
        height: 44,
        width: 44,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.60),
            width: 1.4,
          ),
        ),
        child: ClipOval(
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    final localPath = _imagePath ?? _imageFile?.path;

    if (localPath != null && localPath.trim().isNotEmpty) {
      final file = File(localPath);

      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
        );
      }
    }

    return CachedNetworkImage(
      imageUrl:
      'https://thumbs.dreamstime.com/b/default-avatar-profile-flat-icon-vector-contact-symbol-illustration-184752213.jpg',
      fit: BoxFit.cover,
      placeholder: (_, __) => _fallbackAvatar(),
      errorWidget: (_, __, ___) => _fallbackAvatar(),
    );
  }

  Widget _fallbackAvatar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(7),
      child: const Image(
        image: AssetImage('assets/images/user2.png'),
        fit: BoxFit.contain,
      ),
    );
  }

  void _showImagePickerSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Wrap(
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text('Photo Library'.tr),
              onTap: () {
                Get.back();
                _pickImage('photo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text('Camera'.tr),
              onTap: () {
                Get.back();
                _pickImage('camera');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}