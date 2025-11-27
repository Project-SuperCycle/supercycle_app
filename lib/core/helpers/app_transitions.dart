import 'package:flutter/material.dart';

import 'page_transition.dart';

// app_transitions.dart
class AppTransitions {
  // Android Style - Extra Smooth
  static CustomTransitionPage material(
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
          curve: Curves.easeOutCubic, // أسلس من fastOutSlowIn
        );

        // Fade خفيف للنعومة
        var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

        // الصفحة القديمة
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

  // iOS Style - Extra Smooth
  static CustomTransitionPage cupertino(
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
          curve: Curves.easeOutCubic, // أسلس
          reverseCurve: Curves.easeInCubic,
        );

        // Fade خفيف جداً
        var fadeTween = Tween<double>(begin: 0.85, end: 1.0);

        // الصفحة القديمة
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

  // Ultra Smooth (الأسلس)
  static CustomTransitionPage ultraSmooth(
    LocalKey key,
    Widget child, {
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.5, 0.0); // حركة أقل = أنعم
        const end = Offset.zero;

        var slideTween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutQuart, // الأنعم
        );

        var fadeTween = Tween<double>(begin: 0.0, end: 1.0);
        var scaleTween = Tween<double>(begin: 0.95, end: 1.0); // scale خفيف

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
}
