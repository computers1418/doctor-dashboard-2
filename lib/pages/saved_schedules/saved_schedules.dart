import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/controller/set_schedule_controller.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

import '../../constants/delete_dialog.dart';
import '../../model/schedule_model.dart';
import '../../widgets/drawer.dart';
import '../set_schedule/set_schedule.dart';

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
  SetScheduleController setScheduleController =
      Get.put(SetScheduleController());

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

    if (setScheduleController.savedScheduleList.isEmpty) {
      setScheduleController.getSavedScheduleList({
        "doctorId": "66bf3adcdd3df57c89074fe1",
        "dateArray": generateDateList()
      }, context);
    }

    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(_controller);
  }

  List<String> generateDateList() {
    DateTime today = DateTime.now();
    List<String> dateList = [];

    // Calculate the date three months from today
    DateTime threeMonthsLater =
        DateTime(today.year, today.month + 3, today.day);

    // Generate dates from today until the date three months later
    for (DateTime date = today;
        date.isBefore(threeMonthsLater);
        date = date.add(Duration(days: 1))) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      dateList.add(formattedDate);
    }

    return dateList;
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
        ));
      } else {
        _scrollController.animateTo(0.0,
            duration: const Duration(microseconds: 10), curve: Curves.easeIn);
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
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
      builder: (controller) => AnimatedPositioned(
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
                    // DynMouseScroll(
                    //   durationMS: 5000,
                    //   scrollSpeed: -4.4,
                    //   builder: (context, controller, physics) =>
                    // ),
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
                            "Future",
                            style: CustomFonts.slussen14W500(
                                color: HexColor("#FFFFFF").withOpacity(.5)),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: screenHeight * .02,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Future schedules for 3 months",
                        style: CustomFonts.slussen12W400(
                            color: HexColor("#FFFFFF").withOpacity(.5)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: Container(
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
                            controller.isDataLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : controller.savedScheduleList.isEmpty
                                    ? SizedBox()
                                    : Expanded(
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          primary: true,
                                          shrinkWrap: false,
                                          itemCount: controller
                                              .savedScheduleList.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 12,
                                              ),
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
                                                              DateFormat('d MMM, EEEE').format(DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .parse(controller
                                                                      .savedScheduleList[
                                                                          index]
                                                                      .date)),
                                                              style: CustomFonts
                                                                  .slussen16W700(
                                                                      color: HexColor(
                                                                          primaryColor)),
                                                            ),
                                                            Text(
                                                              "${controller.savedScheduleList[index].slots.length} Appointments scheduled",
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
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            SetSchedule(
                                                                              id: controller.savedScheduleList[index].id,
                                                                              date: controller.savedScheduleList[index].date,
                                                                            ))).then(
                                                                  (value) {
                                                                    setScheduleController
                                                                        .getSavedScheduleList({
                                                                      "doctorId":
                                                                          "66bf3adcdd3df57c89074fe1",
                                                                      "dateArray":
                                                                          generateDateList()
                                                                    }, context);
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            InkWell(
                                                              onTap: () =>
                                                                  setState(() {
                                                                if (selectedDate ==
                                                                    index) {
                                                                  selectedDate =
                                                                      -1;
                                                                } else {
                                                                  selectedDate =
                                                                      index;
                                                                }
                                                              }),
                                                              child: Container(
                                                                padding: const EdgeInsets
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
                                                                      style: CustomFonts.slussen9W700(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    Icon(
                                                                      selectedDate ==
                                                                              index
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
                                                    if (selectedDate == index)
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                    if (selectedDate == index)
                                                      Container(
                                                        height: 140,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: controller
                                                              .savedScheduleList[
                                                                  index]
                                                              .slots
                                                              .length,
                                                          itemBuilder:
                                                              (context, i) {
                                                            Slot slot = controller
                                                                .savedScheduleList[
                                                                    index]
                                                                .slots[i];
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 8),
                                                              child: Container(
                                                                width: 88,
                                                                height: 140,
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
                                                                      slot.slotStartTime
                                                                          .split(
                                                                              " ")[2],
                                                                      style: CustomFonts.slussen10W600(
                                                                          color:
                                                                              HexColor(primaryColor)),
                                                                    ),
                                                                    TextField(
                                                                      controller: TextEditingController(
                                                                          text: slot
                                                                              .slotStartTime
                                                                              .split(" ")[1]),
                                                                      autofocus:
                                                                          true,
                                                                      readOnly:
                                                                          true,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter
                                                                            .singleLineFormatter
                                                                      ],
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
                                                                      autofocus:
                                                                          true,
                                                                      readOnly:
                                                                          true,
                                                                      controller: TextEditingController(
                                                                          text: slot
                                                                              .slotEndTime
                                                                              .split(" ")[1]),
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter
                                                                            .singleLineFormatter
                                                                      ],
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
                                                                    Text(
                                                                      slot.slotEndTime
                                                                          .split(
                                                                              " ")[2],
                                                                      style: CustomFonts.slussen10W600(
                                                                          color:
                                                                              HexColor(primaryColor)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
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
      ),
    );
  }
}
