import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' hide CustomTransitionPage;
import 'package:supercycle_app/core/helpers/page_transition.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/features/contact_us/presentation/view/contact_us_view.dart';
import 'package:supercycle_app/features/home/presentation/views/home_view.dart';
import 'package:supercycle_app/features/onboarding/presentation/views/first_onboarding_view.dart';
import 'package:supercycle_app/features/onboarding/presentation/views/second_onboarding_view.dart';
import 'package:supercycle_app/features/onboarding/presentation/views/third_onboarding_view.dart';
import 'package:supercycle_app/features/profile/edit_profile/presentation/view/edit_profile_view.dart';
import 'package:supercycle_app/features/profile/presentation/view/profile_view.dart';
import 'package:supercycle_app/features/sales_process/data/models/shipment_model.dart';
import 'package:supercycle_app/features/sales_process/presentation/views/sales_process_view.dart';
import 'package:supercycle_app/features/shipment_details/presentation/views/shipment_details_view.dart';
import 'package:supercycle_app/features/sign_in/presentation/views/sign_in_view.dart';
import 'package:supercycle_app/features/sign_up/presentation/views/sign_up_details_view.dart';
import 'package:supercycle_app/features/sign_up/presentation/views/sign_up_verify_view.dart';
import 'package:supercycle_app/features/sign_up/presentation/views/sign_up_view.dart';
import 'package:supercycle_app/features/splash/views/splash_view.dart';
import 'package:supercycle_app/features/calendar/presentation/view/shipments_calendar_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      // Splash Screen Route - Choose your preferred transition
      GoRoute(
        path: EndPoints.splashView,
        name: 'splash',
        pageBuilder: (context, state) => TransitionHelper.createPage(
          key: state.pageKey,
          child: const SplashView(),
          // Easy to change - just replace with any transition:
          // transition: PageTransitions.elasticScale, // Current: Elastic scale
          // transition: PageTransitions.slideFromBottom,
          // transition: PageTransitions.rotationScale,
          transition: PageTransitions.bounceScale,
          // transition: PageTransitions.doorSwing,
          duration: const Duration(milliseconds: 600),
        ),
      ),

      // First Onboarding Route
      GoRoute(
        path: EndPoints.firstOnboardingView,
        name: 'FirstOnboarding',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const FirstOnboardingView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide transition from right to left
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      ),

      // Second Onboarding Route
      GoRoute(
        path: EndPoints.secondOnboardingView,
        name: 'SecondOnboarding',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SecondOnboardingView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Smooth slide transition
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ),

      // Third Onboarding Route
      GoRoute(
        path: EndPoints.thirdOnboardingView,
        name: 'ThirdOnboarding',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ThirdOnboardingView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Smooth slide transition
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ),

      // Home View Route
      GoRoute(
        path: EndPoints.homeView,
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomeView(), // Replace with your actual home widget
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Scale and fade transition
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),

      // SignIn View Route
      GoRoute(
        path: EndPoints.signInView,
        name: 'SignIn',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignInView(), // Replace with your actual home widget
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Scale and fade transition
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),

      // SignUp View Route
      GoRoute(
        path: EndPoints.signUpView,
        name: 'SignUp',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignUpView(), // Replace with your actual home widget
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Scale and fade transition
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),

      // SignUpVerify View Route
      GoRoute(
        path: EndPoints.signUpVerifyView,
        name: 'SignUpVerify',
        pageBuilder: (context, state) {
          final credential = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            child: SignUpVerifyView(
              credential: credential,
            ), // Replace with your actual home widget
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  // Scale and fade transition
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
            transitionDuration: const Duration(milliseconds: 400),
          );
        },
      ),

      // SignUpDetails View Route
      GoRoute(
        path: EndPoints.signUpDetailsView,
        name: 'SignUpDetails',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child:
              const SignUpDetailsView(), // Replace with your actual home widget
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Scale and fade transition
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),

      // Sales Process View Route
      GoRoute(
        path: EndPoints.salesProcessView,
        name: 'SalesProcess',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child:
              const SalesProcessView(), // Replace with your actual home widget
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Scale and fade transition
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),

      // Shipping Details View Route
      GoRoute(
        path: EndPoints.shippingDetailsView,
        name: 'ShippingDetails',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ShipmentDetailsView(
            shipment: state.extra as ShipmentModel,
          ), // Replace with your actual home widget
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Scale and fade transition
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),
      GoRoute(
        path: EndPoints.shipmentsCalendarView,
        builder: (context, state) => const ShipmentsCalendarView(),
      ),
      GoRoute(
        path: EndPoints.contactUsView,
        builder: (context, state) => const ContactUsView(),
      ),
      GoRoute(
        path: EndPoints.profileView,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: EndPoints.editprofileView,
        builder: (context, state) => const EditProfileView(),
      ),
    ],

    // Custom error page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri.toString()}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(EndPoints.splashView),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
