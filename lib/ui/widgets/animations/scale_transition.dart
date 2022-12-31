import 'package:flutter/material.dart';

class ScalePageTransitionRoute extends PageRouteBuilder {
  final Widget child;

  ScalePageTransitionRoute({
    required this.child,
  }) : super(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      ScaleTransition(
        scale: animation,
        child: child,
      );
}
