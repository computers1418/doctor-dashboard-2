import 'package:doctor_dashboard/pages/history/widgets/month_counter.dart';
import 'package:doctor_dashboard/pages/history/widgets/total_counter.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/text_style.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#201A3F"),
      body: Stack(
        children: [
          Column(
            children: [
              CustomAppbar(callback: () {
                Navigator.pop(context);
              }),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.0175),
                              child: Text(
                                "History",
                                style: CustomFonts.slussen32W700(
                                    color: HexColor("#FFFFFF")),
                              ),
                            ),
                            Text(
                              "SMS",
                              style: CustomFonts.slussen14W500(
                                  color: HexColor("#FFFFFF").withOpacity(.5)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            "This Month",
                            style: TextStyle(
                              color: HexColor("#E957C9"),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: HexColor("#E957C9"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset("assets/images/arrow-cross.png",
                          width: 30, height: 30)),
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TotalCounter(
                              isLeft: true,
                              image: "sms",
                              count: "486",
                              text: "SMS Sent"),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TotalCounter(
                              isLeft: false,
                              image: "voice-call",
                              count: "238",
                              text: "Voice SMS Sent"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Older",
                      style:
                          CustomFonts.slussen24W700(color: HexColor("#FFFFFF")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        "All Time",
                        style: TextStyle(
                          color: HexColor("#E957C9"),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: HexColor("#E957C9"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: HexColor("#F2F7FB"),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(45))),
                  child: const Column(
                    children: [
                      MonthCounter(
                        month: "April 2024",
                        callCount: "338",
                        smsCount: "512",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MonthCounter(
                        month: "Mar 2024",
                        callCount: "301",
                        smsCount: "397",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: HexColor("#FF65DE")),
              child: Text(
                "READ GUIDLINES",
                style: CustomFonts.slussen12W700(
                  color: HexColor("#FFFFFF"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
