import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/data.dart';

import '../controllers/check_phone_number_controller.dart';

class CheckPhoneNumberView extends GetView<CheckPhoneNumberController> {
  const CheckPhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: WillPopScope(
        onWillPop: () async {
          exit(0);
        },
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _TopSection(),
                          const SizedBox(height: 26),
                          const _PhoneFormCard(),
                          const SizedBox(height: 14),
                          const _TermsCard(),
                          const SizedBox(height: 20),
                          const _ContinueButton(),
                          const SizedBox(height: 18),
                          const _SimStatusNote(),
                          const SizedBox(height: 22),
                          const _VersionText(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _TopSection extends GetView<CheckPhoneNumberController> {
  const _TopSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Obx(() {
            if (controller.isUpdateChecking.value) {
              return const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              );
            }

            return const SizedBox(height: 22);
          }),
        ),
        Container(
          width: 128,
          height: 128,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _primary.withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Image.asset(
            'assets/Logo.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'Login'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _navy,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your registered DSR mobile number to continue.'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _PhoneFormCard extends GetView<CheckPhoneNumberController> {
  const _PhoneFormCard();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.mobileFormKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: _border),
          boxShadow: [
            BoxShadow(
              color: _primary.withOpacity(0.07),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mobile Number'.tr,
              style: const TextStyle(
                color: _navy,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Use the 11 digit Bangladeshi number registered as DSR.'.tr,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 14),
            Obx(
                  () => TextFormField(
                controller: controller.textEditingController,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                validator: controller.mobileValidator,
                onChanged: controller.updateMobileInput,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => controller.continueWithMobile(),
                style: const TextStyle(
                  color: _navy,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '01XXXXXXXXX'.tr,
                  prefixIcon: const Icon(
                    Icons.phone_android_rounded,
                    color: _primary,
                  ),
                  suffixIcon: _SimOperatorIcon(
                    imagePath: controller.simOperator.value,
                  ),
                  filled: true,
                  fillColor: _fieldBg,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 15,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: _border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: _primary,
                      width: 1.3,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 1.1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 1.2,
                    ),
                  ),
                  errorStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimOperatorIcon extends StatelessWidget {
  const _SimOperatorIcon({
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    if (imagePath.trim().isEmpty) {
      return const Icon(
        Icons.sim_card_outlined,
        color: Colors.black38,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(11),
      child: Image.asset(
        imagePath,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) {
          return const Icon(
            Icons.sim_card_outlined,
            color: Colors.black38,
          );
        },
      ),
    );
  }
}

class _TermsCard extends GetView<CheckPhoneNumberController> {
  const _TermsCard();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => controller.toggleTerms(!controller.checkTerm.value),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
          decoration: BoxDecoration(
            color: controller.checkTerm.value
                ? _primary.withOpacity(0.07)
                : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: controller.checkTerm.value
                  ? _primary.withOpacity(0.35)
                  : _border,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: controller.checkTerm.value,
                activeColor: _primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: controller.toggleTerms,
              ),
              Expanded(
                child: Text(
                  'I agree to the Terms and Conditions of this app.'.tr,
                  style: TextStyle(
                    color: controller.checkTerm.value ? _navy : Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    height: 1.35,
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

class _ContinueButton extends GetView<CheckPhoneNumberController> {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isBusy = controller.isCheckingNumber.value;

      return SizedBox(
        height: 54,
        child: ElevatedButton(
          onPressed: isBusy ? null : controller.continueWithMobile,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade300,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: isBusy
                ? const SizedBox(
              key: ValueKey('loading'),
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.3,
                color: Colors.white,
              ),
            )
                : Row(
              key: const ValueKey('buttonText'),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue'.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _SimStatusNote extends GetView<CheckPhoneNumberController> {
  const _SimStatusNote();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isSimInfoLoading.value) {
        return _StatusNote(
          icon: Icons.sim_card_outlined,
          color: _primary,
          text: 'Checking SIM information...'.tr,
        );
      }

      if (!controller.isAnySimAvailable.value && GetPlatform.isAndroid) {
        return _StatusNote(
          icon: Icons.info_outline_rounded,
          color: Colors.orange,
          text:
          'SIM information could not be detected. You can still continue by entering your registered number manually.'
              .tr,
        );
      }

      return _StatusNote(
        icon: Icons.verified_user_outlined,
        color: Colors.green,
        text: 'Your number will be verified securely before login.'.tr,
      );
    });
  }
}

class _StatusNote extends StatelessWidget {
  const _StatusNote({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VersionText extends StatelessWidget {
  const _VersionText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'App Version: ${MyData.appVersion}',
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black38,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

const Color _primary = Color(0xFF652981);
const Color _navy = Color(0xFF21112C);
const Color _bg = Color(0xFFF8F3FB);
const Color _fieldBg = Color(0xFFFCFAFD);
const Color _border = Color(0xFFE8DFF0);
