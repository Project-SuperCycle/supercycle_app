class LoginedUserModel {
  final String bussinessName;
  final String rawBusinessType;
  final String bussinessAdress;
  final String doshMangerName;
  final String doshMangerPhone;
  final String email;

  LoginedUserModel({
    required this.bussinessName,
    required this.rawBusinessType,
    required this.bussinessAdress,
    required this.doshMangerName,
    required this.doshMangerPhone,
    required this.email,
  });


  // fromJson constructor
  factory LoginedUserModel.fromJson(Map<String, dynamic> json) {
    return LoginedUserModel(
      bussinessName: json['profile']['bussinessName'] as String,
      rawBusinessType: json['profile']['rawBusinessType'] as String,
      bussinessAdress: json['profile']['bussinessAdress'] as String,
      doshMangerName: json['profile']['doshMangerName'] as String,
      doshMangerPhone: json['profile']['doshMangerPhone'] as String,
      email: json['email'] as String,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'bussinessName': bussinessName,
      'rawBusinessType': rawBusinessType,
      'bussinessAdress': bussinessAdress,
      'doshMangerName': doshMangerName,
      'doshMangerPhone': doshMangerPhone,
      'email': email,
    };
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'LoginedUserModel(bussinessName: $bussinessName, rawBusinessType: $rawBusinessType, bussinessAdress: $bussinessAdress, doshMangerName: $doshMangerName, doshMangerPhone: $doshMangerPhone, email: $email)';
  }

  // Optional: copyWith method for creating modified copies
  LoginedUserModel copyWith({
    String? bussinessName,
    String? rawBusinessType,
    String? bussinessAdress,
    String? doshMangerName,
    String? doshMangerPhone,
    String? email,
  }) {
    return LoginedUserModel(
      bussinessName: bussinessName ?? this.bussinessName,
      rawBusinessType: rawBusinessType ?? this.rawBusinessType,
      bussinessAdress: bussinessAdress ?? this.bussinessAdress,
      doshMangerName: doshMangerName ?? this.doshMangerName,
      doshMangerPhone: doshMangerPhone ?? this.doshMangerPhone,
      email: email ?? this.email,
    );
  }
}
