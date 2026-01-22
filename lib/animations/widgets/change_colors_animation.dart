import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChangeColorsAnimation extends StatefulWidget {
  const ChangeColorsAnimation({super.key});

  @override
  State<ChangeColorsAnimation> createState() => _ChangeColorsAnimationState();
}

class _ChangeColorsAnimationState extends State<ChangeColorsAnimation>
    with SingleTickerProviderStateMixin {
  Color getRendomColor() =>
      Color((0xFF000000 + (math.Random().nextInt(0x00FFFFFF))));

  @override
  Widget build(BuildContext context) {
    var colorC = getRendomColor();
    return ClipPath(
      clipper: const CircleCliper(),
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 1),

        tween: ColorTween(begin: getRendomColor(), end: colorC),
        onEnd: () => setState(() {
          colorC = getRendomColor();
        }),
        builder: (context, Color? color, child) {
          return Container(
            color: color,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
          );
        },
      ),
    );
  }
}

class CircleCliper extends CustomClipper<Path> {
  const CircleCliper();
  @override
  Path getClip(Size size) {
    Path path = Path();

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
