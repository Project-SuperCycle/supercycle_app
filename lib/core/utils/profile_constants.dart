// Constants for profile view
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/features/representative_main_profile/data/models/representative_profile_data.dart';
import 'package:supercycle_app/features/trader_main_profile/data/models/trader_profile_data.dart';

class ProfileConstants {
  // UI Constants
  static const double headerHeight = 0.28;
  static const double profileImageSize = 100;
  static const double borderRadius = 50;
  static const double cardBorderRadius = 20;
  static const double spacing = 16;

  // Sample data - in real app, this would come from state management or API
  static final TraderProfileData sampleProfileData = TraderProfileData(
    name: "Carrefour",
    activityType: "متجر تجاري",
    address: "التجمع الخامس شارع النار",
    responsiblePerson: "محمد احمد",
    phoneNumber: "+234 808 2344 6675",
    email: "carrefour1123@gmail.com",
    requiredProducts: 3,
    availableProducts: 43,
    logoPath: 'assets/images/carrefour_logo.png',
    // البيانات الجديدة
    branches: [
      BranchModel(
        name: "فرع التجمع الخامس",
        address: "التجمع الخامس، شارع التسعين الجنوبي",
        managerName: "محمد أحمد",
        managerPhone: "+201012345678",
        deliveryVolume: 1500,
      ),
      BranchModel(
        name: "فرع مدينة نصر",
        address: "مدينة نصر، شارع عباس العقاد",
        managerName: "أحمد علي",
        managerPhone: "+201123456789",
        deliveryVolume: 2300,
      ),
      BranchModel(
        name: "فرع المعادي",
        address: "المعادي، شارع 9",
        managerName: "خالد حسن",
        managerPhone: "+201234567890",
        deliveryVolume: 1800,
      ),
      BranchModel(
        name: "فرع الزمالك",
        address: "الزمالك، شارع 26 يوليو",
        managerName: "محمود سعيد",
        managerPhone: "+201098765432",
        deliveryVolume: 2100,
      ),
      BranchModel(
        name: "فرع الشروق",
        address: "مدينة الشروق، المنطقة السكنية الأولى",
        managerName: "عمر فاروق",
        managerPhone: "+201087654321",
        deliveryVolume: 1200,
      ),
      BranchModel(
        name: "فرع 6 أكتوبر",
        address: "6 أكتوبر، المحور المركزي",
        managerName: "يوسف إبراهيم",
        managerPhone: "+201076543210",
        deliveryVolume: 1900,
      ),
    ],
    recyclableTypes: [
      "كرتون بني",
      "ورق أبيض",
      "ورق وش و وش",
      "ورق كوشية",
      "ورق برستول",
      "ورق 4A",
    ],
  );

  static RepresentativeProfileData sampleRepresentativeData =
  RepresentativeProfileData(
    name: "إسلام شاكر",
    phoneNumber: "+201095767137",
    email: "islamelzantot@gmail.com",
    totalShipments: 20,
    weeklyShipments: 5,
    logoPath: AppAssets.defaultAvatar,
  );
}