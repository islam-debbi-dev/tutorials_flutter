import 'package:flutter/material.dart';

class ScalingAnimation extends StatefulWidget {
  const ScalingAnimation({super.key});

  @override
  State<ScalingAnimation> createState() => _ScalingAnimationState();
}

class _ScalingAnimationState extends State<ScalingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationIcon;
  late Animation<double> _animationContainer;
  late Animation<Offset> _animationOffset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animationIcon = Tween<double>(
      begin: 7,
      end: 6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _animationContainer = Tween<double>(
      begin: 2,
      end: 0.4,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _animationOffset = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.23),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..reset()
      ..forward();
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 100,
        maxHeight: 600,
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 150),

                    Text(
                      'Scaling Animation',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'An animation that scales an icon and a container simultaneously.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
              Positioned.fill(
                child: RepaintBoundary(
                  child: SlideTransition(
                    position: _animationOffset,
                    child: ScaleTransition(
                      scale: _animationContainer,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: Center(
                          child: ScaleTransition(
                            scale: _animationIcon,
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
