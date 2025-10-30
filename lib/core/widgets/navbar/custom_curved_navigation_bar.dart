import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/services/storage_services.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart';

class CustomCurvedNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onTap;
  final GlobalKey<CurvedNavigationBarState>? navigationKey;

  const CustomCurvedNavigationBar({
    super.key,
    this.currentIndex = 2,
    this.onTap,
    this.navigationKey,
  });

  @override
  State<CustomCurvedNavigationBar> createState() =>
      _CustomCurvedNavigationBarState();
}

class _CustomCurvedNavigationBarState extends State<CustomCurvedNavigationBar> {
  late int _currentIndex;
  bool isUserLoggedIn = true;

  void getUser() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    Logger().w("user: $user");
    if (mounted) {
      setState(() {
        isUserLoggedIn = (user != null);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    _currentIndex = widget.currentIndex;
  }

  void _handleTap(int index) {
    Logger().d("🔵 TAP: index=$index, current=$_currentIndex");

    if (!mounted) return;

    setState(() {
      _currentIndex = index;
    });

    if (widget.onTap != null) {
      widget.onTap!(index);
    }

    // ✅ استخدم Future.microtask لضمان تنفيذ النافجيشن بعد البناء
    Future.microtask(() {
      if (mounted) {
        _navigateToScreen(index);
      }
    });
  }

  void _navigateToScreen(int index) {
    if (!mounted) return;

    Logger().d("🚀 NAVIGATE: index=$index");

    // ✅ احصل على الـ router من context
    final router = GoRouter.of(context);

    try {
      switch (index) {
        case 0:
          Logger().d("➡️ Going to Calculator");
          router.go(EndPoints.calculatorView);
          break;
        case 1:
          Logger().d("➡️ Going to Sales/SignIn");
          if (isUserLoggedIn) {
            router.go(EndPoints.salesProcessView);
          } else {
            router.go(EndPoints.signInView);
          }
          break;
        case 2:
          Logger().d("➡️ Going to Home");
          router.go(EndPoints.homeView);
          break;
        case 3:
          Logger().d("➡️ Going to Calendar/SignIn");
          if (isUserLoggedIn) {
            router.go(EndPoints.shipmentsCalendarView);
          } else {
            router.go(EndPoints.signInView);
          }
          break;
        case 4:
          Logger().d("➡️ Going to Contact");
          router.go(EndPoints.contactUsView);
          break;
      }
      Logger().d("✅ Navigation command executed");
    } catch (e) {
      Logger().e("❌ Navigation error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: _currentIndex,
      key: widget.navigationKey,
      color: Colors.white,
      backgroundColor: AppColors.primaryColor,
      height: 60,
      items: <Widget>[
        _buildNavigationItem(asset: AppAssets.calculatorIcon, isSvg: true),
        _buildNavigationItem(asset: AppAssets.boxIcon, isSvg: true),
        _buildNavigationItem(
          asset: AppAssets.homeIcon,
          isSvg: false,
          height: 30,
        ),
        _buildNavigationItem(asset: AppAssets.calendarIcon, isSvg: true),
        _buildNavigationItem(asset: AppAssets.chatIcon, isSvg: true),
      ],
      onTap: _handleTap,
    );
  }

  Widget _buildNavigationItem({
    required String asset,
    required bool isSvg,
    double? height,
  }) {
    if (isSvg) {
      return SvgPicture.asset(asset, fit: BoxFit.cover, height: height);
    } else {
      return Image.asset(asset, height: height ?? 24, fit: BoxFit.cover);
    }
  }
}