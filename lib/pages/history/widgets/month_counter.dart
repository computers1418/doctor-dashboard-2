import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/pages/history/history_view_detail.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MonthCounter extends StatelessWidget {
  final String month;
  final String smsCount;
  final String callCount;
  const MonthCounter(
      {super.key,
      required this.month,
      required this.smsCount,
      required this.callCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60, bottom: 10),
          child: Text(
            month,
            style: CustomFonts.slussen12W700(
                color: HexColor(primaryColor).withOpacity(0.4)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 30),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: HexColor("#FFFFFF"),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(45))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundColor:
                                  HexColor("#E7CB87").withOpacity(0.15),
                              child: Image.asset("assets/images/sms-grad.png",
                                  width: 22, height: 22),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    smsCount,
                                    style: CustomFonts.slussen15W700(
                                            color: HexColor(primaryColor))
                                        .copyWith(height: 1),
                                  ),
                                  Text(
                                    "SMS Sent",
                                    style: TextStyle(
                                      color: HexColor(primaryColor)
                                          .withOpacity(.6),
                                      fontSize: 7,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundColor:
                                  HexColor("#E7CB87").withOpacity(0.15),
                              child: Image.asset(
                                  "assets/images/voice-call-grad.png",
                                  width: 22,
                                  height: 22),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    callCount,
                                    style: CustomFonts.slussen15W700(
                                            color: HexColor(primaryColor))
                                        .copyWith(height: 1),
                                  ),
                                  Text(
                                    "Voice SMS Sent",
                                    style: TextStyle(
                                      color: HexColor(primaryColor)
                                          .withOpacity(.6),
                                      fontSize: 7,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HistoryDetailsView(),
                  ),
                ),
                child: CircleAvatar(
                    radius: 18,
                    backgroundColor: HexColor(primaryColor),
                    child: Image.asset("assets/images/arrow-cross-1.png",
                        width: 14, height: 14)),
              )
            ],
          ),
        )
      ],
    );
  }
}
