import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({
    super.key,
    required this.profileName,
    required this.profileImage,
    required this.isTrader,
  });

  final String profileName;
  final String profileImage;
  final bool isTrader;

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
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
          SliverToBoxAdapter(
            child: _buildUserInfoTile(),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 10)),
          _buildDrawerItemsList(),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                _buildInActiveItem(
                  icon: Icons.settings,
                  title: 'الإعدادات',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('صفحة الإعدادات قريباً'),
                        backgroundColor: Color(0xFF10B981),
                      ),
                    );
                  },
                ),
                _buildInActiveItem(
                  icon: Icons.logout,
                  title: 'تسجيل الخروج',
                  isLogout: true,
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context);
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF10B981), width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                widget.profileImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    widget.isTrader ? Icons.store : Icons.person,
                    size: 30,
                    color: const Color(0xFF10B981),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.profileName,
                  style: AppStyles.styleBold16(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.isTrader ? 'تاجر' : 'مندوب',
                  style: AppStyles.styleMedium12(context).copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItemsList() {
    final items = [
      {
        'icon': Icons.edit,
        'title': 'تعديل البروفايل',
        'onTap': () {
          Navigator.pop(context);
          if (widget.isTrader) {
            GoRouter.of(context).go(EndPoints.editTraderProfileView);
          } else {
            GoRouter.of(context).go(EndPoints.editRepresentativeProfileView);
          }
        },
      },
      {
        'icon': Icons.notifications,
        'title': 'الإشعارات',
        'onTap': () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('صفحة الإشعارات قريباً'),
              backgroundColor: Color(0xFF10B981),
            ),
          );
        },
      },
      {
        'icon': Icons.eco,
        'title': 'أثرك البيئي',
        'onTap': () {
          GoRouter.of(context).push(EndPoints.environmentalImpactView);
        },

      },
      {
        'icon': Icons.help_outline,
        'title': 'المساعدة والدعم',
        'onTap': () {
          GoRouter.of(context).push(EndPoints.contactUsView);
        },
      },
    ];

    return SliverList.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (activeIndex != index) {
              setState(() {
                activeIndex = index;
              });
            }
            items[index]['onTap'] as VoidCallback;
          },
          child: _buildDrawerItem(
            icon: items[index]['icon'] as IconData,
            title: items[index]['title'] as String,
            isActive: activeIndex == index,
            onTap: items[index]['onTap'] as VoidCallback,
          ),
        );
      },
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
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
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
      ),
    );
  }

  Widget _buildInActiveItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            icon,
            color: isLogout ? Colors.red : Colors.grey[600],
            size: 24,
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                      GoRouter.of(context).go(EndPoints.homeView);
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