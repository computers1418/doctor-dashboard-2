import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/text_style.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Scaffold(
        backgroundColor: HexColor("#201A3F"),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 20.h, top: 30.h, bottom: 20.h, right: 20.h),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 52.h,
                        width: 52.h,
                        decoration: BoxDecoration(
                            border: GradientBoxBorder(
                              gradient: LinearGradient(colors: [
                                HexColor("#15102E"),
                                HexColor("#2C2553")
                              ], transform: GradientRotation(0.9)),
                              width: 2.h,
                            ),
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              HexColor("#392F70"),
                              HexColor("#0D0823")
                            ], transform: GradientRotation(0.9))),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/back.png",
                          width: 20.h,
                          height: 20.h,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    // ),
                    Spacer(),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Good Day!",
                              style: CustomFonts.slussen10W400(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              "Dr. Mitchell Adams ",
                              style: CustomFonts.slussen14W700(
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15.h,
                        ),
                        Image.asset(
                          "assets/images/profile.png",
                          height: 52.h,
                          width: 52.h,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      child: Text(
                        "Your",
                        style: CustomFonts.slussen14W400(
                            color: Colors.white.withOpacity(0.5)),
                      ),
                      padding: EdgeInsets.only(left: 30.h, top: 10.h),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.h, right: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Notifications",
                            style:
                                CustomFonts.slussen32W700(color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Text(
                              "Today",
                              style: CustomFonts.slussen12W600(
                                  color: HexColor("#E957C9")),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13.h, right: 20.h),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/dot.png",
                            height: 6.h,
                            width: 6.h,
                          ),
                          SizedBox(
                            width: 6.h,
                          ),
                          Image.asset(
                            "assets/images/noti1.png",
                            height: 60.h,
                            width: 60.h,
                          ),
                          SizedBox(
                            width: 15.h,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: "New Appointment:",
                                      style: CustomFonts.slussen10W600(
                                          color: Colors.white),
                                      children: [
                                        TextSpan(
                                            text: " Patient, ",
                                            style: CustomFonts.slussen10W400(
                                                color: Colors.white
                                                    .withOpacity(0.5))),
                                        TextSpan(
                                            text: "John Doe, ",
                                            style: CustomFonts.slussen10W600(
                                                color: Colors.white)),
                                        TextSpan(
                                            text:
                                                "has booked an appointment for a ",
                                            style: CustomFonts.slussen10W400(
                                                color: Colors.white
                                                    .withOpacity(0.5))),
                                        TextSpan(
                                            text:
                                                "dental checkup on July 15th at 10 AM.",
                                            style: CustomFonts.slussen10W600(
                                                color: Colors.white)),
                                      ]),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  "10 mins ago",
                                  style: CustomFonts.slussen8W600(
                                      color: Colors.white.withOpacity(0.3)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 30.h),
                        child: Divider(
                          color: Colors.white.withOpacity(0.1),
                          height: 0,
                          thickness: 1,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 13.h, right: 20.h),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/dot.png",
                            height: 6.h,
                            width: 6.h,
                          ),
                          SizedBox(
                            width: 6.h,
                          ),
                          Image.asset(
                            "assets/images/noti2.png",
                            height: 60.h,
                            width: 60.h,
                          ),
                          SizedBox(
                            width: 15.h,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: "Appointment Reminder: ",
                                      style: CustomFonts.slussen10W600(
                                          color: Colors.white),
                                      children: [
                                        TextSpan(
                                            text: "Patient, ",
                                            style: CustomFonts.slussen10W400(
                                                color: Colors.white
                                                    .withOpacity(0.5))),
                                        TextSpan(
                                            text: "Sarah Lee, ",
                                            style: CustomFonts.slussen10W600(
                                                color: Colors.white)),
                                        TextSpan(
                                            text:
                                                "has an upcoming appointment ",
                                            style: CustomFonts.slussen10W400(
                                                color: Colors.white
                                                    .withOpacity(0.5))),
                                        TextSpan(
                                            text:
                                                "today at 3 PM for a root canal. ",
                                            style: CustomFonts.slussen10W600(
                                                color: Colors.white)),
                                        TextSpan(
                                            text: "Please confirm attendance.",
                                            style: CustomFonts.slussen10W400(
                                                color: Colors.white
                                                    .withOpacity(0.5))),
                                      ]),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  "20 mins ago",
                                  style: CustomFonts.slussen8W600(
                                      color: Colors.white.withOpacity(0.3)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 30.h),
                        child: Divider(
                          color: Colors.white.withOpacity(0.1),
                          height: 0,
                          thickness: 1,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 25.h, right: 20.h),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/noti3.png",
                            height: 60.h,
                            width: 60.h,
                          ),
                          SizedBox(
                            width: 15.h,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: "Appointment Cancelled: ",
                                      style: CustomFonts.slussen10W600(
                                          color: HexColor("#FF636F")),
                                      children: [
                                        TextSpan(
                                            text: "Patient, ",
                                            style: CustomFonts.slussen10W400(
                                                color: Colors.white
                                                    .withOpacity(0.5))),
                                        TextSpan(
                                            text: "Joseph Don, ",
                                            style: CustomFonts.slussen10W600(
                                                color: Colors.white)),
                                        TextSpan(
                                            text:
                                                "has cancelled their appointment ",
                                            style: CustomFonts.slussen10W400(
                                                color: Colors.white
                                                    .withOpacity(0.5))),
                                        TextSpan(
                                            text:
                                                "Scheduled on July 17th at 03 PM.",
                                            style: CustomFonts.slussen10W600(
                                                color: Colors.white)),
                                      ]),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  "2 hr ago",
                                  style: CustomFonts.slussen8W600(
                                      color: Colors.white.withOpacity(0.3)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.h, right: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Older",
                            style:
                                CustomFonts.slussen24W700(color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: Text(
                              "All Time",
                              style: CustomFonts.slussen12W600(
                                  color: HexColor("#E957C9")),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(45.h))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 35.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 25.h, right: 20.h),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/noti3.png",
                                      height: 60.h,
                                      width: 60.h,
                                    ),
                                    SizedBox(
                                      width: 15.h,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text:
                                                    "Appointment Rescheduled: ",
                                                style:
                                                    CustomFonts.slussen10W600(
                                                        color: HexColor(
                                                            "#F335CA")),
                                                children: [
                                                  TextSpan(
                                                      text: "Patient, ",
                                                      style: CustomFonts
                                                          .slussen10W400(
                                                              color: HexColor(
                                                                      "#201A3F")
                                                                  .withOpacity(
                                                                      0.5))),
                                                  TextSpan(
                                                      text: "Emily Carter, ",
                                                      style: CustomFonts
                                                          .slussen10W600(
                                                              color: HexColor(
                                                                  "#201A3F"))),
                                                  TextSpan(
                                                      text:
                                                          "has rescheduled her appointment from ",
                                                      style: CustomFonts
                                                          .slussen10W400(
                                                              color: HexColor(
                                                                      "#201A3F")
                                                                  .withOpacity(
                                                                      0.5))),
                                                  TextSpan(
                                                      text:
                                                          "July 10th to July 17th at 2 PM.",
                                                      style: CustomFonts
                                                          .slussen10W600(
                                                              color: HexColor(
                                                                  "#201A3F"))),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Text(
                                            "10 July, 05:37 PM",
                                            style: CustomFonts.slussen8W600(
                                                color: HexColor("#201A3F")
                                                    .withOpacity(0.3)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 30.h),
                                  child: Divider(
                                    color: HexColor("#201A3F").withOpacity(0.1),
                                    height: 0,
                                    thickness: 1,
                                  )),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 25.h, right: 20.h),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/noti3.png",
                                      height: 60.h,
                                      width: 60.h,
                                    ),
                                    SizedBox(
                                      width: 15.h,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: "New Appointment: ",
                                                style:
                                                    CustomFonts.slussen10W600(
                                                        color: HexColor(
                                                            "#F335CA")),
                                                children: [
                                                  TextSpan(
                                                      text: "Patient, ",
                                                      style: CustomFonts
                                                          .slussen10W400(
                                                              color: HexColor(
                                                                      "#201A3F")
                                                                  .withOpacity(
                                                                      0.5))),
                                                  TextSpan(
                                                      text: "Amanda Smith, ",
                                                      style: CustomFonts
                                                          .slussen10W600(
                                                              color: HexColor(
                                                                  "#201A3F"))),
                                                  TextSpan(
                                                      text:
                                                          "has booked an upcoming appointment for ",
                                                      style: CustomFonts
                                                          .slussen10W400(
                                                              color: HexColor(
                                                                      "#201A3F")
                                                                  .withOpacity(
                                                                      0.5))),
                                                  TextSpan(
                                                      text:
                                                          "dental crown on July 15 at 3 PM.",
                                                      style: CustomFonts
                                                          .slussen10W600(
                                                              color: HexColor(
                                                                  "#201A3F"))),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Text(
                                            "10 July, 03:12 PM",
                                            style: CustomFonts.slussen8W600(
                                                color: HexColor("#201A3F")
                                                    .withOpacity(0.3)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 30.h),
                                  child: Divider(
                                    color: HexColor("#201A3F").withOpacity(0.1),
                                    height: 0,
                                    thickness: 1,
                                  )),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 25.h, right: 20.h),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/noti3.png",
                                      height: 60.h,
                                      width: 60.h,
                                    ),
                                    SizedBox(
                                      width: 15.h,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: "Appointment Cancelled: ",
                                                style:
                                                    CustomFonts.slussen10W600(
                                                        color: HexColor(
                                                            "#FF3040")),
                                                children: [
                                                  TextSpan(
                                                      text: "Patient, ",
                                                      style: CustomFonts
                                                          .slussen10W400(
                                                              color: HexColor(
                                                                      "#201A3F")
                                                                  .withOpacity(
                                                                      0.5))),
                                                  TextSpan(
                                                      text: "Sera Jones, ",
                                                      style: CustomFonts
                                                          .slussen10W600(
                                                              color: HexColor(
                                                                  "#201A3F"))),
                                                  TextSpan(
                                                      text:
                                                          "has cancelled their appointment Scheduled on ",
                                                      style: CustomFonts
                                                          .slussen10W400(
                                                              color: HexColor(
                                                                      "#201A3F")
                                                                  .withOpacity(
                                                                      0.5))),
                                                  TextSpan(
                                                      text:
                                                          "July 10th at 03 PM.",
                                                      style: CustomFonts
                                                          .slussen10W600(
                                                              color: HexColor(
                                                                  "#201A3F"))),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Text(
                                            "09 July, 09:22 PM",
                                            style: CustomFonts.slussen8W600(
                                                color: HexColor("#201A3F")
                                                    .withOpacity(0.3)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 125.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
