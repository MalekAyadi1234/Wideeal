import 'package:flutter/material.dart';
import 'dart:math';

enum DotType2 {
  square, circle, diamond, icon
}

class Loader34 extends StatefulWidget {

  final Color dotOneColor;
  final Color dotTwoColor;
  final Color dotThreeColor;
  final Duration duration;
  final DotType2 dotType;
  final Icon dotIcon;

  Loader34({
    this.dotOneColor = Colors.redAccent,
    this.dotTwoColor = Colors.green,
    this.dotThreeColor = Colors.blueAccent,
    this.duration = const Duration(milliseconds: 1000),
    this.dotType = DotType2.circle,
    this.dotIcon = const Icon(Icons.blur_on)
  });

  @override
  _Loader34State createState() => _Loader34State();
}

class _Loader34State extends State<Loader34>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation_1;
  Animation<double>? animation_2;
  Animation<double>? animation_3;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: widget.duration, vsync: this);

    animation_1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Interval(0.0, 0.80, curve: Curves.ease),
      ),
    );

    animation_2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Interval(0.1, 0.9, curve: Curves.ease),
      ),
    );

    animation_3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Interval(0.2, 1.0, curve: Curves.ease),
      ),
    );

    controller!.addListener(() {
      setState(() {
        //print(animation_1.value);
      });
    });

    controller!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Transform.translate(
            offset: Offset(
              0.0,
              -30 *
                  (animation_1!.value <= 0.50
                      ? animation_1!.value
                      : 1.0 - animation_1!.value),
            ),
            child: new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotOneColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(
              0.0,
              -30 *
                  (animation_2!.value <= 0.50
                      ? animation_2!.value
                      : 1.0 - animation_2!.value),
            ),
            child: new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotTwoColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(
              0.0,
              -30 *
                  (animation_3!.value <= 0.50
                      ? animation_3!.value
                      : 1.0 - animation_3!.value),
            ),
            child: new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotThreeColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  final DotType2 type;
  final Icon icon;

  Dot({required this.radius, required this.color, required this.type, required this.icon});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: type == DotType2.icon ?
      Icon(icon.icon, color: color, size: 1.3 * radius,)
          : new Transform.rotate(
        angle: type == DotType2.diamond ? pi/4 : 0.0,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(color: color, shape: type == DotType2.circle? BoxShape.circle : BoxShape.rectangle),
        ),
      ),
    );
  }
}