import 'package:flutter/material.dart';

class TransitionUtils {
  static Future<void> navigateWithFadeTransition(BuildContext context, Widget destination) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return destination;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 5.0;
          const curve = Curves.fastLinearToSlowEaseIn;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var fadeAnimation = animation.drive(tween);
          return FadeTransition(opacity: fadeAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 4000),
      ),
    );
  }
}
