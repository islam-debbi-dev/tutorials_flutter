import 'package:flutter/material.dart';
import 'package:tutorials_flutter/animations/widgets/first_animation_widget.dart';

import 'widgets/change_colors_animation.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const FirstAnimationWidget(),
            SizedBox(height: 50),
            // const SecondAnimationWidget(),
            const SizedBox(height: 50),

            // const ImplicitAnimationWidget(),
            // const SizedBox(height: 50),
            const ChangeColorsAnimation(),
          ],
        ),
      ),
    );
  }
}
