abstract class ApiEndpoints {
  static const String login = '/auth/login';
  static const String socialLogin = '/auth/social-login';
  static const String signup = '/auth/signup';
  static const String verifyOtp = '/auth/verify-otp';
  static const String completeSignup = '/auth/complete-profile';
  static const String doshPricesCurrent = '/dosh/prices/current';
  static const String doshPricesHistory = '/dosh/prices/history';
  static const String doshTypesData = '/dosh/types';
  static const String getAllShipments = '/shipments';
  static const String getShipmentById = '/shipments/{id}';
  static const String createShipment = '/shipments';
  static const String updateShipment = '/shipments/{id}';
  static const String cancelShipment = '/shipments/{id}/cancel';
  static const String addNotes = '/shipments/{id}/notes';
  static const String getAllNotes = '/shipments/{id}/notes';
}
