class LoginedUserModel {
  final String businessName;
  final String rawBusinessType;
  final String businessAddress;
  final String doshManagerName;
  final String doshManagerPhone;
  final String email;

  LoginedUserModel({
    required this.businessName,
    required this.rawBusinessType,
    required this.businessAddress,
    required this.doshManagerName,
    required this.doshManagerPhone,
    required this.email,
  });

  // fromJson constructor
  factory LoginedUserModel.fromJson(Map<String, dynamic> json) {
    return LoginedUserModel(
      businessName: json['profile']['bussinessName'] as String,
      rawBusinessType: json['profile']['rawBusinessType'] as String,
      businessAddress: json['profile']['bussinessAdress'] as String,
      doshManagerName: json['profile']['doshMangerName'] as String,
      doshManagerPhone: json['profile']['doshMangerPhone'] as String,
      email: json['email'] as String,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'businessName': businessName,
      'rawBusinessType': rawBusinessType,
      'businessAddress': businessAddress,
      'doshManagerName': doshManagerName,
      'doshManagerPhone': doshManagerPhone,
      'email': email,
    };
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'LoginedUserModel(businessName: $businessName, rawBusinessType: $rawBusinessType, businessAddress: $businessAddress, doshManagerName: $doshManagerName, doshManagerPhone: $doshManagerPhone, email: $email)';
  }

  // Optional: copyWith method for creating modified copies
  LoginedUserModel copyWith({
    String? businessName,
    String? rawBusinessType,
    String? businessAddress,
    String? doshManagerName,
    String? doshManagerPhone,
    String? email,
  }) {
    return LoginedUserModel(
      businessName: businessName ?? this.businessName,
      rawBusinessType: rawBusinessType ?? this.rawBusinessType,
      businessAddress: businessAddress ?? this.businessAddress,
      doshManagerName: doshManagerName ?? this.doshManagerName,
      doshManagerPhone: doshManagerPhone ?? this.doshManagerPhone,
      email: email ?? this.email,
    );
  }
}
