import 'package:flutter/material.dart';

class StyledWrapper extends StatelessWidget {
  final Widget child;
  const StyledWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
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
              color: Color(0xFFE1EAF1)
            )
          ]
        ), child: child);
  }
}