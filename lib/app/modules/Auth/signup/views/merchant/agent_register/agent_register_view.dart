import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/views/merchant/agent_register/controller/agent_register_controller.dart';


class AgentRegisterView extends GetView<AgentRegisterController> {
  const AgentRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Agent Registration'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: controller.agentRegisterFormKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 110),
            children: [
              const _HeaderCard(),
              const SizedBox(height: 14),
              const _AgentInfoSection(),
              const SizedBox(height: 14),
              const _OutletSection(),
              const SizedBox(height: 14),
              const _LocationSection(),
              const SizedBox(height: 14),
              const _InfoNote(
                text:
                'Please review all information carefully before submitting the agent registration.',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BottomSubmitBar(),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF652981),
            Color(0xFF8C3CB2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _primary.withOpacity(0.22),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withOpacity(0.22),
              ),
            ),
            child: const Icon(
              Icons.verified_user_outlined,
              color: _yellow,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register New Agent'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fill all required information carefully before submission.'
                      .tr,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.78),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 1.35,
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

class _AgentInfoSection extends GetView<AgentRegisterController> {
  const _AgentInfoSection();

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            title: 'Agent Information',
            subtitle: 'Enter agent contact and identity information.',
            icon: Icons.person_add_alt_1_rounded,
          ),
          const SizedBox(height: 16),
          _InputField(
            controller: controller.personalPhoneController,
            label: 'Mobile No',
            hint: 'Enter agent mobile number',
            icon: Icons.phone_android_rounded,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            validator: controller.requiredMobileValidator,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: controller.emailController,
            label: 'Email',
            hint: 'Enter agent email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: controller.requiredEmailValidator,
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: controller.customerNameController,
            label: 'Customer Name',
            hint: 'Enter customer name',
            icon: Icons.person_outline_rounded,
            textCapitalization: TextCapitalization.words,
            validator: (value) => controller.requiredTextValidator(
              value,
              'Customer Name',
            ),
          ),
        ],
      ),
    );
  }
}

class _OutletSection extends GetView<AgentRegisterController> {
  const _OutletSection();

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            title: 'Outlet Details',
            subtitle: 'Enter outlet name, address and post code.',
            icon: Icons.storefront_rounded,
          ),
          const SizedBox(height: 16),
          _InputField(
            controller: controller.outletNameController,
            label: 'Outlet Name',
            hint: 'Enter outlet name',
            icon: Icons.storefront_outlined,
            textCapitalization: TextCapitalization.words,
            validator: (value) => controller.requiredTextValidator(
              value,
              'Outlet Name',
            ),
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: controller.outletAddressController,
            label: 'Outlet Address',
            hint: 'Enter outlet address',
            icon: Icons.location_on_outlined,
            maxLines: 3,
            validator: (value) => controller.requiredTextValidator(
              value,
              'Outlet Address',
            ),
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: controller.postCodeController,
            label: 'Post Code',
            hint: 'Enter post code',
            icon: Icons.markunread_mailbox_outlined,
            keyboardType: TextInputType.number,
            validator: controller.requiredPostCodeValidator,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ],
      ),
    );
  }
}

class _LocationSection extends GetView<AgentRegisterController> {
  const _LocationSection();

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            title: 'Business & Location',
            subtitle:
            'Select business type, district and upazila for this agent.',
            icon: Icons.map_outlined,
          ),
          const SizedBox(height: 16),

          Obx(() {
            final items = controller.businessTypes
                .map((item) => item.type?.trim() ?? '')
                .where((item) => item.isNotEmpty)
                .toSet()
                .toList();

            final selected = controller.selectedBusinessTypeName.value.trim();
            final safeSelected = items.contains(selected) ? selected : null;

            return _DropdownCard(
              label: 'Business Type',
              icon: Icons.business_center_outlined,
              isLoading: controller.isBusinessTypeLoading.value,
              child: DropdownSearch<String>(
                key: ValueKey('agent-business-${items.length}'),
                enabled: !controller.isBusinessTypeLoading.value &&
                    items.isNotEmpty,
                selectedItem: safeSelected,
                items: (filter, infiniteScrollProps) {
                  return items;
                },
                onChanged: (value) {
                  controller.selectBusinessTypeByName(value);
                },
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                ),
              ),
            );
          }),

          const SizedBox(height: 12),

          Obx(() {
            final items = controller.districtsTypes
                .map((item) => item.districtName?.trim() ?? '')
                .where((item) => item.isNotEmpty)
                .toSet()
                .toList();

            final selected = controller.selectedDistrictName.value.trim();
            final safeSelected = items.contains(selected) ? selected : null;

            return _DropdownCard(
              label: 'জেলা',
              icon: Icons.map_outlined,
              isLoading: controller.isDistrictLoading.value,
              child: DropdownSearch<String>(
                key: ValueKey('agent-district-${items.length}'),
                enabled: !controller.isDistrictLoading.value &&
                    items.isNotEmpty,
                selectedItem: safeSelected,
                items: (filter, infiniteScrollProps) {
                  return items;
                },
                onChanged: (value) {
                  controller.selectDistrictByName(value);
                },
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                ),
              ),
            );
          }),

          const SizedBox(height: 12),

          Obx(() {
            final items = controller.thanas
                .map((item) => item.upazilaName?.trim() ?? '')
                .where((item) => item.isNotEmpty)
                .toSet()
                .toList();

            final selected = controller.selectedThanaName.value.trim();
            final safeSelected = items.contains(selected) ? selected : null;

            return _DropdownCard(
              label: 'উপজেলা',
              icon: Icons.location_city_outlined,
              isLoading: controller.isThanaLoading.value,
              child: DropdownSearch<String>(
                key: ValueKey(
                  'agent-upazila-${controller.selectedCityId.value}-${items.length}',
                ),
                enabled: !controller.isThanaLoading.value &&
                    controller.selectedCityId.value.trim().isNotEmpty &&
                    items.isNotEmpty,
                selectedItem: safeSelected,
                items: (filter, infiniteScrollProps) {
                  return items;
                },
                onChanged: (value) {
                  controller.selectThanaByName(value);
                },
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                ),
              ),
            );
          }),

          const SizedBox(height: 14),

          Obx(() {
            return Column(
              children: [
                _LocationRow(
                  label: 'Business Type ID',
                  value: controller.businessTypeId.value,
                  optional: true,
                ),
                const SizedBox(height: 8),
                _LocationRow(
                  label: 'District ID',
                  value: controller.selectedCityId.value,
                ),
                const SizedBox(height: 8),
                _LocationRow(
                  label: 'Upazila ID',
                  value: controller.selectedZoneId.value,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _DropdownCard extends StatelessWidget {
  const _DropdownCard({
    required this.label,
    required this.icon,
    required this.child,
    this.isLoading = false,
  });

  final String label;
  final IconData icon;
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 11, 13, 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _primary, size: 20),
              const SizedBox(width: 9),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        label.tr,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '*',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow({
    required this.label,
    required this.value,
    this.optional = false,
  });

  final String label;
  final String value;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    final isMissing = value.trim().isEmpty || value.trim() == 'null';
    final isWarning = isMissing && !optional;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: isWarning
            ? Colors.redAccent.withOpacity(0.06)
            : Colors.green.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isWarning
              ? Colors.redAccent.withOpacity(0.18)
              : Colors.green.withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isWarning
                ? Icons.error_outline_rounded
                : Icons.check_circle_rounded,
            color: isWarning ? Colors.redAccent : Colors.green,
            size: 20,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              label.tr,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            isMissing ? (optional ? 'Optional'.tr : 'Missing'.tr) : value,
            style: TextStyle(
              color: isWarning ? Colors.redAccent : Colors.green,
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSubmitBar extends GetView<AgentRegisterController> {
  const _BottomSubmitBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Obx(() {
          final busy = controller.isAgentSubmitting.value;

          return ElevatedButton(
            onPressed: busy ? null : controller.addAgentController,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              elevation: 0,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: busy
                ? const SizedBox(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                color: Colors.white,
              ),
            )
                : Text(
              'Submit Agent Registration'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      style: const TextStyle(
        color: _navy,
        fontWeight: FontWeight.w800,
        fontSize: 13,
      ),
      decoration: InputDecoration(
        counterText: '',
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label.tr),
            const SizedBox(width: 4),
            const Text(
              '*',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        hintText: hint.tr,
        prefixIcon: Icon(icon, color: _primary, size: 21),
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w700,
        ),
        hintStyle: const TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _primary, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        errorStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          height: 1.25,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: _primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: _primary, size: 22),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.tr,
                style: const TextStyle(
                  color: _navy,
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
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoNote extends StatelessWidget {
  const _InfoNote({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _primary.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: _primary, size: 20),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text.tr,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BaseCard extends StatelessWidget {
  const _BaseCard({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: _primary.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: child,
    );
  }
}

const Color _primary = Color(0xFF652981);
const Color _navy = Color(0xFF21112C);
const Color _bg = Color(0xFFF7F3FA);
const Color _border = Color(0xFFE8DFF0);
const Color _yellow = Color(0xFFFFD84D);
