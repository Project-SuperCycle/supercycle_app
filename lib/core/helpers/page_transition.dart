import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Custom page transitions library for smooth navigation animations
class PageTransitions {

  /// 1. Scale Transition - Zoom in/out effect
  static Widget scaleTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      )),
      child: child,
    );
  }

  /// 2. Slide from Right
  static Widget slideFromRight(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: child,
    );
  }

  /// 3. Slide from Bottom
  static Widget slideFromBottom(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: child,
    );
  }

  /// 4. Slide from Top
  static Widget slideFromTop(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: child,
    );
  }

  /// 5. Rotation + Scale
  static Widget rotationScale(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return Transform.rotate(
      angle: (1 - animation.value) * 0.3,
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0.7,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        )),
        child: child,
      ),
    );
  }

  /// 6. Size Transition (expand from center)
  static Widget sizeTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return Align(
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animation,
          curve: Curves.elasticOut,
        ),
        child: child,
      ),
    );
  }

  /// 7. 3D Flip Transition
  static Widget flipTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final rotateAnim = Tween<double>(
          begin: math.pi,
          end: 0.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ));

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(rotateAnim.value),
          child: child,
        );
      },
      child: child,
    );
  }

  /// 8. Elastic Scale
  static Widget elasticScale(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.5,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.elasticOut,
      )),
      child: child,
    );
  }

  /// 9. Blur Transition
  static Widget blurTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final blur = Tween<double>(
          begin: 10.0,
          end: 0.0,
        ).animate(animation);

        return ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: blur.value,
            sigmaY: blur.value,
          ),
          child: child,
        );
      },
      child: child,
    );
  }

  /// 10. Diagonal Slide
  static Widget diagonalSlide(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, -1.0), // From top-right
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutQuart,
      )),
      child: child,
    );
  }

  /// 11. Bounce Scale
  static Widget bounceScale(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.bounceOut,
      )),
      child: child,
    );
  }

  /// 12. Curved Slide with Fade
  static Widget curvedSlideFade(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.3, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCirc,
      )),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  /// 13. Door Swing
  static Widget doorSwing(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final rotateAnim = Tween<double>(
          begin: -math.pi / 2,
          end: 0.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        ));

        return Transform(
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(rotateAnim.value),
          child: child,
        );
      },
      child: child,
    );
  }

  /// 14. Zoom Rotation
  static Widget zoomRotation(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: Transform.rotate(
            angle: (1 - animation.value) * 2 * math.pi,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  /// 15. Curtain Effect
  static Widget curtainEffect(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Align(
            alignment: Alignment.topCenter,
            widthFactor: 1.0,
            heightFactor: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

// Easy way to use these transitions in your GoRouter
class TransitionHelper {
  /// Creates a CustomTransitionPage with the specified transition
  static CustomTransitionPage<T> createPage<T>({
    required LocalKey key,
    required Widget child,
    required Widget Function(BuildContext, Animation<double>, Animation<double>, Widget) transition,
    Duration? duration,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionsBuilder: transition,
      transitionDuration: duration ?? const Duration(milliseconds: 500),
    );
  }
}

// Custom transition page class for more control
class CustomTransitionPage<T> extends Page<T> {
  const CustomTransitionPage({
    required this.child,
    required this.transitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final Duration transitionDuration;
  final Duration? reverseTransitionDuration;
  final Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) transitionsBuilder;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: transitionsBuilder,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration ?? transitionDuration,
    );
  }
}

// Add the import for ImageFilter
