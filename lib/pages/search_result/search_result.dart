import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

import '../../widgets/drawer.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({ Key? key }) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> 
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

  List<String> timeRangeList = [
    'All Time',
    '1 Week',
    '15 Days',
    '1 Month',
    '3 Months',
    '6 Months',
    '1 Year'
  ];

  String selectedTime = 'All Time';

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
          CustomDrawer(callback: callback,),
          content(context)
        ],
      ));
  }

  Widget content(context){
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
          borderRadius: BorderRadius.all(Radius.circular(
            isCollapsed ? 0 : 40)),
          elevation: 8,
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(
            isCollapsed ? 0 : 40)),
            child: Container(width: double.infinity,
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
                      ? physics : const NeverScrollableScrollPhysics(),
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                           
                                const SizedBox(height: 24,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Stack(alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.white.withOpacity(.05)
                                        ),
                                        child: Center(child: TextField(
                                          style: CustomFonts.slussen14W600(
                                              color: Colors.white
                                            ),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(
                                              left: 16, right: 50
                                            ),
                                            hintText: "Search",
                                            hintStyle: CustomFonts.slussen14W600(
                                              color: Colors.white.withOpacity(.7)
                                            ),
                                            border: InputBorder.none
                                          ),
                                        )),
                                      ),
                                      Positioned(right: 5,
                                                            child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(colors: [
                                              HexColor("#E7CB87"),
                                              HexColor("#E49356"),
                                            ])
                                          ),
                                          child: Image.asset("lib/pages/dashboard/assets/search.png",
                                            height: 20, 
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("History",
                                      style: CustomFonts.slussen12W500(
                                        color: Colors.white
                                      ),),
                                      Text("Clear",
                                        style: TextStyle(
                                          color: HexColor("#E957C9"),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          decorationColor: HexColor("#E957C9"),
                                        ),),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                for(int i = 0; i < 2; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                                    child: Container(height: screenHeight * 0.1,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: HexColor("#FFFFFF"),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(screenHeight * 0.08),
                                        topRight: Radius.circular(screenHeight * 0.03),
                                        bottomLeft: Radius.circular(screenHeight * 0.08),
                                        bottomRight: Radius.circular(screenHeight * 0.08),
                                      ),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset("lib/pages/dashboard/assets/img.png",
                                          height: screenHeight * 0.08, width: screenHeight * 0.08,),
                                          const SizedBox(width: 8,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Rooney Jay",
                                              style: CustomFonts.slussen14W700(
                                                color: HexColor("#201A3F")
                                              ),),
                                              SizedBox(height: screenHeight * 0.005,),
                                              Text("ID - F864HIA85VX00",
                                              style: CustomFonts.slussen8W500(
                                                color: HexColor("#201A3F").withOpacity(.4)
                                              ),),
                                              SizedBox(height: screenHeight * 0.0075,),
                                              Container(
                                                height: 20, width: 200,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(colors: [
                                                    HexColor("#E2C680"),
                                                    HexColor("#D8874B"),
                                                  ]),
                                                  borderRadius: BorderRadius.circular(35)
                                                ),
                                                child: Center(
                                                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Dental Braces ",
                                                        style: CustomFonts.slussen10W500(
                                                        color: Colors.white)),
                                                        Text("(Paid - Rs. 2000)",
                                                        style: CustomFonts.slussen10W700(
                                                        color: Colors.white)),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text("21 Feb, Wed",
                                              style: CustomFonts.slussen8W500(
                                                color: HexColor("#201A3F").withOpacity(.4)
                                              ),),
                                              SizedBox(height: screenHeight * 0.02,),
                                              Image.asset("lib/pages/search_result/assets/call.png",
                                                  height: 30, width: 30,),
                                            ],
                                          ),
                                          const SizedBox(width: 10,),
                                        ],
                                      ),
                                    ),
                                  ),          
                                const SizedBox(height: 16,),
                                Stack(alignment: Alignment.topLeft,
                                  children: [
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(height: 28,
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("History",
                                              style: CustomFonts.slussen12W500(
                                                color: Colors.white
                                              ),),
                                              const SizedBox()
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8,),
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: HexColor("#F2F7FB"),
                                            borderRadius: const BorderRadius.only(
                                              topLeft:  Radius.circular(45),
                                              topRight: Radius.circular(45),
                                              bottomLeft: Radius.circular(45),
                                              bottomRight: Radius.circular(45),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 8,),
                                              for(int i = 0; i < 8; i++)
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 12,),
                                            child: Container(height: screenHeight * 0.1,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: HexColor("#F2F7FB"),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(screenHeight * 0.08),
                                                topRight: Radius.circular(screenHeight * 0.03),
                                                bottomLeft: Radius.circular(screenHeight * 0.08),
                                                bottomRight: Radius.circular(screenHeight * 0.08),
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0xffFFFFFF),
                                                  offset: Offset(-5.0, -5.0),
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
                                                  Image.asset("lib/pages/dashboard/assets/img.png",
                                                  height: screenHeight * 0.08, width: screenHeight * 0.08,),
                                                  const SizedBox(width: 8,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Rooney Jay",
                                                      style: CustomFonts.slussen14W700(
                                                        color: HexColor("#201A3F")
                                                      ),),
                                                      SizedBox(height: screenHeight * 0.005,),
                                                      Text("ID - F864HIA85VX00",
                                                      style: CustomFonts.slussen8W500(
                                                        color: HexColor("#201A3F").withOpacity(.4)
                                                      ),),
                                                      SizedBox(height: screenHeight * 0.0075,),
                                                      Container(
                                                        height: 20, width: 200,
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(colors: [
                                                            HexColor("#E2C680"),
                                                            HexColor("#D8874B"),
                                                          ]),
                                                          borderRadius: BorderRadius.circular(35)
                                                        ),
                                                        child: Center(
                                                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text("Dental Braces ",
                                                                style: CustomFonts.slussen10W500(
                                                                color: Colors.white)),
                                                                Text("(Paid - Rs. 2000)",
                                                                style: CustomFonts.slussen10W700(
                                                                color: Colors.white)),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text("21 Feb, Wed",
                                                      style: CustomFonts.slussen8W500(
                                                        color: HexColor("#201A3F").withOpacity(.4)
                                                      ),),
                                                      SizedBox(height: screenHeight * 0.02,),
                                                      Image.asset("lib/pages/search_result/assets/call.png",
                                                          height: 30, width: 30,),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 10,),
                                                ],
                                              ),
                                            ),
                                          ),          
                                        
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              GlassContainer.clearGlass(height: 
                                              showTimeSelector ? 150 : 28, 
                                              borderRadius: BorderRadius.circular(13),
                                              width: 100, child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                                child: !showTimeSelector ? 
                                                InkWell(
                                                  onTap: () => setState(() {
                                                    showTimeSelector = true;
                                                  }),
                                                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Expanded(
                                                                child: Center(
                                                                  child: Text(selectedTime,
                                                                  style: CustomFonts.slussen12W700(
                                                                    color: HexColor(pinkColor))),
                                                                ),
                                                              ),
                                                              const SizedBox(width: 16,
                                                                child:Icon(Icons.keyboard_arrow_down,
                                                                size: 16, color: Colors.white,))
                                                            ],
                                                          ),
                                                ) :
                                                Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    for(String item in timeRangeList)
                                                    InkWell(
                                                      onTap: () => setState(() {
                                                        selectedTime = item;
                                                        showTimeSelector = false;
                                                      }),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 2),
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(item,
                                                            style: selectedTime == item ? CustomFonts.slussen12W700(
                                                              color: HexColor(pinkColor)) :
                                                            CustomFonts.slussen10W500(
                                                              color: HexColor("#201A3F").withOpacity(.7)
                                                            ),),
                                                            SizedBox(width: 16,
                                                              child: 'All Time' == item ?
                                                              const Icon(Icons.keyboard_arrow_up,
                                                              size: 16, color: Colors.white,)
                                                              : const SizedBox())
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                  ],
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