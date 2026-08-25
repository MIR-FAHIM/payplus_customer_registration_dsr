import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/views/merchant/controller/merchant_register_controller.dart';

class MerchantRegisterView extends GetView<MerchantRegisterController> {
  const MerchantRegisterView({super.key});

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
          'Merchant Registration'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(
                  () => _StepHeader(
                currentStep: controller.merchantCurrentStep.value,
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  _VerificationStep(),
                  _NidUploadStep(),
                  _NidInfoStep(),
                  _TradeLicenseStep(),
                  _AddressStep(),
                  _ReviewStep(),
                ],
              ),
            ),
            const _BottomActions(),
          ],
        ),
      ),
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({
    required this.currentStep,
  });

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final steps = ['Verify', 'NID', 'Info', 'Trade', 'Address', 'Review'];
    final progress = (currentStep + 1) / steps.length;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${'Step'.tr} ${currentStep + 1} ${'of'.tr} ${steps.length}',
                  style: const TextStyle(
                    color: _navy,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                steps[currentStep].tr,
                style: const TextStyle(
                  color: _primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: progress,
              backgroundColor: _border,
              valueColor: const AlwaysStoppedAnimation<Color>(_primary),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(steps.length, (index) {
              final active = index == currentStep;
              final done = index < currentStep;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: active || done ? _primary : _bg,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: active || done ? _primary : _border,
                              ),
                            ),
                            child: Center(
                              child: done
                                  ? const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 17,
                              )
                                  : Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: active
                                      ? Colors.white
                                      : Colors.black45,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            steps[index].tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: active || done
                                  ? _primary
                                  : Colors.black45,
                              fontWeight: FontWeight.w900,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index != steps.length - 1)
                      Container(
                        width: 10,
                        height: 2,
                        color: index < currentStep ? _primary : _border,
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}


class _VerificationStep extends GetView<MerchantRegisterController> {
  const _VerificationStep();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.verifyFormKey,
      child: _StepBody(
        title: 'Merchant Verification',
        subtitle:
        '',
        children: [
          _InputField(
            controller: controller.mobileNoController,
            label: 'Mobile No',
            hint: 'Enter mobile number',
            icon: Icons.phone_android_rounded,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            validator: controller.requiredMobileValidator,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: controller.emailController,
            label: 'Email',
            hint: 'Enter email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
           // validator: controller.requiredEmailValidator,
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: controller.outletNameController,
            label: 'Outlet Name',
            hint: 'Enter outlet name',
            icon: Icons.storefront_outlined,
            validator: (value) => controller.requiredTextValidator(
              value,
              'Outlet Name',
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 14),
          Obx(() {
            if (!controller.isNumberChecking.value) {
              return const _InfoNote(
                text:
                'Mobile number and email will be checked before you can continue to NID upload.',
              );
            }

            return const _StatusCard(
              color: Colors.blue,
              icon: Icons.verified_user_outlined,
              title: 'Verifying',
              message: 'Checking mobile number and email. Please wait.',
              loading: true,
            );
          }),
        ],
      ),
    );
  }
}

class _NidUploadStep extends GetView<MerchantRegisterController> {
  const _NidUploadStep();

  @override
  Widget build(BuildContext context) {
    return _StepBody(
      title: 'NID Upload',
      subtitle: '',
      children: [
        Obx(
              () => _UploadCard(
            title: 'NID Front Image',
            subtitle: 'Required. Tap to upload NID front side',
            icon: Icons.credit_card_rounded,
            uploaded: controller.hasNidFront,
            fileName: controller.nidFrontFileName.value,
            base64Image: controller.nidFrontBase64.value,
            onTap: () => controller.showDocumentPickerSheet(
              MerchantRegisterDocType.nidFront,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const _NidOcrStatus(),
        const SizedBox(height: 12),
        Obx(
              () => _UploadCard(
            title: 'NID Back Image',
            subtitle: 'Required. Tap to upload NID back side',
            icon: Icons.credit_card_outlined,
            uploaded: controller.hasNidBack,
            fileName: controller.nidBackFileName.value,
            base64Image: controller.nidBackBase64.value,
            onTap: () => controller.showDocumentPickerSheet(
              MerchantRegisterDocType.nidBack,
            ),
          ),
        ),
        const SizedBox(height: 14),
        const _InfoNote(
          text:
          'NID front image will be scanned only to detect the NID number. If it cannot read the number, you can continue and enter it manually.',
        ),
      ],
    );
  }
}

class _NidOcrStatus extends GetView<MerchantRegisterController> {
  const _NidOcrStatus();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isOcrReading.value) {
        return const _StatusCard(
          color: Colors.blue,
          icon: Icons.document_scanner_outlined,
          title: 'Reading NID',
          message: 'Please wait while we try to read the NID number.',
          loading: true,
        );
      }

      final status = controller.ocrStatusMsg.value.trim();

      if (status.isEmpty) {
        return const SizedBox.shrink();
      }

      final isSuccess = controller.nidController.text.trim().isNotEmpty;

      return _StatusCard(
        color: isSuccess ? Colors.green : Colors.orange,
        icon: isSuccess ? Icons.verified_rounded : Icons.warning_amber_rounded,
        title: isSuccess ? 'NID Read Successfully' : 'NID Reading Notice',
        message: status,
      );
    });
  }
}

class _NidInfoStep extends GetView<MerchantRegisterController> {
  const _NidInfoStep();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.nidInfoFormKey,
      child: _StepBody(
        title: 'NID & Personal Info',
        subtitle:
        'Enter the personal information after the verification step.',
        children: [
          _InputField(
            controller: controller.customerNameController,
            label: 'Customer Name',
            hint: 'Enter customer name',
            icon: Icons.person_outline_rounded,
            validator: (value) => controller.requiredTextValidator(
              value,
              'Customer Name',
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: controller.personalMobileController,
            label: 'Secondary Mobile',
            hint: 'Enter Secondary mobile',
            icon: Icons.phone_iphone_rounded,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            validator: controller.requiredMobileValidator,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: controller.nidController,
            label: 'NID',
            hint: 'Enter NID number',
            icon: Icons.badge_outlined,
            keyboardType: TextInputType.number,
            validator: controller.requiredNidValidator,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: controller.dobController,
            label: 'Date of Birth',
            hint: 'yyyy-mm-dd',
            icon: Icons.calendar_month_outlined,
            readOnly: true,
            onTap: controller.pickDob,
            validator: controller.requiredDobValidator,
          ),

          const SizedBox(height: 12),
          Obx(
                () => _UploadCard(
              title: 'Merchant Image',
              subtitle: 'Required. Tap to upload Merchant image',
              icon: Icons.verified_user,
              uploaded: controller.hasUserFront,
              fileName: controller.userFileName.value,
              base64Image: controller.userBase64.value,
              onTap: () => controller.showDocumentPickerSheet(
                MerchantRegisterDocType.userImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TradeLicenseStep extends GetView<MerchantRegisterController> {
  const _TradeLicenseStep();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.tradeLicenseFormKey,
      child: _StepBody(
        title: 'Trade License',
        subtitle: 'Trade license information and document are required.',
        children: [
          _InputField(
            controller: controller.tradeLicenseNumberController,
            label: 'Trade License Number',
            hint: 'Enter trade license number',
            icon: Icons.confirmation_number_outlined,
            validator: (value) => controller.requiredTextValidator(
              value,
              'Trade License Number',
            ),
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: controller.tradeLicenseExpireDateController,
            label: 'Trade License Expire Date',
            hint: 'yyyy-06-30',
            icon: Icons.event_available_outlined,
            readOnly: true,
            onTap: controller.pickTradeLicenseExpiryYear,
            validator: (value) => controller.requiredTextValidator(
              value,
              'Trade License Expire Date',
            ),
          ),
          const SizedBox(height: 12),
          Obx(
                () => _UploadCard(
              title: 'Trade License Document',
              subtitle: 'Required. Tap to upload trade license',
              icon: Icons.description_outlined,
              uploaded: controller.hasTradeLicense,
              fileName: controller.tradeLicenseFileName.value,
              base64Image: controller.tradeLicenseBase64.value,
              onTap: () => controller.showDocumentPickerSheet(
                MerchantRegisterDocType.tradeLicense,
              ),
            ),
          ),
          const SizedBox(height: 14),
          const _InfoNote(
            text:
            'If selected, trade license expiry date will always be 30 June of the selected year.',
          ),
        ],
      ),
    );
  }
}

class _AddressStep extends GetView<MerchantRegisterController> {
  const _AddressStep();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.addressFormKey,
      child: _StepBody(
        title: 'Outlet & Address',
        subtitle: 'Business and address information are required.',
        children: [

          Obx(
                () {
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
                  key: ValueKey('business-${items.length}'),
                  enabled: !controller.isBusinessTypeLoading.value &&
                      items.isNotEmpty,
                  selectedItem: safeSelected,
                  items: (filter, infiniteScrollProps) => items,
                  onChanged: (value) {
                    controller.selectBusinessTypeByName(value);
                  },
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Obx(
                () {
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
                  key: ValueKey('district-${items.length}'),
                  enabled: !controller.isDistrictLoading.value &&
                      items.isNotEmpty,
                  selectedItem: safeSelected,
                  items: (filter, infiniteScrollProps) => items,
                  onChanged: (value) {
                    controller.selectDistrictByName(value);
                  },
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Obx(
                () {
              final items = controller.thanas
                  .map((item) => item.upazilaName?.trim() ?? '')
                  .where((item) => item.isNotEmpty)
                  .toSet()
                  .toList();

              final selected = controller.selectedThanaName.value.trim();
              final safeSelected = items.contains(selected) ? selected : null;

              return _DropdownCard(
                label: 'উপজেলা/থানা',
                icon: Icons.location_city_outlined,
                isLoading: controller.isThanaLoading.value,
                child: DropdownSearch<String>(
                  key: ValueKey(
                    'upazila-${controller.districtId.value}-${items.length}',
                  ),
                  enabled: !controller.isThanaLoading.value &&
                      controller.districtId.value.trim().isNotEmpty &&
                      items.isNotEmpty,
                  selectedItem: safeSelected,
                  items: (filter, infiniteScrollProps) => items,
                  onChanged: (value) {
                    controller.selectThanaByName(value);
                  },
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 12),
          _InputField(
            controller: controller.postCodeController,
            label: 'Post Code',
            hint: 'Enter post code',
            icon: Icons.markunread_mailbox_outlined,
            keyboardType: TextInputType.number,
            validator: controller.requiredPostCodeValidator,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

        ],
      ),
    );
  }
}

class _ReviewStep extends GetView<MerchantRegisterController> {
  const _ReviewStep();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => _StepBody(
        title: 'Review & Submit',
        subtitle: 'Check all required information before submission.',
        children: [
          _ReviewCard(
            title: 'Personal Info',
            rows: [
              _ReviewRowData('Mobile No', controller.mobileNoController.text),
              _ReviewRowData('Name', controller.customerNameController.text),
              _ReviewRowData('Email', controller.emailController.text),
              _ReviewRowData('Outlet Name', controller.outletNameController.text),
              _ReviewRowData(
                'Personal Mobile',
                controller.personalMobileController.text,
              ),
              _ReviewRowData('NID', controller.nidController.text),
              _ReviewRowData('DOB', controller.dobController.text),
            ],
          ),
          const SizedBox(height: 12),
          _ReviewCard(
            title: 'Documents',
            rows: [
              _ReviewRowData(
                'NID Front',
                controller.hasNidFront
                    ? Icons.check_circle_rounded
                    : Icons.cancel_rounded,
              ),
              _ReviewRowData(
                'NID Back',
                controller.hasNidBack
                    ? Icons.check_circle_rounded
                    : Icons.cancel_rounded,
              ),
              _ReviewRowData(
                'Trade License',
                controller.hasTradeLicense
                    ? Icons.check_circle_rounded
                    : Icons.cancel_rounded,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _ReviewCard(
            title: 'Trade License',
            rows: [
              _ReviewRowData(
                'Trade No',
                controller.tradeLicenseNumberController.text,
              ),
              _ReviewRowData(
                'Expire Date',
                controller.tradeLicenseExpireDateController.text,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _ReviewCard(
            title: 'Outlet & Address',
            rows: [
              _ReviewRowData(
                'Outlet Address',
                controller.outletAddressController.text,
              ),
              _ReviewRowData(
                'Business Type',
                controller.selectedBusinessTypeName.value,
              ),
              _ReviewRowData('District', controller.selectedDistrictName.value),
              _ReviewRowData('Upazila', controller.selectedThanaName.value),
              _ReviewRowData('Post Code', controller.postCodeController.text),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends GetView<MerchantRegisterController> {
  const _BottomActions();

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
      child: Obx(() {
        final isLast =
            controller.merchantCurrentStep.value == merchantRegisterLastStep;
        final isBusy =
            controller.isMerchantSubmitting.value ||
                controller.isNumberChecking.value ||
                controller.isFilePicking.value;

        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: isBusy ? null : controller.previousStep,
                style: OutlinedButton.styleFrom(
                  foregroundColor: _primary,
                  side: const BorderSide(color: _primary),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  controller.merchantCurrentStep.value == 0
                      ? 'Cancel'.tr
                      : 'Back'.tr,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: isBusy
                    ? null
                    : () {
                  if (isLast) {
                    controller.submitMerchantRegistration();
                  } else {
                    controller.nextStep();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: isBusy
                    ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : Text(
                  isLast ? 'Submit Merchant'.tr : 'Continue'.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _StepBody extends StatelessWidget {
  const _StepBody({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
      children: [
        _BaseCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(title: title, subtitle: subtitle),
              const SizedBox(height: 16),
              ...children,
            ],
          ),
        ),
      ],
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
                    Text(
                      label.tr,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),

                  Text("*", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),),
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

class _UploadCard extends StatelessWidget {
  const _UploadCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.uploaded,
    required this.onTap,
    this.fileName,
    this.base64Image,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool uploaded;
  final VoidCallback onTap;
  final String? fileName;
  final String? base64Image;

  @override
  Widget build(BuildContext context) {
    final color = uploaded ? Colors.green : _primary;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: uploaded ? Colors.green.withOpacity(0.06) : _bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: uploaded ? Colors.green.withOpacity(0.35) : _border,
          ),
        ),
        child: Row(
          children: [
            _DocumentPreview(
              uploaded: uploaded,
              base64Image: base64Image,
              fileName: fileName,
              icon: icon,
              color: color,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _navy,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const _RequiredBadge(),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    uploaded
                        ? (fileName?.isNotEmpty == true
                        ? fileName!
                        : 'Uploaded'.tr)
                        : subtitle.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: uploaded ? Colors.green : Colors.black54,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              uploaded ? Icons.check_circle_rounded : Icons.upload_file_rounded,
              color: color,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentPreview extends StatelessWidget {
  const _DocumentPreview({
    required this.uploaded,
    required this.base64Image,
    required this.fileName,
    required this.icon,
    required this.color,
  });

  final bool uploaded;
  final String? base64Image;
  final String? fileName;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Widget child = Icon(
      uploaded ? Icons.check_circle_rounded : icon,
      color: color,
      size: 27,
    );

    final isPdf = (fileName ?? '').toLowerCase().endsWith('.pdf');

    if (uploaded && isPdf) {
      child = Icon(
        Icons.picture_as_pdf_rounded,
        color: color,
        size: 28,
      );
    } else if (uploaded &&
        base64Image != null &&
        base64Image!.trim().isNotEmpty) {
      child = ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.memory(
          base64Decode(base64Image!),
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Icon(
              Icons.description_outlined,
              color: color,
              size: 27,
            );
          },
        ),
      );
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: child),
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
    this.obscureText = false,
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
  final bool obscureText;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      obscureText: obscureText,
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
        suffixIcon: readOnly
            ? const Icon(Icons.keyboard_arrow_down_rounded, color: _primary)
            : null,
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

class _RequiredBadge extends StatelessWidget {
  const _RequiredBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Required',
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.w900,
          fontSize: 9,
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.message,
    this.loading = false,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String message;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Row(
        children: [
          loading
              ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: color,
            ),
          )
              : Icon(icon, color: color, size: 22),
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
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message.tr,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    height: 1.3,
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

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.title,
    required this.rows,
  });

  final String title;
  final List<_ReviewRowData> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.tr,
            style: const TextStyle(
              color: _primary,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          ...rows.map((row) {
            return _ReviewRow(label: row.label, value: row.value);
          }),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.label,
    required this.value,
  });

  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    final isIcon = value is IconData;

    final isSuccessIcon = value == Icons.check ||
        value == Icons.check_rounded ||
        value == Icons.check_circle ||
        value == Icons.check_circle_rounded;

    final safeValue = value == null || value.toString().trim().isEmpty
        ? 'Missing'
        : value.toString();

    final isMissing = safeValue == 'Missing';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label.tr,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: Align(
              alignment: Alignment.centerRight,
              child: isIcon
                  ? Icon(
                value,
                color: isSuccessIcon ? Colors.green : Colors.redAccent,
                size: 22,
              )
                  : Text(
                safeValue.tr,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: isMissing ? Colors.redAccent : _navy,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewRowData {
  const _ReviewRowData(this.label, this.value);

  final String label;
  final dynamic value;
}
class _ReviewRowDataDocument {
  const _ReviewRowDataDocument(this.label, this.value);

  final String label;
  final Icons value;
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 42,
          decoration: BoxDecoration(
            color: _primary,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.tr,
                style: const TextStyle(
                  color: _navy,
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle.tr,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
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
        borderRadius: BorderRadius.circular(18),
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
