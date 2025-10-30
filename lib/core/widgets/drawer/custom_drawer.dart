import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/services/storage_services.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/widgets/drawer/user_info_list_tile.dart';
import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle_app/generated/l10n.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    this.isInProfilePage = false,
  });

  final bool isInProfilePage;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    if (mounted) {
      setState(() {
        isUserLoggedIn = (user != null);
      });
    }
  }

  void logout() async {
    // حذف البيانات
    await StorageServices.clearAll();

    // تسجيل الخروج من Google و Facebook
    GoogleSignIn().signOut();
    FacebookAuth.instance.logOut();

    // الانتقال لصفحة تسجيل الدخول
    if (mounted) {
      GoRouter.of(context).go(EndPoints.signInView);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouter.of(context).routeInformationProvider.value.uri.path;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: MediaQuery.sizeOf(context).width * .75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // ======= المسافة العلوية =======
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.top + 10),
            ),

            // ======= معلومات المستخدم =======
            const SliverToBoxAdapter(child: UserInfoListTile()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // ======= خط فاصل =======
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            // ======= القائمة الرئيسية =======
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildDrawerItem(
                    icon: Icons.home_rounded,
                    title: 'الرئيسية',
                    isActive: currentLocation == EndPoints.homeView,
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).go(EndPoints.homeView);
                    },
                  ),

                  _buildDrawerItem(
                    icon: Icons.person_rounded,
                    title: 'الملف الشخصي',
                    isActive: currentLocation == EndPoints.representativeProfileView ||
                        currentLocation == EndPoints.editProfileView,
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).go(EndPoints.representativeProfileView);
                    },
                  ),

                  if (widget.isInProfilePage)
                    _buildChildDrawerItem(
                      icon: Icons.edit_rounded,
                      title: 'تعديل الملف الشخصي',
                      onTap: () {
                        Navigator.pop(context);
                        GoRouter.of(context).go(EndPoints.editProfileView);
                      },
                    ),

                  _buildDrawerItem(
                    icon: Icons.calendar_today_rounded,
                    title: 'جدول الشحنات',
                    isActive: currentLocation == EndPoints.shipmentsCalendarView,
                    onTap: () {
                      Navigator.pop(context);
                      if (isUserLoggedIn) {
                        GoRouter.of(context).go(EndPoints.shipmentsCalendarView);
                      } else {
                        GoRouter.of(context).go(EndPoints.signInView);
                      }
                    },
                  ),

                  _buildDrawerItem(
                    icon: Icons.calculate_rounded,
                    title: 'حاسبة الشحنات',
                    isActive: currentLocation == EndPoints.calculatorView,
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).go(EndPoints.calculatorView);
                    },
                  ),

                  _buildDrawerItem(
                    icon: Icons.eco_rounded,
                    title: 'الأثر البيئي',
                    isActive: currentLocation == EndPoints.environmentalImpactView,
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).go(EndPoints.environmentalImpactView);
                    },
                  ),

                  _buildDrawerItem(
                    icon: Icons.notifications_rounded,
                    title: 'الإشعارات',
                    isActive: false,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'صفحة الإشعارات قريباً',
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: const Color(0xFF10B981),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),

                  _buildDrawerItem(
                    icon: Icons.support_agent_rounded,
                    title: 'الدعم والمساعدة',
                    isActive: currentLocation == EndPoints.contactUsView,
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).go(EndPoints.contactUsView);
                    },
                  ),
                ],
              ),
            ),

            // ======= الأسفل (الإعدادات + تسجيل الخروج) =======
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const Spacer(),

                  // خط فاصل
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                  ),

                  _buildBottomItem(
                    icon: Icons.settings_rounded,
                    asset: AppAssets.settingsIcon,
                    title: 'الإعدادات',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'صفحة الإعدادات قريباً',
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: const Color(0xFF10B981),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),

                  isUserLoggedIn
                      ? _buildBottomItem(
                    icon: Icons.logout_rounded,
                    asset: AppAssets.logoutIcon,
                    title: 'تسجيل الخروج',
                    isLogout: true,
                    onTap: () {
                      Navigator.pop(context);
                      _showLogoutDialog(context);
                    },
                  )
                      : _buildBottomItem(
                    icon: Icons.login_rounded,
                    asset: AppAssets.loginIcon,
                    title: 'تسجيل الدخول',
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).go(EndPoints.signInView);
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ======= عنصر القائمة =======
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: isActive
            ? const Color(0xFF10B981).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive
                      ? const Color(0xFF10B981)
                      : Colors.grey[600],
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: isActive
                        ? AppStyles.styleBold16(context).copyWith(
                      color: const Color(0xFF10B981),
                    )
                        : AppStyles.styleMedium16(context).copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ======= عنصر فرعي =======
  Widget _buildChildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, top: 4, bottom: 4, left: 12),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: const Color(0xFF10B981),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: AppStyles.styleMedium14(context).copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ======= عنصر الأسفل =======
  Widget _buildBottomItem({
    required IconData icon,
    required String asset,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Image.asset(
                  asset,
                  width: 24,
                  height: 24,
                  color: isLogout ? Colors.red : const Color(0xFF10B981),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: AppStyles.styleMedium16(context).copyWith(
                      color: isLogout ? Colors.red : Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ======= نافذة تأكيد تسجيل الخروج =======
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.all(24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ======= الأيقونة =======
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),

                const SizedBox(height: 20),

                // ======= العنوان =======
                Text(
                  'تسجيل الخروج',
                  style: AppStyles.styleBold20(context),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // ======= الرسالة =======
                Text(
                  'هل أنت متأكد من تسجيل الخروج من حسابك؟',
                  style: AppStyles.styleMedium14(context).copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // ======= الأزرار =======
                Row(
                  children: [
                    // زر الإلغاء
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 50,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                          child: Text(
                            'إلغاء',
                            style: AppStyles.styleSemiBold16(context).copyWith(
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // زر تسجيل الخروج
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            logout();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'تسجيل الخروج',
                            style: AppStyles.styleSemiBold16(context).copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}