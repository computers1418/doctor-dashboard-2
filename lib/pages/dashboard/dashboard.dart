import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/pages/notification/notification_screen.dart';
import 'package:doctor_dashboard/pages/profile/profile_view.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
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

  List graphData = [17, 15, 24, 25, 19, 27, 23];

  List days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  double total = 0.0;
  int greatestValue = 0;

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
    setState(() {
      greatestValue = graphData
          .reduce((value, element) => value > element ? value : element);
      print(greatestValue);
      for (final val in graphData) {
        total += val;
        print(val / total * 1000);
      }
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
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
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
            child: Stack(
              children: [
                DynMouseScroll(
                  durationMS: 5000,
                  scrollSpeed: -4.4,
                  builder: (context, controller, physics) => ListView(
                    controller: _scrollController,
                    physics: isCollapsed
                        ? physics
                        : const NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        width: double.infinity,
                        color: HexColor("#F2F7FB"),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    "lib/pages/dashboard/assets/bg.png",
                                    fit: BoxFit.fill,
                                  ),
                                  Image.asset(
                                    "lib/pages/dashboard/assets/line.png",
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(20.0),
                                      child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.12,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.0175),
                                                      child: Text(
                                                        "Reimagined.",
                                                        style: CustomFonts
                                                            .slussen32W700(
                                                                color: HexColor(
                                                                    "#FFFFFF")),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Patient Management",
                                                      style: CustomFonts
                                                          .slussen14W500(
                                                              color: HexColor(
                                                                      "#FFFFFF")
                                                                  .withOpacity(
                                                                      .5)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.015,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            HexColor("#E7CB87"),
                                                            HexColor("#E49356"),
                                                          ])),
                                                  child: Image.asset(
                                                    "lib/pages/dashboard/assets/search.png",
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.025,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.025,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                            ),
                                            Center(
                                              child: Image.asset(
                                                "lib/pages/dashboard/assets/teeth.png",
                                                fit: BoxFit.fill,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                            Center(
                                              child: Text(
                                                "Refresh Data",
                                                style:
                                                    CustomFonts.slussen12W700(
                                                        color: HexColor(
                                                                "#FFFFFF")
                                                            .withOpacity(.5)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                            Center(
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.asset(
                                                    "lib/pages/dashboard/assets/refresh-bg.png",
                                                    fit: BoxFit.fill,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                  ),
                                                  Image.asset(
                                                    "lib/pages/dashboard/assets/refresh.png",
                                                    fit: BoxFit.fill,
                                                    height: 34,
                                                    width: 34,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
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
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          "Options",
                                          style: CustomFonts.slussen30W700(
                                              color: HexColor("#201A3F")),
                                        ),
                                      ),
                                      Text(
                                        "Quick",
                                        style: CustomFonts.slussen14W700(
                                            color: HexColor("#201A3F")),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 38,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: HexColor("#E957C9"),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 6),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "lib/pages/dashboard/assets/calender.png",
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            "28 Dec, Fri",
                                            style: CustomFonts.slussen10W600(
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        SimpleShadow(
                                          opacity: 1,
                                          // Default: 0.5
                                          color: HexColor("#E1EAF1"),
                                          // Default: Black
                                          offset: const Offset(5, 5),
                                          // Default: Offset(2, 2)
                                          sigma: 5,
                                          child: Image.asset(
                                              'lib/pages/dashboard/assets/shape1.png'),
                                        ),
                                        SimpleShadow(
                                          opacity: 1,
                                          // Default: 0.5
                                          color: HexColor("#FFFFFF"),
                                          // Default: Black
                                          offset: const Offset(-5, -5),
                                          // Default: Offset(2, 2)
                                          sigma: 5,
                                          child: Image.asset(
                                              'lib/pages/dashboard/assets/shape1.png'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#201A3F"),
                                                      shape: BoxShape.circle),
                                                  child: Image.asset(
                                                    'lib/pages/dashboard/assets/schedule.png',
                                                    width: 18,
                                                    height: 18,
                                                  )),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.008,
                                              ),
                                              if (isCollapsed)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Text(
                                                          "Scheduling",
                                                          style: CustomFonts
                                                              .slussen10W700(
                                                                  color: HexColor(
                                                                      "#201A3F")),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Super",
                                                        style: CustomFonts
                                                            .slussen10W700(
                                                                color: HexColor(
                                                                    "#201A3F")),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SimpleShadow(
                                          opacity: 1,
                                          // Default: 0.5
                                          color: HexColor("#E1EAF1"),
                                          // Default: Black
                                          offset: const Offset(5, 5),
                                          // Default: Offset(2, 2)
                                          sigma: 5,
                                          child: Image.asset(
                                              'lib/pages/dashboard/assets/shape2.png'), // Default: 2
                                        ),
                                        SimpleShadow(
                                          opacity: 1,
                                          // Default: 0.5
                                          color: HexColor("#FFFFFF"),
                                          // Default: Black
                                          offset: const Offset(-5, -5),
                                          // Default: Offset(2, 2)
                                          sigma: 5,
                                          child: Image.asset(
                                              'lib/pages/dashboard/assets/shape2.png'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // SizedBox(height: MediaQuery.of(context).size.height * 0.008,),
                                              if (isCollapsed)
                                                Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Text(
                                                        "Consultation",
                                                        style: CustomFonts
                                                            .slussen10W700(
                                                                color: HexColor(
                                                                    "#FFFFFF")),
                                                      ),
                                                    ),
                                                    Text(
                                                      "New",
                                                      style: CustomFonts
                                                          .slussen10W700(
                                                              color: HexColor(
                                                                  "#FFFFFF")),
                                                    ),
                                                  ],
                                                ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.008,
                                              ),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#FFFFFF"),
                                                      shape: BoxShape.circle),
                                                  child: Image.asset(
                                                    'lib/pages/dashboard/assets/consultation.png',
                                                    width: 18,
                                                    height: 18,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        SimpleShadow(
                                          opacity: 1,
                                          // Default: 0.5
                                          color: HexColor("#E1EAF1"),
                                          // Default: Black
                                          offset: const Offset(5, 5),
                                          // Default: Offset(2, 2)
                                          sigma: 5,
                                          child: Image.asset(
                                              'lib/pages/dashboard/assets/shape3.png'),
                                        ),
                                        SimpleShadow(
                                          opacity: 1,
                                          // Default: 0.5
                                          color: HexColor("#FFFFFF"),
                                          // Default: Black
                                          offset: const Offset(-5, -5),
                                          // Default: Offset(2, 2)
                                          sigma: 5,
                                          child: Image.asset(
                                              'lib/pages/dashboard/assets/shape3.png'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#201A3F"),
                                                      shape: BoxShape.circle),
                                                  child: Image.asset(
                                                    'lib/pages/dashboard/assets/specialization.png',
                                                    width: 18,
                                                    height: 18,
                                                  )),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.008,
                                              ),
                                              if (isCollapsed)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topRight,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Text(
                                                          "Specialization",
                                                          style: CustomFonts
                                                              .slussen10W700(
                                                                  color: HexColor(
                                                                      "#201A3F")),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Super",
                                                        style: CustomFonts
                                                            .slussen10W700(
                                                                color: HexColor(
                                                                    "#201A3F")),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text(
                                      "Appointments",
                                      style: CustomFonts.slussen30W700(
                                          color: HexColor("#201A3F")),
                                    ),
                                  ),
                                  Text(
                                    "Upcoming",
                                    style: CustomFonts.slussen14W700(
                                        color: HexColor("#201A3F")),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                height: 216,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color: HexColor("#201A3F"),
                                    image: const DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            "lib/pages/dashboard/assets/card-bg.png"))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 32,
                                            width: 170,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                color: HexColor("#E957C9")),
                                            child: Center(
                                              child: Text(
                                                "Today, 09:00 am",
                                                style:
                                                    CustomFonts.slussen14W600(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          GradientText("Dental Decay",
                                              style: const TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w600),
                                              colors: [
                                                HexColor(lightColor1),
                                                HexColor(lightColor2)
                                              ]),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text("Patient name",
                                              style: CustomFonts.slussen10W400(
                                                  color: Colors.white
                                                      .withOpacity(.5))),
                                          Text("Arnold Marley",
                                              style: CustomFonts.slussen14W700(
                                                  color: Colors.white)),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 44,
                                            width: 151,
                                            decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  HexColor("#E2C680"),
                                                  HexColor("#D8874B"),
                                                ]),
                                                borderRadius:
                                                    BorderRadius.circular(35)),
                                            child: Center(
                                              child: Text("Reschedule",
                                                  style:
                                                      CustomFonts.slussen14W700(
                                                          color: Colors.white)),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Image.asset(
                                                  "lib/pages/dashboard/assets/img2.png",
                                                  height: 90,
                                                  width: 100,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  height: 24,
                                                  width: 72,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: HexColor("#FFFFFF")
                                                        .withOpacity(.3),
                                                  ),
                                                  child: Center(
                                                    child: Text("3rd visit",
                                                        style: CustomFonts
                                                            .slussen10W600(
                                                                color: Colors
                                                                    .white)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: 44,
                                            width: 44,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: HexColor("#E957C9"),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "lib/pages/dashboard/assets/arrow.png",
                                                height: 19,
                                                width: 19,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                width: double.infinity,
                                height: 380,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(35),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff000000)
                                          .withOpacity(.1),
                                      offset: const Offset(-10.0, -10.0),
                                      blurRadius: 20,
                                      spreadRadius: 0.0,
                                    ),
                                    BoxShadow(
                                      color: const Color(0xff000000)
                                          .withOpacity(.1),
                                      offset: const Offset(10.0, 10.0),
                                      blurRadius: 20,
                                      spreadRadius: 0.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 12, right: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Text(
                                          "Next",
                                          style: CustomFonts.slussen16W700(
                                              color: HexColor("#201A3F")),
                                        ),
                                      ),
                                      Expanded(
                                          child: Scrollbar(
                                        thickness: 6.0,
                                        trackVisibility: true,
                                        thumbVisibility: true,
                                        controller: _firstController,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: SingleChildScrollView(
                                            controller: _firstController,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (int i = 0; i < 8; i++)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 12),
                                                      child: Container(
                                                        height: 90,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: HexColor(
                                                                  "#F4F4F7")
                                                              .withOpacity(.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(45),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                              "lib/pages/dashboard/assets/img.png",
                                                              height: 74,
                                                              width: 74,
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Taylor Russel",
                                                                  style: CustomFonts
                                                                      .slussen14W700(),
                                                                ),
                                                                const SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Text(
                                                                  "Dental Check - Up",
                                                                  style: CustomFonts
                                                                      .slussen8W600(),
                                                                ),
                                                                const SizedBox(
                                                                  height: 6,
                                                                ),
                                                                Container(
                                                                  height: 20,
                                                                  width: 122,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          gradient: LinearGradient(
                                                                              colors: [
                                                                                HexColor("#E2C680"),
                                                                                HexColor("#D8874B"),
                                                                              ]),
                                                                          borderRadius:
                                                                              BorderRadius.circular(35)),
                                                                  child: Center(
                                                                    child: Text(
                                                                        "Today at 10:30 am",
                                                                        style: CustomFonts.slussen10W500(
                                                                            color:
                                                                                Colors.white)),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            const Spacer(),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const ProfileView(),
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                width: 30,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: HexColor(
                                                                            "#201A3F"))),
                                                                child: Center(
                                                                  child: Image.asset(
                                                                      "lib/pages/dashboard/assets/arrow.png",
                                                                      height:
                                                                          13,
                                                                      width: 13,
                                                                      color: HexColor(
                                                                          "#201A3F")),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 24,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: HexColor(primaryColor),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(45),
                                    topRight: Radius.circular(45)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Insights",
                                      style: CustomFonts.slussen32W700(
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: screenHeight * .4,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(screenHeight * .02),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          HexColor("#E49356"),
                                          HexColor("#E7CB87"),
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * .0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  height: 40,
                                                  width: 40,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: HexColor(
                                                          primaryColor),
                                                      shape: BoxShape.circle),
                                                  child: Image.asset(
                                                      "lib/pages/dashboard/assets/insights.png")),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              Stack(
                                                //crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Text(
                                                      "Patient Data",
                                                      style: CustomFonts
                                                          .slussen20W700(
                                                              color: HexColor(
                                                                  "#FFFFFF")),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    child: Text(
                                                      "Doctors Patient Data Summary",
                                                      style: CustomFonts
                                                          .slussen10W500(
                                                              color: HexColor(
                                                                      "#FFFFFF")
                                                                  .withOpacity(
                                                                      1)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              const Spacer(),
                                              Container(
                                                height: 44,
                                                decoration: BoxDecoration(
                                                  color: HexColor(primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "This week",
                                                        style: CustomFonts
                                                            .slussen12W500(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: screenHeight * .01,
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                for (int i = 0;
                                                    i < graphData.length;
                                                    i++)
                                                  graphData[i] == greatestValue
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Image.asset(
                                                              "lib/pages/dashboard/assets/graph-candle.png",
                                                              fit: BoxFit.fill,
                                                              width: 37,
                                                              height:
                                                                  graphData[i] /
                                                                      total *
                                                                      500,
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              days[i],
                                                              style: CustomFonts
                                                                  .slussen12W600(
                                                                      color: Colors
                                                                          .white),
                                                            )
                                                          ],
                                                        )
                                                      : Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              width: 37,
                                                              height:
                                                                  graphData[i] /
                                                                      total *
                                                                      500,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24)),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              days[i],
                                                              style: CustomFonts
                                                                  .slussen12W600(
                                                                      color: Colors
                                                                          .white),
                                                            )
                                                          ],
                                                        )
                                              ],
                                            ),
                                          )),
                                          SizedBox(
                                            height: screenHeight * .0125,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  Row(
                                    children: [
                                      GradientText(
                                        "4.6",
                                        style: CustomFonts.slussen28W700(),
                                        colors: [
                                          HexColor(goldDarkColor),
                                          HexColor(goldLightColor),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: RichText(
                                            text: TextSpan(
                                                style:
                                                    CustomFonts.slussen12W500(
                                                        color: Colors.white),
                                                children: [
                                              TextSpan(
                                                  text: "Patient Love! ",
                                                  style:
                                                      CustomFonts.slussen12W700(
                                                          color: Colors.white)),
                                              const TextSpan(
                                                  text:
                                                      "Patient love! Your ratings surged "),
                                              TextSpan(
                                                  text: "20% ",
                                                  style:
                                                      CustomFonts.slussen12W700(
                                                          color: HexColor(
                                                              goldLightColor))),
                                              const TextSpan(text: "this week"),
                                            ])),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        height: 28,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.1),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "lib/pages/dashboard/assets/share.png",
                                                height: 12,
                                                width: 12,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "Share Progress",
                                                style:
                                                    CustomFonts.slussen10W500(
                                                        color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  Center(
                                    child: Text(
                                      "Time Regained",
                                      style: CustomFonts.slussen28W700(
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Image.asset(
                                        "lib/pages/dashboard/assets/photo.png",
                                        fit: BoxFit.fill,
                                      ),
                                      Positioned(
                                        bottom: 32,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 54,
                                                  width: 54,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          HexColor(pinkColor)),
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "lib/pages/dashboard/assets/chat.png",
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "Chat",
                                                  style:
                                                      CustomFonts.slussen10W700(
                                                          color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 22,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 54,
                                                  width: 54,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          HexColor(pinkColor)),
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "lib/pages/dashboard/assets/faq.png",
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "FAQs",
                                                  style:
                                                      CustomFonts.slussen10W700(
                                                          color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 22,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 54,
                                                  width: 54,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          HexColor(pinkColor)),
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "lib/pages/dashboard/assets/mail.png",
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "Email",
                                                  style:
                                                      CustomFonts.slussen10W700(
                                                          color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomAppbar(callback: callback)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
