import 'package:flutter/material.dart';

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
          child: Padding(
            padding: const EdgeInsets.only(left: 100, top: 50),
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Item ${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
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
