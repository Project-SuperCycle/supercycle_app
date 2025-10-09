import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' hide CustomTransitionPage;
import 'package:supercycle_app/core/helpers/page_transition.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/features/calculator/presentation/view/calculator_view.dart';
import 'package:supercycle_app/features/contact_us/presentation/view/contact_us_view.dart';
import 'package:supercycle_app/features/environment/presentation/views/environmental_impact_view.dart';
import 'package:supercycle_app/features/home/presentation/views/home_view.dart';
import 'package:supercycle_app/features/onboarding/presentation/views/first_onboarding_view.dart';
import 'package:supercycle_app/features/onboarding/presentation/views/fourth_onboarding_view.dart';
import 'package:supercycle_app/features/onboarding/presentation/views/second_onboarding_view.dart';
import 'package:supercycle_app/features/onboarding/presentation/views/third_onboarding_view.dart';
import 'package:supercycle_app/features/edit_profile/presentation/view/edit_profile_view.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/view/representative_profile_view.dart';
import 'package:supercycle_app/features/sales_process/data/models/create_shipment_model.dart';
import 'package:supercycle_app/features/sales_process/presentation/views/sales_process_view.dart';
import 'package:supercycle_app/features/shipment_details/data/models/single_shipment_model.dart';
import 'package:supercycle_app/features/shipment_details/presentation/views/shipment_details_view.dart';
import 'package:supercycle_app/features/shipment_edit/presentation/views/shipment_edit_view.dart';
import 'package:supercycle_app/features/shipment_preview/presentation/views/shipment_review_view.dart';
import 'package:supercycle_app/features/sign_in/presentation/views/sign_in_view.dart';
import 'package:supercycle_app/features/sign_up/presentation/views/sign_up_details_view.dart';
import 'package:supercycle_app/features/sign_up/presentation/views/sign_up_verify_view.dart';
import 'package:supercycle_app/features/sign_up/presentation/views/sign_up_view.dart';
import 'package:supercycle_app/features/splash/views/splash_view.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/view/shipments_calendar_view.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/view/trader_profile_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: EndPoints.homeView,
    routes: [
      // Splash Screen Route - Choose your preferred transition
      GoRoute(
        path: EndPoints.splashView,
        name: 'splash',
        pageBuilder: (context, state) => TransitionHelper.createPage(
          key: state.pageKey,
          child: const SplashView(),
          transition: PageTransitions.bounceScale,
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

      // Fourth Onboarding Route
      GoRoute(
        path: EndPoints.fourthOnboardingView,
        name: 'FourthOnboarding',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const FourthOnboardingView(),
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

      // Home View Route
      GoRoute(
        path: EndPoints.homeView,
        name: 'Home',
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

      // Shipment Preview View Route
      GoRoute(
        path: EndPoints.shipmentPreviewView,
        name: 'ShipmentPreview',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ShipmentReviewView(
            shipment: state.extra as CreateShipmentModel,
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
      // Shipment Details View Route
      GoRoute(
        path: EndPoints.shipmentDetailsView,
        name: 'ShipmentDetails',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ShipmentDetailsView(
            shipment: state.extra as SingleShipmentModel,
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

      // Shipment Edit View Route
      GoRoute(
        path: EndPoints.shipmentEditView,
        name: 'ShipmentEdit',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ShipmentEditView(
            shipment: state.extra as SingleShipmentModel,
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

      // Representative Profile View Route
      GoRoute(
        path: EndPoints.representativeProfileView,
        name: 'Representative Profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          child:
              RepresentativeProfileView(), // Replace with your actual home widget
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

      // Shipments Calender View Route
      GoRoute(
        path: EndPoints.shipmentsCalendarView,
        name: 'Shipments Calendar',
        pageBuilder: (context, state) => CustomTransitionPage(
          child:
              ShipmentsCalendarView(), // Replace with your actual home widget
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

      // Contact Us View Route
      GoRoute(
        path: EndPoints.contactUsView,
        name: 'Contact Us',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: ContactUsView(), // Replace with your actual home widget
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

      // Trader Profile View Route
      GoRoute(
        path: EndPoints.traderProfileView,
        name: 'Trader Profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: TraderProfileView(), // Replace with your actual home widget
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

      // Trader Edit Profile View Route
      GoRoute(
        path: EndPoints.editTraderProfileView,
        name: 'Trader Edit Profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: EditProfileView(), // Replace with your actual home widget
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

      // Environmental Impact View Route
      GoRoute(
        path: EndPoints.environmentalImpactView,
        name: 'Environmental Impact',
        pageBuilder: (context, state) => CustomTransitionPage(
          child:
              EnvironmentalImpactView(), // Replace with your actual home widget
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

      // Calculator View Route
      GoRoute(
        path: EndPoints.calculatorView,
        name: 'Calculator',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: CalculatorView(), // Replace with your actual home widget
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
