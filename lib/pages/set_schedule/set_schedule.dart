import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:slider_button/slider_button.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

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

  final _scrollController = ScrollController();
  double _currentOffset = 0.0;

  List icons = ['Set Problem', 'Set Test', 'Set Medicine', 'Set Surgery'];

  int selectedIcon = 0;

  final timeController = TextEditingController();
  final minController = TextEditingController();

  List days = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];
  int selectedDate = 3;
  final ScrollController _firstController = ScrollController();

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
                            physics: isCollapsed
                                ? physics
                                : const NeverScrollableScrollPhysics(),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 36,
                                          width: 36,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Center(
                                            child: Icon(
                                              Icons.keyboard_arrow_left,
                                              size: 20,
                                              color: HexColor(primaryColor),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Jan",
                                          style: CustomFonts.slussen24W700(
                                              color: HexColor("#E49356")),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 36,
                                          width: 36,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Center(
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              size: 20,
                                              color: HexColor(primaryColor),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 20),
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: HexColor(pinkColor)),
                                      child: Center(
                                        child: Text(
                                          "DONE",
                                          style: CustomFonts.slussen12W700(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      for (int i = 1; i < 20; i++)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: GestureDetector(
                                            onTap: () => setState(() {
                                              selectedDate = i;
                                            }),
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: HexColor("#FFFFFF"),
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  gradient: LinearGradient(
                                                      colors: i == selectedDate
                                                          ? [
                                                              HexColor(
                                                                  goldLightColor),
                                                              HexColor(
                                                                  goldDarkColor)
                                                            ]
                                                          : [
                                                              HexColor(
                                                                  "#FFFFFF"),
                                                              HexColor(
                                                                  "#FFFFFF"),
                                                            ])),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "$i",
                                                    style: CustomFonts.slussen32W700(
                                                        color: i == selectedDate
                                                            ? Colors.white
                                                            : HexColor(
                                                                    primaryColor)
                                                                .withOpacity(
                                                                    .5)),
                                                  ),
                                                  Text(
                                                    "${days[i % 7]}",
                                                    style: CustomFonts.slussen16W500(
                                                        color: i == selectedDate
                                                            ? Colors.white
                                                            : HexColor(
                                                                    primaryColor)
                                                                .withOpacity(
                                                                    .5)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                        Expanded(flex: 2, child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Start Time",
                                            style: CustomFonts.slussen12W700(
                                              color: HexColor(primaryColor).withOpacity(.5)
                                            ),),
                                            const SizedBox(height: 4,),
                                            Container(
                                              // height: 60,
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(45),
                                                color: HexColor("#F2F7FB")
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextField(
                                                      controller: timeController,
                                                      style: CustomFonts.slussen28W700(
                                                          color: HexColor(primaryColor)
                                                        ),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                                        border: InputBorder.none,
                                                        hintText: "00:00",
                                                        hintStyle: CustomFonts.slussen28W700(
                                                          color: HexColor(primaryColor).withOpacity(.3)
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        if(value.length == 3 && value[2] == ':'){
                                                          timeController.text = timeController.text.substring(0, 2);
                                                        }
                                                        if(value.length == 3){
                                                          String char = timeController.text[2];
                                                          timeController.text = timeController.text.substring(0, 2);
                                                          timeController.text += ':$char';
                                                        }else if(value.length == 5){
                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                        }else if(value.length > 5){
                                                          timeController.text = timeController.text.substring(0, 5);
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Container(height: 30, width: 30,
                                                    decoration: BoxDecoration(
                                                      color: HexColor(pinkColor),
                                                      shape: BoxShape.circle
                                                    ),
                                                    child: Center(
                                                      child: Text("AM",
                                                      style: CustomFonts.slussen10W700(
                                                        color: Colors.white
                                                      ),),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4,),
                                                  Container(height: 30, width: 30,
                                                    decoration: BoxDecoration(
                                                      color: HexColor(pinkColor).withOpacity(.5),
                                                      shape: BoxShape.circle
                                                    ),
                                                    child: Center(
                                                      child: Text("PM",
                                                      style: CustomFonts.slussen10W700(
                                                        color: Colors.white
                                                      ),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            Text("End Time",
                                            style: CustomFonts.slussen12W700(
                                              color: HexColor(primaryColor).withOpacity(.5)
                                            ),),
                                            const SizedBox(height: 4,),
                                            Container(
                                              // height: 60,
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(45),
                                                color: HexColor("#F2F7FB")
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextField(
                                                      controller: timeController,
                                                      style: CustomFonts.slussen28W700(
                                                          color: HexColor(primaryColor)
                                                        ),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                                        border: InputBorder.none,
                                                        hintText: "00:00",
                                                        hintStyle: CustomFonts.slussen28W700(
                                                          color: HexColor(primaryColor).withOpacity(.3)
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        if(value.length == 3 && value[2] == ':'){
                                                          timeController.text = timeController.text.substring(0, 2);
                                                        }
                                                        if(value.length == 3){
                                                          String char = timeController.text[2];
                                                          timeController.text = timeController.text.substring(0, 2);
                                                          timeController.text += ':$char';
                                                        }else if(value.length == 5){
                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                        }else if(value.length > 5){
                                                          timeController.text = timeController.text.substring(0, 5);
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Container(height: 30, width: 30,
                                                    decoration: BoxDecoration(
                                                      color: HexColor(pinkColor),
                                                      shape: BoxShape.circle
                                                    ),
                                                    child: Center(
                                                      child: Text("AM",
                                                      style: CustomFonts.slussen10W700(
                                                        color: Colors.white
                                                      ),),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4,),
                                                  Container(height: 30, width: 30,
                                                    decoration: BoxDecoration(
                                                      color: HexColor(pinkColor).withOpacity(.5),
                                                      shape: BoxShape.circle
                                                    ),
                                                    child: Center(
                                                      child: Text("PM",
                                                      style: CustomFonts.slussen10W700(
                                                        color: Colors.white
                                                      ),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          
                                          ],
                                        )),
                                        const SizedBox(width: 16,),
                                        Expanded(flex: 1, child: Column(
                                          children: [
                                            Text("Start Interval",
                                            style: CustomFonts.slussen12W700(
                                              color: HexColor(primaryColor).withOpacity(.5)
                                            ),),
                                            const SizedBox(height: 4,),
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: HexColor(primaryColor),
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(56),
                                                  topRight: Radius.circular(56),
                                                  bottomLeft: Radius.circular(56),
                                                  bottomRight: Radius.circular(30),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(height: 30, width: 30,
                                                    decoration: BoxDecoration(
                                                      color: HexColor(pinkColor),
                                                      shape: BoxShape.circle
                                                    ),
                                                    child: Center(
                                                      child: Text("-",
                                                      style: CustomFonts.slussen20W700(
                                                        color: Colors.white
                                                      ),),
                                                    ),
                                                  ),
                                                  TextField(
                                                      controller: minController,
                                                      style: CustomFonts.slussen28W700(
                                                          color: HexColor("#FFFFFF")
                                                        ),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                                        border: InputBorder.none,
                                                        hintText: "00",
                                                        hintStyle: CustomFonts.slussen28W700(
                                                          color: HexColor("#FFFFFF").withOpacity(.3)
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        if(value.length == 2){
                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                        }else if(value.length > 2){
                                                          minController.text = minController.text.substring(0, 2);
                                                        }
                                                      },
                                                    ),
                                                  Container(height: 30, width: 30,
                                                    decoration: BoxDecoration(
                                                      color: HexColor(pinkColor),
                                                      shape: BoxShape.circle
                                                    ),
                                                    child: Center(
                                                      child: Text("+",
                                                      style: CustomFonts.slussen20W700(
                                                        color: Colors.white
                                                      ),),
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
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
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
                                                padding: const EdgeInsets.all(9),
                                                height: 30, width: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor("#F7F9FC"),
                                                ),
                                                child: Center(child: Image.asset("assets/images/delete.png")),
                                              ),
                                              const SizedBox(width: 4,),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: HexColor(pinkColor),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "schedules ",
                                                      style:
                                                          CustomFonts.slussen10W700(
                                                              color: Colors.white),
                                                    ),
                                                    const Icon(
                                                      Icons.keyboard_arrow_up,
                                                      color: Colors.white,
                                                      size: 14,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                              ),
                              const SizedBox(height: 8,),
                              SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              for (int i = 0; i < 8; i++)
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 24,
                                                        vertical: 16),
                                                    // height: 110,
                                                    decoration: BoxDecoration(
                                                      color: HexColor("#FFFFFF"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "am",
                                                          style: CustomFonts
                                                              .slussen10W600(
                                                                  color: HexColor(primaryColor).withOpacity(.5)),
                                                        ),
                                                         Text(
                                                          "09:00",
                                                          style: CustomFonts
                                                              .slussen14W700(
                                                                  color: HexColor(primaryColor)),
                                                        ),
                                                         Text(
                                                          "-",
                                                          style: CustomFonts
                                                              .slussen14W700(
                                                                  color: HexColor(primaryColor)),
                                                        ),
                                                         Text(
                                                          "09:30",
                                                          style: CustomFonts
                                                              .slussen14W700(
                                                                  color: HexColor(primaryColor)),
                                                        ),
                                                         Text(
                                                          "am",
                                                          style: CustomFonts
                                                              .slussen10W600(
                                                                  color: HexColor(primaryColor)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                      ),
                              const SizedBox(height: 16,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: HexColor("#E49356"),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset("assets/images/note.png"),
                                      ),
                                      Expanded(child: Text("Copy previous schedule for today",
                                      style: CustomFonts.slussen12W700(
                                        color: Colors.white
                                      ),)),
                                      const SizedBox(width: 8,),
                                      Icon(Icons.keyboard_arrow_down, color: Colors.white,)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: HexColor("#E49356"),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset("assets/images/note.png"),
                                      ),
                                      Expanded(child: Text("Copy previous schedule for today",
                                      style: CustomFonts.slussen12W700(
                                        color: Colors.white
                                      ),)),
                                      const SizedBox(width: 8,),
                                      Icon(Icons.keyboard_arrow_down, color: Colors.white,)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                      height: 28,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: HexColor("#E957C9").withOpacity(.15),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, color: HexColor(pinkColor),
                                          size: 12,),
                                         Text(" Tap to edit",
                                          style: CustomFonts.slussen9W700(
                                            color: HexColor(pinkColor)
                                          ),),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 4,),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                      height: 28,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: HexColor("#E957C9").withOpacity(.15),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, color: HexColor(pinkColor),
                                          size: 12,),
                                         Text(" you can copy multiple schedules",
                                          style: CustomFonts.slussen9W700(
                                            color: HexColor(pinkColor)
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 16,),
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
    );
  }
}
