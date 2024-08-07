import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/text_style.dart';

class Popup9 extends StatefulWidget {
  const Popup9({super.key});

  @override
  State<Popup9> createState() => _Popup9State();
}

class _Popup9State extends State<Popup9> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 30,
          left: 15,
          right: 15,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("res/images/popup9.png"),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 25, left: 160),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "res/images/cloud.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "26°C, Sat - 13 Jul",
                              style: CustomFonts.slussen12W600(
                                  color: HexColor("#201A3F").withOpacity(0.5)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        Text(
                          "Make Them Smile.",
                          style: CustomFonts.slussen20W700(
                              color: HexColor("#FF43D7")),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Another day, another opportunity to\nbrighten someone's day.",
                          style: CustomFonts.slussen10W500(
                              color: HexColor("#201A3F")),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12, right: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "res/images/close.png",
                        height: 26,
                        width: 26,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
