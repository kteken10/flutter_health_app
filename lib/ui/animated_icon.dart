import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedIconss extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Animation<Color?> colorAnimation;
  final VoidCallback onTap;

  const AnimatedIconss({
    required this.controller,
    required this.scaleAnimation,
    required this.colorAnimation,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return ScaleTransition(
            scale: scaleAnimation,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22,
              child: Icon(
                FontAwesomeIcons.heartPulse,
                color: colorAnimation.value,
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }
}
