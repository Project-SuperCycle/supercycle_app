class ContactFormData {
  final String name;
  final String email;
  final String mobile;
  final String message;
  final bool isRagPaperMerchant;
const ContactFormData({
required this.name,
required this.email,
required this.mobile,
required this.message,
required this.isRagPaperMerchant,
});


Map<String, dynamic> toJson() => {
'name': name,
'email': email,
'mobile': mobile,
'message': message,
'isRagPaperMerchant': isRagPaperMerchant,
};

@override
String toString() => 'ContactFormData(name: $name, email: $email)';

@override
bool operator ==(Object other) =>
identical(this, other) ||
other is ContactFormData &&
name == other.name &&
email == other.email &&
mobile == other.mobile &&
message == other.message &&
isRagPaperMerchant == other.isRagPaperMerchant;

@override
int get hashCode => Object.hash(name, email, mobile, message, isRagPaperMerchant);
}