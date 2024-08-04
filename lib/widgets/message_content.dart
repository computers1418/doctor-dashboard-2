import 'package:flutter/material.dart';

import '../constants/colors_const.dart';

class MessageContent extends StatelessWidget {
  final String pName;
  final String dName;
  final String dateTime;
  final String location;
  const MessageContent({super.key, required this.pName, required this.dName, required this.dateTime, required this.location});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          const TextSpan(
            text: "Dear",
            style: TextStyle(
              fontFamily: 'Slussen',
              fontSize: 14, fontWeight: FontWeight.w300, color: ColorsConst.text
            )
          ),
          TextSpan(
            text: " ${pName.isEmpty ? '[Patient Name]': pName} ",
            style: TextStyle(
              fontFamily: 'Slussen',
              fontSize: 14, fontWeight: (pName.isEmpty ? FontWeight.w300 : FontWeight.w800), color: ColorsConst.text
            )
          ),
          const TextSpan(
            text: "This is a friendly reminder from ABC Hospital about your upcoming appointment with",
            style: TextStyle(
              fontFamily: 'Slussen',
              fontSize: 14, fontWeight: FontWeight.w300, color: ColorsConst.text
            )
          ),
          TextSpan(
            text: " ${dName.isEmpty ? '[Doctor Name]': dName} ",
            style: TextStyle(
              fontFamily: 'Slussen',
              fontSize: 14, fontWeight: (dName.isEmpty ? FontWeight.w300 : FontWeight.w800), color: ColorsConst.text
            )
          ),
          const TextSpan(
            text: "on",
            style: TextStyle(
              fontFamily: 'Slussen',
              fontSize: 14, fontWeight: FontWeight.w300, color: ColorsConst.text
            )
          ),
          TextSpan(
            text: " ${dateTime.isEmpty ? '[Date & Time]': dateTime} ",
            style: TextStyle(
              fontFamily: 'Slussen',
              fontSize: 14, fontWeight: (dateTime.isEmpty ? FontWeight.w300 : FontWeight.w800), color: ColorsConst.text
            )
          ),
          const TextSpan(
            text: "Your appointment will be held at",
            style: TextStyle(
              fontFamily: 'Slussen',
              fontSize: 14, fontWeight: FontWeight.w300, color: ColorsConst.text
            )
          ),
          TextSpan(
            text: " ${location.isEmpty ? '[Location]': location} ",
            style: TextStyle(
              fontFamily: 'Slussen',
              fontSize: 14, fontWeight: (location.isEmpty ? FontWeight.w300 : FontWeight.w800), color: ColorsConst.text
            )
          ),
        ]
      ),
    );
  }
}