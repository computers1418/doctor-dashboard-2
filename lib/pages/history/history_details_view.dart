
import 'package:doctor_dashboard/pages/history/widgets/history_call_item.dart';
import 'package:doctor_dashboard/pages/history/widgets/history_sms_item.dart';
import 'package:doctor_dashboard/pages/history/widgets/sms_info_dialog.dart';
import 'package:doctor_dashboard/pages/history/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/constants.dart';
import '../../constants/data_const.dart';
import '../../constants/text_style.dart';
import '../../widgets/custom_appbar.dart';

class HistoryDetailsView extends StatefulWidget {
  const HistoryDetailsView({super.key});

  @override
  State<HistoryDetailsView> createState() => _HistoryDetailsViewState();
}

class _HistoryDetailsViewState extends State<HistoryDetailsView> {
  var active = "sms";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#201A3F"),
      body: Stack(
        children: [
          Column(
            children: [
              CustomAppbar(callback: () {}),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.0175),
                          child: Text(
                            "May",
                            style: CustomFonts.slussen32W700(
                                color: HexColor("#FFFFFF")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            "Month",
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
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      color: HexColor("#F2F7FB"),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(36))),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/${active == "sms" ? "left" : "right"}-bg.png"),
                            fit: BoxFit.fill)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        active = "sms";
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 35,
                                          left: 20,
                                          right: 15,
                                          bottom: 0),
                                      child: TabItem(
                                          type: "sms",
                                          count: "486",
                                          isSelected: active == "sms"),
                                    ))),
                            Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        active = "voice";
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 35,
                                          left: 15,
                                          right: 20,
                                          bottom: 0),
                                      child: TabItem(
                                          type: "voice-call",
                                          count: "238",
                                          isSelected: active == "voice"),
                                    )))
                          ],
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: active == "sms"
                                ? smsHistory.length
                                : voiceHistory.length,
                            itemBuilder: (_, idx) {
                              if (active == "voice") {
                                var e = voiceHistory[idx];
                                return HistoryCallItem(
                                  name: e["name"],
                                  phone: e["phone"],
                                  time: e["time"],
                                  image: e["image"],
                                  received: e["received"],
                                );
                              }

                              var e = smsHistory[idx];
                              return HistorySmsItem(
                                  name: e["name"],
                                  phone: e["phone"],
                                  time: e["time"],
                                  image: e["image"]);
                            },
                            separatorBuilder: (_, idx) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Divider(
                                  color:
                                      HexColor(primaryColor).withOpacity(0.1),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40))),
                  backgroundColor: Colors.white,
                  barrierColor: HexColor("#201A3F").withOpacity(0.8),
                  context: context,
                  builder: (context) {
                    return SmsInfoDialog();
                  },
                );
              },
              child: Container(
                  margin: const EdgeInsets.all(25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: HexColor(primaryColor)),
                  child: Text("READ GUIDLINES",
                      style: CustomFonts.slussen12W700(
                          color: HexColor("#FFFFFF")))),
            ),
          ),
        ],
      ),
    );
  }
}
