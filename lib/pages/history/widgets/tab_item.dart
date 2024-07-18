import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TabItem extends StatelessWidget {
  final String type;
  final String count;
  final bool isSelected;
  const TabItem(
      {super.key,
      required this.type,
      required this.count,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: HexColor("#ffffff"),
          borderRadius: BorderRadius.circular(30),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [HexColor("#E49356"), HexColor("#FF65DE")])
              : null),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: HexColor("#ffffff"),
                borderRadius: BorderRadius.circular(100),
                gradient: isSelected
                    ? null
                    : LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [HexColor("#E49356"), HexColor("#FF65DE")])),
            child: Image.asset(
                "assets/images/${type == "sms" ? "sms" : "voice-call"}${isSelected ? "-color-grad" : ""}.png",
                width: 16,
                height: 16),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            count,
            style: CustomFonts.slussen24W800(
                color: HexColor(isSelected ? "#FFFFFF" : primaryColor)),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            type == "sms" ? "SMS\nSent" : "Voice\nCall",
            style: CustomFonts.slussen10W700(
                    color: HexColor(isSelected ? "#FFFFFF" : primaryColor))
                .copyWith(height: 1.1),
          ),
        ],
      ),
    );
  }
}
