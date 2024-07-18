import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/text_style.dart';
import 'neumorphic_widgets.dart';

class CustomAppbar extends StatefulWidget {
  final Function callback;
  const CustomAppbar({Key? key, required this.callback}) : super(key: key);

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
      height: MediaQuery.of(context).size.height * .115,
      color: HexColor("#201A3F"),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => widget.callback(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    NeumorphicWidgets(
                      hasShadow: false,
                      type: 2,
                      height: 56,
                      width: 56,
                      colors: [
                        HexColor("#392F70"),
                        HexColor("#0D0823"),
                      ],
                      radius: 82,
                      child: const SizedBox(
                        height: 82,
                        width: 82,
                      ),
                    ),
                    NeumorphicWidgets(
                      hasShadow: false,
                      type: 3,
                      height: 52,
                      width: 52,
                      colors: [
                        HexColor("#392F70"),
                        HexColor("#0D0823"),
                      ],
                      radius: 52,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Image.asset(
                          "lib/pages/dashboard/assets/menu.png",
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Good Day!",
                        style: CustomFonts.slussen10W500(
                            color: HexColor("#FFFFFF").withOpacity(.5)),
                      ),
                      Text(
                        "Dr. Mitchell Adams",
                        style: CustomFonts.slussen14W700(
                            color: HexColor("#FFFFFF")),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Image.asset(
                    "lib/pages/dashboard/assets/img.png",
                    height: 52,
                    width: 52,
                  ),
                ],
              ),
            ],
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        ],
      ),
    );
  }
}
