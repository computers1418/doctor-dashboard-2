import 'package:doctor_dashboard/extensions/context_exten.dart';
import 'package:doctor_dashboard/extensions/number_exten.dart';
import 'package:doctor_dashboard/extensions/string_exten.dart';
import 'package:doctor_dashboard/widgets/sheet_wrapper.dart';
import 'package:flutter/material.dart';

import '../constants/assets_const.dart';
import '../constants/colors_const.dart';

class SuccessSheet extends StatelessWidget {
  const SuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SheetWrapper(
      child: Column(
        children: [
          Image.asset(AssetsConst.mailSent, width: 74, height: 74),
          16.h(),
          "Message Sent Successfully".semibold20(color: ColorsConst.primary),
          20.h(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => context.back(),
                child: Container(
                  width: 104,
                  height: 50,
                  decoration: BoxDecoration(
                      color: ColorsConst.secondary,
                      borderRadius: BorderRadius.circular(32)),
                  alignment: Alignment.center,
                  child: "DONE".bold14(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
