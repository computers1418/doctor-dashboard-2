import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

import '../../constants/delete_dialog.dart';
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
  List<TextEditingController> startTimeController = [];
  List<TextEditingController> endTimeController = [];

  List<TextEditingController> firststartTimeController = [];
  List<TextEditingController> firstendTimeController = [];

  final _scrollController = ScrollController();
  double _currentOffset = 0.0;
  int scheduleSelect = -1;
  int firstscheduleSelect = -1;

  int selectedDate = -1;
  List<dynamic> timeData = [
    {"startTime": "09:00", "endtime": "09:30", "edit": true},
    {"startTime": "09:00", "endtime": "09:30", "edit": true},
    {"startTime": "09:00", "endtime": "09:30", "edit": true},
    {"startTime": "09:00", "endtime": "09:30", "edit": true}
  ];

  List<dynamic> firsttimeData = [
    {"startTime": "09:00", "endtime": "09:30", "edit": true},
    {"startTime": "09:00", "endtime": "09:30", "edit": true},
    {"startTime": "09:00", "endtime": "09:30", "edit": true},
    {"startTime": "09:00", "endtime": "09:30", "edit": true}
  ];

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
                                              GestureDetector(
                                                child: Container(
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
                                                onTap: () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i <
                                                            firsttimeData
                                                                .length;
                                                        i++) {
                                                      if (i ==
                                                          firstscheduleSelect) {
                                                        // Set edit to true for the selected index
                                                        firsttimeData[i]
                                                            ['edit'] = false;
                                                      } else {
                                                        // Set edit to false for all other indices
                                                        firsttimeData[i]
                                                            ['edit'] = true;
                                                      }
                                                    }
                                                  });
                                                },
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
                                            GestureDetector(
                                              child: Container(
                                                height: 22,
                                                decoration: BoxDecoration(
                                                    color: HexColor("#FF65DE"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Text(
                                                  "Save",
                                                  style:
                                                      CustomFonts.slussen10W500(
                                                          color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  firsttimeData.add({
                                                    "startTime":
                                                        firststartTimeController[
                                                                firstscheduleSelect]
                                                            .text,
                                                    "endtime":
                                                        firstendTimeController[
                                                                firstscheduleSelect]
                                                            .text,
                                                    "edit": true
                                                  });
                                                  firstscheduleSelect = -1;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  firsttimeData.add({
                                                    "startTime": "",
                                                    "endtime": "",
                                                    "edit": true
                                                  });
                                                });
                                              },
                                              child: Container(
                                                height: 22,
                                                decoration: BoxDecoration(
                                                    color: HexColor("#FF65DE"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 12),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/white_add.png",
                                                      height: 12,
                                                      width: 12,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "Add",
                                                      style: CustomFonts
                                                          .slussen10W500(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  barrierColor:
                                                      HexColor("#201A3F")
                                                          .withOpacity(0.8),
                                                  builder: (context) {
                                                    return DeleteDialog(
                                                      onTap: () {
                                                        setState(() {
                                                          firsttimeData.removeAt(
                                                              firstscheduleSelect);
                                                          firstscheduleSelect =
                                                              -1;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                height: 22,
                                                decoration: BoxDecoration(
                                                    color: HexColor("#201A3F"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 12),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/blue_delete.png",
                                                      height: 12,
                                                      width: 12,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "Delete",
                                                      style: CustomFonts
                                                          .slussen10W500(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ],
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
                                        Container(
                                          height: 140,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: firsttimeData.length,
                                            itemBuilder: (context, index) {
                                              firststartTimeController
                                                  .add(TextEditingController(
                                                text: firsttimeData[index]
                                                                ["startTime"]
                                                            ?.isNotEmpty ??
                                                        false
                                                    ? firsttimeData[index]
                                                        ["startTime"]
                                                    : '',
                                              ));
                                              firstendTimeController
                                                  .add(TextEditingController(
                                                text: firsttimeData[index]
                                                                ["endtime"]
                                                            ?.isNotEmpty ??
                                                        false
                                                    ? firsttimeData[index]
                                                        ["endtime"]
                                                    : '',
                                              ));
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      firstscheduleSelect =
                                                          index;

                                                      // if (timeData.containsKey(scheduleSelect)) {
                                                      // Retrieve the current data for the selected schedule
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 88,
                                                    height: 140,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#F7F9FC"),
                                                      gradient:
                                                          firstscheduleSelect ==
                                                                  index
                                                              ? LinearGradient(
                                                                  colors: [
                                                                      HexColor(
                                                                          goldLightColor),
                                                                      HexColor(
                                                                          goldDarkColor)
                                                                    ])
                                                              : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                                  color: HexColor(
                                                                          primaryColor)
                                                                      .withOpacity(
                                                                          .5)),
                                                        ),
                                                        TextField(
                                                          readOnly:
                                                              firsttimeData[
                                                                      index]
                                                                  ["edit"],
                                                          controller:
                                                              firststartTimeController[
                                                                  index],
                                                          style: CustomFonts
                                                              .slussen14W700(
                                                                  color: HexColor(
                                                                      primaryColor)),
                                                          textAlign:
                                                              TextAlign.center,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "00:00",
                                                            hintStyle: CustomFonts
                                                                .slussen14W700(
                                                                    color: HexColor(
                                                                            primaryColor)
                                                                        .withOpacity(
                                                                            .3)),
                                                          ),
                                                          onChanged: (value) {
                                                            if (value.length ==
                                                                    3 &&
                                                                value[2] ==
                                                                    ':') {
                                                              firststartTimeController[
                                                                          index]
                                                                      .text =
                                                                  firststartTimeController[
                                                                          index]
                                                                      .text
                                                                      .substring(
                                                                          0, 2);
                                                              firststartTimeController[
                                                                          index]
                                                                      .selection =
                                                                  TextSelection.fromPosition(TextPosition(
                                                                      offset: firststartTimeController[
                                                                              index]
                                                                          .text
                                                                          .length));
                                                            } else if (value
                                                                    .length ==
                                                                3) {
                                                              String char =
                                                                  firststartTimeController[
                                                                          index]
                                                                      .text[2];
                                                              firststartTimeController[
                                                                          index]
                                                                      .text =
                                                                  firststartTimeController[
                                                                          index]
                                                                      .text
                                                                      .substring(
                                                                          0, 2);
                                                              firststartTimeController[
                                                                          index]
                                                                      .text +=
                                                                  ':$char';
                                                              firststartTimeController[
                                                                          index]
                                                                      .selection =
                                                                  TextSelection.fromPosition(TextPosition(
                                                                      offset: firststartTimeController[
                                                                              index]
                                                                          .text
                                                                          .length));
                                                            } else if (value
                                                                    .length ==
                                                                5) {
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            } else if (value
                                                                    .length >
                                                                5) {
                                                              firststartTimeController[
                                                                          index]
                                                                      .text =
                                                                  firststartTimeController[
                                                                          index]
                                                                      .text
                                                                      .substring(
                                                                          0, 5);
                                                              firststartTimeController[
                                                                          index]
                                                                      .selection =
                                                                  TextSelection.fromPosition(TextPosition(
                                                                      offset: firststartTimeController[
                                                                              index]
                                                                          .text
                                                                          .length));
                                                            }
                                                          },
                                                        ),
                                                        Text(
                                                          "-",
                                                          style: CustomFonts
                                                              .slussen14W700(
                                                                  color: HexColor(
                                                                      primaryColor)),
                                                        ),
                                                        TextField(
                                                          readOnly:
                                                              firsttimeData[
                                                                      index]
                                                                  ["edit"],
                                                          controller:
                                                              firstendTimeController[
                                                                  index],
                                                          style: CustomFonts
                                                              .slussen14W700(
                                                                  color: HexColor(
                                                                      primaryColor)),
                                                          textAlign:
                                                              TextAlign.center,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "00:00",
                                                            hintStyle: CustomFonts
                                                                .slussen14W700(
                                                                    color: HexColor(
                                                                            primaryColor)
                                                                        .withOpacity(
                                                                            .3)),
                                                          ),
                                                          onChanged: (value) {
                                                            if (value.length ==
                                                                    3 &&
                                                                value[2] ==
                                                                    ':') {
                                                              firstendTimeController[
                                                                          index]
                                                                      .text =
                                                                  firstendTimeController[
                                                                          index]
                                                                      .text
                                                                      .substring(
                                                                          0, 2);
                                                              firstendTimeController[
                                                                          index]
                                                                      .selection =
                                                                  TextSelection.fromPosition(TextPosition(
                                                                      offset: firstendTimeController[
                                                                              index]
                                                                          .text
                                                                          .length));
                                                            } else if (value
                                                                    .length ==
                                                                3) {
                                                              String char =
                                                                  firstendTimeController[
                                                                          index]
                                                                      .text[2];
                                                              firstendTimeController[
                                                                          index]
                                                                      .text =
                                                                  firstendTimeController[
                                                                          index]
                                                                      .text
                                                                      .substring(
                                                                          0, 2);
                                                              firstendTimeController[
                                                                          index]
                                                                      .text +=
                                                                  ':$char';
                                                              firstendTimeController[
                                                                          index]
                                                                      .selection =
                                                                  TextSelection.fromPosition(TextPosition(
                                                                      offset: firstendTimeController[
                                                                              index]
                                                                          .text
                                                                          .length));
                                                            } else if (value
                                                                    .length ==
                                                                5) {
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            } else if (value
                                                                    .length >
                                                                5) {
                                                              firstendTimeController[
                                                                          index]
                                                                      .text =
                                                                  firstendTimeController[
                                                                          index]
                                                                      .text
                                                                      .substring(
                                                                          0, 5);
                                                              firstendTimeController[
                                                                          index]
                                                                      .selection =
                                                                  TextSelection.fromPosition(TextPosition(
                                                                      offset: firstendTimeController[
                                                                              index]
                                                                          .text
                                                                          .length));
                                                            }
                                                          },
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
                                                ),
                                              );
                                            },
                                          ),
                                        )
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
                                                      GestureDetector(
                                                        child: Container(
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
                                                        onTap: () {
                                                          setState(() {
                                                            for (int i = 0;
                                                                i <
                                                                    timeData
                                                                        .length;
                                                                i++) {
                                                              if (i ==
                                                                  scheduleSelect) {
                                                                // Set edit to true for the selected index
                                                                timeData[i][
                                                                        'edit'] =
                                                                    false;
                                                              } else {
                                                                // Set edit to false for all other indices
                                                                timeData[i][
                                                                        'edit'] =
                                                                    true;
                                                              }
                                                            }
                                                          });
                                                        },
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
                                                    GestureDetector(
                                                      child: Container(
                                                        height: 22,
                                                        decoration: BoxDecoration(
                                                            color: HexColor(
                                                                "#FF65DE"),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        alignment:
                                                            Alignment.center,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15),
                                                        child: Text(
                                                          "Save",
                                                          style: CustomFonts
                                                              .slussen10W500(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          timeData.add({
                                                            "startTime":
                                                                startTimeController[
                                                                        scheduleSelect]
                                                                    .text,
                                                            "endtime":
                                                                endTimeController[
                                                                        scheduleSelect]
                                                                    .text,
                                                            "edit": true
                                                          });
                                                          scheduleSelect = -1;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          timeData.add({
                                                            "startTime": "",
                                                            "endtime": "",
                                                            "edit": true
                                                          });
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 22,
                                                        decoration: BoxDecoration(
                                                            color: HexColor(
                                                                "#FF65DE"),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                right: 12),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/white_add.png",
                                                              height: 12,
                                                              width: 12,
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              "Add",
                                                              style: CustomFonts
                                                                  .slussen10W500(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {

                                                        showModalBottomSheet(
                                                          context: context,
                                                          barrierColor:
                                                          HexColor("#201A3F")
                                                              .withOpacity(0.8),
                                                          builder: (context) {
                                                            return DeleteDialog(
                                                              onTap: () {
                                                                setState(() {
                                                                  timeData.removeAt(
                                                                      scheduleSelect);
                                                                  scheduleSelect = -1;
                                                                });
                                                                Navigator.pop(context);
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 22,
                                                        decoration: BoxDecoration(
                                                            color: HexColor(
                                                                "#201A3F"),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                right: 12),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/blue_delete.png",
                                                              height: 12,
                                                              width: 12,
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              "Delete",
                                                              style: CustomFonts
                                                                  .slussen10W500(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ],
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
                                                Container(
                                                  height: 140,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: timeData.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      if (timeData[index]
                                                              ["startTime"] ==
                                                          "") {
                                                        startTimeController.add(
                                                            new TextEditingController());
                                                        endTimeController.add(
                                                            new TextEditingController());
                                                        startTimeController[
                                                                index]
                                                            .clear();
                                                        endTimeController[index]
                                                            .clear();
                                                      } else {
                                                        startTimeController.add(
                                                            new TextEditingController(
                                                                text: timeData[
                                                                        index][
                                                                    "startTime"]));
                                                        endTimeController.add(
                                                            new TextEditingController(
                                                                text: timeData[
                                                                        index][
                                                                    "endtime"]));
                                                      }

                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              scheduleSelect =
                                                                  index;

                                                              // if (timeData.containsKey(scheduleSelect)) {
                                                              // Retrieve the current data for the selected schedule
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 88,
                                                            height: 140,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: HexColor(
                                                                  "#F7F9FC"),
                                                              gradient: scheduleSelect ==
                                                                      index
                                                                  ? LinearGradient(
                                                                      colors: [
                                                                          HexColor(
                                                                              goldLightColor),
                                                                          HexColor(
                                                                              goldDarkColor)
                                                                        ])
                                                                  : null,
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
                                                                  style: CustomFonts.slussen10W600(
                                                                      color: HexColor(
                                                                              primaryColor)
                                                                          .withOpacity(
                                                                              .5)),
                                                                ),
                                                                TextField(
                                                                  readOnly: timeData[
                                                                          index]
                                                                      ["edit"],
                                                                  controller:
                                                                      startTimeController[
                                                                          index],
                                                                  style: CustomFonts
                                                                      .slussen14W700(
                                                                          color:
                                                                              HexColor(primaryColor)),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "00:00",
                                                                    hintStyle: CustomFonts
                                                                        .slussen14W700(
                                                                            color:
                                                                                HexColor(primaryColor).withOpacity(.3)),
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    if (value.length ==
                                                                            3 &&
                                                                        value[2] ==
                                                                            ':') {
                                                                      startTimeController[
                                                                              index]
                                                                          .text = startTimeController[
                                                                              index]
                                                                          .text
                                                                          .substring(
                                                                              0,
                                                                              2);
                                                                      startTimeController[index]
                                                                              .selection =
                                                                          TextSelection.fromPosition(
                                                                              TextPosition(offset: startTimeController[index].text.length));
                                                                    } else if (value
                                                                            .length ==
                                                                        3) {
                                                                      String
                                                                          char =
                                                                          startTimeController[index]
                                                                              .text[2];
                                                                      startTimeController[
                                                                              index]
                                                                          .text = startTimeController[
                                                                              index]
                                                                          .text
                                                                          .substring(
                                                                              0,
                                                                              2);
                                                                      startTimeController[index]
                                                                              .text +=
                                                                          ':$char';
                                                                      startTimeController[index]
                                                                              .selection =
                                                                          TextSelection.fromPosition(
                                                                              TextPosition(offset: startTimeController[index].text.length));
                                                                    } else if (value
                                                                            .length ==
                                                                        5) {
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    } else if (value
                                                                            .length >
                                                                        5) {
                                                                      startTimeController[
                                                                              index]
                                                                          .text = startTimeController[
                                                                              index]
                                                                          .text
                                                                          .substring(
                                                                              0,
                                                                              5);
                                                                      startTimeController[index]
                                                                              .selection =
                                                                          TextSelection.fromPosition(
                                                                              TextPosition(offset: startTimeController[index].text.length));
                                                                    }
                                                                  },
                                                                ),
                                                                Text(
                                                                  "-",
                                                                  style: CustomFonts
                                                                      .slussen14W700(
                                                                          color:
                                                                              HexColor(primaryColor)),
                                                                ),
                                                                TextField(
                                                                  readOnly: timeData[
                                                                          index]
                                                                      ["edit"],
                                                                  controller:
                                                                      endTimeController[
                                                                          index],
                                                                  style: CustomFonts
                                                                      .slussen14W700(
                                                                          color:
                                                                              HexColor(primaryColor)),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "00:00",
                                                                    hintStyle: CustomFonts
                                                                        .slussen14W700(
                                                                            color:
                                                                                HexColor(primaryColor).withOpacity(.3)),
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    if (value.length ==
                                                                            3 &&
                                                                        value[2] ==
                                                                            ':') {
                                                                      endTimeController[
                                                                              index]
                                                                          .text = endTimeController[
                                                                              index]
                                                                          .text
                                                                          .substring(
                                                                              0,
                                                                              2);
                                                                      endTimeController[index]
                                                                              .selection =
                                                                          TextSelection.fromPosition(
                                                                              TextPosition(offset: endTimeController[index].text.length));
                                                                    } else if (value
                                                                            .length ==
                                                                        3) {
                                                                      String
                                                                          char =
                                                                          endTimeController[index]
                                                                              .text[2];
                                                                      endTimeController[
                                                                              index]
                                                                          .text = endTimeController[
                                                                              index]
                                                                          .text
                                                                          .substring(
                                                                              0,
                                                                              2);
                                                                      endTimeController[index]
                                                                              .text +=
                                                                          ':$char';
                                                                      endTimeController[index]
                                                                              .selection =
                                                                          TextSelection.fromPosition(
                                                                              TextPosition(offset: endTimeController[index].text.length));
                                                                    } else if (value
                                                                            .length ==
                                                                        5) {
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    } else if (value
                                                                            .length >
                                                                        5) {
                                                                      endTimeController[
                                                                              index]
                                                                          .text = endTimeController[
                                                                              index]
                                                                          .text
                                                                          .substring(
                                                                              0,
                                                                              5);
                                                                      endTimeController[index]
                                                                              .selection =
                                                                          TextSelection.fromPosition(
                                                                              TextPosition(offset: endTimeController[index].text.length));
                                                                    }
                                                                  },
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
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
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
