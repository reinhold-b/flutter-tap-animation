import 'dart:math';

import 'package:flutter/material.dart';

class Tap extends StatefulWidget {
  const Tap({
    Key? key,
    required this.child,
    this.tapWeight = 0,
  }) : super(key: key);

  /// the child on which to apply the tap animation
  final Widget child;

  /// Influences the speed with which the child is "pressed down".
  /// Also: 0 is a "light" press, 1 the maximum press weight.
  /// Defaults to 0
  final double tapWeight;

  @override
  _TapState createState() => _TapState();
}

class _TapState extends State<Tap> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  /// Used to normalize user input, as [tapWeight] can only be in the range of
  /// 0 and 1.
  double normalize(double x) {
    if (x > 1) {
      return 1;
    } else if (x < 0) {
      return 0;
    }
    return x;
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200 - (100 * normalize(widget.tapWeight)).round(),
      ),
      lowerBound: 0,
      upperBound: 0.5 * pi,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void tapDown(PointerDownEvent event) async {
    await controller.animateTo(0.5 * pi);
  }

  void tapUp(PointerUpEvent event) async {
    await controller.animateBack(0);
  }

  void tapCancel(PointerCancelEvent event) async {
    if (controller.value != pi * 0.5) return;
    await controller.animateBack(pi);
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: tapDown,
      onPointerUp: tapUp,
      onPointerCancel: tapCancel,
      child: AnimatedBuilder(
        animation: controller,
        child: widget.child,
        builder: (_, child) => Transform.scale(
          child: child,
          scale: 1 - 0.05 * sin(controller.value),
        ),
      ),
    );
  }
}
