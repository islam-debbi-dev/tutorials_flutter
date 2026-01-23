import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyDrawer extends StatefulWidget {
  final Widget drawer;
  final Widget child;
  const MyDrawer({super.key, required this.child, required this.drawer});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late AnimationController _xControllerForChild;
  late Animation<double> _XRotationAnimationForChild;

  late AnimationController _xControllerForDrawer;
  late Animation<double> _XRotationAnimationForDrawer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _xControllerForChild = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _XRotationAnimationForChild = Tween<double>(
      begin: 0,
      end: -math.pi / 2.7,
    ).animate(_xControllerForChild);

    _xControllerForDrawer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _XRotationAnimationForDrawer = Tween<double>(
      begin: -math.pi / 2.7,
      end: 0.0,
    ).animate(_xControllerForDrawer);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _xControllerForChild.dispose();
    _xControllerForDrawer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 0.8;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.delta.dx / maxDrag;

        // Dragging to the right
        _xControllerForChild.value += delta;
        _xControllerForDrawer.value += delta;
      },
      onHorizontalDragEnd: (details) {
        if (_xControllerForChild.value >= 0.5) {
          _xControllerForChild.forward();
          _xControllerForDrawer.forward();
        } else {
          _xControllerForChild.reverse();
          _xControllerForDrawer.reverse();
        }
      },
      child: Stack(
        children: [
          Container(color: const Color.fromARGB(255, 24, 18, 18)),

          AnimatedBuilder(
            animation: _XRotationAnimationForChild,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(_xControllerForChild.value * maxDrag)
                  ..rotateY(_XRotationAnimationForChild.value),
                child: widget.child,
              );
            },
          ),
          AnimatedBuilder(
            animation: _XRotationAnimationForDrawer,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                    -screenWidth + _xControllerForDrawer.value * maxDrag,
                  )
                  ..rotateY(_XRotationAnimationForDrawer.value),
                child: widget.drawer,
              );
            },
          ),
        ],
      ),
    );
  }
}
