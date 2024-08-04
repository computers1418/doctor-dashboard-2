import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/text_style.dart';

class SmsInfoDialog extends StatefulWidget {
  const SmsInfoDialog({super.key});

  @override
  State<SmsInfoDialog> createState() => _SmsInfoDialogState();
}

class _SmsInfoDialogState extends State<SmsInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 8,
              width: 60,
              decoration: BoxDecoration(
                  color: HexColor('#F0F0F0'),
                  borderRadius: BorderRadius.circular(30)),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/images/delete.png",
                    width: 26,
                    height: 26,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 22,
        ),
        Text(
          "SMS Info",
          style: CustomFonts.slussen20W700(color: HexColor("#201A3F")),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "Sorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
            style: CustomFonts.slussen10W400(
                color: HexColor("#201A3F").withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 35,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: HexColor("#FF65DE"),
                borderRadius: BorderRadius.circular(32)),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
            child: Text(
              "DONE",
              style: CustomFonts.slussen12W700(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 65,
        ),
      ],
    );
  }
}
