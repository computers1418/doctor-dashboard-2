import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class TotalCounter extends StatelessWidget {
  final bool isLeft;
  final String image;
  final String count;
  final String text;
  const TotalCounter(
      {super.key,
      required this.isLeft,
      required this.image,
      required this.count,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: HexColor("#FFFFFF"),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isLeft ? 45 : 20),
              topRight: Radius.circular(isLeft ? 20 : 45),
              bottomLeft: const Radius.circular(45),
              bottomRight: const Radius.circular(45))),
      child: Row(
        children: [
          Visibility(visible: isLeft, child: avatar(context)),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  count,
                  style:
                      CustomFonts.slussen24W700(color: HexColor(primaryColor))
                          .copyWith(height: 1),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: HexColor(primaryColor).withOpacity(.6),
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Visibility(visible: !isLeft, child: avatar(context)),
        ],
      ),
    );
  }

  Widget avatar(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;

    return Container(
      width: sw * 0.17,
      height: sw * 0.17,
      margin: EdgeInsets.only(left: !isLeft ? 10 : 0, right: isLeft ? 10 : 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [HexColor("#E49356"), HexColor("#FF65DE")])),
      child: Image.asset("assets/images/$image.png"),
    );
  }
}
