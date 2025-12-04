import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:supercycle/core/routes/end_points.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/core/utils/app_assets.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/features/home/data/managers/home_cubit/home_cubit.dart';
import 'package:supercycle/features/home/data/managers/shipments_cubit/today_shipments_cubit.dart';
import 'package:supercycle/features/sign_in/data/models/logined_user_model.dart';

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
    Logger().d("user: $user");
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
    // لو دوست على نفس الـ tab اللي أنت فيه، متعملش حاجة
    if (_currentIndex == index) {
      return;
    }

    setState(() {
      _currentIndex = index;
    });

    if (widget.onTap != null) {
      widget.onTap!(index);
    }

    _navigateToScreen(index);
  }

  void _navigateToScreen(int index) {
    if (!mounted) return;

    final router = GoRouter.of(context);

    try {
      switch (index) {
        case 0:
          router.push(EndPoints.calculatorView);
          break;
        case 1:
          if (isUserLoggedIn) {
            router.push(EndPoints.salesProcessView);
          } else {
            router.push(EndPoints.signInView);
          }
          break;
        case 2:
          router.pushReplacement(EndPoints.homeView);
          break;
        case 3:
          if (isUserLoggedIn) {
            router.push(EndPoints.shipmentsCalendarView);
          } else {
            router.push(EndPoints.signInView);
          }
          break;
        case 4:
          router.push(EndPoints.contactUsView);
          break;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to navigate: ${e.toString()}')),
        );
      }
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
