import 'package:flutter/material.dart';
import 'package:tutorials_flutter/animations/widgets/first_animation_widget.dart';

import 'widgets/change_colors_animation.dart';
import 'widgets/drawer/my_drawer.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      drawer: Material(
        child: Container(
          color: const Color.fromARGB(255, 17, 32, 45),
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              return ListTile(title: Text('Item ${index + 1}'));
            },
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Animations Screen')),
        body: SafeArea(
          child: Column(
            children: [
              // const FirstAnimationWidget(),
              // SizedBox(height: 50),
              // // const SecondAnimationWidget(),
              // const SizedBox(height: 50),

              // // const ImplicitAnimationWidget(),
              // // const SizedBox(height: 50),
              // const ChangeColorsAnimation(),
            ],
          ),
        ),
      ),
    );
  }
}
