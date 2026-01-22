import 'dart:math';

import 'package:flutter/material.dart';

class FirstAnimationWidget extends StatefulWidget {
  const FirstAnimationWidget({super.key});

  @override
  State<FirstAnimationWidget> createState() => _FirstAnimationWidgetState();
}

class _FirstAnimationWidgetState extends State<FirstAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _counterClockwiseRotationController;
  late Animation<double> _counterClockwiseRotationAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  @override
  void initState() {
    super.initState();

    _counterClockwiseRotationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _counterClockwiseRotationAnimation = Tween<double>(begin: 0, end: -(pi / 2))
        .animate(
          CurvedAnimation(
            parent: _counterClockwiseRotationController,
            curve: Curves.bounceOut,
          ),
        );

    _flipController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.bounceOut),
    );
    _counterClockwiseRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Use the current animation value (radians), not the controller's
        // normalized value (0..1). Recreate the tween so the flip continues
        // from the current rotation value.
        _flipAnimation =
            Tween<double>(
              begin: _flipAnimation.value,
              end: _flipAnimation.value + pi,
            ).animate(
              CurvedAnimation(parent: _flipController, curve: Curves.bounceOut),
            );

        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Continue the rotation from the current animation value (radians).
        _counterClockwiseRotationAnimation =
            Tween<double>(
              begin: _counterClockwiseRotationAnimation.value,
              end: _counterClockwiseRotationAnimation.value + -(pi / 2),
            ).animate(
              CurvedAnimation(
                parent: _counterClockwiseRotationController,
                curve: Curves.bounceOut,
              ),
            );

        _counterClockwiseRotationController
          ..reset()
          ..forward();
      }
    });

    // Start the first animation once after the first frame with a small delay.
    // Avoid starting animations from build() which can be called many times.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        _counterClockwiseRotationController
          ..reset()
          ..forward();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _counterClockwiseRotationController.dispose();
    _flipController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: don't start animations here — starting in build schedules a new
    // delayed start on every rebuild which creates unexpected behavior.
    // Initial start is scheduled once in initState instead.
    return Column(
      children: [
        AnimatedBuilder(
          animation: _counterClockwiseRotationController,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ(_counterClockwiseRotationAnimation.value),
              child: AnimatedBuilder(
                animation: _flipController,
                builder: (context, child) => Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipPath(
                        clipper: HalfCircleClipper(side: CircleSide.left),
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.red,
                        ),
                      ),
                      ClipPath(
                        clipper: HalfCircleClipper(side: CircleSide.right),
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 50),
      ],
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  const HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) {
    return side.toPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;
    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );
    path.close();
    return path;
  }
}
