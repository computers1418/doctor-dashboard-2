import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

import '../../widgets/drawer.dart';

class SavedSchedules extends StatefulWidget {
  const SavedSchedules({Key? key}) : super(key: key);

  @override
  State<SavedSchedules> createState() => _SavedSchedulesState();
}

class _SavedSchedulesState extends State<SavedSchedules>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;

  final _scrollController = ScrollController();
  double _currentOffset = 0.0;

  int selectedDate = -1;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.light, //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  callback() {
    setState(() {
      if (_scrollController.offset != 0) {
        _currentOffset = _scrollController.offset;
      }

      if (isCollapsed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }

      isCollapsed = !isCollapsed;

      if (isCollapsed) {
        _scrollController.animateTo(_currentOffset,
            duration: const Duration(microseconds: 10), curve: Curves.easeIn);
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          // statusBarBrightness: Brightness.dark // Set your desired color
        ));
      } else {
        _scrollController.animateTo(0.0,
            duration: const Duration(microseconds: 10), curve: Curves.easeIn);
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          // statusBarBrightness: Brightness.dark // Set your desired color
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            CustomDrawer(
              callback: callback,
            ),
            content(context)
          ],
        ));
  }

  Widget content(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(isCollapsed ? 0 : 40)),
          elevation: 8,
          color: Colors.white,
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(isCollapsed ? 0 : 40)),
            child: Container(
              width: double.infinity,
              color: HexColor("#201A3F"),
              child: Column(
                children: [
                  CustomAppbar(callback: callback),
                  Expanded(
                    child: DynMouseScroll(
                      durationMS: 5000,
                      scrollSpeed: -4.4,
                      builder: (context, controller, physics) => ListView(
                        controller: _scrollController,
                        physics: isCollapsed
                            ? physics
                            : const NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0175),
                                      child: Text(
                                        "Schedules",
                                        style: CustomFonts.slussen32W700(
                                            color: HexColor("#FFFFFF")),
                                      ),
                                    ),
                                    Text(
                                      "Saved",
                                      style: CustomFonts.slussen14W500(
                                          color: HexColor("#FFFFFF")
                                              .withOpacity(.5)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * .02,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(35)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "26 Feb, Monday",
                                                style:
                                                    CustomFonts.slussen16W700(
                                                        color: HexColor(
                                                            primaryColor)),
                                              ),
                                              Text(
                                                "10 Appointments scheduled for today",
                                                style: TextStyle(
                                                  color: HexColor(primaryColor)
                                                      .withOpacity(.4),
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(9),
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor("#F7F9FC"),
                                                ),
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/images/edit.png")),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              InkWell(
                                                onTap: () => setState(() {
                                                  if (selectedDate == -1) {
                                                    selectedDate = -2;
                                                  } else {
                                                    selectedDate = -1;
                                                  }
                                                }),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: HexColor(pinkColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "schedules ",
                                                        style: CustomFonts
                                                            .slussen9W700(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      Icon(
                                                        selectedDate != -2
                                                            ? Icons
                                                                .keyboard_arrow_up
                                                            : Icons
                                                                .keyboard_arrow_down,
                                                        color: Colors.white,
                                                        size: 14,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      if (selectedDate != -2)
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      if (selectedDate != -2)
                                        Row(
                                          children: [
                                            Container(
                                              width: 68,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      HexColor(goldDarkColor),
                                                      HexColor(goldLightColor)
                                                    ]),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Morning",
                                                  style:
                                                      CustomFonts.slussen10W500(
                                                          color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Container(
                                              width: 68,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient:
                                                    LinearGradient(colors: [
                                                  HexColor(goldDarkColor)
                                                      .withOpacity(.2),
                                                  HexColor(goldLightColor)
                                                      .withOpacity(.1),
                                                ]),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Afternoon",
                                                  style:
                                                      CustomFonts.slussen10W500(
                                                          color: HexColor(
                                                              "#E49356")),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Container(
                                              width: 68,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient:
                                                    LinearGradient(colors: [
                                                  HexColor(goldDarkColor)
                                                      .withOpacity(.2),
                                                  HexColor(goldLightColor)
                                                      .withOpacity(.1),
                                                ]),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Evening",
                                                  style:
                                                      CustomFonts.slussen10W500(
                                                          color: HexColor(
                                                              "#E49356")),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (selectedDate != -2)
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      if (selectedDate != -2)
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Row(
                                              children: [
                                                for (int i = 0; i < 8; i++)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 24,
                                                          vertical: 16),
                                                      // height: 110,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            HexColor("#F7F9FC"),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "am",
                                                            style: CustomFonts.slussen10W600(
                                                                color: HexColor(
                                                                        primaryColor)
                                                                    .withOpacity(
                                                                        .5)),
                                                          ),
                                                          Text(
                                                            "09:00",
                                                            style: CustomFonts
                                                                .slussen14W700(
                                                                    color: HexColor(
                                                                        primaryColor)),
                                                          ),
                                                          Text(
                                                            "-",
                                                            style: CustomFonts
                                                                .slussen14W700(
                                                                    color: HexColor(
                                                                        primaryColor)),
                                                          ),
                                                          Text(
                                                            "09:30",
                                                            style: CustomFonts
                                                                .slussen14W700(
                                                                    color: HexColor(
                                                                        primaryColor)),
                                                          ),
                                                          Text(
                                                            "am",
                                                            style: CustomFonts
                                                                .slussen10W600(
                                                                    color: HexColor(
                                                                        primaryColor)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: HexColor("#F2F7FB"),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(45),
                                    topRight: Radius.circular(45),
                                    // bottomLeft: Radius.circular(45),
                                    // bottomRight: Radius.circular(45),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        "Upcomoing",
                                        style: CustomFonts.slussen16W700(
                                            color: HexColor(primaryColor)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    for (int i = 0; i < 8; i++)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 20),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "26 Feb, Monday",
                                                        style: CustomFonts
                                                            .slussen16W700(
                                                                color: HexColor(
                                                                    primaryColor)),
                                                      ),
                                                      Text(
                                                        "10 Appointments scheduled for today",
                                                        style: TextStyle(
                                                          color: HexColor(
                                                                  primaryColor)
                                                              .withOpacity(.4),
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(9),
                                                        height: 30,
                                                        width: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: HexColor(
                                                              "#F7F9FC"),
                                                        ),
                                                        child: Center(
                                                            child: Image.asset(
                                                                "assets/images/edit.png")),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            setState(() {
                                                          if (selectedDate ==
                                                              i) {
                                                            selectedDate = -1;
                                                          } else {
                                                            selectedDate = i;
                                                          }
                                                        }),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: HexColor(
                                                                pinkColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "schedules ",
                                                                style: CustomFonts
                                                                    .slussen9W700(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                              Icon(
                                                                selectedDate ==
                                                                        i
                                                                    ? Icons
                                                                        .keyboard_arrow_down
                                                                    : Icons
                                                                        .keyboard_arrow_down,
                                                                color: Colors
                                                                    .white,
                                                                size: 14,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              if (selectedDate == i)
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              if (selectedDate == i)
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 68,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              HexColor(
                                                                  goldDarkColor),
                                                              HexColor(
                                                                  goldLightColor)
                                                            ]),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Morning",
                                                          style: CustomFonts
                                                              .slussen10W500(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Container(
                                                      width: 68,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              HexColor(
                                                                      goldDarkColor)
                                                                  .withOpacity(
                                                                      .2),
                                                              HexColor(
                                                                      goldLightColor)
                                                                  .withOpacity(
                                                                      .1),
                                                            ]),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Afternoon",
                                                          style: CustomFonts
                                                              .slussen10W500(
                                                                  color: HexColor(
                                                                      "#E49356")),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Container(
                                                      width: 68,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              HexColor(
                                                                      goldDarkColor)
                                                                  .withOpacity(
                                                                      .2),
                                                              HexColor(
                                                                      goldLightColor)
                                                                  .withOpacity(
                                                                      .1),
                                                            ]),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Evening",
                                                          style: CustomFonts
                                                              .slussen10W500(
                                                                  color: HexColor(
                                                                      "#E49356")),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (selectedDate == i)
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                              if (selectedDate == i)
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 0),
                                                    child: Row(
                                                      children: [
                                                        for (int i = 0;
                                                            i < 8;
                                                            i++)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8),
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          24,
                                                                      vertical:
                                                                          16),
                                                              // height: 110,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: HexColor(
                                                                    "#F7F9FC"),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "am",
                                                                    style: CustomFonts
                                                                        .slussen10W600(
                                                                            color:
                                                                                HexColor(primaryColor).withOpacity(.5)),
                                                                  ),
                                                                  Text(
                                                                    "09:00",
                                                                    style: CustomFonts
                                                                        .slussen14W700(
                                                                            color:
                                                                                HexColor(primaryColor)),
                                                                  ),
                                                                  Text(
                                                                    "-",
                                                                    style: CustomFonts
                                                                        .slussen14W700(
                                                                            color:
                                                                                HexColor(primaryColor)),
                                                                  ),
                                                                  Text(
                                                                    "09:30",
                                                                    style: CustomFonts
                                                                        .slussen14W700(
                                                                            color:
                                                                                HexColor(primaryColor)),
                                                                  ),
                                                                  Text(
                                                                    "am",
                                                                    style: CustomFonts
                                                                        .slussen10W600(
                                                                            color:
                                                                                HexColor(primaryColor)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
