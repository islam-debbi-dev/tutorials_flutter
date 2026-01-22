import 'package:flutter/material.dart';

class ImplicitAnimationWidget extends StatefulWidget {
  const ImplicitAnimationWidget({super.key});

  @override
  State<ImplicitAnimationWidget> createState() =>
      _ImplicitAnimationWidgetState();
}

class _ImplicitAnimationWidgetState extends State<ImplicitAnimationWidget> {
  var isZoomed = false;
  var isZoomedText = 'zoom in';
  var widthImage = 100.00;
  final _curve = Curves.fastEaseInToSlowEaseOut;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              curve: _curve,
              duration: Duration(seconds: 1),
              width: widthImage,
              color: Colors.blue,
              child: Image.asset(
                'assets/images/images1.png',
                // // make the image fill the container so width changes are visible
                // width: double.infinity,
                // fit: BoxFit.cover,
              ),
            ),
          ],
        ),

        TextButton(
          onPressed: () {
            setState(() {
              if (isZoomed) {
                isZoomed = false;
                isZoomedText = 'zoom in';
                widthImage = 100.00;
              } else {
                isZoomed = true;
                isZoomedText = 'zoom out';
                widthImage = MediaQuery.of(context).size.width;
              }
            });
          },
          child: Text(isZoomedText),
        ),
      ],
    );
  }
}
