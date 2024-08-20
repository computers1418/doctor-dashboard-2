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

class PreviousSchedules extends StatefulWidget {
  String id;

  PreviousSchedules({Key? key, this.id = ""}) : super(key: key);

  @override
  State<PreviousSchedules> createState() => _PreviousSchedulesState();
}

class _PreviousSchedulesState extends State<PreviousSchedules>
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
  SetScheduleController setScheduleController =
      Get.put(SetScheduleController());

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.light, //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.dark,
    ));

    if (widget.id.isNotEmpty) {
      setScheduleController.getScheduleById(widget.id, context);
    } else {
      if (setScheduleController.previousScheduleList.isEmpty) {
        setScheduleController.getPreviousScheduleListData(
            {"doctorId": "66bf3adcdd3df57c89074fe1", "dateArray": list()},
            context);
      }
    }

    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(_controller);
  }

  List<String> list() {
    DateTime today = DateTime.now();
    List<String> dateList = [];

    for (int i = 1; i <= 30; i++) {
      DateTime date = today.subtract(Duration(days: i));
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      dateList.add(formattedDate);
    }

    // Print the list of dates
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
                      height: 15,
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
                            "Previous",
                            style: CustomFonts.slussen14W500(
                                color: HexColor("#FFFFFF").withOpacity(.5)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Previous schedules for 1 months",
                        style: CustomFonts.slussen12W400(
                            color: HexColor("#FFFFFF").withOpacity(.5)),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .02,
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
                        child: widget.id.isNotEmpty
                            ? schedule.isDataLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : schedule.schduleList.isEmpty
                                    ? SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: Wrap(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
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
                                                                    'd MMM, EEEE')
                                                                .format(DateFormat(
                                                                        'yyyy-MM-dd')
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
                                                          InkWell(
                                                            onTap: () =>
                                                                setState(() {
                                                              if (selectedDate ==
                                                                  -1) {
                                                                selectedDate =
                                                                    0;
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
                                                                    selectedDate == -1
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
                                                  if (selectedDate == -1)
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                  if (selectedDate == -1)
                                                    Container(
                                                      height: 140,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: schedule
                                                            .schduleList
                                                            .first
                                                            .slots
                                                            .length,
                                                        itemBuilder:
                                                            (context, i) {
                                                          Slot slot = schedule
                                                              .schduleList
                                                              .first
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
                                                                    style: CustomFonts
                                                                        .slussen10W600(
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
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "00:00",
                                                                      hintStyle:
                                                                          CustomFonts.slussen14W700(
                                                                              color: HexColor(primaryColor).withOpacity(.3)),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "-",
                                                                    style: CustomFonts
                                                                        .slussen14W700(
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
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "00:00",
                                                                      hintStyle:
                                                                          CustomFonts.slussen14W700(
                                                                              color: HexColor(primaryColor).withOpacity(.3)),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    slot.slotEndTime
                                                                        .split(
                                                                            " ")[2],
                                                                    style: CustomFonts
                                                                        .slussen10W600(
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
                                          ],
                                        ),
                                      )
                            : schedule.isDataLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : schedule.previousScheduleList.isEmpty
                                    ? SizedBox()
                                    : ListView.builder(
                                        primary: true,
                                        shrinkWrap: false,
                                        padding: EdgeInsets.zero,
                                        itemCount: schedule
                                            .previousScheduleList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 12,
                                            ),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
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
                                                                    'd MMM, EEEE')
                                                                .format(DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .parse(schedule
                                                                        .previousScheduleList[
                                                                            index]
                                                                        .date)),
                                                            style: CustomFonts
                                                                .slussen16W700(
                                                                    color: HexColor(
                                                                        primaryColor)),
                                                          ),
                                                          Text(
                                                            "${schedule.previousScheduleList[index].slots.length} Appointments scheduled",
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
                                                    // Container(
                                                    //   height: 140,
                                                    //   child: ListView.builder(
                                                    //     scrollDirection:
                                                    //         Axis.horizontal,
                                                    //     itemCount: timeData.length,
                                                    //     itemBuilder:
                                                    //         (context, index) {
                                                    //       if (timeData[index]
                                                    //               ["startTime"] ==
                                                    //           "") {
                                                    //         startTimeController.add(
                                                    //             new TextEditingController());
                                                    //         endTimeController.add(
                                                    //             new TextEditingController());
                                                    //         startTimeController[
                                                    //                 index]
                                                    //             .clear();
                                                    //         endTimeController[index]
                                                    //             .clear();
                                                    //       } else {
                                                    //         startTimeController.add(
                                                    //             new TextEditingController(
                                                    //                 text: timeData[
                                                    //                         index][
                                                    //                     "startTime"]));
                                                    //         endTimeController.add(
                                                    //             new TextEditingController(
                                                    //                 text: timeData[
                                                    //                         index][
                                                    //                     "endtime"]));
                                                    //       }
                                                    //
                                                    //       return Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .only(right: 8),
                                                    //         child: GestureDetector(
                                                    //           onTap: () {
                                                    //             setState(() {
                                                    //               scheduleSelect =
                                                    //                   index;
                                                    //
                                                    //               // if (timeData.containsKey(scheduleSelect)) {
                                                    //               // Retrieve the current data for the selected schedule
                                                    //             });
                                                    //           },
                                                    //           child: Container(
                                                    //             width: 88,
                                                    //             height: 140,
                                                    //             decoration:
                                                    //                 BoxDecoration(
                                                    //               color: HexColor(
                                                    //                   "#F7F9FC"),
                                                    //               gradient: scheduleSelect ==
                                                    //                       index
                                                    //                   ? LinearGradient(
                                                    //                       colors: [
                                                    //                           HexColor(
                                                    //                               goldLightColor),
                                                    //                           HexColor(
                                                    //                               goldDarkColor)
                                                    //                         ])
                                                    //                   : null,
                                                    //               borderRadius:
                                                    //                   BorderRadius
                                                    //                       .circular(
                                                    //                           25),
                                                    //             ),
                                                    //             child: Column(
                                                    //               mainAxisAlignment:
                                                    //                   MainAxisAlignment
                                                    //                       .center,
                                                    //               children: [
                                                    //                 Text(
                                                    //                   "am",
                                                    //                   style: CustomFonts.slussen10W600(
                                                    //                       color: HexColor(
                                                    //                               primaryColor)
                                                    //                           .withOpacity(
                                                    //                               .5)),
                                                    //                 ),
                                                    //                 TextField(
                                                    //                   readOnly: timeData[
                                                    //                           index]
                                                    //                       ["edit"],
                                                    //                   controller:
                                                    //                       startTimeController[
                                                    //                           index],
                                                    //                   style: CustomFonts
                                                    //                       .slussen14W700(
                                                    //                           color:
                                                    //                               HexColor(primaryColor)),
                                                    //                   textAlign:
                                                    //                       TextAlign
                                                    //                           .center,
                                                    //                   decoration:
                                                    //                       InputDecoration(
                                                    //                     isDense:
                                                    //                         true,
                                                    //                     border:
                                                    //                         InputBorder
                                                    //                             .none,
                                                    //                     hintText:
                                                    //                         "00:00",
                                                    //                     hintStyle: CustomFonts
                                                    //                         .slussen14W700(
                                                    //                             color:
                                                    //                                 HexColor(primaryColor).withOpacity(.3)),
                                                    //                   ),
                                                    //                   onChanged:
                                                    //                       (value) {
                                                    //                     if (value.length ==
                                                    //                             3 &&
                                                    //                         value[2] ==
                                                    //                             ':') {
                                                    //                       startTimeController[
                                                    //                               index]
                                                    //                           .text = startTimeController[
                                                    //                               index]
                                                    //                           .text
                                                    //                           .substring(
                                                    //                               0,
                                                    //                               2);
                                                    //                       startTimeController[index]
                                                    //                               .selection =
                                                    //                           TextSelection.fromPosition(
                                                    //                               TextPosition(offset: startTimeController[index].text.length));
                                                    //                     } else if (value
                                                    //                             .length ==
                                                    //                         3) {
                                                    //                       String
                                                    //                           char =
                                                    //                           startTimeController[index]
                                                    //                               .text[2];
                                                    //                       startTimeController[
                                                    //                               index]
                                                    //                           .text = startTimeController[
                                                    //                               index]
                                                    //                           .text
                                                    //                           .substring(
                                                    //                               0,
                                                    //                               2);
                                                    //                       startTimeController[index]
                                                    //                               .text +=
                                                    //                           ':$char';
                                                    //                       startTimeController[index]
                                                    //                               .selection =
                                                    //                           TextSelection.fromPosition(
                                                    //                               TextPosition(offset: startTimeController[index].text.length));
                                                    //                     } else if (value
                                                    //                             .length ==
                                                    //                         5) {
                                                    //                       FocusManager
                                                    //                           .instance
                                                    //                           .primaryFocus
                                                    //                           ?.unfocus();
                                                    //                     } else if (value
                                                    //                             .length >
                                                    //                         5) {
                                                    //                       startTimeController[
                                                    //                               index]
                                                    //                           .text = startTimeController[
                                                    //                               index]
                                                    //                           .text
                                                    //                           .substring(
                                                    //                               0,
                                                    //                               5);
                                                    //                       startTimeController[index]
                                                    //                               .selection =
                                                    //                           TextSelection.fromPosition(
                                                    //                               TextPosition(offset: startTimeController[index].text.length));
                                                    //                     }
                                                    //                   },
                                                    //                 ),
                                                    //                 Text(
                                                    //                   "-",
                                                    //                   style: CustomFonts
                                                    //                       .slussen14W700(
                                                    //                           color:
                                                    //                               HexColor(primaryColor)),
                                                    //                 ),
                                                    //                 TextField(
                                                    //                   readOnly: timeData[
                                                    //                           index]
                                                    //                       ["edit"],
                                                    //                   controller:
                                                    //                       endTimeController[
                                                    //                           index],
                                                    //                   style: CustomFonts
                                                    //                       .slussen14W700(
                                                    //                           color:
                                                    //                               HexColor(primaryColor)),
                                                    //                   textAlign:
                                                    //                       TextAlign
                                                    //                           .center,
                                                    //                   decoration:
                                                    //                       InputDecoration(
                                                    //                     isDense:
                                                    //                         true,
                                                    //                     border:
                                                    //                         InputBorder
                                                    //                             .none,
                                                    //                     hintText:
                                                    //                         "00:00",
                                                    //                     hintStyle: CustomFonts
                                                    //                         .slussen14W700(
                                                    //                             color:
                                                    //                                 HexColor(primaryColor).withOpacity(.3)),
                                                    //                   ),
                                                    //                   onChanged:
                                                    //                       (value) {
                                                    //                     if (value.length ==
                                                    //                             3 &&
                                                    //                         value[2] ==
                                                    //                             ':') {
                                                    //                       endTimeController[
                                                    //                               index]
                                                    //                           .text = endTimeController[
                                                    //                               index]
                                                    //                           .text
                                                    //                           .substring(
                                                    //                               0,
                                                    //                               2);
                                                    //                       endTimeController[index]
                                                    //                               .selection =
                                                    //                           TextSelection.fromPosition(
                                                    //                               TextPosition(offset: endTimeController[index].text.length));
                                                    //                     } else if (value
                                                    //                             .length ==
                                                    //                         3) {
                                                    //                       String
                                                    //                           char =
                                                    //                           endTimeController[index]
                                                    //                               .text[2];
                                                    //                       endTimeController[
                                                    //                               index]
                                                    //                           .text = endTimeController[
                                                    //                               index]
                                                    //                           .text
                                                    //                           .substring(
                                                    //                               0,
                                                    //                               2);
                                                    //                       endTimeController[index]
                                                    //                               .text +=
                                                    //                           ':$char';
                                                    //                       endTimeController[index]
                                                    //                               .selection =
                                                    //                           TextSelection.fromPosition(
                                                    //                               TextPosition(offset: endTimeController[index].text.length));
                                                    //                     } else if (value
                                                    //                             .length ==
                                                    //                         5) {
                                                    //                       FocusManager
                                                    //                           .instance
                                                    //                           .primaryFocus
                                                    //                           ?.unfocus();
                                                    //                     } else if (value
                                                    //                             .length >
                                                    //                         5) {
                                                    //                       endTimeController[
                                                    //                               index]
                                                    //                           .text = endTimeController[
                                                    //                               index]
                                                    //                           .text
                                                    //                           .substring(
                                                    //                               0,
                                                    //                               5);
                                                    //                       endTimeController[index]
                                                    //                               .selection =
                                                    //                           TextSelection.fromPosition(
                                                    //                               TextPosition(offset: endTimeController[index].text.length));
                                                    //                     }
                                                    //                   },
                                                    //                 ),
                                                    //                 Text(
                                                    //                   "am",
                                                    //                   style: CustomFonts
                                                    //                       .slussen10W600(
                                                    //                           color:
                                                    //                               HexColor(primaryColor)),
                                                    //                 ),
                                                    //               ],
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //       );
                                                    //     },
                                                    //   ),
                                                    // )
                                                    Container(
                                                      height: 140,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: schedule
                                                            .previousScheduleList[
                                                                index]
                                                            .slots
                                                            .length,
                                                        itemBuilder:
                                                            (context, i) {
                                                          Slot slot = schedule
                                                              .previousScheduleList[
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
                                                                    style: CustomFonts
                                                                        .slussen10W600(
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
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "00:00",
                                                                      hintStyle:
                                                                          CustomFonts.slussen14W700(
                                                                              color: HexColor(primaryColor).withOpacity(.3)),
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
                                                                    style: CustomFonts
                                                                        .slussen14W700(
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
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "00:00",
                                                                      hintStyle:
                                                                          CustomFonts.slussen14W700(
                                                                              color: HexColor(primaryColor).withOpacity(.3)),
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
                                                                    style: CustomFonts
                                                                        .slussen10W600(
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
