import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle/core/helpers/app_transitions.dart';
import 'package:supercycle/core/models/single_shipment_model.dart';
import 'package:supercycle/core/models/user_profile_model.dart';
import 'package:supercycle/core/routes/end_points.dart';
import 'package:supercycle/features/calculator/presentation/view/calculator_view.dart';
import 'package:supercycle/features/contact_us/presentation/view/contact_us_view.dart';
import 'package:supercycle/features/environment/presentation/views/environmental_impact_view.dart';
import 'package:supercycle/features/forget_password/presentation/views/forget_password_view.dart';
import 'package:supercycle/features/forget_password/presentation/views/verify_reset_otp_view.dart';
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
      // Splash Screen Route
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
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, const SignInView()),
      ),

      // SignUp View Route
      GoRoute(
        path: EndPoints.signUpView,
        name: 'SignUp',
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, const SignUpView()),
      ),

      // SignUpVerify View Route
      GoRoute(
        path: EndPoints.signUpVerifyView,
        name: 'SignUpVerify',
        pageBuilder: (context, state) {
          final credential = state.extra as String;
          return AppTransitions.ultraSmooth(
            state.pageKey,
            SignUpVerifyView(credential: credential),
          );
        },
      ),

      // SignUpDetails View Route
      GoRoute(
        path: EndPoints.signUpDetailsView,
        name: 'SignUpDetails',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          const SignUpDetailsView(),
        ),
      ),

      // Sales Process View Route
      GoRoute(
        path: EndPoints.salesProcessView,
        name: 'SalesProcess',
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, const SalesProcessView()),
      ),

      // Trader Shipment Preview View Route
      GoRoute(
        path: EndPoints.traderShipmentPreviewView,
        name: 'TraderShipmentReview',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          TraderShipmentReviewView(
            shipment: state.extra as CreateShipmentModel,
          ),
        ),
      ),

      // Trader Shipment Details View Route
      GoRoute(
        path: EndPoints.traderShipmentDetailsView,
        name: 'TraderShipmentDetails',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          TraderShipmentDetailsView(
            shipment: state.extra as SingleShipmentModel,
          ),
        ),
      ),

      // Shipment Edit View Route
      GoRoute(
        path: EndPoints.shipmentEditView,
        name: 'ShipmentEdit',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          ShipmentEditView(shipment: state.extra as SingleShipmentModel),
        ),
      ),

      // Representative Profile View Route
      GoRoute(
        path: EndPoints.representativeProfileView,
        name: 'Representative Profile',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          RepresentativeProfileView(
            userProfile: state.extra as UserProfileModel,
          ),
        ),
      ),

      // Edit Profile View Route
      GoRoute(
        path: EndPoints.editProfileView,
        name: 'Edit Profile',
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, EditProfileView()),
      ),

      // Shipments Calendar View Route
      GoRoute(
        path: EndPoints.shipmentsCalendarView,
        name: 'Shipments Calendar',
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, ShipmentsCalendarView()),
      ),

      // Contact Us View Route
      GoRoute(
        path: EndPoints.contactUsView,
        name: 'Contact Us',
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, ContactUsView()),
      ),

      // Trader Profile View Route
      GoRoute(
        path: EndPoints.traderProfileView,
        name: 'Trader Profile',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          TraderProfileView(userProfile: state.extra as UserProfileModel),
        ),
      ),

      // Trader Edit Profile View Route
      GoRoute(
        path: EndPoints.editTraderProfileView,
        name: 'Trader Edit Profile',
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, EditProfileView()),
      ),

      // Environmental Impact View Route
      GoRoute(
        path: EndPoints.environmentalImpactView,
        name: 'Environmental Impact',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          EnvironmentalImpactView(),
        ),
      ),

      // Calculator View Route
      GoRoute(
        path: EndPoints.calculatorView,
        name: 'Calculator',
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, CalculatorView()),
      ),

      // Representative Shipment Details View Route
      GoRoute(
        path: EndPoints.representativeShipmentDetailsView,
        name: 'Representative Shipment Details',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          RepresentativeShipmentDetailsView(
            shipment: state.extra as SingleShipmentModel,
          ),
        ),
      ),

      // Representative Shipment Review View Route
      GoRoute(
        path: EndPoints.representativeShipmentReviewView,
        name: 'Representative Shipment Review',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          RepresentativeShipmentReviewView(
            shipment: state.extra as SingleShipmentModel,
          ),
        ),
      ),

      // Representative Shipment Edit View Route
      GoRoute(
        path: EndPoints.representativeShipmentEditView,
        name: 'Representative Shipment Edit',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          RepresentativeShipmentEditView(
            shipment: state.extra as SingleShipmentModel,
          ),
        ),
      ),

      // Forget Password View Route
      GoRoute(
        path: EndPoints.forgetPasswordView,
        name: 'Forget Password',
        pageBuilder: (context, state) =>
            AppTransitions.ultraSmooth(state.pageKey, ForgetPasswordView()),
      ),

      // Verify Reset OTP View Route
      GoRoute(
        path: EndPoints.verifyResetOtpView,
        name: 'Verify Reset OTP',
        pageBuilder: (context, state) => AppTransitions.ultraSmooth(
          state.pageKey,
          VerifyResetOtpView(email: state.extra as String),
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
