import 'package:flutter/material.dart';

class NeumorphicWidgets extends StatelessWidget {
  final double height, width, radius;
  final Widget child;
  final List<Color> colors;
  final int type;
  final bool hasShadow;
  final color;

  const NeumorphicWidgets({super.key, required this.child, required this.height, required this.width, required this.colors, required this.radius, required this.type, required this.hasShadow, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: height,
        height: width,
        // color: Color(0xff333333),
        alignment: Alignment.center,
        transformAlignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              color: color ?? const Color(0xff333333),
              borderRadius: BorderRadius.circular(radius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: type == 1 ? //flat
                  [const Color(0xff505050), const Color(0xff161616),] 
                  : type == 2 ? [colors[1], colors[0],] : //concave
                  [colors[0], colors[1],], //convex
              ),
              boxShadow: hasShadow ?
              const [
                BoxShadow(
                  color: Color(0xff505050),
                  offset: Offset(-4, -4),
                  blurRadius: 5,
                  spreadRadius: 0.0,
                ),
                BoxShadow(
                  color: Color(0xff161616),
                  offset: Offset(4, 4),
                  blurRadius: 5,
                  spreadRadius: 0.0,
                ),
              ] : null,
            ),
          child: child,
          ),
        );
  }
}