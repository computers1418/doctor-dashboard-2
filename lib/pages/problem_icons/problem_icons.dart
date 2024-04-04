import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/text_style.dart';
import '../../widgets/drawer.dart';
import '../../widgets/neumorphic_widgets.dart';

class ProblemIcons extends StatefulWidget {
  const ProblemIcons({ Key? key }) : super(key: key);

  @override
  State<ProblemIcons> createState() => _ProblemIconsState();
}

class _ProblemIconsState extends State<ProblemIcons> 
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

  int selectedIcon = -1;

  @override
  void initState() {
    super.initState();
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
            borderRadius: BorderRadius.all(Radius.circular(isCollapsed ? 0 : 40)),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                  Stack(alignment: Alignment.topCenter,
                    children: [
                      Image.asset("lib/pages/problem_icons/assets/bg.png",
                      fit: BoxFit.fill,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAppbar(callback: callback),
                          SizedBox(height: screenHeight * .03,),
                          Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child:Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0175),
                                        child: Text("Problem Icons",
                                        style: CustomFonts.slussen32W700(
                                          color: HexColor("#FFFFFF")
                                        ),),
                                      ),
                                      Text("select Icons",
                                      style: CustomFonts.slussen14W500(
                                        color: HexColor("#FFFFFF").withOpacity(.5)
                                      ),),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                      if(isCollapsed)
                      Positioned(bottom: screenWidth * .03 + screenWidth * .25,
                      // left: -width * .045,
                        child: Row(
                          children: [
                            for(int i = 1; i <= 3; i++)
                            Padding(
                              padding: EdgeInsets.only(right: i < 3 ? screenWidth * .03 : 0),
                              child: InkWell(
                                onTap: () => setState(() {
                                  if(selectedIcon == i){
                                    selectedIcon = -1;
                                  }else{
                                    selectedIcon = i;
                                  }
                                }),
                                child: Container(
                                  padding: const EdgeInsets.all(30),
                                  height: screenWidth * .25, width: screenWidth * .25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(.05)
                                  ),
                                  child: Center(
                                    child: Image.asset("lib/pages/problem_icons/assets/icon$i.png",
                                    color: selectedIcon == i ? HexColor(goldDarkColor) :
                                Colors.white,),)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(isCollapsed)
                      Positioned(bottom: screenWidth * .03,
                      left: -screenWidth * .045,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          child: Row(
                            children: [
                              for(int i = 4; i <= 7; i++)
                              Padding(
                                padding: EdgeInsets.only(right: i < 7 ? screenWidth * .03 : 0),
                                child: InkWell(
                                onTap: () => setState(() {
                                  if(selectedIcon == i){
                                    selectedIcon = -1;
                                  }else{
                                    selectedIcon = i;
                                  }
                                }),
                                  child: Container(
                                    padding: const EdgeInsets.all(30),
                                    height: screenWidth * .25, width: screenWidth * .25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(.05)
                                    ),
                                    child: Center(
                                      child: Image.asset("lib/pages/problem_icons/assets/icon$i.png",
                                      color: selectedIcon == i ? HexColor(goldDarkColor) :
                                Colors.white,),)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenWidth,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for(int i = 1; i <= 3; i++)
                        Padding(
                          padding: EdgeInsets.only(right: i < 3 ? screenWidth * .03 : 0),
                          child: InkWell(
                                onTap: () => setState(() {
                                  if(selectedIcon == i*10){
                                    selectedIcon = -1;
                                  }else{
                                    selectedIcon = i*10;
                                  }
                                }),
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              height: screenWidth * .25, width: screenWidth * .25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor(primaryColor)
                              ),
                              child: Center(
                                child: Image.asset("lib/pages/problem_icons/assets/icon$i.png",
                                color: selectedIcon == i*10 ? HexColor(goldDarkColor) :
                                Colors.white,),)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      SizedBox(width: screenWidth,
                      height: screenWidth * .31,),
                      Positioned(//bottom: width * .03,
                          left: -screenWidth * .045,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              child: Row(
                                children: [
                                  for(int i = 4; i <= 7; i++)
                                  Padding(
                                    padding: EdgeInsets.only(right: i < 7 ? screenWidth * .03 : 0),
                                    child: InkWell(
                                      onTap: () => setState(() {
                                        if(selectedIcon == i*10){
                                          selectedIcon = -1;
                                        }else{
                                          selectedIcon = i*10;
                                        }
                                      }),
                                      child: Container(
                                        padding: const EdgeInsets.all(30),
                                        height: screenWidth * .25, width: screenWidth * .25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: HexColor(primaryColor)
                                        ),
                                        child: Center(
                                          child: Image.asset("lib/pages/problem_icons/assets/icon$i.png",
                                          color: selectedIcon == i*10 ? HexColor(goldDarkColor) :
                                Colors.white,),)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
                  const SizedBox(height: 32,),
                  Container(height: 60, width: 172,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: HexColor(pinkColor)
                    ),
                    child: Center(
                      child: Text("DONE",
                      style: CustomFonts.slussen20W700(
                        color: Colors.white
                      ),),
                    ),
                  ),
                  const SizedBox(height: 16,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}