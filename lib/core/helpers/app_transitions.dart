import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// تحويلات التطبيق باستخدام Material Design Transitions
class AppTransitions {
  /// Fade Through Transition - Material Design
  /// الانتقال المثالي بين الصفحات غير المرتبطة
  static Page<dynamic> fadeThrough(
    LocalKey key,
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          fillColor: Colors.white,
          child: child, // لون الخلفية أثناء الانتقال
        );
      },
      transitionDuration: duration,
    );
  }

  /// Shared Axis Transition - Horizontal
  /// للانتقال بين صفحات في نفس المستوى
  static Page<dynamic> sharedAxisHorizontal(
    LocalKey key,
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: Colors.white,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Shared Axis Transition - Vertical
  /// للانتقال بين صفحات في تسلسل عمودي
  static Page<dynamic> sharedAxisVertical(
    LocalKey key,
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          fillColor: Colors.white,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Shared Axis Transition - Scaled
  /// للانتقال مع تأثير zoom
  static Page<dynamic> sharedAxisScaled(
    LocalKey key,
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.scaled,
          fillColor: Colors.white,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Fade Scale Transition
  /// للـ dialogs والـ pop-ups
  static Page<dynamic> fadeScale(
    LocalKey key,
    Widget child, {
    Duration duration = const Duration(milliseconds: 250),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
      transitionDuration: duration,
    );
  }

  /// Ultra Smooth - النسخة المحسّنة (بدون animations package)
  /// للاستخدام إذا كنت تريد transition مخصص
  static Page<dynamic> ultraSmooth(
    LocalKey key,
    Widget child, {
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.5, 0.0);
        const end = Offset.zero;

        var slideTween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutQuart,
        );

        var fadeTween = Tween<double>(begin: 0.0, end: 1.0);
        var scaleTween = Tween<double>(begin: 0.95, end: 1.0);

        return SlideTransition(
          position: slideTween.animate(curvedAnimation),
          child: FadeTransition(
            opacity: fadeTween.animate(curvedAnimation),
            child: ScaleTransition(
              scale: scaleTween.animate(curvedAnimation),
              child: child,
            ),
          ),
        );
      },
      transitionDuration: duration,
    );
  }

  /// Material Style - Android
  static Page<dynamic> material(
    LocalKey key,
    Widget child, {
    Duration duration = const Duration(milliseconds: 350),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;

        var slideTween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );

        var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

        var secondarySlide =
            Tween(begin: Offset.zero, end: const Offset(-0.3, 0.0)).animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: Curves.easeOutCubic,
              ),
            );

        return SlideTransition(
          position: slideTween.animate(curvedAnimation),
          child: FadeTransition(
            opacity: fadeTween.animate(curvedAnimation),
            child: SlideTransition(position: secondarySlide, child: child),
          ),
        );
      },
      transitionDuration: duration,
    );
  }

  /// Cupertino Style - iOS
  static Page<dynamic> cupertino(
    LocalKey key,
    Widget child, {
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;

        var slideTween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        var fadeTween = Tween<double>(begin: 0.85, end: 1.0);

        var secondarySlide =
            Tween(begin: Offset.zero, end: const Offset(-0.35, 0.0)).animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: Curves.easeOutCubic,
              ),
            );

        return SlideTransition(
          position: slideTween.animate(curvedAnimation),
          child: FadeTransition(
            opacity: fadeTween.animate(curvedAnimation),
            child: SlideTransition(position: secondarySlide, child: child),
          ),
        );
      },
      transitionDuration: duration,
    );
  }
}
