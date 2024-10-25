// import 'package:flutter/material.dart';
//
// class AppartmentHistory extends StatefulWidget {
//   const AppartmentHistory({super.key});
//
//   @override
//   State<AppartmentHistory> createState() => _AppartmentHistoryState();
// }
//
// class _AppartmentHistoryState extends State<AppartmentHistory> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/controller/consultation_controller.dart';
import 'package:doctor_dashboard/model/phone_email_consult_model.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

import '../../widgets/drawer.dart';

class AppointmentHistory extends StatefulWidget {
  const AppointmentHistory({Key? key}) : super(key: key);

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  ConsultationController consultationController =
      Get.put(ConsultationController());

  final _scrollController = ScrollController();
  double _currentOffset = 0.0;

  List<String> timeRangeList = [
    // 'All Time',
    '1 Week',
    '1 Month',
    '2 Months',
    '3 Months',
    '6 Months',
    '1 Year'
  ];

  String selectedTime = '1 Week';

  bool showTimeSelector = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.light, //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    consultationController.getHistoryAppointment({
      "doctorId": "66bf3adcdd3df57c89074fe1",
      "range": selectedTime == "1 Week" ? "week" : selectedTime
    });
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
    return GetBuilder<ConsultationController>(
      init: ConsultationController(),
      builder: (controller) => AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 : 0.5 * screenWidth,
        right: isCollapsed ? 0 : -0.5 * screenWidth,
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
                  children: [
                    CustomAppbar(callback: callback),
                    controller.historyByYesterday.isEmpty
                        ? SizedBox()
                        : Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "History",
                                      style: CustomFonts.slussen12W500(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Clear",
                                      style: TextStyle(
                                        color: HexColor("#E957C9"),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        decorationColor: HexColor("#E957C9"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: controller.historyByYesterday.length,
                                itemBuilder: (context, index) {
                                  PhoneEmailConsultModel model =
                                      controller.historyByYesterday[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 12, left: 16, right: 16),
                                    child: Container(
                                      height: screenHeight * 0.1,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: HexColor("#FFFFFF"),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              screenHeight * 0.08),
                                          topRight: Radius.circular(
                                              screenHeight * 0.03),
                                          bottomLeft: Radius.circular(
                                              screenHeight * 0.08),
                                          bottomRight: Radius.circular(
                                              screenHeight * 0.08),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "lib/pages/dashboard/assets/img.png",
                                            height: screenHeight * 0.08,
                                            width: screenHeight * 0.08,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  model.name!,
                                                  style:
                                                      CustomFonts.slussen14W700(
                                                          color: HexColor(
                                                              "#201A3F")),
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.005,
                                                ),
                                                Text(
                                                  "ID - ${model.id}",
                                                  style:
                                                      CustomFonts.slussen8W500(
                                                          color: HexColor(
                                                                  "#201A3F")
                                                              .withOpacity(.4)),
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.0075,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            HexColor("#E2C680"),
                                                            HexColor("#D8874B"),
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35)),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 9,
                                                      vertical: 4),
                                                  child: RichText(
                                                    maxLines: 1,
                                                    text: TextSpan(
                                                        text: "Dental Braces ",
                                                        style: CustomFonts
                                                            .slussen10W500(
                                                                color: Colors
                                                                    .white),
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  "(Paid - Rs. 2000)",
                                                              style: CustomFonts
                                                                  .slussen10W700(
                                                                      color: Colors
                                                                          .white,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis))
                                                        ]),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          // const Spacer(),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                DateFormat('d MMM, E')
                                                    .format(model.dateTime!),
                                                style: CustomFonts.slussen8W500(
                                                    color: HexColor("#201A3F")
                                                        .withOpacity(.4)),
                                              ),
                                              SizedBox(
                                                height: screenHeight * 0.02,
                                              ),
                                              Image.asset(
                                                "lib/pages/search_result/assets/forward.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 28,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Align(
                                  child: Text(
                                    "History",
                                    style: CustomFonts.slussen12W500(
                                        color: Colors.white),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: HexColor("#F2F7FB"),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(45),
                                      topRight: Radius.circular(45),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: controller
                                              .historyByUpcoming.length,
                                          itemBuilder: (context, index) {
                                            PhoneEmailConsultModel model =
                                                controller
                                                    .historyByUpcoming[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 12,
                                              ),
                                              child: Container(
                                                height: screenHeight * 0.1,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: HexColor("#F2F7FB"),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        screenHeight * 0.08),
                                                    topRight: Radius.circular(
                                                        screenHeight * 0.03),
                                                    bottomLeft: Radius.circular(
                                                        screenHeight * 0.08),
                                                    bottomRight:
                                                        Radius.circular(
                                                            screenHeight *
                                                                0.08),
                                                  ),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color(0xffFFFFFF),
                                                      offset:
                                                          Offset(-5.0, -5.0),
                                                      blurRadius: 8,
                                                      spreadRadius: 0.0,
                                                    ),
                                                    BoxShadow(
                                                      color: Color(0xffE1EAF1),
                                                      offset: Offset(5.0, 5.0),
                                                      blurRadius: 8,
                                                      spreadRadius: 0.0,
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "lib/pages/dashboard/assets/img.png",
                                                      height:
                                                          screenHeight * 0.08,
                                                      width:
                                                          screenHeight * 0.08,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            model.name!,
                                                            style: CustomFonts
                                                                .slussen14W700(
                                                                    color: HexColor(
                                                                        "#201A3F")),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.005,
                                                          ),
                                                          Text(
                                                            "ID - ${model.id}",
                                                            style: CustomFonts.slussen8W500(
                                                                color: HexColor(
                                                                        "#201A3F")
                                                                    .withOpacity(
                                                                        .4)),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.0075,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    gradient:
                                                                        LinearGradient(
                                                                            colors: [
                                                                          HexColor(
                                                                              "#E2C680"),
                                                                          HexColor(
                                                                              "#D8874B"),
                                                                        ]),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            35)),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        9,
                                                                    vertical:
                                                                        4),
                                                            child: RichText(
                                                              maxLines: 1,
                                                              text: TextSpan(
                                                                  text:
                                                                      "Dental Braces ",
                                                                  style: CustomFonts
                                                                      .slussen10W500(
                                                                          color:
                                                                              Colors.white),
                                                                  children: [
                                                                    TextSpan(
                                                                        text:
                                                                            "(Paid - Rs. 2000)",
                                                                        style: CustomFonts.slussen10W700(
                                                                            color:
                                                                                Colors.white,
                                                                            overflow: TextOverflow.ellipsis))
                                                                  ]),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          DateFormat('d MMM, E')
                                                              .format(model
                                                                  .dateTime!),
                                                          style: CustomFonts
                                                              .slussen8W500(
                                                                  color: HexColor(
                                                                          "#201A3F")
                                                                      .withOpacity(
                                                                          .4)),
                                                        ),
                                                        SizedBox(
                                                          height: screenHeight *
                                                              0.02,
                                                        ),
                                                        Image.asset(
                                                          "lib/pages/search_result/assets/forward.png",
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
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
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: GlassContainer.clearGlass(
                                  height: showTimeSelector ? 150 : 28,
                                  borderRadius: BorderRadius.circular(13),
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: !showTimeSelector
                                        ? InkWell(
                                            onTap: () => setState(() {
                                              showTimeSelector = true;
                                            }),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Text(selectedTime,
                                                        style: CustomFonts
                                                            .slussen12W700(
                                                                color: HexColor(
                                                                    pinkColor))),
                                                  ),
                                                ),
                                                const SizedBox(
                                                    width: 16,
                                                    child: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              for (String item in timeRangeList)
                                                InkWell(
                                                  onTap: () => setState(() {
                                                    selectedTime = item;
                                                    showTimeSelector = false;
                                                    if (selectedTime ==
                                                        "1 Week") {
                                                      consultationController
                                                          .getHistoryAppointment({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1",
                                                        "range": "week"
                                                      });
                                                    } else if (selectedTime ==
                                                        "1 Month") {
                                                      consultationController
                                                          .getHistoryAppointment({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1",
                                                        "range": "month"
                                                      });
                                                    } else if (selectedTime ==
                                                        "2 Months") {
                                                      consultationController
                                                          .getHistoryAppointment({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1",
                                                        "range": "2months"
                                                      });
                                                    } else if (selectedTime ==
                                                        "3 Months") {
                                                      consultationController
                                                          .getHistoryAppointment({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1",
                                                        "range": "3months"
                                                      });
                                                    } else if (selectedTime ==
                                                        "6 Months") {
                                                      consultationController
                                                          .getHistoryAppointment({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1",
                                                        "range": "6months"
                                                      });
                                                    } else if (selectedTime ==
                                                        "1 Year") {
                                                      consultationController
                                                          .getHistoryAppointment({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1",
                                                        "range": "years"
                                                      });
                                                    }
                                                  }),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          item,
                                                          style: selectedTime ==
                                                                  item
                                                              ? CustomFonts
                                                                  .slussen12W700(
                                                                      color: HexColor(
                                                                          pinkColor))
                                                              : CustomFonts.slussen10W500(
                                                                  color: HexColor(
                                                                          "#201A3F")
                                                                      .withOpacity(
                                                                          .7)),
                                                        ),
                                                        SizedBox(
                                                            width: 16,
                                                            child: 'All Time' ==
                                                                    item
                                                                ? const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_up,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                : const SizedBox())
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                  )),
                            ),
                          )
                        ],
                      ),
                    )
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
