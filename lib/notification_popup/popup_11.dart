import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/text_style.dart';

class Popup11 extends StatefulWidget {
  const Popup11({super.key});

  @override
  State<Popup11> createState() => _Popup11State();
}

class _Popup11State extends State<Popup11> {
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
                    image: AssetImage("res/images/popup11.png"),
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
                          "Hola! Doc.",
                          style: CustomFonts.slussen20W700(
                              color: HexColor("#FF43D7")),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "May your day be filled with healthy\nsmiles and grateful patients.",
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
