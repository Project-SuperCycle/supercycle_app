import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart'
    show LoginedUserModel;

class AuthService {
  LoginedUserModel? _user;
  String? _token;

  LoginedUserModel? get user => _user;

  String? get token => _token;

  void setUser(LoginedUserModel user) {
    _user = user;
  }

  void setToken(String token) {
    _token = token;
  }

  void logout() {
    _user = null;
  }
}
