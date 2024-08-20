import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/controller/problem_controller.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:slider_button/slider_button.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:vector_math/vector_math.dart' as vector;

import '../../constants/delete_dialog.dart';
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
  FToast? fToast;
  Map<dynamic, dynamic>? selectProblem;

  final _scrollController = ScrollController();
  double _currentOffset = 0.0;

  List icons = ['Set Problem', 'Set Test', 'Set Medicine', 'Set Surgery'];

  int selectedIcon = 0;

  ProblemController problemController = Get.put(ProblemController());

  final ScrollController _firstController = ScrollController();
  List<TextEditingController> textController = [];
  bool edit = true;

  int selectBtn = 0;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
    problemController.getAllSetProblemList(
        {"doctorId": "66bf3adcdd3df57c89074fe1", "isDoctor": "yes"});
    problemController.getAllTestList({"doctorId": "66bf3adcdd3df57c89074fe1"});
    problemController
        .getAllMedicineList({"doctorId": "66bf3adcdd3df57c89074fe1"});
    problemController
        .getAllSurgeryList({"doctorId": "66bf3adcdd3df57c89074fe1"});
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
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: GetBuilder<ProblemController>(
          init: ProblemController(),
          builder: (setProblem) => Stack(
            children: [
              CustomDrawer(
                callback: callback,
              ),
              AnimatedPositioned(
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
                        borderRadius: BorderRadius.all(
                            Radius.circular(isCollapsed ? 0 : 40)),
                        child: Container(
                          width: double.infinity,
                          color: HexColor("#201A3F"),
                          child: Column(
                            children: [
                              CustomAppbar(callback: callback),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (int i = 0; i < icons.length; i++)
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          selectedIcon = i;
                                          selectBtn = i;
                                          selectProblem = null;
                                        }),
                                        child: Container(
                                          width: 79,
                                          height: 110,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 79,
                                                width: 79,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: selectedIcon == i
                                                        ? null
                                                        : Colors.white
                                                            .withOpacity(0.1),
                                                    gradient: selectedIcon == i
                                                        ? LinearGradient(
                                                            colors: [
                                                                HexColor(
                                                                    goldLightColor),
                                                                HexColor(
                                                                    goldDarkColor)
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
                                  builder: (context, controller, physics) =>
                                      Container(
                                    color: HexColor("#F2F7FB"),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: HexColor("#F2F7FB"),
                                              borderRadius:
                                                  const BorderRadius.only(
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 14),
                                                          child: Text(
                                                            selectedIcon == 0
                                                                ? "Problem"
                                                                : selectedIcon ==
                                                                        1
                                                                    ? "Test"
                                                                    : selectedIcon ==
                                                                            2
                                                                        ? "Medicine"
                                                                        : "Surgery",
                                                            style: CustomFonts
                                                                .slussen30W700(
                                                                    color: HexColor(
                                                                        "#201A3F")),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Set",
                                                          style: CustomFonts
                                                              .slussen14W700(
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
                                                                const EdgeInsets
                                                                    .all(12),
                                                            height: 40,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: HexColor(
                                                                  "#201A3F"),
                                                            ),
                                                            child: Center(
                                                                child:
                                                                    Image.asset(
                                                              "assets/images/edit.png",
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                          ),
                                                          onTap: () {
                                                            if (selectProblem !=
                                                                null) {
                                                              if (selectedIcon ==
                                                                  0) {
                                                                problemController
                                                                    .updateReadStatus(
                                                                        selectProblem!);
                                                              } else if (selectedIcon ==
                                                                  1) {
                                                                problemController
                                                                    .updateTestReadStatus(
                                                                        selectProblem!);
                                                              } else if (selectedIcon ==
                                                                  2) {
                                                                problemController
                                                                    .updateMedicineReadStatus(
                                                                        selectProblem!);
                                                              } else if (selectedIcon ==
                                                                  3) {
                                                                problemController
                                                                    .updateSurgeryReadStatus(
                                                                        selectProblem!);
                                                              }
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            if (selectedIcon ==
                                                                0) {
                                                              problemController
                                                                  .addController({
                                                                "id": '',
                                                                "problemController":
                                                                    TextEditingController(),
                                                                "problemPrice":
                                                                    TextEditingController(),
                                                                "read": false,
                                                                "new": true,
                                                                "edit": false
                                                              });
                                                            } else if (selectedIcon ==
                                                                1) {
                                                              problemController
                                                                  .addTestController({
                                                                "id": '',
                                                                "problemController":
                                                                    TextEditingController(),
                                                                "problemPrice":
                                                                    TextEditingController(),
                                                                "read": false,
                                                                "new": true,
                                                                "edit": false
                                                              });
                                                            } else if (selectedIcon ==
                                                                2) {
                                                              problemController
                                                                  .addMedicineController({
                                                                "id": '',
                                                                "problemController":
                                                                    TextEditingController(),
                                                                "problemPrice":
                                                                    TextEditingController(),
                                                                "read": false,
                                                                "new": true,
                                                                "edit": false
                                                              });
                                                            } else if (selectedIcon ==
                                                                3) {
                                                              problemController
                                                                  .addSurgeryController({
                                                                "id": '',
                                                                "problemController":
                                                                    TextEditingController(),
                                                                "problemPrice":
                                                                    TextEditingController(),
                                                                "read": false,
                                                                "new": true,
                                                                "edit": false
                                                              });
                                                            }
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12),
                                                            height: 40,
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
                                                                  "ADD NEW",
                                                                  style: CustomFonts
                                                                      .slussen12W700(
                                                                          color:
                                                                              Colors.white),
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
                                                Expanded(
                                                  child: setProblem
                                                          .isFetching.value
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                          color: HexColor(
                                                              "#201A3F"),
                                                        ))
                                                      : Container(
                                                          height:
                                                              screenHeight * .5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xffffffff),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: const Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        .1),
                                                                offset:
                                                                    const Offset(
                                                                        -10.0,
                                                                        -10.0),
                                                                blurRadius: 20,
                                                                spreadRadius:
                                                                    0.0,
                                                              ),
                                                              BoxShadow(
                                                                color: const Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        .1),
                                                                offset:
                                                                    const Offset(
                                                                        10.0,
                                                                        10.0),
                                                                blurRadius: 20,
                                                                spreadRadius:
                                                                    0.0,
                                                              ),
                                                            ],
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 10,
                                                                  bottom: 8,
                                                                  left: 8,
                                                                  right: 16),
                                                          child: RawScrollbar(
                                                            controller:
                                                                _firstController,
                                                            thumbColor:
                                                                HexColor(
                                                                    "#E957C9"),
                                                            trackColor:
                                                                HexColor(
                                                                    "#F2F7FB"),
                                                            radius:
                                                                Radius.circular(
                                                                    25),
                                                            trackRadius:
                                                                Radius.circular(
                                                                    25),
                                                            trackBorderColor:
                                                                HexColor(
                                                                    "#F2F7FB"),
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 43,
                                                                    top: 10),
                                                            thickness: 10,
                                                            trackVisibility:
                                                                true,
                                                            thumbVisibility:
                                                                true,
                                                            child: ListView
                                                                .separated(
                                                              controller:
                                                                  _firstController,
                                                              separatorBuilder:
                                                                  (context,
                                                                      index) {
                                                                return SizedBox(
                                                                  height: 10,
                                                                );
                                                              },
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 20,
                                                                      top: 10),
                                                              itemCount: selectedIcon ==
                                                                      0
                                                                  ? setProblem
                                                                      .newProblemList
                                                                      .length
                                                                  : selectedIcon ==
                                                                          1
                                                                      ? setProblem
                                                                          .newTestList
                                                                          .length
                                                                      : selectedIcon ==
                                                                              2
                                                                          ? setProblem
                                                                              .newMedicineList
                                                                              .length
                                                                          : setProblem
                                                                              .newSurgeryList
                                                                              .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      if (selectedIcon ==
                                                                          0) {
                                                                        selectProblem =
                                                                            setProblem.newProblemList[i];
                                                                        problemController
                                                                            .updateAllReadStatus();
                                                                      } else if (selectedIcon ==
                                                                          1) {
                                                                        selectProblem =
                                                                            setProblem.newTestList[i];
                                                                        problemController
                                                                            .updateTestAllReadStatus();
                                                                      } else if (selectedIcon ==
                                                                          2) {
                                                                        selectProblem =
                                                                            setProblem.newMedicineList[i];
                                                                        problemController
                                                                            .updateMedicineAllReadStatus();
                                                                      } else if (selectedIcon ==
                                                                          3) {
                                                                        selectProblem =
                                                                            setProblem.newSurgeryList[i];
                                                                        problemController
                                                                            .updateSurgeryAllReadStatus();
                                                                      }
                                                                    });
                                                                  },
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    children: [
                                                                      Container(
                                                                        height: isCollapsed
                                                                            ? null
                                                                            : 66,
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                8,
                                                                            right:
                                                                                18,
                                                                            bottom:
                                                                                8,
                                                                            left:
                                                                                8),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(45),
                                                                            color: HexColor("#F2F7FB")),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              padding: const EdgeInsets.all(10),
                                                                              height: 40,
                                                                              width: 40,
                                                                              decoration: BoxDecoration(shape: BoxShape.circle, color: HexColor(primaryColor)),
                                                                              child: Image.asset("lib/pages/new_consultation_details/assets/Dental Braces.png", color: Colors.white),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                            Expanded(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  TextField(
                                                                                    style: CustomFonts.slussen14W700(color: HexColor(primaryColor)),
                                                                                    textAlign: TextAlign.start,
                                                                                    readOnly: selectedIcon == 0
                                                                                        ? setProblem.newProblemList[i]["read"]
                                                                                        : selectedIcon == 1
                                                                                            ? setProblem.newTestList[i]["read"]
                                                                                            : selectedIcon == 2
                                                                                                ? setProblem.newMedicineList[i]["read"]
                                                                                                : setProblem.newSurgeryList[i]["read"],
                                                                                    decoration: InputDecoration(
                                                                                      contentPadding: EdgeInsets.zero,
                                                                                      isDense: true,
                                                                                      border: InputBorder.none,
                                                                                      hintText: "Name",
                                                                                      hintStyle: CustomFonts.slussen16W700(color: HexColor(primaryColor).withOpacity(.3)),
                                                                                    ),
                                                                                    controller: selectedIcon == 0
                                                                                        ? setProblem.newProblemList[i]["problemController"]
                                                                                        : selectedIcon == 1
                                                                                            ? setProblem.newTestList[i]["problemController"]
                                                                                            : selectedIcon == 2
                                                                                                ? setProblem.newMedicineList[i]["problemController"]
                                                                                                : setProblem.newSurgeryList[i]["problemController"],
                                                                                  ),
                                                                                  if (isCollapsed)
                                                                                    Container(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(12),
                                                                                        color: HexColor("#E49356"),
                                                                                      ),
                                                                                      child: TextField(
                                                                                        style: CustomFonts.slussen10W500(color: Colors.white, overFlow: TextOverflow.ellipsis),
                                                                                        textAlign: TextAlign.start,
                                                                                        readOnly: selectedIcon == 0
                                                                                            ? setProblem.newProblemList[i]["read"]
                                                                                            : selectedIcon == 1
                                                                                                ? setProblem.newTestList[i]["read"]
                                                                                                : selectedIcon == 2
                                                                                                    ? setProblem.newMedicineList[i]["read"]
                                                                                                    : setProblem.newSurgeryList[i]["read"],
                                                                                        decoration: InputDecoration(
                                                                                          contentPadding: EdgeInsets.zero,
                                                                                          hintText: "Price",
                                                                                          isDense: true,
                                                                                          border: InputBorder.none,
                                                                                          hintStyle: CustomFonts.slussen10W500(color: Colors.white, overFlow: TextOverflow.ellipsis),
                                                                                        ),
                                                                                        controller: selectedIcon == 0
                                                                                            ? setProblem.newProblemList[i]["problemPrice"]
                                                                                            : selectedIcon == 1
                                                                                                ? setProblem.newTestList[i]["problemPrice"]
                                                                                                : selectedIcon == 2
                                                                                                    ? setProblem.newMedicineList[i]["problemPrice"]
                                                                                                    : setProblem.newSurgeryList[i]["problemPrice"],
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
                                                                                decoration: BoxDecoration(color: HexColor("#FF65DE"), borderRadius: BorderRadius.circular(14)),
                                                                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Image.asset(
                                                                                      "res/images/light.png",
                                                                                      height: 16,
                                                                                      width: 16,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 2,
                                                                                    ),
                                                                                    Text(
                                                                                      "Live",
                                                                                      style: CustomFonts.slussen9W700(color: Colors.white),
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
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            // setState(() {
                                                                            //   problems.removeAt(i);
                                                                            // });
                                                                            showModalBottomSheet(
                                                                              context: context,
                                                                              barrierColor: HexColor("#201A3F").withOpacity(0.8),
                                                                              builder: (context) {
                                                                                return DeleteDialog(
                                                                                  onTap: () {
                                                                                    if (selectedIcon == 0) {
                                                                                      problemController.deleteProblem(
                                                                                        setProblem.newProblemList[i]["id"],
                                                                                        context,
                                                                                        fToast,
                                                                                        "problem",
                                                                                        () {
                                                                                          problemController.getAllSetProblemList({
                                                                                            "doctorId": "66bf3adcdd3df57c89074fe1",
                                                                                            "isDoctor": "yes"
                                                                                          });
                                                                                        },
                                                                                      ).then(
                                                                                        (value) {
                                                                                          problemController.getAllSetProblemList({
                                                                                            "doctorId": "66bf3adcdd3df57c89074fe1",
                                                                                            "isDoctor": "yes"
                                                                                          });
                                                                                          setState(() {
                                                                                            selectProblem = null;
                                                                                          });
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                      );
                                                                                    } else if (selectedIcon == 1) {
                                                                                      problemController.deleteProblem(
                                                                                        setProblem.newTestList[i]["id"],
                                                                                        context,
                                                                                        fToast,
                                                                                        "test",
                                                                                        () {
                                                                                          problemController.getAllTestList({
                                                                                            "doctorId": "66bf3adcdd3df57c89074fe1"
                                                                                          });
                                                                                        },
                                                                                      ).then(
                                                                                        (value) {
                                                                                          problemController.getAllTestList({
                                                                                            "doctorId": "66bf3adcdd3df57c89074fe1"
                                                                                          });
                                                                                          setState(() {
                                                                                            selectProblem = null;
                                                                                          });
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                      );
                                                                                    } else if (selectedIcon == 2) {
                                                                                      problemController.deleteProblem(
                                                                                        setProblem.newMedicineList[i]["id"],
                                                                                        context,
                                                                                        fToast,
                                                                                        "medicine",
                                                                                        () {
                                                                                          problemController.getAllMedicineList({
                                                                                            "doctorId": "66bf3adcdd3df57c89074fe1"
                                                                                          });
                                                                                        },
                                                                                      ).then(
                                                                                        (value) {
                                                                                          problemController.getAllMedicineList({
                                                                                            "doctorId": "66bf3adcdd3df57c89074fe1"
                                                                                          });
                                                                                          setState(() {
                                                                                            selectProblem = null;
                                                                                          });
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                      );
                                                                                    } else if (selectedIcon == 3) {
                                                                                      problemController.deleteProblem(
                                                                                        setProblem.newSurgeryList[i]["id"],
                                                                                        context,
                                                                                        fToast,
                                                                                        "surgery",
                                                                                        () {
                                                                                          problemController.getAllSurgeryList({
                                                                                            "doctorId": "66bf3adcdd3df57c89074fe1"
                                                                                          });
                                                                                        },
                                                                                      ).then(
                                                                                        (value) {
                                                                                          problemController.getAllSurgeryList({
                                                                                            "doctorId": "66bf3adcdd3df57c89074fe1"
                                                                                          });
                                                                                          setState(() {
                                                                                            selectProblem = null;
                                                                                          });
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                      );
                                                                                    }
                                                                                  },
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                          child:
                                                                              Image.asset(
                                                                            "res/images/delete.png",
                                                                            width:
                                                                                22,
                                                                            height:
                                                                                22,
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
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              if (selectedIcon == 0) {
                                                if (setProblem.newProblemList
                                                    .where((element) =>
                                                        element["new"] == true)
                                                    .isNotEmpty) {
                                                  problemController.setProblem({
                                                    "doctorId":
                                                        "66bf3adcdd3df57c89074fe1",
                                                    "problemName": setProblem
                                                        .newProblemList[
                                                            setProblem
                                                                .newProblemList
                                                                .indexWhere(
                                                      (element) =>
                                                          element["new"] ==
                                                          true,
                                                    )]["problemController"]
                                                        .text,
                                                    "price": setProblem
                                                        .newProblemList[
                                                            setProblem
                                                                .newProblemList
                                                                .indexWhere(
                                                      (element) =>
                                                          element["new"] ==
                                                          true,
                                                    )]["problemPrice"]
                                                        .text
                                                  }, context, fToast).then(
                                                    (value) {
                                                      selectProblem = null;
                                                      problemController
                                                          .clearNewProblemList();
                                                      problemController
                                                          .getAllSetProblemList({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1",
                                                        "isDoctor": "yes"
                                                      });
                                                    },
                                                  );
                                                } else if (setProblem
                                                    .newProblemList
                                                    .where((element) =>
                                                        element["edit"] == true)
                                                    .isNotEmpty) {
                                                  int index = setProblem
                                                      .newProblemList
                                                      .indexWhere(
                                                    (element) =>
                                                        element["edit"] == true,
                                                  );
                                                  problemController
                                                      .updateProblem(
                                                    context,
                                                    fToast,
                                                    {
                                                      "doctorId":
                                                          "66bf3adcdd3df57c89074fe1",
                                                      "problemName": setProblem
                                                          .newProblemList[index]
                                                              [
                                                              "problemController"]
                                                          .text,
                                                      "price": setProblem
                                                          .newProblemList[index]
                                                              ["problemPrice"]
                                                          .text
                                                    },
                                                    "problem",
                                                    setProblem.newProblemList[
                                                        index]["id"],
                                                    () {
                                                      selectProblem = null;
                                                      problemController
                                                          .clearNewProblemList();
                                                      problemController
                                                          .getAllSetProblemList({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1",
                                                        "isDoctor": "yes"
                                                      });
                                                    },
                                                  );
                                                }
                                              } else if (selectedIcon == 1) {
                                                if (setProblem.newTestList
                                                    .where((element) =>
                                                        element["new"] == true)
                                                    .isNotEmpty) {
                                                  problemController.setTest({
                                                    "doctorId":
                                                        "66bf3adcdd3df57c89074fe1",
                                                    "testName": setProblem
                                                        .newTestList[setProblem
                                                            .newTestList
                                                            .indexWhere(
                                                      (element) =>
                                                          element["new"] ==
                                                          true,
                                                    )]["problemController"]
                                                        .text,
                                                    "price": setProblem
                                                        .newTestList[setProblem
                                                            .newTestList
                                                            .indexWhere(
                                                      (element) =>
                                                          element["new"] ==
                                                          true,
                                                    )]["problemPrice"]
                                                        .text
                                                  }, context, fToast).then(
                                                    (value) {
                                                      selectProblem = null;
                                                      problemController
                                                          .clearTestList();
                                                      problemController
                                                          .getAllTestList({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1"
                                                      });
                                                    },
                                                  );
                                                } else if (setProblem
                                                    .newTestList
                                                    .where((element) =>
                                                        element["edit"] == true)
                                                    .isNotEmpty) {
                                                  int index = setProblem
                                                      .newTestList
                                                      .indexWhere(
                                                    (element) =>
                                                        element["edit"] == true,
                                                  );
                                                  problemController
                                                      .updateProblem(
                                                    context,
                                                    fToast,
                                                    {
                                                      "doctorId":
                                                          "66bf3adcdd3df57c89074fe1",
                                                      "testName": setProblem
                                                          .newTestList[index][
                                                              "problemController"]
                                                          .text,
                                                      "price": setProblem
                                                          .newTestList[index]
                                                              ["problemPrice"]
                                                          .text
                                                    },
                                                    "test",
                                                    setProblem
                                                            .newTestList[index]
                                                        ["id"],
                                                    () {
                                                      selectProblem = null;
                                                      problemController
                                                          .clearTestList();
                                                      problemController
                                                          .getAllTestList({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1"
                                                      });
                                                    },
                                                  );
                                                }
                                              } else if (selectedIcon == 2) {
                                                if (setProblem.newMedicineList
                                                    .where((element) =>
                                                        element["new"] == true)
                                                    .isNotEmpty) {
                                                  problemController
                                                      .setMedicine({
                                                    "doctorId":
                                                        "66bf3adcdd3df57c89074fe1",
                                                    "medicineName": setProblem
                                                        .newMedicineList[
                                                            setProblem
                                                                .newMedicineList
                                                                .indexWhere(
                                                      (element) =>
                                                          element["new"] ==
                                                          true,
                                                    )]["problemController"]
                                                        .text,
                                                    "price": setProblem
                                                        .newMedicineList[
                                                            setProblem
                                                                .newMedicineList
                                                                .indexWhere(
                                                      (element) =>
                                                          element["new"] ==
                                                          true,
                                                    )]["problemPrice"]
                                                        .text
                                                  }, context, fToast).then(
                                                    (value) {
                                                      selectProblem = null;
                                                      problemController
                                                          .clearMedicineList();
                                                      problemController
                                                          .getAllMedicineList({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1"
                                                      });
                                                    },
                                                  );
                                                } else if (setProblem
                                                    .newMedicineList
                                                    .where((element) =>
                                                        element["edit"] == true)
                                                    .isNotEmpty) {
                                                  int index = setProblem
                                                      .newMedicineList
                                                      .indexWhere(
                                                    (element) =>
                                                        element["edit"] == true,
                                                  );
                                                  problemController
                                                      .updateProblem(
                                                    context,
                                                    fToast,
                                                    {
                                                      "doctorId":
                                                          "66bf3adcdd3df57c89074fe1",
                                                      "medicineName": setProblem
                                                          .newMedicineList[
                                                              index][
                                                              "problemController"]
                                                          .text,
                                                      "price": setProblem
                                                          .newMedicineList[
                                                              index]
                                                              ["problemPrice"]
                                                          .text
                                                    },
                                                    "medicine",
                                                    setProblem.newMedicineList[
                                                        index]["id"],
                                                    () {
                                                      selectProblem = null;
                                                      problemController
                                                          .clearMedicineList();
                                                      problemController
                                                          .getAllMedicineList({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1"
                                                      });
                                                    },
                                                  );
                                                }
                                              } else if (selectedIcon == 3) {
                                                if (setProblem.newSurgeryList
                                                    .where((element) =>
                                                        element["new"] == true)
                                                    .isNotEmpty) {
                                                  problemController.setSurgery({
                                                    "doctorId":
                                                        "66bf3adcdd3df57c89074fe1",
                                                    "surgeryName": setProblem
                                                        .newSurgeryList[
                                                            setProblem
                                                                .newSurgeryList
                                                                .indexWhere(
                                                      (element) =>
                                                          element["new"] ==
                                                          true,
                                                    )]["problemController"]
                                                        .text,
                                                    "price": setProblem
                                                        .newSurgeryList[
                                                            setProblem
                                                                .newSurgeryList
                                                                .indexWhere(
                                                      (element) =>
                                                          element["new"] ==
                                                          true,
                                                    )]["problemPrice"]
                                                        .text
                                                  }, context, fToast).then(
                                                    (value) {
                                                      selectProblem = null;
                                                      problemController
                                                          .clearSurgeryList();
                                                      problemController
                                                          .getAllSurgeryList({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1"
                                                      });
                                                    },
                                                  );
                                                } else if (setProblem
                                                    .newSurgeryList
                                                    .where((element) =>
                                                        element["edit"] == true)
                                                    .isNotEmpty) {
                                                  int index = setProblem
                                                      .newSurgeryList
                                                      .indexWhere(
                                                    (element) =>
                                                        element["edit"] == true,
                                                  );
                                                  problemController
                                                      .updateProblem(
                                                    context,
                                                    fToast,
                                                    {
                                                      "doctorId":
                                                          "66bf3adcdd3df57c89074fe1",
                                                      "surgeryName": setProblem
                                                          .newSurgeryList[index]
                                                              [
                                                              "problemController"]
                                                          .text,
                                                      "price": setProblem
                                                          .newSurgeryList[index]
                                                              ["problemPrice"]
                                                          .text
                                                    },
                                                    "surgery",
                                                    setProblem.newSurgeryList[
                                                        index]["id"],
                                                    () {
                                                      selectProblem = null;
                                                      problemController
                                                          .clearSurgeryList();
                                                      problemController
                                                          .getAllSurgeryList({
                                                        "doctorId":
                                                            "66bf3adcdd3df57c89074fe1"
                                                      });
                                                    },
                                                  );
                                                }
                                              }
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
                                        const SizedBox(
                                          height: 10,
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
              )
            ],
          ),
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
