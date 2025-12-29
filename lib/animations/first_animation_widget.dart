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
        _flipAnimation =
            Tween<double>(
              begin: _flipController.value,
              end: _flipController.value + pi,
            ).animate(
              CurvedAnimation(parent: _flipController, curve: Curves.bounceOut),
            );
        (() {
          _flipController
            ..reset()
            ..forward();
        }).delayed(Duration(milliseconds: 500));
      }
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
    (() {
      _counterClockwiseRotationController
        ..reset()
        ..forward();
    }).delayed(Duration(seconds: 1));
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

extension on VoidCallback {
  Future<void> delayed(Duration delay) {
    return Future.delayed(delay, this);
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
