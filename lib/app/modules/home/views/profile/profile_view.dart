import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_widget/custom_widget.dart';
import 'package:latest_payplus_agent/service/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends GetView<HomeController> {
  const ProfileView({Key? key}) : super(key: key);

  AuthService get auth => Get.find<AuthService>();
  InboxController get inbox => Get.find<InboxController>();

  @override
  Widget build(BuildContext context) {
    final user = controller.profileInfoModel.value.data;

    if(user == null){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF652981),
          centerTitle: true,
          title: Text("Profile"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 72, color: Colors.redAccent),
              const SizedBox(height: 16),
              Text(
                "Session expired.\nPlease log in again.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('imagepath');



                  await prefs.remove('imagepath');


                  SharedPreff.to.prefss.remove("logindate");
                  Get.find<AuthService>()
                      .logOutApi(true);
                },
                icon: const Icon(Icons.logout),
                label: const Text("Log out"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final outletName = user!.outletName ?? '';
      final mobile = user!.mobileNo ?? '';
      final agentNo = user!.acc_no ?? '';
      final kyc = (user!.kyc_status ?? '')
          .trim(); // "none" | "required" | "rejected" | "approved" | etc.

      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) => Get.toNamed(Routes.ROOT),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(64),
            child: _GradientAppBar(
              title: "Profile".tr,
              onBellTap: () {
                Get.lazyPut<RechargeController>(() => RechargeController());
                inbox.removeNewMsgNum();
                Get.toNamed(Routes.Notification_View);
              },
            ),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                // Top gradient background
                Container(
                  height: 220,
                  decoration: BoxDecoration(),
                ),
                // Content
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _HeaderCard(
                        outletName: outletName,
                        mobile: mobile,
                        agentNo: agentNo,
                        kycStatus: kyc,
                        onLogoTap: controller.getAllCompany,
                      ),
                      const SizedBox(height: 12),

                      // KYC Smart Banner

                      _KycBanner(
                        kycStatus: kyc,
                        onGiveInfo: () {
                          if (kyc == "required") {
                            Get.put(SignupController());
                            Get.find<SignupController>()
                                .checkCameraPermission();
                          } else if (kyc == "rejected") {
                            Get.put(SignupController());
                            Get.find<SignupController>()
                                .checkCameraPermission();
                          }else{
                            print("i am here 123 $kyc");
                          }
                        },
                      ),

                      const SizedBox(height: 16),

                      // Profile Form (read/edit intent, but using your CustomTextField)
                      _SectionTitle("Profile Information".tr),
                      const SizedBox(height: 8),
                      _InfoCard(
                        children: [
                          _EditableField(
                            title: "Owner Name".tr,
                            controller: controller.ownerController.value,
                            hint: controller
                                .profileInfoModel.value.data?.customerName ??
                                "No Data",
                            keyboardType: TextInputType.name,
                          ),
                          _EditableField(
                            title: "Outlet Name".tr,
                            controller: controller.outletNameController.value,
                            hint: outletName.isEmpty
                                ? "Add Outlet Name"
                                : outletName,
                            keyboardType: TextInputType.text,
                          ),
                          _EditableField(
                            title: "Personal Mobile no".tr,
                            controller: controller.phoneController.value,
                            hint: mobile,
                            keyboardType: TextInputType.phone,
                          ),
                          _EditableField(
                            title: "Address".tr,
                            controller: controller.addressController.value,
                            hint: controller
                                .profileInfoModel.value.data?.outletAddress ??
                                "No Data",
                            keyboardType: TextInputType.streetAddress,
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Support & Policies
                      _SectionTitle("Support".tr),
                      const SizedBox(height: 8),
                      _InfoCard(
                        children: [
                          _ActionTile(
                            leading:
                            const _TileIcon(asset: "assets/icons/help.png"),
                            title: "Get help",
                            onTap: () => Get.toNamed(Routes.HOTLINE),
                          ),
                          const Divider(height: 1),
                          _ActionTile(
                            leading:
                            const _TileIcon(asset: "assets/icons/report.png"),
                            title: "Terms of Service",
                            onTap: () async {
                              final url = Uri.parse(
                                  'https://shl.com.bd/terms-and-conditions.php');
                              if (await canLaunchUrl(url)) launchUrl(url);
                            },
                          ),
                          const Divider(height: 1),
                          _ActionTile(
                            leading:
                            const _TileIcon(asset: "assets/icons/report.png"),
                            title: "Privacy Policy",
                            onTap: () async {
                              final url = Uri.parse(
                                  "https://raw.githubusercontent.com/musabbir-mamun/app-privacy-policy/master/paystation/paystation.html");
                              if (await canLaunchUrl(url)) launchUrl(url);
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Logout with confirmation
                      Center(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.redTextColor,
                          ),
                          icon: const Icon(Icons.logout),
                          label: Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.redTextColor,
                            ),
                          ),
                          onPressed: () => _confirmLogout(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

  }

  Future<void> _confirmLogout(BuildContext context) async {
    final outlet = auth.currentUser.value.outletName ?? '';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Log out?".tr),
        content: Text("You’re about to log out from $outlet".tr),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancel".tr)),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Log out".tr)),
        ],
      ),
    );
    if (confirmed != true) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('imagepath');


    SharedPreff.to.prefss.remove("logindate");
    Get.find<AuthService>()
        .logOutApi(true);
  }
}

/* ===========================
   Small, focused widgets
   =========================== */

class _GradientAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBellTap;
  const _GradientAppBar({required this.title, required this.onBellTap});

  @override
  Widget build(BuildContext context) {
    final inbox = Get.find<InboxController>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradientOne, AppColors.gradientTwo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.only(top: 8, left: 12, right: 8),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            const Spacer(),
            Obx(() {
              final count = inbox.newNotificationNum;
              return badges.Badge(
                position: badges.BadgePosition.topEnd(top: -6, end: -6),
                showBadge: count > 0,
                badgeContent: Text('$count',
                    style: const TextStyle(color: Colors.white, fontSize: 10)),
                badgeStyle:
                    const badges.BadgeStyle(badgeColor: Colors.redAccent),
                child: IconButton(
                  onPressed: onBellTap,
                  icon: const Icon(CupertinoIcons.bell, color: Colors.white70),
                  tooltip: 'Notifications',
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String outletName;
  final String mobile;
  final String agentNo;
  final String kycStatus;
  final VoidCallback onLogoTap;

  const _HeaderCard({
    required this.outletName,
    required this.mobile,
    required this.agentNo,
    required this.kycStatus,
    required this.onLogoTap,
  });

  bool get _isVerified =>
      kycStatus == "approved" || kycStatus == "verified" || kycStatus == "none";

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    return Material(
      elevation: 2,
      borderRadius: radius,
      color: AppColors.primaryColor.withOpacity(.8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: radius,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .12,
                  width: MediaQuery.of(context).size.width * .25,
                  child: const _ProfileImage(),
                ),
                Positioned(
                  right: -4,
                  bottom: -4,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.verified,
                      size: 20,
                      color:
                          _isVerified ? AppColors.greenTextColor : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(outletName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(mobile,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.white70)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text("Agent Account No: $agentNo",
                          style: const TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KycBanner extends StatelessWidget {
  final String kycStatus;
  final VoidCallback onGiveInfo;
  const _KycBanner({required this.kycStatus, required this.onGiveInfo});

  @override
  Widget build(BuildContext context) {
    // Hide when none/approved; show actionable states only
    if (kycStatus.isEmpty ||
        kycStatus == "none" ||
        kycStatus == "approved" ||
        kycStatus == "Verified") {
      return const SizedBox.shrink();
    }

    final isRequired = kycStatus == "required";
    final bg = Colors.red.withOpacity(.12);
    final msg = isRequired
        ? "আপনার NID'র তথ্য দিয়ে রেজিস্ট্রেশন নিশ্চিত করুন"
        : "আপনার NID'র তথ্য দিয়ে রেজিস্ট্রেশন নিশ্চিত করুন";

    return Card(
      color: bg,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: const Icon(Icons.warning_amber_rounded, color: Colors.red),
        title: Text(msg, style: const TextStyle(fontSize: 13)),
        trailing: FilledButton(
          style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(64, 36)),
          onPressed: onGiveInfo,
          child: Text("তথ্য দিন", style: const TextStyle(fontSize: 12)),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1) const SizedBox(height: 12),
          ],
        ]),
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;

  const _EditableField({
    required this.title,
    required this.controller,
    required this.hint,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      context: context,
      controller: controller,
      title: title,
      keyboardType: keyboardType,
      obsecure: false,
      hint: hint,
      iconName: Icons.edit_outlined,
    );
  }
}

class _ActionTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final VoidCallback onTap;

  const _ActionTile({
    required this.leading,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: leading,
      title: Text(title),
      trailing: const Icon(Icons.navigate_next),
      onTap: onTap,
      dense: true,
      minLeadingWidth: 28,
    );
  }
}

class _TileIcon extends StatelessWidget {
  final String asset;
  const _TileIcon({required this.asset});
  @override
  Widget build(BuildContext context) {
    return Image.asset(asset, width: 22, height: 22);
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage();

  @override
  Widget build(BuildContext context) {
    final avatarUrl = Get.find<AuthService>().currentUser.value.image ?? '';
    final radius = BorderRadius.circular(14);

    return ClipRRect(
      borderRadius: radius,
      child: Container(
        color: Colors.white.withOpacity(0.1),
        child: avatarUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: avatarUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => const _AvatarPlaceholder(),
                errorWidget: (_, __, ___) => const _AvatarPlaceholder(),
              )
            : const _AvatarPlaceholder(),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white12,
      child: const Center(
        child: Icon(Icons.person, color: Colors.white70, size: 36),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
    );
  }
}
