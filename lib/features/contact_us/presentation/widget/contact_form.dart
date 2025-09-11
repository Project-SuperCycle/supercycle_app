import 'package:flutter/material.dart';
import 'package:supercycle_app/features/contact_us/presentation/widget/form_fields.dart';
import 'package:supercycle_app/features/contact_us/presentation/widget/form_header.dart';
import 'package:supercycle_app/features/contact_us/presentation/widget/merchant_question_widget.dart';
import 'package:supercycle_app/features/contact_us/presentation/widget/submit_button.dart';
import '../controllers/form_controller.dart';


class ContactForm extends StatefulWidget {
  final FormController formController;
  final bool isArabic;
  final bool isLoading;
  final VoidCallback onSubmit;

  const ContactForm({
    Key? key,
    required this.formController,
    required this.isArabic,
    required this.isLoading,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: widget.formController.formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  FormHeader(isArabic: widget.isArabic),
                  const SizedBox(height: 32),
                  FormFields(
                    formController: widget.formController,
                    isArabic: widget.isArabic,
                    isLoading: widget.isLoading,
                    onTopicChanged: (value) {
                      setState(() {
                        widget.formController.selectedTopic = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  MerchantQuestionWidget(
                    value: widget.formController.isRagPaperMerchant,
                    onChanged: (value) {
                      setState(() {
                        widget.formController.isRagPaperMerchant = value;
                      });
                    },
                    isArabic: widget.isArabic,
                    enabled: !widget.isLoading,
                  ),
                  const SizedBox(height: 32),
                  SubmitButton(
                    isArabic: widget.isArabic,
                    isLoading: widget.isLoading,
                    onPressed: widget.onSubmit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}