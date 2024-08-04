import 'package:doctor_dashboard/extensions/context_exten.dart';
import 'package:doctor_dashboard/extensions/number_exten.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/assets_const.dart';


class SheetWrapper extends StatelessWidget {
  final Widget child;

  const SheetWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                width: 60,
                height: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFF0F0F0)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      context.back();
                    },
                    child: Image.asset(
                      AssetsConst.close,
                      width: 26,
                      height: 26,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        34.h(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: child,
        )
      ],
    );
  }
}
