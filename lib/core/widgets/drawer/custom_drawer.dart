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
    setState(() {
      isUserLoggedIn = (user != null);
    });
  }

  void logout() async {
    await StorageServices.clearAll();
    GoRouter.of(context).push(EndPoints.signInView);
    GoogleSignIn().signOut();
    FacebookAuth.instance.logOut();
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouter.of(context).routeInformationProvider.value.uri.path;
    return Container(
      width: MediaQuery.sizeOf(context).width * .7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.top),
          ),
          const SliverToBoxAdapter(child: UserInfoListTile()),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),

          // القايمة الرئيسية
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildDrawerItem(
                  icon: Icons.home,
                  title: S.of(context).drawer_home ?? 'الصفحة الرئيسية',
                  isActive: currentLocation == EndPoints.homeView,
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).go(EndPoints.homeView);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.person,
                  title: 'الصفحة الشخصية',
                  isActive: currentLocation == EndPoints.representativeProfileView ||
                      currentLocation == EndPoints.editProfileView,
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).push(EndPoints.representativeProfileView);
                  },
                ),
                if (widget.isInProfilePage)
                  _buildChildDrawerItem(
                    icon: Icons.edit,
                    title: 'تعديل الصفحة الشخصية',
                    onTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).go(EndPoints.editProfileView);
                    },
                  ),
                _buildDrawerItem(
                  icon: Icons.calendar_month,
                  title: 'جدول الشحنات',
                  isActive: currentLocation == EndPoints.shipmentsCalendarView,
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).push(EndPoints.shipmentsCalendarView);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.eco,
                  title: 'الأثر البيئي',
                  isActive: currentLocation == EndPoints.environmentalImpactView,
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).push(EndPoints.environmentalImpactView);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.notifications,
                  title: 'الإشعارات',
                  isActive: false,
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('صفحة الإشعارات قريباً'),
                        backgroundColor: Color(0xFF10B981),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.help_outline,
                  title: 'الدعم و المساعدة',
                  isActive: currentLocation == EndPoints.contactUsView,
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).push(EndPoints.contactUsView);
                  },
                ),
              ],
            ),
          ),

          // الأسفل (الإعدادات + تسجيل الخروج)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                _buildBottomItem(
                  icon: Icons.settings,
                  asset: AppAssets.settingsIcon,
                  title: S.of(context).drawer_settings,
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).push(EndPoints.homeView);
                  },
                ),
                isUserLoggedIn
                    ? _buildBottomItem(
                  icon: Icons.logout,
                  asset: AppAssets.logoutIcon,
                  title: S.of(context).drawer_logout,
                  isLogout: true,
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context);
                  },
                )
                    : _buildBottomItem(
                  icon: Icons.login,
                  asset: AppAssets.loginIcon,
                  title: S.of(context).drawer_sign_in,
                  onTap: () => GoRouter.of(context).push(EndPoints.signInView),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: isActive ? const Color(0xFF10B981) : Colors.grey[600],
          size: 24,
        ),
        title: FittedBox(
          alignment: AlignmentDirectional.centerStart,
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: isActive
                ? AppStyles.styleBold16(context)
                : AppStyles.styleMedium16(context),
          ),
        ),
        trailing: isActive
            ? Container(
          width: 3.5,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFF10B981),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        )
            : null,
      ),
    );
  }

  Widget _buildChildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 32.0),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: const Color(0xFF10B981),
          size: 20,
        ),
        title: Text(
          title,
          style: AppStyles.styleMedium14(context).copyWith(
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomItem({
    required IconData icon,
    required String asset,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListTile(
        onTap: onTap,
        leading: Image.asset(
          asset,
          fit: BoxFit.cover,
          width: 30,
          height: 30,
          color: isLogout ? Colors.red : null,
        ),
        title: FittedBox(
          alignment: AlignmentDirectional.centerStart,
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: AppStyles.styleMedium16(context).copyWith(
              color: isLogout ? Colors.red : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'تسجيل الخروج',
            style: AppStyles.styleBold18(context),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'هل أنت متأكد من تسجيل الخروج؟',
            style: AppStyles.styleMedium14(context),
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xFF10B981)),
                      ),
                    ),
                    child: Text(
                      'إلغاء',
                      style: AppStyles.styleSemiBold14(context).copyWith(
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      logout();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'تسجيل الخروج',
                      style: AppStyles.styleSemiBold14(context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
