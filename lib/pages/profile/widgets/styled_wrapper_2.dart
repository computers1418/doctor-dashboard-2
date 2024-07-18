import 'package:flutter/material.dart';

class StyledWrapper2 extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const StyledWrapper2({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F7FB),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              offset: Offset(-5, -5),
              blurRadius: 10,
              spreadRadius: 0,
              color: Color(0xFFFFFFFF)
            ),
            BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 10,
              spreadRadius: 0,
              color: Color(0xFFD3E7F6)
            )
          ]
        ), child: child);
  }
}