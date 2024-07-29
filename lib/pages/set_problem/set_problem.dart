import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:slider_button/slider_button.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:vector_math/vector_math.dart' as vector;

import '../../widgets/drawer.dart';

class SetProblem extends StatefulWidget {
  const SetProblem({Key? key}) : super(key: key);

  @override
  State<SetProblem> createState() => _SetProblemState();
}

class _SetProblemState extends State<SetProblem>
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

  // List problems = [
  //   'Dental Braces',
  //   'Decayed Tooth',
  //   'Tooth Extraction',
  //   'Dental Crown',
  //   'Gum Treatment',
  //   'Dental Cleaning',
  //   'Teeth Straightening',
  // ];

  List<dynamic> problems = [
    {
      "image": "Dental Braces",
      "price": "Rs. 1000 - 2000",
    },
    {
      "image": "Decayed Tooth",
      "price": "Rs. 3500",
    },
    {
      "image": "Tooth Extraction",
      "price": "Starting @ Rs. 10000",
    },
    {
      "image": "Dental Crown",
      "price": "Rs. 3000 - 5000",
    },
    {
      "image": "Gum Treatment",
      "price": "Rs. 500 - 5000",
    },
    {
      "image": "Dental Cleaning",
      "price": "Starting @ Rs. 8000",
    },
  ];
  int selectedProblem = 0;
  final ScrollController _firstController = ScrollController();
  List<TextEditingController> textController = [];
  bool edit = true;

  int selectBtn = 0;

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

  Transform navigationBar() {
    return Transform(
      transform: Matrix4.rotationX(3.14),
      alignment: Alignment.center,
      child: AnimatedContainer(
        height: 40.0,
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: HexColor("#201A3F"),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < icons.length; i++) iconBtn(i),
          ],
        ),
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    // var height = isActive ? 50.0 : 0.0;
    // var width = isActive ? 50.0 : 0.0;
    return SizedBox(
      width: 79.0,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              color: HexColor("#201A3F"),
              height: 70,
              width: 55,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                      painter: ButtonNotch(),
                    )
                  : const SizedBox(),
            ),
          ),
          isActive
              ? Positioned(
                  bottom: 30,
                  child: Container(
                    // margin: EdgeInsets.only(bottom: 23),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: HexColor("#E957C9")),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < icons.length; i++)
                            GestureDetector(
                              onTap: () => setState(() {
                                selectedIcon = i;
                                selectBtn = i;
                              }),
                              child: Container(
                                width: 79,
                                height: 110,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 79,
                                      width: 79,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: selectedIcon == i
                                              ? null
                                              : Colors.white.withOpacity(0.1),
                                          gradient: selectedIcon == i
                                              ? LinearGradient(colors: [
                                                  HexColor(goldLightColor),
                                                  HexColor(goldDarkColor)
                                                ])
                                              : null),
                                      child: Image.asset(
                                        "lib/pages/set_problem/assets/${icons[i]}.png",
                                        color: Colors.white,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      icons[i],
                                      style: selectedIcon == i
                                          ? CustomFonts.slussen10W600(
                                              color: Colors.white)
                                          : CustomFonts.slussen8W500(
                                              color: Colors.white
                                                  .withOpacity(0.3)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    navigationBar(),
                    Expanded(
                      child: DynMouseScroll(
                        durationMS: 5000,
                        scrollSpeed: -4.4,
                        builder: (context, controller, physics) => ListView(
                          padding: EdgeInsets.zero,
                          controller: _scrollController,
                          // physics:  NeverScrollableScrollPhysics(),
                          children: [
                            Container(
                              color: HexColor("#F2F7FB"),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: screenHeight * .02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14),
                                                  child: Text(
                                                    "Problem",
                                                    style: CustomFonts
                                                        .slussen30W700(
                                                            color: HexColor(
                                                                "#201A3F")),
                                                  ),
                                                ),
                                                Text(
                                                  "Set",
                                                  style:
                                                      CustomFonts.slussen14W700(
                                                          color: HexColor(
                                                              "#201A3F")),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          HexColor("#201A3F"),
                                                    ),
                                                    child: Center(
                                                        child: Image.asset(
                                                      "assets/images/edit.png",
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      edit = false;
                                                    });
                                                  },
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                InkWell(
                                                  onTap: () => setState(() {}),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          HexColor(pinkColor),
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
                                                          "ADD NEW",
                                                          style: CustomFonts
                                                              .slussen12W700(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenHeight * .02,
                                        ),
                                        Container(
                                          height: screenHeight * .5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xff000000)
                                                    .withOpacity(.1),
                                                offset:
                                                    const Offset(-10.0, -10.0),
                                                blurRadius: 20,
                                                spreadRadius: 0.0,
                                              ),
                                              BoxShadow(
                                                color: const Color(0xff000000)
                                                    .withOpacity(.1),
                                                offset:
                                                    const Offset(10.0, 10.0),
                                                blurRadius: 20,
                                                spreadRadius: 0.0,
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              bottom: 8,
                                              left: 8,
                                              right: 16),
                                          child: RawScrollbar(
                                            controller: _firstController,
                                            thumbColor: HexColor("#E957C9"),
                                            trackColor: HexColor("#F2F7FB"),
                                            radius: Radius.circular(25),
                                            trackRadius: Radius.circular(25),
                                            trackBorderColor:
                                                HexColor("#F2F7FB"),
                                            padding: EdgeInsets.only(
                                                bottom: 43, top: 10),
                                            thickness: 10,
                                            trackVisibility: true,
                                            thumbVisibility: true,
                                            child: ListView.separated(
                                              controller: _firstController,
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                  height: 10,
                                                );
                                              },
                                              padding: EdgeInsets.only(
                                                  right: 20, top: 10),
                                              itemCount: problems.length,
                                              itemBuilder: (context, i) {
                                                textController.add(
                                                    TextEditingController(
                                                        text: problems[i]
                                                            ["image"]));
                                                return GestureDetector(
                                                  onTap: () => setState(() {
                                                    selectedProblem = i;
                                                  }),
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topRight,
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        height: isCollapsed
                                                            ? null
                                                            : 66,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8,
                                                                right: 18,
                                                                bottom: 8,
                                                                left: 8),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        45),
                                                            color: selectedProblem ==
                                                                    i
                                                                ? HexColor(
                                                                    "#F2F7FB")
                                                                : HexColor(
                                                                    "#F2F7FB")),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              height: 40,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: HexColor(
                                                                      primaryColor)),
                                                              child: Image.asset(
                                                                  "lib/pages/new_consultation_details/assets/${problems[i]["image"]}.png",
                                                                  color: Colors
                                                                      .white),
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
                                                                  TextField(
                                                                    style: CustomFonts
                                                                        .slussen14W700(
                                                                            color:
                                                                                HexColor(primaryColor)),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    readOnly:
                                                                        edit,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintStyle:
                                                                          CustomFonts.slussen16W700(
                                                                              color: HexColor(primaryColor).withOpacity(.3)),
                                                                    ),
                                                                    controller:
                                                                        textController[
                                                                            i],
                                                                  ),
                                                                  if (isCollapsed)
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              2,
                                                                          horizontal:
                                                                              10),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                        // gradient: LinearGradient(colors: [
                                                                        //   HexColor(goldDarkColor),
                                                                        //   HexColor(goldLightColor)
                                                                        // ]
                                                                        color: HexColor(
                                                                            "#E49356"),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        problems[i]
                                                                            [
                                                                            "price"],
                                                                        style: CustomFonts.slussen10W500(
                                                                            color:
                                                                                Colors.white,
                                                                            overFlow: TextOverflow.ellipsis),
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: HexColor(
                                                                        "#FF65DE"),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            14)),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            2,
                                                                        horizontal:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      "res/images/light.png",
                                                                      height:
                                                                          16,
                                                                      width: 16,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      "Live",
                                                                      style: CustomFonts.slussen9W700(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                            // const SizedBox(
                                                            //   width: 8,
                                                            // ),
                                                            // const SizedBox(
                                                            //   width: 12,
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: -4,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              problems
                                                                  .removeAt(i);
                                                            });
                                                          },
                                                          child: Image.asset(
                                                            "res/images/delete.png",
                                                            width: 22,
                                                            height: 22,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                edit = true;
                                              });
                                            },
                                            child: Container(
                                              width: 180,
                                              height: 61,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(32),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      HexColor(goldDarkColor),
                                                      HexColor(goldLightColor)
                                                    ]),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "DONE",
                                                  style:
                                                      CustomFonts.slussen20W700(
                                                          color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
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
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class ButtonNotch extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var dotPoint = Offset(size.width / 2, 2);

    var paint_1 = Paint()
      ..color = HexColor("#F2F7FB")
      ..style = PaintingStyle.fill;
    var paint_2 = Paint()
      ..color = HexColor("#E957C9")
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(7.5, 0, 12, 5);
    path.quadraticBezierTo(size.width / 2, size.height / 2, size.width - 12, 5);
    path.quadraticBezierTo(size.width - 7.5, 0, size.width, 0);
    path.close();
    canvas.drawPath(path, paint_1);
    // canvas.drawCircle(dotPoint, 6, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
