import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/text_style.dart';

class Popup1 extends StatefulWidget {
  const Popup1({super.key});

  @override
  State<Popup1> createState() => _Popup1State();
}

class _Popup1State extends State<Popup1> {
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
                          children: [
                            Image.asset(
                              "assets/images/bell.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Remainder",
                              style: CustomFonts.slussen14W500(
                                  color: HexColor("#201A3F").withOpacity(0.5)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        Text(
                          "12:00 PM - 12:45 PM",
                          style: CustomFonts.slussen20W900(
                              color: HexColor("#FF43D7")),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Patient, Armando Gayle, has an upcoming appointment today at 12 PM for a root canal.",
                          style: CustomFonts.slussen12W500(
                              color: HexColor("#201A3F").withOpacity(0.5)),
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
