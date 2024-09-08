import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'animated_icon.dart';

class LabSection extends StatelessWidget {
  final VoidCallback onTap;
  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Animation<Color?> colorAnimation;

  const LabSection({
    required this.onTap,
    required this.controller,
    required this.scaleAnimation,
    required this.colorAnimation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Laboratory',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          AnimatedIconss(
            controller: controller,
            scaleAnimation: scaleAnimation,
            colorAnimation: colorAnimation,
            onTap: onTap,
          ),
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22,
                  child: Icon(
                    FontAwesomeIcons.flask,
                    color: Color.fromARGB(255, 132, 177, 254),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
