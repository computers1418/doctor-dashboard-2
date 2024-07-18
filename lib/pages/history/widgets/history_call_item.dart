import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryCallItem extends StatelessWidget {
  final String name;
  final String phone;
  final String time;
  final String image;
  final bool received;

  const HistoryCallItem(
      {super.key,
      required this.name,
      required this.phone,
      required this.time,
      required this.image,
      required this.received});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 40),
      child: Row(
        children: [
          CircleAvatar(
            radius: 37,
            backgroundImage: AssetImage("assets/images/$image.png"),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style:
                      CustomFonts.slussen14W800(color: HexColor(primaryColor)),
                ),
                Text(
                  phone,
                  style: CustomFonts.slussen10W500(
                      color: HexColor(primaryColor).withOpacity(0.6)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            HexColor("#E49356"),
                            HexColor("#E7CB87"),
                          ])),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    "Time : $time",
                    style:
                        CustomFonts.slussen10W700(color: HexColor("#FFFFFF")),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => {},
                child: CircleAvatar(
                    radius: 13,
                    backgroundColor: HexColor(received ? "#E957C9" : "#E72A36"),
                    child: Image.asset(
                        "assets/images/${received ? 'check-white' : 'close'}.png",
                        width: 13,
                        height: 13)),
              ),
              const SizedBox(height: 4),
              Text(
                received ? "Voice Call\nReceived" : "Voice Call Not\nReceived",
                style: CustomFonts.slussen8W700(color: HexColor("#E957C9")),
              )
            ],
          )
        ],
      ),
    );
  }
}
