import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainContainer extends StatelessWidget {
  final String icon;
  final String title;
  final String sub;
  final bool invert;
  const MainContainer({super.key, required this.icon, required this.sub, required this.title, this.invert = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 125,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F7FB),
          gradient: invert ? const LinearGradient(colors: [
                              Color(0xFFE7CB87),
                              Color(0xFFE49356)
                            ]): null,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(invert? 30: 60),
            bottom: Radius.circular(invert? 60: 30)
          ),
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: !invert,
              child: CircleAvatar(
                backgroundColor: const Color(0xFF201A3F),
                child: ImageIcon(AssetImage(icon), color: Colors.white, size: 18)),
            ),
            Visibility(
              visible: !invert,
              child: const Spacer()),
            Text(title, style: TextStyle(
              fontFamily: "Slussen",
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Color(invert ? 0xFFFFFFFF: 0xFFFF65DE)
            )),
            Text(sub, textAlign: TextAlign.center, style: const TextStyle(
              fontFamily: "Slussen",
              fontWeight: FontWeight.w600,
              fontSize: 8,
              color: Color(0xFF201A3F)
            )),
            Visibility(
              visible: invert,
              child: const Spacer()),
            Visibility(
              visible: invert,
              child: CircleAvatar(
                backgroundColor: Color(invert ? 0xFFFFFFFF: 0xFF201A3F),
                child: ImageIcon(AssetImage(icon), color: invert ? const Color(0xFF201A3F) :Colors.white, size: 18)),
            ),
          ],
        ),
      ),
    );
  }
}