import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' hide CustomTransitionPage;
import 'package:supercycle/core/helpers/app_transitions.dart';
import 'package:supercycle/core/helpers/page_transition.dart';
import 'package:supercycle/core/models/single_shipment_model.dart';
import 'package:supercycle/core/models/user_profile_model.dart';
import 'package:supercycle/core/routes/end_points.dart';
import 'package:supercycle/features/calculator/presentation/view/calculator_view.dart';
import 'package:supercycle/features/contact_us/presentation/view/contact_us_view.dart';
import 'package:supercycle/features/environment/presentation/views/environmental_impact_view.dart';
import 'package:supercycle/features/home/presentation/views/home_view.dart';
import 'package:supercycle/features/onboarding/presentation/views/first_onboarding_view.dart';
import 'package:supercycle/features/onboarding/presentation/views/fourth_onboarding_view.dart';
import 'package:supercycle/features/onboarding/presentation/views/second_onboarding_view.dart';
import 'package:supercycle/features/onboarding/presentation/views/third_onboarding_view.dart';
import 'package:supercycle/features/edit_profile/presentation/view/edit_profile_view.dart';
import 'package:supercycle/features/representative_main_profile/presentation/view/representative_profile_view.dart';
import 'package:supercycle/features/representative_shipment_details/presentation/views/representative_shipment_details_view.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/views/representative_shipment_edit_view.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/views/representative_shipment_review_view.dart';
import 'package:supercycle/features/sales_process/data/models/create_shipment_model.dart';
import 'package:supercycle/features/sales_process/presentation/views/sales_process_view.dart';
import 'package:supercycle/features/shipment_edit/presentation/views/shipment_edit_view.dart';
import 'package:supercycle/features/sign_in/presentation/views/sign_in_view.dart';
import 'package:supercycle/features/sign_up/presentation/views/sign_up_details_view.dart';
import 'package:supercycle/features/sign_up/presentation/views/sign_up_verify_view.dart';
import 'package:supercycle/features/sign_up/presentation/views/sign_up_view.dart';
import 'package:supercycle/features/splash/views/splash_view.dart';
import 'package:supercycle/features/shipments_calendar/presentation/view/shipments_calendar_view.dart';
import 'package:supercycle/features/trader_main_profile/presentation/view/trader_profile_view.dart';
import 'package:supercycle/features/trader_shipment_details/presentation/views/trader_shipment_details_view.dart';
import 'package:supercycle/features/trader_shipment_preview/presentation/views/trader_shipment_review_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: EndPoints.splashView,
    routes: [
      // Splash Screen Route - Choose your preferred transition
      GoRoute(
        path: EndPoints.splashView,
        name: 'splash',
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, const SplashView()),
      ),

      // First Onboarding Route
      GoRoute(
        path: EndPoints.firstOnboardingView,
        name: 'FirstOnboarding',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          const FirstOnboardingView(),
        ),
      ),

      // Second Onboarding Route
      GoRoute(
        path: EndPoints.secondOnboardingView,
        name: 'SecondOnboarding',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          const SecondOnboardingView(),
        ),
      ),

      // Third Onboarding Route
      GoRoute(
        path: EndPoints.thirdOnboardingView,
        name: 'ThirdOnboarding',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          const ThirdOnboardingView(),
        ),
      ),

      // Fourth Onboarding Route
      GoRoute(
        path: EndPoints.fourthOnboardingView,
        name: 'FourthOnboarding',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          const FourthOnboardingView(),
        ),
      ),

      // Home View Route
      GoRoute(
        path: EndPoints.homeView,
        name: 'Home',
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, const HomeView()),
      ),

      // SignIn View Route
      GoRoute(
        path: EndPoints.signInView,
        name: 'SignIn',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignInView(),
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

      //Trader Shipment Preview View Route
      GoRoute(
        path: EndPoints.traderShipmentPreviewView,
        name: 'TraderShipmentReview',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: TraderShipmentReviewView(
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
      // Trader Shipment Details View Route
      GoRoute(
        path: EndPoints.traderShipmentDetailsView,
        name: 'TraderShipmentDetails',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: TraderShipmentDetailsView(
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
          child: RepresentativeProfileView(
            userProfile: state.extra as UserProfileModel,
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

      // Edit Profile View Route
      GoRoute(
        path: EndPoints.editProfileView,
        name: 'Edit Profile',
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
          child: TraderProfileView(
            userProfile: state.extra as UserProfileModel,
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

      //Trader Edit Profile View Route
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

      // Representative Shipment Details View Route
      GoRoute(
        path: EndPoints.representativeShipmentDetailsView,
        name: 'Representative Shipment Details',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: RepresentativeShipmentDetailsView(
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

      // Representative Shipment Review View Route
      GoRoute(
        path: EndPoints.representativeShipmentReviewView,
        name: 'Representative Shipment Review ',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: RepresentativeShipmentReviewView(
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

      // Representative Shipment Edit View Route
      GoRoute(
        path: EndPoints.representativeShipmentEditView,
        name: 'Representative Shipment Edit ',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: RepresentativeShipmentEditView(
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
