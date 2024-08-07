import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/text_style.dart';

class Popup6 extends StatefulWidget {
  const Popup6({super.key});

  @override
  State<Popup6> createState() => _Popup6State();
}

class _Popup6State extends State<Popup6> {
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
                    image: AssetImage("res/images/popup6.png"),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 20),
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
                          "Superhero in disguise.",
                          style: CustomFonts.slussen20W700(
                              color: HexColor("#FF43D7")),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "wielding drills and scalpels with unmatched\nprecision and care.",
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
