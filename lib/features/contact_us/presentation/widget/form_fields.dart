import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/contact_strings.dart';
import 'package:supercycle_app/core/utils/form_validators.dart';
import 'package:supercycle_app/features/contact_us/presentation/widget/custom_text_field.dart';
import '../controllers/form_controller.dart';
import 'topic_dropdown.dart';

class FormFields extends StatelessWidget {
  final FormController formController;
  final bool isArabic;
  final bool isLoading;
  final Function(String?) onTopicChanged;

  const FormFields({
    Key? key,
    required this.formController,
    required this.isArabic,
    required this.isLoading,
    required this.onTopicChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: ContactStrings.get('fullName', isArabic),
          hint: ContactStrings.get('fullNameHint', isArabic),
          controller: formController.nameController,
          icon: Icons.person_outline,
          validator: (value) => FormValidators.validateName(value, isArabic),
          isArabic: isArabic,
          enabled: !isLoading,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: ContactStrings.get('email', isArabic),
          hint: ContactStrings.get('emailHint', isArabic),
          controller: formController.emailController,
          keyboardType: TextInputType.emailAddress,
          icon: Icons.email_outlined,
          validator: (value) => FormValidators.validateEmail(value, isArabic),
          isArabic: isArabic,
          enabled: !isLoading,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: ContactStrings.get('mobile', isArabic),
          hint: ContactStrings.get('mobileHint', isArabic),
          controller: formController.mobileController,
          keyboardType: TextInputType.phone,
          icon: Icons.phone_outlined,
          validator: (value) => FormValidators.validateMobile(value, isArabic),
          isArabic: isArabic,
          enabled: !isLoading,
        ),
        const SizedBox(height: 20),

        const SizedBox(height: 20),
        CustomTextField(
          label: ContactStrings.get('message', isArabic),
          hint: ContactStrings.get('messageHint', isArabic),
          controller: formController.messageController,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          icon: Icons.message_outlined,
          validator: (value) => FormValidators.validateMessage(value, isArabic),
          isArabic: isArabic,
          enabled: !isLoading,
          child: TopicDropdown(
            value: formController.selectedTopic,
            onChanged: onTopicChanged,
            isArabic: isArabic,
            enabled: !isLoading,
          ),
        ),

      ],
    );
  }
}