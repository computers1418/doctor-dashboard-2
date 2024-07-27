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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < icons.length; i++)
                            GestureDetector(
                              onTap: () => setState(() {
                                selectedIcon = i;
                              }),
                              child: Container(
                                height: 70,
                                width: 70,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        selectedIcon == i ? null : Colors.white,
                                    gradient: selectedIcon == i
                                        ? LinearGradient(colors: [
                                            HexColor(goldLightColor),
                                            HexColor(goldDarkColor)
                                          ])
                                        : null),
                                child: Image.asset(
                                  "lib/pages/set_problem/assets/${icons[i]}.png",
                                  color: selectedIcon == i
                                      ? Colors.white
                                      : HexColor(primaryColor),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: screenHeight * .01,
                    ),
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
                                                    "Details",
                                                    style: CustomFonts
                                                        .slussen30W700(
                                                            color: HexColor(
                                                                "#201A3F")),
                                                  ),
                                                ),
                                                Text(
                                                  "Add",
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
                                          child: Scrollbar(
                                            thickness: 10.0,
                                            trackVisibility: true,
                                            thumbVisibility: true,
                                            controller: _firstController,
                                            child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                  height: 10,
                                                );
                                              },
                                              padding: EdgeInsets.only(
                                                  right: 32, top: 10),
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
                                                                        .slussen16W700(
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
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: HexColor(
                                                                        "#201A3F"),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            14)),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            5,
                                                                        horizontal:
                                                                            14),
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      "res/images/light.png",
                                                                      height:
                                                                          18,
                                                                      width: 18,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      "Live",
                                                                      style: CustomFonts.slussen10W700(
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
                                                            width: 24,
                                                            height: 24,
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
