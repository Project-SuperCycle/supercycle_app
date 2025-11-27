import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle/core/routes/end_points.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/core/utils/app_assets.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/features/sign_in/data/models/logined_user_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  LoginedUserModel? user;

  @override
  void initState() {
    super.initState();
    getUserData();
    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Create fade animation (opacity: 0.0 to 1.0)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    // Create scale animation (scale: 0.5 to 1.0)
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    // Start animation
    _animationController.forward();

    // Navigate to onboard screen after animation completes (3000ms total)
    Future.delayed(const Duration(milliseconds: 5000), () {
      (user == null && mounted)
          ? GoRouter.of(context).pushReplacement(EndPoints.firstOnboardingView)
          : GoRouter.of(context).go(EndPoints.homeView);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void getUserData() async {
    user = await StorageServices.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "أهلا بيك",
              style: AppStyles.styleBold24(
                context,
              ).copyWith(fontSize: 36, color: AppColors.primaryColor),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: screenSize.width * 0.8,
                      height: screenSize.width * 0.8,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.logo),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Text(
              "حوّل الكرتون المستهلك لفلوس",
              style: AppStyles.styleMedium18(
                context,
              ).copyWith(color: AppColors.primaryColor),
            ),
            SizedBox(height: 8),
            Text(
              "بطريقة سهلة وآمنة",
              style: AppStyles.styleMedium18(
                context,
              ).copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
