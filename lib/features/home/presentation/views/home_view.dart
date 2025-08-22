import 'package:curved_navigation_bar/curved_navigation_bar.dart'
    show CurvedNavigationBarState, CurvedNavigationBar;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:supercycle_app/core/utils/app_assets.dart' show AppAssets;
import 'package:supercycle_app/core/utils/app_colors.dart' show AppColors;
import 'package:supercycle_app/features/home/presentation/widgets/home_view_body.dart'
    show HomeViewBody;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const HomeViewBody(),
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        key: _bottomNavigationKey,
        color: Colors.white,
        backgroundColor: AppColors.primaryColor,
        height: 60,
        items: <Widget>[
          SvgPicture.asset(AppAssets.calculatorIcon, fit: BoxFit.cover),
          SvgPicture.asset(AppAssets.boxIcon, fit: BoxFit.cover),
          Image.asset(AppAssets.homeIcon, height: 30, fit: BoxFit.cover),
          SvgPicture.asset(AppAssets.calendarIcon, fit: BoxFit.cover),
          SvgPicture.asset(AppAssets.chatIcon, fit: BoxFit.cover),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
