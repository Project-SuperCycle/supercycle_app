import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/features/home/presentation/views/home_view.dart';
import 'package:supercycle_app/features/onboarding/presentation/views/first_onboarding_view.dart';
import 'package:supercycle_app/features/onboarding/presentation/views/second_onboarding_view.dart'
    show SecondOnboardingView;
import 'package:supercycle_app/features/onboarding/presentation/views/third_onboarding_view.dart'
    show ThirdOnboardingView;
import 'package:supercycle_app/features/sales_process/presentation/views/sales_process_view.dart';
import 'package:supercycle_app/features/shipping_details/presentation/views/shipping_details_view.dart';
import 'package:supercycle_app/features/sign_in/presentation/views/sign_in_view.dart';
import 'package:supercycle_app/features/sign_up/presentation/views/sign_up_details_view.dart';
import 'package:supercycle_app/features/sign_up/presentation/views/sign_up_verify_view.dart';
import 'package:supercycle_app/features/sign_up/presentation/views/sign_up_view.dart';
import 'package:supercycle_app/features/splash/views/splash_view.dart';
import 'package:supercycle_app/features/calendar/presentation/view/shipments_calendar_view.dart';

abstract class Routes {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: EndPoints.splashView,
        builder: (context, state) => const SplashView(),
      ),

      GoRoute(
        path: EndPoints.firstOnboardingView,
        builder: (context, state) => const FirstOnboardingView(),
      ),
      GoRoute(
        path: EndPoints.secondOnboardingView,
        builder: (context, state) => const SecondOnboardingView(),
      ),
      GoRoute(
        path: EndPoints.thirdOnboardingView,
        builder: (context, state) => const ThirdOnboardingView(),
      ),

      GoRoute(
        path: EndPoints.homeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: EndPoints.signInView,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: EndPoints.signUpView,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: EndPoints.signUpVerifyView,
        builder: (context, state) {
          final String credential = state.extra as String;
          return SignUpVerifyView(credential: credential);
        },
      ),
      GoRoute(
        path: EndPoints.signUpDetailsView,
        builder: (context, state) => const SignUpDetailsView(),
      ),
      GoRoute(
        path: EndPoints.shippingDetailsView,
        builder: (context, state) => const ShippingDetailsView(),
      ),
      GoRoute(
        path: EndPoints.salesProcessView,
        builder: (context, state) => const SalesProcessView(),
      ),
      GoRoute(
        path: EndPoints.shipmentsCalendarView,
        builder: (context, state) => const ShipmentsCalendarView(),
      ),
    ],
  );
}
