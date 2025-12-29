import 'package:flutter/material.dart';
import 'package:tutorials_flutter/animations/first_animation_widget.dart';
import 'package:tutorials_flutter/animations/second_animation_widget.dart';

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
            const SecondAnimationWidget(),
          ],
        ),
      ),
    );
  }
}
