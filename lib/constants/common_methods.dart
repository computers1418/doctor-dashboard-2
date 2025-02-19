import 'dart:async';
import 'dart:convert';
import 'package:doctor_dashboard/constants/pref_data.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/controller/consultation_controller.dart';
import 'package:doctor_dashboard/model/medicine_model.dart';
import 'package:doctor_dashboard/model/surgery_model.dart';
import 'package:doctor_dashboard/model/test_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

import '../controller/problem_controller.dart';
import '../model/set_problem_model.dart';
import 'constants.dart';

class CommonMethods {
  static Map decodeResponse(String response) {
    Map respJson = {};
    try {
      respJson = jsonDecode(response);
      return respJson;
    } catch (e) {
      respJson = {};
      return respJson;
    }
  }

  static Future<Map<String, dynamic>> decodeStreamedResponse(
      http.StreamedResponse response) async {
    Map<String, dynamic> respJson = {};
    try {
      respJson = jsonDecode(await response.stream.bytesToString());
      return respJson;
    } catch (e) {
      respJson = {};
      return respJson;
    }
  }

  static Future<void> showProblemBottomSheet(
      context,
      ProblemController problemController,
      ConsultationController consultationController) async {
    problemController.getAllSetProblemList(
        {"doctorId": await PrefData.getDoctorId(), "isDoctor": "yes"});
    List<String> problemList = consultationController.selectProblem;

    await showModalBottomSheet<void>(
      backgroundColor: Colors.white.withOpacity(.0000000001),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<ProblemController>(
          init: ProblemController(),
          builder: (setProblem) => StatefulBuilder(
            builder: (context, setState) => SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "lib/pages/new_consultation_details/assets/bottom-sheet-bg.png"))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 14),
                                        child: Text(
                                          "Problems",
                                          style: CustomFonts.slussen28W700(
                                              color: HexColor(primaryColor)),
                                        ),
                                      ),
                                      Text(
                                        "Select",
                                        style: CustomFonts.slussen14W700(
                                            color: HexColor(primaryColor)),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      consultationController
                                          .addProblem(problemList);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: HexColor(pinkColor),
                                      ),
                                      child: Text(
                                        'DONE',
                                        style: CustomFonts.slussen12W700(
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Expanded(
                                child: DynMouseScroll(
                                  durationMS: 5000,
                                  scrollSpeed: -4.4,
                                  builder: (context, controller, physics) =>
                                      Scrollbar(
                                    thickness: 10.0,
                                    trackVisibility: true,
                                    thumbVisibility: true,
                                    controller: controller,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: ListView.builder(
                                        itemCount:
                                            setProblem.getProblemList.length,
                                        controller: controller,
                                        itemBuilder: (context, i) {
                                          SetProblemModel problem =
                                              setProblem.getProblemList[i];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: GestureDetector(
                                              onTap: () => setState(() {
                                                if (problemList.contains(
                                                    problem.problemName)) {
                                                  problemList.remove(
                                                      problem.problemName);
                                                } else {
                                                  problemList
                                                      .add(problem.problemName);
                                                }
                                              }),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: problemList.contains(
                                                            problem.problemName)
                                                        ? HexColor("#E49356")
                                                        : Colors.white),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: problemList
                                                                  .contains(problem
                                                                      .problemName)
                                                              ? Colors.white
                                                              : HexColor(
                                                                  primaryColor)),
                                                      child: Image.asset(
                                                          "lib/pages/new_consultation_details/assets/Dental Braces.png",
                                                          color: problemList
                                                                  .contains(problem
                                                                      .problemName)
                                                              ? HexColor(
                                                                  primaryColor)
                                                              : Colors.white),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            problem.problemName,
                                                            style: CustomFonts.slussen16W700(
                                                                color: problemList
                                                                        .contains(problem
                                                                            .problemName)
                                                                    ? Colors
                                                                        .white
                                                                    : HexColor(
                                                                        primaryColor)),
                                                          ),
                                                          Container(
                                                            // width: 68,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              gradient:
                                                                  LinearGradient(
                                                                      colors: [
                                                                    HexColor(
                                                                        goldDarkColor),
                                                                    HexColor(
                                                                        goldLightColor)
                                                                  ]),
                                                            ),
                                                            child: Text(
                                                              problem.price,
                                                              style: CustomFonts
                                                                  .slussen10W500(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Container(
                                                      height: problemList
                                                              .contains(problem
                                                                  .problemName)
                                                          ? 42
                                                          : 30,
                                                      width: problemList
                                                              .contains(problem
                                                                  .problemName)
                                                          ? 42
                                                          : 30,
                                                      padding: EdgeInsets.all(
                                                          problemList.contains(
                                                                  problem
                                                                      .problemName)
                                                              ? 10
                                                              : 6),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: HexColor(
                                                                  pinkColor)
                                                              .withOpacity(problemList
                                                                      .contains(
                                                                          problem
                                                                              .problemName)
                                                                  ? 1
                                                                  : .2)),
                                                      child: Image.asset(
                                                          "lib/pages/new_consultation_details/assets/${problemList.contains(problem.problemName) ? 'done' : 'add'}.png"),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showTestBottomSheet(
      context,
      ProblemController problemController,
      ConsultationController consultationController) async {
    problemController
        .getAllTestList({"doctorId": await PrefData.getDoctorId()});
    List<String> testList = consultationController.selectTest;

    await showModalBottomSheet<void>(
      backgroundColor: Colors.white.withOpacity(.0000000001),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<ProblemController>(
          init: ProblemController(),
          builder: (setProblem) => StatefulBuilder(
            builder: (context, setState) => SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "lib/pages/new_consultation_details/assets/bottom-sheet-bg.png"))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 14),
                                        child: Text(
                                          "Tests",
                                          style: CustomFonts.slussen28W700(
                                              color: HexColor(primaryColor)),
                                        ),
                                      ),
                                      Text(
                                        "Select",
                                        style: CustomFonts.slussen14W700(
                                            color: HexColor(primaryColor)),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      consultationController.addTest(testList);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: HexColor(pinkColor),
                                      ),
                                      child: Text(
                                        'DONE',
                                        style: CustomFonts.slussen12W700(
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Expanded(
                                child: DynMouseScroll(
                                  durationMS: 5000,
                                  scrollSpeed: -4.4,
                                  builder: (context, controller, physics) =>
                                      Scrollbar(
                                    thickness: 10.0,
                                    trackVisibility: true,
                                    thumbVisibility: true,
                                    controller: controller,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: ListView.builder(
                                        itemCount:
                                            setProblem.getTestList.length,
                                        controller: controller,
                                        itemBuilder: (context, i) {
                                          TestModel problem =
                                              setProblem.getTestList[i];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: GestureDetector(
                                              onTap: () => setState(() {
                                                if (testList.contains(
                                                    problem.testName)) {
                                                  testList
                                                      .remove(problem.testName);
                                                } else {
                                                  testList
                                                      .add(problem.testName);
                                                }
                                              }),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: testList.contains(
                                                            problem.testName)
                                                        ? HexColor("#E49356")
                                                        : Colors.white),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: testList.contains(
                                                                  problem
                                                                      .testName)
                                                              ? Colors.white
                                                              : HexColor(
                                                                  primaryColor)),
                                                      child: Image.asset(
                                                          "lib/pages/new_consultation_details/assets/Dental Braces.png",
                                                          color: testList.contains(
                                                                  problem
                                                                      .testName)
                                                              ? HexColor(
                                                                  primaryColor)
                                                              : Colors.white),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            problem.testName,
                                                            style: CustomFonts.slussen16W700(
                                                                color: testList.contains(
                                                                        problem
                                                                            .testName)
                                                                    ? Colors
                                                                        .white
                                                                    : HexColor(
                                                                        primaryColor)),
                                                          ),
                                                          Container(
                                                            // width: 68,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              gradient:
                                                                  LinearGradient(
                                                                      colors: [
                                                                    HexColor(
                                                                        goldDarkColor),
                                                                    HexColor(
                                                                        goldLightColor)
                                                                  ]),
                                                            ),
                                                            child: Text(
                                                              problem.price,
                                                              style: CustomFonts
                                                                  .slussen10W500(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Container(
                                                      height: testList.contains(
                                                              problem.testName)
                                                          ? 42
                                                          : 30,
                                                      width: testList.contains(
                                                              problem.testName)
                                                          ? 42
                                                          : 30,
                                                      padding: EdgeInsets.all(
                                                          testList.contains(
                                                                  problem
                                                                      .testName)
                                                              ? 10
                                                              : 6),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: HexColor(
                                                                  pinkColor)
                                                              .withOpacity(testList
                                                                      .contains(
                                                                          problem
                                                                              .testName)
                                                                  ? 1
                                                                  : .2)),
                                                      child: Image.asset(
                                                          "lib/pages/new_consultation_details/assets/${testList.contains(problem.testName) ? 'done' : 'add'}.png"),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showSurgeryBottomSheet(
      context,
      ProblemController problemController,
      ConsultationController consultationController) async {
    problemController
        .getAllSurgeryList({"doctorId": await PrefData.getDoctorId()});
    List<String> surgeryList = consultationController.selectSurgery;

    await showModalBottomSheet<void>(
      backgroundColor: Colors.white.withOpacity(.0000000001),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<ProblemController>(
          init: ProblemController(),
          builder: (setProblem) => StatefulBuilder(
            builder: (context, setState) => SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "lib/pages/new_consultation_details/assets/bottom-sheet-bg.png"))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 14),
                                        child: Text(
                                          "Surgery",
                                          style: CustomFonts.slussen28W700(
                                              color: HexColor(primaryColor)),
                                        ),
                                      ),
                                      Text(
                                        "Select",
                                        style: CustomFonts.slussen14W700(
                                            color: HexColor(primaryColor)),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      consultationController
                                          .addSurgery(surgeryList);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: HexColor(pinkColor),
                                      ),
                                      child: Text(
                                        'DONE',
                                        style: CustomFonts.slussen12W700(
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Expanded(
                                child: DynMouseScroll(
                                  durationMS: 5000,
                                  scrollSpeed: -4.4,
                                  builder: (context, controller, physics) =>
                                      Scrollbar(
                                    thickness: 10.0,
                                    trackVisibility: true,
                                    thumbVisibility: true,
                                    controller: controller,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: ListView.builder(
                                        itemCount:
                                            setProblem.getSurgeryList.length,
                                        controller: controller,
                                        itemBuilder: (context, i) {
                                          SurgeryModel problem =
                                              setProblem.getSurgeryList[i];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: GestureDetector(
                                              onTap: () => setState(() {
                                                if (surgeryList.contains(
                                                    problem.surgeryName)) {
                                                  surgeryList.remove(
                                                      problem.surgeryName);
                                                } else {
                                                  surgeryList
                                                      .add(problem.surgeryName);
                                                }
                                              }),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: surgeryList.contains(
                                                            problem.surgeryName)
                                                        ? HexColor("#E49356")
                                                        : Colors.white),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: surgeryList
                                                                  .contains(problem
                                                                      .surgeryName)
                                                              ? Colors.white
                                                              : HexColor(
                                                                  primaryColor)),
                                                      child: Image.asset(
                                                          "lib/pages/new_consultation_details/assets/Dental Braces.png",
                                                          color: surgeryList
                                                                  .contains(problem
                                                                      .surgeryName)
                                                              ? HexColor(
                                                                  primaryColor)
                                                              : Colors.white),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            problem.surgeryName,
                                                            style: CustomFonts.slussen16W700(
                                                                color: surgeryList
                                                                        .contains(problem
                                                                            .surgeryName)
                                                                    ? Colors
                                                                        .white
                                                                    : HexColor(
                                                                        primaryColor)),
                                                          ),
                                                          Container(
                                                            // width: 68,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              gradient:
                                                                  LinearGradient(
                                                                      colors: [
                                                                    HexColor(
                                                                        goldDarkColor),
                                                                    HexColor(
                                                                        goldLightColor)
                                                                  ]),
                                                            ),
                                                            child: Text(
                                                              problem.price,
                                                              style: CustomFonts
                                                                  .slussen10W500(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Container(
                                                      height: surgeryList
                                                              .contains(problem
                                                                  .surgeryName)
                                                          ? 42
                                                          : 30,
                                                      width: surgeryList
                                                              .contains(problem
                                                                  .surgeryName)
                                                          ? 42
                                                          : 30,
                                                      padding: EdgeInsets.all(
                                                          surgeryList.contains(
                                                                  problem
                                                                      .surgeryName)
                                                              ? 10
                                                              : 6),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: HexColor(
                                                                  pinkColor)
                                                              .withOpacity(surgeryList
                                                                      .contains(
                                                                          problem
                                                                              .surgeryName)
                                                                  ? 1
                                                                  : .2)),
                                                      child: Image.asset(
                                                          "lib/pages/new_consultation_details/assets/${surgeryList.contains(problem.surgeryName) ? 'done' : 'add'}.png"),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showMedicineBottomSheet(
      context,
      ProblemController problemController,
      ConsultationController consultationController) async {
    problemController
        .getAllMedicineList({"doctorId": await PrefData.getDoctorId()});
    List<String> medicineList = consultationController.selectMedicine;

    await showModalBottomSheet<void>(
      backgroundColor: Colors.white.withOpacity(.0000000001),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<ProblemController>(
          init: ProblemController(),
          builder: (setProblem) => StatefulBuilder(
            builder: (context, setState) => SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "lib/pages/new_consultation_details/assets/bottom-sheet-bg.png"))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 14),
                                        child: Text(
                                          "Medicine",
                                          style: CustomFonts.slussen28W700(
                                              color: HexColor(primaryColor)),
                                        ),
                                      ),
                                      Text(
                                        "Select",
                                        style: CustomFonts.slussen14W700(
                                            color: HexColor(primaryColor)),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      consultationController
                                          .addMedicine(medicineList);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: HexColor(pinkColor),
                                      ),
                                      child: Text(
                                        'DONE',
                                        style: CustomFonts.slussen12W700(
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Expanded(
                                child: DynMouseScroll(
                                  durationMS: 5000,
                                  scrollSpeed: -4.4,
                                  builder: (context, controller, physics) =>
                                      Scrollbar(
                                    thickness: 10.0,
                                    trackVisibility: true,
                                    thumbVisibility: true,
                                    controller: controller,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: ListView.builder(
                                        itemCount:
                                            setProblem.getMedicineList.length,
                                        controller: controller,
                                        itemBuilder: (context, i) {
                                          MedicineModel problem =
                                              setProblem.getMedicineList[i];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: GestureDetector(
                                              onTap: () => setState(() {
                                                if (medicineList.contains(
                                                    problem.medicineName)) {
                                                  medicineList.remove(
                                                      problem.medicineName);
                                                } else {
                                                  medicineList.add(
                                                      problem.medicineName);
                                                }
                                              }),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: medicineList
                                                            .contains(problem
                                                                .medicineName)
                                                        ? HexColor("#E49356")
                                                        : Colors.white),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: medicineList
                                                                  .contains(problem
                                                                      .medicineName)
                                                              ? Colors.white
                                                              : HexColor(
                                                                  primaryColor)),
                                                      child: Image.asset(
                                                          "lib/pages/new_consultation_details/assets/Dental Braces.png",
                                                          color: medicineList
                                                                  .contains(problem
                                                                      .medicineName)
                                                              ? HexColor(
                                                                  primaryColor)
                                                              : Colors.white),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            problem
                                                                .medicineName,
                                                            style: CustomFonts.slussen16W700(
                                                                color: medicineList
                                                                        .contains(problem
                                                                            .medicineName)
                                                                    ? Colors
                                                                        .white
                                                                    : HexColor(
                                                                        primaryColor)),
                                                          ),
                                                          Container(
                                                            // width: 68,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              gradient:
                                                                  LinearGradient(
                                                                      colors: [
                                                                    HexColor(
                                                                        goldDarkColor),
                                                                    HexColor(
                                                                        goldLightColor)
                                                                  ]),
                                                            ),
                                                            child: Text(
                                                              problem.price,
                                                              style: CustomFonts
                                                                  .slussen10W500(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Container(
                                                      height: medicineList
                                                              .contains(problem
                                                                  .medicineName)
                                                          ? 42
                                                          : 30,
                                                      width: medicineList
                                                              .contains(problem
                                                                  .medicineName)
                                                          ? 42
                                                          : 30,
                                                      padding: EdgeInsets.all(
                                                          medicineList.contains(
                                                                  problem
                                                                      .medicineName)
                                                              ? 10
                                                              : 6),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: HexColor(
                                                                  pinkColor)
                                                              .withOpacity(medicineList
                                                                      .contains(
                                                                          problem
                                                                              .medicineName)
                                                                  ? 1
                                                                  : .2)),
                                                      child: Image.asset(
                                                          "lib/pages/new_consultation_details/assets/${medicineList.contains(problem.medicineName) ? 'done' : 'add'}.png"),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MapAppOption {
  final String name;
  final String package;

  MapAppOption(this.name, this.package);
}
