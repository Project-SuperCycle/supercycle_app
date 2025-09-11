import 'package:flutter/material.dart';
import 'package:supercycle_app/core/services/contact_service.dart';
import 'package:supercycle_app/core/services/mock_contact_service.dart';
import 'package:supercycle_app/core/utils/contact_strings.dart';
import 'package:supercycle_app/features/contact_us/presentation/controllers/form_controller.dart';
import 'package:supercycle_app/features/contact_us/presentation/widget/contact_app_bar.dart';
import 'package:supercycle_app/features/contact_us/presentation/widget/contact_body.dart';
import 'package:supercycle_app/features/contact_us/presentation/widget/floating_button.dart';
import 'package:supercycle_app/features/contact_us/presentation/widget/success_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsViewBody extends StatefulWidget {
  final ContactService? contactService;
  final String? logoUrl;
  final String? companyName;
  final bool initialLanguage;

  const ContactUsViewBody({
    Key? key,
    this.contactService,
    this.logoUrl,
    this.companyName,
    this.initialLanguage = true,
  }) : super(key: key);

  @override
  State<ContactUsViewBody> createState() => _ContactUsViewBodyState();
}

class _ContactUsViewBodyState extends State<ContactUsViewBody>
    with SingleTickerProviderStateMixin {

  // Services and Controllers
  late final ContactService _contactService;
  late final FormController _formController;
  late final AnimationController _animationController;

  // Animations
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // State
  bool _isArabic = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeComponents();
    _setupAnimations();
  }

  void _initializeComponents() {
    _contactService = widget.contactService ?? MockContactService();
    _formController = FormController();
    _isArabic = widget.initialLanguage;
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _formController.dispose();
    super.dispose();
  }

  void _toggleLanguage() {
    if (_isLoading) return;

    setState(() => _isArabic = !_isArabic);
    _animationController.reset();
    _animationController.forward();
  }

  Future<void> _submitForm() async {
    if (_isLoading || !_formController.validateForm(_isArabic)) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final formData = _formController.buildContactFormData();
      final success = await _contactService.submitContactForm(formData);

      if (!mounted) return;

      if (success) {
        await _showSuccessDialog();
        _formController.resetForm();
      } else {
        _showErrorSnackBar(ContactStrings.get('submissionFailed', _isArabic));
      }
    } catch (error) {
      if (mounted) {
        _showErrorSnackBar(ContactStrings.get('errorOccurred', _isArabic));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => SuccessDialog(isArabic: _isArabic),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: ContactAppBar(
          isArabic: _isArabic,
          isLoading: _isLoading,
          onLanguageToggle: _toggleLanguage,
          onBack: () => Navigator.of(context).pop(),
        ),
        body: ContactBody(
          animationController: _animationController,
          fadeAnimation: _fadeAnimation,
          slideAnimation: _slideAnimation,
          formController: _formController,
          isArabic: _isArabic,
          isLoading: _isLoading,
          onSubmit: _submitForm,
        ),

        floatingActionButton: FloatingButton(
          isArabic: _isArabic,
          onPressed: _openWhatsApp,
        ),
        floatingActionButtonLocation: _isArabic
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,

      ),
    );
  }
  Future<void> _openWhatsApp() async {
    final phone = "201017185116"; // رقمك بكود الدولة بدون +
    final message = Uri.encodeComponent("مرحبا، أحتاج إلى المساعدة");

    final whatsappUrl = Uri.parse("whatsapp://send?phone=$phone&text=$message");
    final fallbackUrl = Uri.parse("https://wa.me/$phone?text=$message");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(fallbackUrl)) {
      await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("WhatsApp is not installed");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("من فضلك ثبّت واتساب على جهازك")),
      );
    }
  }

}