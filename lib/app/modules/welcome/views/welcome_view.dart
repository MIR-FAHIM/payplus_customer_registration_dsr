import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3FA),
      body: SafeArea(
        child: Stack(
          children: [
            _TopBackground(),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
              child: Column(
                children: [
                  const Spacer(),
                  _WelcomeCard(),
                  const Spacer(),
                  _StartButton(),
                  const SizedBox(height: 10),
                  Text(
                    'Agent and Merchant Registration'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
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

class _TopBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -110,
      left: -60,
      right: -60,
      child: Container(
        height: 310,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              const Color(0xFF8C3CB2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(160),
          ),
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.14),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        children: [
          _LogoBox(),
          const SizedBox(height: 28),

          Text(
            'Welcome to'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: 6),

          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  const Color(0xFF9B44C5),
                ],
              ).createShader(bounds);
            },
            child: Text(
              'DSR App'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
                height: 1.05,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.07),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(0.12),
              ),
            ),
            child: Text(
              'App is for Agent and Merchant Registration.'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                height: 1.35,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _FeatureChip(
                  icon: Icons.person_add_alt_1_rounded,
                  text: 'Agent'.tr,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _FeatureChip(
                  icon: Icons.storefront_rounded,
                  text: 'Merchant'.tr,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LogoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.08),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.12),
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/PP_Splash_Screen.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.10),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primaryColor,
            size: 26,
          ),
          const SizedBox(height: 6),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF21112C),
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Get.find<AuthService>().setFirstUseOrNot();
          Get.offAllNamed(Routes.CHECK_PHONE_NUMBER);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: AppColors.primaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login / Registration'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}