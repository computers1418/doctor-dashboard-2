import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/controller/set_schedule_controller.dart';
import 'package:doctor_dashboard/model/schedule_model.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:slider_button/slider_button.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

import '../../constants/delete_dialog.dart';
import '../../date_picker/src/properties/date_formatter.dart';
import '../../date_picker/src/properties/day_style.dart';
import '../../date_picker/src/properties/easy_day_props.dart';
import '../../date_picker/src/properties/easy_header_props.dart';
import '../../date_picker/src/widgets/easy_date_timeline_widget/easy_date_timeline_widget.dart';
import '../../widgets/drawer.dart';

class SetSchedule extends StatefulWidget {
  const SetSchedule({Key? key}) : super(key: key);

  @override
  State<SetSchedule> createState() => _SetScheduleState();
}

class _SetScheduleState extends State<SetSchedule>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  DateTime dateTime = DateTime.now();
  final ScrollController _firstController = ScrollController();

  List<dynamic> firsttimeData = [
    {"startTime": "09:00", "endtime": "09:30", "edit": true},
    {"startTime": "09:00", "endtime": "09:30", "edit": true},
    {"startTime": "09:00", "endtime": "09:30", "edit": true},
    {"startTime": "09:00", "endtime": "09:30", "edit": true}
  ];
  final _scrollController = ScrollController();
  double _currentOffset = 0.0;
  bool edit = false;

  List icons = ['Set Problem', 'Set Test', 'Set Medicine', 'Set Surgery'];

  int selectedIcon = 0;

  // List<TextEditingController> firststartTimeController = [];
  // List<TextEditingController> firstendTimeController = [];

  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final minController = TextEditingController();
  String startTimeam = "Am";
  String endTimeam = "Am";
  int editSchedule = -1;
  dynamic selectSlotData;
  int addSlot = 0;
  bool editTextField = false;

  int selectedDate = -1;
  List<dynamic> schedule = [
    {"date": "21 Feb, Wed", "check": false},
    {"date": "22 Feb, Thu", "check": true},
    {"date": "23 Feb, Fri", "check": true},
    {"date": "24 Feb, Sat", "check": false},
    {"date": "25 Feb, Sun", "check": false},
    {"date": "25 Feb, Mon", "check": false},
  ];

  List days = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  // int selectedDate = 3;
  SetScheduleController setScheduleController =
      Get.put(SetScheduleController());
  FToast? fToast;

  @override
  void initState() {
    super.initState();
    setScheduleController.getScheduleByDate({
      "doctorId": "66a776f354c2bd0642e7b5e7",
      "dateArray": ["${DateFormat("yyyy-MM-dd").format(dateTime)}"]
    }, context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.light, //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    fToast = FToast();
    fToast?.init(context);

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
    return GetBuilder<SetScheduleController>(
      init: SetScheduleController(),
      builder: (schedule) => AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 : 0.6 * screenWidth,
        right: isCollapsed ? 0 : -0.2 * screenWidth,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            animationDuration: duration,
            borderRadius:
                BorderRadius.all(Radius.circular(isCollapsed ? 0 : 40)),
            elevation: 8,
            color: Colors.white,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(isCollapsed ? 0 : 40)),
                child: Container(
                  width: double.infinity,
                  color: HexColor("#201A3F"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppbar(callback: callback),
                      SizedBox(
                        height: screenHeight * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.0175),
                              child: Text(
                                "Schedules",
                                style: CustomFonts.slussen32W700(
                                    color: HexColor("#FFFFFF")),
                              ),
                            ),
                            Text(
                              "Set",
                              style: CustomFonts.slussen14W500(
                                  color: HexColor("#FFFFFF").withOpacity(.5)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: HexColor("#F2F7FB"),
                          child: DynMouseScroll(
                            durationMS: 5000,
                            scrollSpeed: -4.4,
                            builder: (context, controller, physics) => ListView(
                              controller: _scrollController,
                              // physics: isCollapsed
                              //     ? physics
                              //     : const NeverScrollableScrollPhysics(),
                              children: [
                                EasyDateTimeLine(
                                  initialDate: DateTime.now(),
                                  onDateChange: (selectedDate) {
                                    setState(() {
                                      dateTime = selectedDate;
                                      selectSlotData = null;
                                      setScheduleController.getScheduleByDate({
                                        "doctorId": "66a776f354c2bd0642e7b5e7",
                                        "dateArray": [
                                          "${DateFormat("yyyy-MM-dd").format(dateTime)}"
                                        ]
                                      }, context);
                                    });
                                  },
                                  headerProps: EasyHeaderProps(
                                      monthPickerType: MonthPickerType.switcher,
                                      dateFormatter:
                                          DateFormatter.fullDateDMY(),
                                      showSelectedDate: false,
                                      monthStyle: CustomFonts.slussen24W700(
                                          color: HexColor("#E49356"))),
                                  dayProps: EasyDayProps(
                                    height: 100,
                                    width: 100,
                                    dayStructure: DayStructure.dayStrDayNum,
                                    todayStyle: DayStyle(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35)),
                                            color: Colors.white),
                                        dayNumStyle: CustomFonts.slussen32W700(
                                            color: HexColor(primaryColor)
                                                .withOpacity(.5)),
                                        dayStrStyle: CustomFonts.slussen16W500(
                                            color: HexColor(primaryColor)
                                                .withOpacity(.5))),
                                    inactiveDayStyle: DayStyle(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35)),
                                            color: Colors.white),
                                        dayNumStyle: CustomFonts.slussen32W700(
                                            color: HexColor(primaryColor)
                                                .withOpacity(.5)),
                                        dayStrStyle: CustomFonts.slussen16W500(
                                            color: HexColor(primaryColor)
                                                .withOpacity(.5))),
                                    activeDayStyle: DayStyle(
                                      dayNumStyle: CustomFonts.slussen32W700(
                                          color: Colors.white),
                                      dayStrStyle: CustomFonts.slussen16W500(
                                          color: Colors.white),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35)),
                                          gradient: LinearGradient(colors: [
                                            HexColor(goldLightColor),
                                            HexColor(goldDarkColor)
                                          ])),
                                    ),
                                  ),
                                  onTap: () {
                                    setScheduleController.createSchedule({
                                      "doctorId": "66a776f354c2bd0642e7b5e7",
                                      "startTime":
                                          "${startTimeController.text} ${startTimeam}",
                                      "endTime":
                                          "${endTimeController.text} ${endTimeam}",
                                      "duration": int.parse(minController.text),
                                      "date": DateFormat("yyyy-MM-dd")
                                          .format(dateTime)
                                    }, context, fToast, dateTime);
                                    selectSlotData = null;
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    "Set Time",
                                    style: CustomFonts.slussen16W700(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Start Time",
                                                    style: CustomFonts
                                                        .slussen12W700(
                                                            color: HexColor(
                                                                    primaryColor)
                                                                .withOpacity(
                                                                    .5)),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Container(
                                                    // height: 60,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(45),
                                                        color: HexColor(
                                                            "#F2F7FB")),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextField(
                                                            controller:
                                                                startTimeController,
                                                            style: CustomFonts
                                                                .slussen24W700(
                                                                    color: HexColor(
                                                                        primaryColor)),
                                                            decoration:
                                                                InputDecoration(
                                                              // contentPadding:
                                                              //     const EdgeInsets
                                                              //         .symmetric(
                                                              //         horizontal:
                                                              //             12),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText: "00:00",
                                                              hintStyle: CustomFonts.slussen24W700(
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
                                                                startTimeController
                                                                        .text =
                                                                    startTimeController
                                                                        .text
                                                                        .substring(
                                                                            0,
                                                                            2);
                                                                startTimeController
                                                                        .selection =
                                                                    TextSelection.fromPosition(TextPosition(
                                                                        offset: startTimeController
                                                                            .text
                                                                            .length));
                                                              } else if (value
                                                                      .length ==
                                                                  3) {
                                                                String char =
                                                                    startTimeController
                                                                        .text[2];
                                                                startTimeController
                                                                        .text =
                                                                    startTimeController
                                                                        .text
                                                                        .substring(
                                                                            0,
                                                                            2);
                                                                startTimeController
                                                                        .text +=
                                                                    ':$char';
                                                                startTimeController
                                                                        .selection =
                                                                    TextSelection.fromPosition(TextPosition(
                                                                        offset: startTimeController
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
                                                                startTimeController
                                                                        .text =
                                                                    startTimeController
                                                                        .text
                                                                        .substring(
                                                                            0,
                                                                            5);
                                                                startTimeController
                                                                        .selection =
                                                                    TextSelection.fromPosition(TextPosition(
                                                                        offset: startTimeController
                                                                            .text
                                                                            .length));
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              startTimeam =
                                                                  "Am";
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: startTimeam ==
                                                                        "Am"
                                                                    ? HexColor(
                                                                        pinkColor)
                                                                    : HexColor(
                                                                            pinkColor)
                                                                        .withOpacity(
                                                                            .5),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Center(
                                                              child: Text(
                                                                "AM",
                                                                style: CustomFonts
                                                                    .slussen10W700(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              startTimeam =
                                                                  "Pm";
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: startTimeam ==
                                                                        "Pm"
                                                                    ? HexColor(
                                                                        pinkColor)
                                                                    : HexColor(
                                                                            pinkColor)
                                                                        .withOpacity(
                                                                            .5),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Center(
                                                              child: Text(
                                                                "PM",
                                                                style: CustomFonts
                                                                    .slussen10W700(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "End Time",
                                                    style: CustomFonts
                                                        .slussen12W700(
                                                            color: HexColor(
                                                                    primaryColor)
                                                                .withOpacity(
                                                                    .5)),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Container(
                                                    // height: 60,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(45),
                                                        color: HexColor(
                                                            "#F2F7FB")),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextField(
                                                            controller:
                                                                endTimeController,
                                                            style: CustomFonts
                                                                .slussen24W700(
                                                                    color: HexColor(
                                                                        primaryColor)),
                                                            decoration:
                                                                InputDecoration(
                                                              // contentPadding:
                                                              //     const EdgeInsets
                                                              //         .symmetric(
                                                              //         horizontal:
                                                              //             12),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText: "00:00",
                                                              hintStyle: CustomFonts.slussen24W700(
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
                                                                endTimeController
                                                                        .text =
                                                                    endTimeController
                                                                        .text
                                                                        .substring(
                                                                            0,
                                                                            2);
                                                                endTimeController
                                                                        .selection =
                                                                    TextSelection.fromPosition(TextPosition(
                                                                        offset: endTimeController
                                                                            .text
                                                                            .length));
                                                              } else if (value
                                                                      .length ==
                                                                  3) {
                                                                String char =
                                                                    endTimeController
                                                                        .text[2];
                                                                endTimeController
                                                                        .text =
                                                                    endTimeController
                                                                        .text
                                                                        .substring(
                                                                            0,
                                                                            2);
                                                                endTimeController
                                                                        .text +=
                                                                    ':$char';
                                                                endTimeController
                                                                        .selection =
                                                                    TextSelection.fromPosition(TextPosition(
                                                                        offset: endTimeController
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
                                                                endTimeController
                                                                        .text =
                                                                    endTimeController
                                                                        .text
                                                                        .substring(
                                                                            0,
                                                                            5);
                                                                endTimeController
                                                                        .selection =
                                                                    TextSelection.fromPosition(TextPosition(
                                                                        offset: endTimeController
                                                                            .text
                                                                            .length));
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              endTimeam = "Am";
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: endTimeam ==
                                                                        "Am"
                                                                    ? HexColor(
                                                                        pinkColor)
                                                                    : HexColor(
                                                                            pinkColor)
                                                                        .withOpacity(
                                                                            .5),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Center(
                                                              child: Text(
                                                                "AM",
                                                                style: CustomFonts
                                                                    .slussen10W700(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              endTimeam = "Pm";
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: endTimeam ==
                                                                        "Pm"
                                                                    ? HexColor(
                                                                        pinkColor)
                                                                    : HexColor(
                                                                            pinkColor)
                                                                        .withOpacity(
                                                                            .5),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Center(
                                                              child: Text(
                                                                "PM",
                                                                style: CustomFonts
                                                                    .slussen10W700(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Start Interval",
                                                    style: CustomFonts
                                                        .slussen12W700(
                                                            color: HexColor(
                                                                    primaryColor)
                                                                .withOpacity(
                                                                    .5)),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 16,
                                                        horizontal: 13),
                                                    decoration: BoxDecoration(
                                                      color: HexColor(
                                                          primaryColor),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(56),
                                                        topRight:
                                                            Radius.circular(56),
                                                        bottomLeft:
                                                            Radius.circular(56),
                                                        bottomRight:
                                                            Radius.circular(30),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        GestureDetector(
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: HexColor(
                                                                    pinkColor),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Center(
                                                              child: Text(
                                                                "-",
                                                                style: CustomFonts
                                                                    .slussen20W700(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            String text =
                                                                minController
                                                                    .text;
                                                            if (text
                                                                .isNotEmpty) {
                                                              if (text ==
                                                                  "01") {
                                                                minController
                                                                    .clear();
                                                              } else {
                                                                try {
                                                                  int value =
                                                                      int.parse(
                                                                          text);
                                                                  value =
                                                                      value - 1;

                                                                  String
                                                                      decrementedValue =
                                                                      value
                                                                          .toString();

                                                                  // Ensure the length is at least 2 by padding with zeros
                                                                  if (decrementedValue
                                                                          .length <
                                                                      2) {
                                                                    decrementedValue =
                                                                        decrementedValue.padLeft(
                                                                            2,
                                                                            '0');
                                                                  }

                                                                  // If the length is more than 2, take only the first 2 characters
                                                                  if (decrementedValue
                                                                          .length >
                                                                      2) {
                                                                    decrementedValue =
                                                                        decrementedValue.substring(
                                                                            0,
                                                                            2);
                                                                  }

                                                                  minController
                                                                          .text =
                                                                      decrementedValue;
                                                                } catch (e) {
                                                                  // Handle the error, e.g., show a message to the user
                                                                  print(
                                                                      "Invalid number format");
                                                                }
                                                              }
                                                            }
                                                          },
                                                        ),
                                                        TextField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          controller:
                                                              minController,
                                                          style: CustomFonts
                                                              .slussen24W700(
                                                                  color: HexColor(
                                                                      "#FFFFFF")),
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12),
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "00",
                                                            hintStyle: CustomFonts
                                                                .slussen24W700(
                                                                    color: HexColor(
                                                                            "#FFFFFF")
                                                                        .withOpacity(
                                                                            .3)),
                                                          ),
                                                          onChanged: (value) {
                                                            if (value.length ==
                                                                2) {
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            } else if (value
                                                                    .length >
                                                                2) {
                                                              minController
                                                                      .text =
                                                                  minController
                                                                      .text
                                                                      .substring(
                                                                          0, 2);
                                                            }
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            String text =
                                                                minController
                                                                    .text;
                                                            if (text
                                                                .isNotEmpty) {
                                                              try {
                                                                int value =
                                                                    int.parse(
                                                                        text);
                                                                String
                                                                    incrementedValue =
                                                                    (value + 1)
                                                                        .toString();

                                                                // Ensure the length is at least 2
                                                                if (incrementedValue
                                                                        .length <
                                                                    2) {
                                                                  incrementedValue =
                                                                      incrementedValue
                                                                          .padLeft(
                                                                              2,
                                                                              '0');
                                                                }

                                                                // If the length is more than 2, take only the first 2 characters
                                                                if (incrementedValue
                                                                        .length >
                                                                    2) {
                                                                  incrementedValue =
                                                                      incrementedValue
                                                                          .substring(
                                                                              0,
                                                                              2);
                                                                }

                                                                minController
                                                                        .text =
                                                                    incrementedValue;
                                                              } catch (e) {
                                                                // Handle the error, e.g., show a message to the user
                                                                print(
                                                                    "Invalid number format");
                                                              }
                                                            } else {
                                                              minController
                                                                  .text = "01";
                                                            }
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: HexColor(
                                                                    pinkColor),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Center(
                                                              child: Text(
                                                                "+",
                                                                style: CustomFonts
                                                                    .slussen20W700(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    )),
                                // Padding(
                                //   padding: const EdgeInsets.all(16.0),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             "26 Feb, Monday",
                                //             style: CustomFonts.slussen16W700(
                                //                 color: HexColor(primaryColor)),
                                //           ),
                                //           Text(
                                //             "10 Appointments scheduled for today",
                                //             style: TextStyle(
                                //               color: HexColor(primaryColor)
                                //                   .withOpacity(.4),
                                //               fontSize: 8,
                                //               fontWeight: FontWeight.w400,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       Row(
                                //         children: [
                                //           Container(
                                //             padding: const EdgeInsets.all(9),
                                //             height: 30,
                                //             width: 30,
                                //             decoration: BoxDecoration(
                                //               shape: BoxShape.circle,
                                //               color: HexColor("#F7F9FC"),
                                //             ),
                                //             child: Center(
                                //                 child: Image.asset(
                                //                     "assets/images/delete.png")),
                                //           ),
                                //           const SizedBox(
                                //             width: 4,
                                //           ),
                                //           Container(
                                //             padding: const EdgeInsets.symmetric(
                                //                 horizontal: 12),
                                //             height: 30,
                                //             decoration: BoxDecoration(
                                //               color: HexColor(pinkColor),
                                //               borderRadius:
                                //                   BorderRadius.circular(40),
                                //             ),
                                //             child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.center,
                                //               children: [
                                //                 Text(
                                //                   "schedules ",
                                //                   style:
                                //                       CustomFonts.slussen10W700(
                                //                           color: Colors.white),
                                //                 ),
                                //                 const Icon(
                                //                   Icons.keyboard_arrow_up,
                                //                   color: Colors.white,
                                //                   size: 14,
                                //                 )
                                //               ],
                                //             ),
                                //           ),
                                //         ],
                                //       )
                                //     ],
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                // SingleChildScrollView(
                                //   scrollDirection: Axis.horizontal,
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 16),
                                //     child: Row(
                                //       children: [
                                //         for (int i = 0; i < 8; i++)
                                //           Padding(
                                //             padding:
                                //                 const EdgeInsets.only(right: 8),
                                //             child: Container(
                                //               padding: const EdgeInsets.symmetric(
                                //                   horizontal: 24, vertical: 16),
                                //               // height: 110,
                                //               decoration: BoxDecoration(
                                //                 color: HexColor("#FFFFFF"),
                                //                 borderRadius:
                                //                     BorderRadius.circular(25),
                                //               ),
                                //               child: Column(
                                //                 mainAxisAlignment:
                                //                     MainAxisAlignment.center,
                                //                 children: [
                                //                   Text(
                                //                     "Am",
                                //                     style:
                                //                         CustomFonts.slussen10W600(
                                //                             color: HexColor(
                                //                                     primaryColor)
                                //                                 .withOpacity(.5)),
                                //                   ),
                                //                   Text(
                                //                     "09:00",
                                //                     style:
                                //                         CustomFonts.slussen14W700(
                                //                             color: HexColor(
                                //                                 primaryColor)),
                                //                   ),
                                //                   Text(
                                //                     "-",
                                //                     style:
                                //                         CustomFonts.slussen14W700(
                                //                             color: HexColor(
                                //                                 primaryColor)),
                                //                   ),
                                //                   Text(
                                //                     "09:30",
                                //                     style:
                                //                         CustomFonts.slussen14W700(
                                //                             color: HexColor(
                                //                                 primaryColor)),
                                //                   ),
                                //                   Text(
                                //                     "Am",
                                //                     style:
                                //                         CustomFonts.slussen10W600(
                                //                             color: HexColor(
                                //                                 primaryColor)),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //           )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 16,
                                ),
                                schedule.isDataLoading.value
                                    ? Center(child: CircularProgressIndicator())
                                    : schedule.schduleList.isEmpty
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          35)),
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
                                                            DateFormat(
                                                                    'dd MMM, EEEE')
                                                                .format(DateTime
                                                                    .parse(schedule
                                                                        .schduleList
                                                                        .first
                                                                        .date)),
                                                            style: CustomFonts
                                                                .slussen16W700(
                                                                    color: HexColor(
                                                                        primaryColor)),
                                                          ),
                                                          Text(
                                                            "${schedule.schduleList.first.slots.length} Appointments scheduled for today",
                                                            style: TextStyle(
                                                              color: HexColor(
                                                                      primaryColor)
                                                                  .withOpacity(
                                                                      .4),
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: HexColor(
                                                                    "#F7F9FC"),
                                                              ),
                                                              child: Center(
                                                                  child: Image
                                                                      .asset(
                                                                          "assets/images/edit.png")),
                                                            ),
                                                            onTap: () {
                                                              if (selectSlotData !=
                                                                  null) {
                                                                setScheduleController
                                                                    .updateReadStatus(
                                                                        selectSlotData);
                                                              }
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          InkWell(
                                                            onTap: () =>
                                                                setState(() {
                                                              if (selectedDate ==
                                                                  -1) {
                                                                selectedDate =
                                                                    -2;
                                                              } else {
                                                                selectedDate =
                                                                    -1;
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
                                                                            color:
                                                                                Colors.white),
                                                                  ),
                                                                  Icon(
                                                                    selectedDate != -2
                                                                        ? Icons
                                                                            .keyboard_arrow_up
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
                                                                color: HexColor(
                                                                    "#FF65DE"),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                            alignment: Alignment
                                                                .center,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15),
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
                                                              if (schedule
                                                                  .newList
                                                                  .where((element) =>
                                                                      element[
                                                                          "new"] ==
                                                                      true)
                                                                  .isNotEmpty) {
                                                                print(true);
                                                                List<
                                                                        Map<String,
                                                                            dynamic>>
                                                                    slotList =
                                                                    [];
                                                                for (int i = 0;
                                                                    i <
                                                                        schedule
                                                                            .newList
                                                                            .length;
                                                                    i++) {
                                                                  if (schedule.newList[
                                                                              i]
                                                                          [
                                                                          "new"] ==
                                                                      true) {
                                                                    slotList
                                                                        .add({
                                                                      "slotStartTime":
                                                                          "${DateFormat("yyyy-MM-dd").format(dateTime)} ${schedule.newList[i]["startController"].text} ${schedule.newList[i]["startAm"]}",
                                                                      "slotEndTime":
                                                                          "${DateFormat("yyyy-MM-dd").format(dateTime)} ${schedule.newList[i]["endController"].text} ${schedule.newList[i]["endAm"]}",
                                                                    });
                                                                  }
                                                                }
                                                                setScheduleController
                                                                    .createASlot(
                                                                        {
                                                                      "doctorId":
                                                                          "66a776f354c2bd0642e7b5e7",
                                                                      "slots":
                                                                          slotList,
                                                                      "date": DateFormat(
                                                                              "yyyy-MM-dd")
                                                                          .format(
                                                                              dateTime)
                                                                    },
                                                                        context,
                                                                        fToast,
                                                                        dateTime);
                                                              } else if (schedule
                                                                  .newList
                                                                  .where((element) =>
                                                                      element[
                                                                          "edit"] ==
                                                                      true)
                                                                  .isNotEmpty) {
                                                                print(
                                                                    "sdsdsdsd1111");
                                                                setScheduleController
                                                                    .updateSlotSchedule(
                                                                        context,
                                                                        fToast,
                                                                        DateFormat("yyyy-MM-dd")
                                                                            .format(dateTime))
                                                                    .then(
                                                                  (value) {
                                                                    selectSlotData =
                                                                        null;
                                                                    setScheduleController
                                                                        .getScheduleByDate({
                                                                      "doctorId":
                                                                          "66a776f354c2bd0642e7b5e7",
                                                                      "dateArray":
                                                                          [
                                                                        "${DateFormat("yyyy-MM-dd").format(dateTime)}"
                                                                      ]
                                                                    }, context);
                                                                  },
                                                                );
                                                              }
                                                            });
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            selectSlotData =
                                                                null;
                                                            setScheduleController
                                                                .addController({
                                                              "startAm": "AM",
                                                              "endAm": "AM",
                                                              "startTime": "",
                                                              "endTime": "",
                                                              "startController":
                                                                  TextEditingController(),
                                                              "endController":
                                                                  TextEditingController(),
                                                              "read": false,
                                                              "new": true,
                                                              "edit": false
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
                                                            alignment: Alignment
                                                                .center,
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
                                                            if (selectSlotData !=
                                                                null) {
                                                              showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                barrierColor: HexColor(
                                                                        "#201A3F")
                                                                    .withOpacity(
                                                                        0.8),
                                                                builder:
                                                                    (context) {
                                                                  return DeleteDialog(
                                                                    onTap: () {
                                                                      setScheduleController
                                                                          .deleteSlotOneByOne({
                                                                        "scheduleId": schedule
                                                                            .schduleList
                                                                            .first
                                                                            .id,
                                                                        "startTime":
                                                                            "${DateFormat("yyyy-MM-dd").format(dateTime)} ${selectSlotData!["startTime"]} ${selectSlotData!["startAm"]}"
                                                                      }, context,
                                                                              fToast).then(
                                                                        (value) {
                                                                          setScheduleController
                                                                              .getScheduleByDate({
                                                                            "doctorId":
                                                                                "66a776f354c2bd0642e7b5e7",
                                                                            "dateArray":
                                                                                [
                                                                              "${DateFormat("yyyy-MM-dd").format(dateTime)}"
                                                                            ]
                                                                          }, context);
                                                                          setState(
                                                                              () {
                                                                            selectSlotData =
                                                                                null;
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              );
                                                            }
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
                                                            alignment: Alignment
                                                                .center,
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
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: schedule
                                                            .newList.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  selectSlotData =
                                                                      schedule.newList[
                                                                          index];
                                                                });
                                                              },
                                                              child: Container(
                                                                width: 88,
                                                                height: 140,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: HexColor(
                                                                      "#F7F9FC"),
                                                                  gradient: index <
                                                                              schedule
                                                                                  .schduleList.first.slots.length &&
                                                                          selectSlotData ==
                                                                              schedule.newList[
                                                                                  index]
                                                                      ? LinearGradient(
                                                                          colors: [
                                                                              HexColor(goldLightColor),
                                                                              HexColor(goldDarkColor)
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
                                                                    GestureDetector(
                                                                      child:
                                                                          Text(
                                                                        schedule.newList[index]
                                                                            [
                                                                            "startAm"],
                                                                        style: CustomFonts.slussen10W600(
                                                                            color:
                                                                                HexColor(primaryColor)),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        if (schedule.newList[index]["edit"] ==
                                                                            true) {
                                                                          setScheduleController
                                                                              .updateStartAMPM(selectSlotData);
                                                                        }
                                                                      },
                                                                    ),
                                                                    TextField(
                                                                      readOnly:
                                                                          schedule.newList[index]
                                                                              [
                                                                              "read"],
                                                                      controller:
                                                                          schedule.newList[index]
                                                                              [
                                                                              "startController"],
                                                                      style: CustomFonts.slussen14W700(
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
                                                                            InputBorder.none,
                                                                        hintText:
                                                                            "00:00",
                                                                        hintStyle:
                                                                            CustomFonts.slussen14W700(color: HexColor(primaryColor).withOpacity(.3)),
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        // editTextField =
                                                                        //     true;
                                                                        setScheduleController.startControllerChange(
                                                                            value,
                                                                            index);
                                                                      },
                                                                    ),
                                                                    Text(
                                                                      "-",
                                                                      style: CustomFonts.slussen14W700(
                                                                          color:
                                                                              HexColor(primaryColor)),
                                                                    ),
                                                                    TextField(
                                                                      readOnly:
                                                                          schedule.newList[index]
                                                                              [
                                                                              "read"],
                                                                      controller:
                                                                          schedule.newList[index]
                                                                              [
                                                                              "endController"],
                                                                      style: CustomFonts.slussen14W700(
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
                                                                            InputBorder.none,
                                                                        hintText:
                                                                            "00:00",
                                                                        hintStyle:
                                                                            CustomFonts.slussen14W700(color: HexColor(primaryColor).withOpacity(.3)),
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        setScheduleController.endControllerChange(
                                                                            value,
                                                                            index);
                                                                      },
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        if (schedule.newList[index]["edit"] ==
                                                                            true) {
                                                                          setScheduleController
                                                                              .updateEndAMPM(selectSlotData);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        schedule.newList[index]
                                                                            [
                                                                            "endAm"],
                                                                        style: CustomFonts.slussen10W600(
                                                                            color:
                                                                                HexColor(primaryColor)),
                                                                      ),
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
                                GestureDetector(
                                  onTap: () {
                                    todayScheduleDialog();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: HexColor("#E49356"),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Image.asset(
                                                "assets/images/note.png"),
                                          ),
                                          Expanded(
                                              child: Text(
                                            "Copy Today's schedule for future",
                                            style: CustomFonts.slussen12W700(
                                                color: Colors.white),
                                          )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    previousScheduleDialog();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: HexColor("#E49356"),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Image.asset(
                                                "assets/images/note.png"),
                                          ),
                                          Expanded(
                                              child: Text(
                                            "Copy previous schedule for today",
                                            style: CustomFonts.slussen12W700(
                                                color: Colors.white),
                                          )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: HexColor("#E957C9")
                                              .withOpacity(.15),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: HexColor(pinkColor),
                                              size: 12,
                                            ),
                                            Text(
                                              " Tap to edit",
                                              style: CustomFonts.slussen9W700(
                                                  color: HexColor(pinkColor)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: HexColor("#E957C9")
                                              .withOpacity(.15),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: HexColor(pinkColor),
                                              size: 12,
                                            ),
                                            Text(
                                              " you can copy multiple schedules",
                                              style: CustomFonts.slussen9W700(
                                                  color: HexColor(pinkColor)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future todayScheduleDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: HexColor("#E49356"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          child: StatefulBuilder(
            builder: (context, setState) => ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                height: 400,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(35)),
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Copy Schedule",
                            style: CustomFonts.slussen16W700(
                                color: HexColor("#7F4010")),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 18),
                            child: Text(
                              "DONE",
                              style: CustomFonts.slussen10W700(
                                  color: HexColor("#201A3F")),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Expanded(
                        child: Theme(
                          data: ThemeData(
                            highlightColor: Colors.white, //Does not work
                          ),
                          child: RawScrollbar(
                            controller: _firstController,
                            thumbColor: Colors.white,
                            trackColor: HexColor("#F1A165"),
                            radius: Radius.circular(25),
                            trackRadius: Radius.circular(25),
                            trackBorderColor: HexColor("#F1A165"),
                            padding: EdgeInsets.only(bottom: 50),
                            thickness: 6,
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 6,
                                );
                              },
                              padding: EdgeInsets.only(right: 25),
                              controller: _firstController,
                              itemCount: schedule.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (schedule[index]["check"] == true) {
                                        schedule[index]["check"] = false;
                                      } else {
                                        schedule[index]["check"] = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("#F1A165"),
                                        borderRadius:
                                            BorderRadius.circular(45)),
                                    padding: EdgeInsets.only(
                                        left: 30,
                                        right: 14,
                                        top: 10,
                                        bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "2024",
                                                style: CustomFonts.slussen8W500(
                                                    color: HexColor("#7F4010")),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                schedule[index]["date"],
                                                style:
                                                    CustomFonts.slussen14W700(
                                                        color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        schedule[index]["check"] == true
                                            ? Image.asset(
                                                "lib/pages/set_schedule/assets/blue_check.png",
                                                height: 34,
                                                width: 34,
                                              )
                                            : Image.asset(
                                                "lib/pages/set_schedule/assets/add.png",
                                                height: 26,
                                                width: 26,
                                              )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future previousScheduleDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: HexColor("#E49356"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          child: StatefulBuilder(
            builder: (context, setState) => ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                height: 400,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(35)),
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Copy Schedule",
                            style: CustomFonts.slussen16W700(
                                color: HexColor("#7F4010")),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 18),
                            child: Text(
                              "DONE",
                              style: CustomFonts.slussen10W700(
                                  color: HexColor("#201A3F")),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Expanded(
                        child: Theme(
                          data: ThemeData(
                            highlightColor: Colors.white, //Does not work
                          ),
                          child: RawScrollbar(
                            controller: _firstController,
                            thumbColor: Colors.white,
                            trackColor: HexColor("#F1A165"),
                            radius: Radius.circular(25),
                            trackRadius: Radius.circular(25),
                            trackBorderColor: HexColor("#F1A165"),
                            padding: EdgeInsets.only(bottom: 50),
                            thickness: 6,
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 6,
                                );
                              },
                              padding: EdgeInsets.only(right: 25),
                              controller: _firstController,
                              itemCount: schedule.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (schedule[index]["check"] == true) {
                                        schedule[index]["check"] = false;
                                      } else {
                                        schedule[index]["check"] = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("#F1A165"),
                                        borderRadius:
                                            BorderRadius.circular(45)),
                                    padding: EdgeInsets.only(
                                        left: 30,
                                        right: 14,
                                        top: 10,
                                        bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "2024",
                                                style: CustomFonts.slussen8W500(
                                                    color: HexColor("#7F4010")),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                schedule[index]["date"],
                                                style:
                                                    CustomFonts.slussen14W700(
                                                        color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: HexColor("#E957C9"),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 14),
                                          child: Text(
                                            "View",
                                            style: CustomFonts.slussen9W700(
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Container(
                                          width: 34,
                                          alignment: Alignment.center,
                                          child:
                                              schedule[index]["check"] == true
                                                  ? Image.asset(
                                                      "lib/pages/set_schedule/assets/blue_check.png",
                                                      height: 34,
                                                      width: 34,
                                                    )
                                                  : Image.asset(
                                                      "lib/pages/set_schedule/assets/add.png",
                                                      height: 26,
                                                      width: 26,
                                                    ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ScheduleToggle extends StatefulWidget {
  final String initialTime;

  ScheduleToggle({required this.initialTime});

  @override
  _ScheduleToggleState createState() => _ScheduleToggleState();
}

class _ScheduleToggleState extends State<ScheduleToggle> {
  late String _timePeriod;

  @override
  void initState() {
    super.initState();
    _timePeriod = widget
        .initialTime; // Initialize with the initial time (either "AM" or "PM")
  }

  void _toggleTimePeriod() {
    setState(() {
      _timePeriod = _timePeriod == 'AM' ? 'PM' : 'AM';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleTimePeriod,
      child: Text(
        _timePeriod,
        style: CustomFonts.slussen10W600(color: HexColor(primaryColor)),
      ),
    );
  }
}
