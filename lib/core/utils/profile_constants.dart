
// Constants for profile view
import 'package:supercycle_app/features/profile/presentation/widgets/profile_data.dart';

class ProfileConstants {
  // UI Constants
  static const double headerHeight = 0.28;
  static const double profileImageSize = 100;
  static const double borderRadius = 50;
  static const double cardBorderRadius = 20;
  static const double spacing = 16;

  // Sample data - in real app, this would come from state management or API
  static const ProfileData sampleProfileData = ProfileData(
    name: "Carrefour",
    activityType: "متجر تجاري",
    address: "التجمع الخامس شارع النار",
    responsiblePerson: "محمد احمد",
    phoneNumber: "+234 808 2344 6675",
    email: "carrefour1123@gmail.com",
    requiredProducts: 3,
    availableProducts: 43,
    branchCount: 6,
    logoPath: 'assets/images/carrefour_logo.png',
  );
}