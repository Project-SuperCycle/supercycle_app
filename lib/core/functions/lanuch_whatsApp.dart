import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsApp({required BuildContext context}) async {
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("من فضلك ثبّت واتساب على جهازك")));
  }
}
