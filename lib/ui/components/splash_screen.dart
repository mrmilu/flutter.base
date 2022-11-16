import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> opacity;

  Splash({super.key, required this.controller})
      : opacity = TweenSequence(<TweenSequenceItem<double>>[
          TweenSequenceItem(
            tween: Tween(
              begin: 1.0,
              end: 0.0,
            ),
            weight: 50,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 0.0,
              end: 1.0,
            ),
            weight: 50,
          ),
        ]).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              1.0,
              curve: Curves.ease,
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Opacity(
              opacity: opacity.value,
              child: Image.asset("assets/images/splash.png"),
            );
          },
        ),
      ),
    );
  }
}
