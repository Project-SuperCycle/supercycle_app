import 'package:supercycle_app/features/contact_us/data/models/contact_form_data.dart';

abstract class ContactService {
  Future<bool> submitContactForm(ContactFormData data);
}