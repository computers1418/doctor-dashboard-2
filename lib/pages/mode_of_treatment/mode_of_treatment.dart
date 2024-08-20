import 'package:doctor_dashboard/controller/mode_of_treatment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math' as math;

import '../../constants/text_style.dart';
import '../../model/consultation_model.dart';
import '../../constants/delete_dialog.dart';

class ModeOfTreatment extends StatefulWidget {
  const ModeOfTreatment({Key? key}) : super(key: key);

  @override
  State<ModeOfTreatment> createState() => _ModeOfTreatmentState();
}

class _ModeOfTreatmentState extends State<ModeOfTreatment> {
  static RxList<ConsultationModel> consultationList = [
    ConsultationModel("assets/images/clinic_visit.png", "At Clinic", true),
    ConsultationModel("assets/images/call.png", "Telephonic", true),
    ConsultationModel("assets/images/video_call.png", "Virtual", false),
    ConsultationModel("assets/images/home_visit.png", "At Home", true),
  ].obs;

  void toggleSelection(int index) {
    consultationList[index].select = !consultationList[index].select;
    consultationList.refresh(); // Notify listeners
  }

  ModeOfTreatmentController homeController =
      Get.put(ModeOfTreatmentController());
  TextEditingController detailController = TextEditingController();
  FToast? fToast;
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(_onFocusChange);

    homeController.isDataLoading.value = true;
    homeController.getTreatmentModesByDoctorId(context);
    homeController.getTreatmentModes(context);
    homeController.getGuideline();
    homeController.isDataLoading.value = false;
    fToast = FToast();
    fToast?.init(context);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      // Schedule the scroll after the build is complete
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    // _focusNode.dispose();
    _scrollController.dispose();
    detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Scaffold(
        backgroundColor: HexColor("#201A3F"),
        body: SafeArea(
          child: GetBuilder<ModeOfTreatmentController>(
            init: ModeOfTreatmentController(),
            builder: (controller) => controller.isDataLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: HexColor("#201A3F"),
                  ))
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.h, top: 30.h, bottom: 20.h, right: 20.h),
                        child: Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 52.h,
                                width: 52.h,
                                decoration: BoxDecoration(
                                    border: GradientBoxBorder(
                                      gradient: LinearGradient(colors: [
                                        HexColor("#15102E"),
                                        HexColor("#2C2553")
                                      ], transform: GradientRotation(0.9)),
                                      width: 2.h,
                                    ),
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(colors: [
                                      HexColor("#392F70"),
                                      HexColor("#0D0823")
                                    ], transform: GradientRotation(0.9))),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/images/back.png",
                                  width: 20.h,
                                  height: 20.h,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            // ),
                            Spacer(),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Good Day!",
                                      style: CustomFonts.slussen10W400(
                                          color: Colors.white.withOpacity(0.5)),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      "Dr. Mitchell Adams ",
                                      style: CustomFonts.slussen14W700(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15.h,
                                ),
                                Image.asset(
                                  "assets/images/profile.png",
                                  height: 52.h,
                                  width: 52.h,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 25.h),
                                child: Text(
                                  "Choose",
                                  style: CustomFonts.slussen14W400(
                                      color: Colors.white.withOpacity(0.5)),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 25.h),
                                child: Text(
                                  "Type of consultation",
                                  style: CustomFonts.slussen22W700(
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Obx(
                                () => GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: consultationList.length,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.h),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          mainAxisExtent: 160.h,
                                          crossAxisSpacing: 10.h,
                                          mainAxisSpacing: 10.h),
                                  itemBuilder: (context, index) {
                                    ConsultationModel data =
                                        consultationList[index];
                                    final isMatch = controller.treatmentModeList
                                        .contains(data.name);
                                    return GestureDetector(
                                      onTap: () {
                                        homeController
                                            .getTreatmentModesByDoctorId(
                                                context);
                                        if (controller.treatment == false) {
                                          controller.createTreatmentModes({
                                            "doctorId":
                                                "66bf3adcdd3df57c89074fe1",
                                            "treatmentMode": data.name
                                          }, context);
                                        } else {
                                          List<String> newData =
                                              controller.treatmentModeList;
                                          if (isMatch) {
                                            newData.remove(data.name);
                                          } else {
                                            newData.add(data.name);
                                          }
                                          controller.updateTreatmentModes(
                                              {"treatmentMode": newData},
                                              context);
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 90.h,
                                            width: 90.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white
                                                  .withOpacity(0.10),
                                              border: isMatch
                                                  ? GradientBoxBorder(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Colors.white,
                                                            HexColor("#FF65DE")
                                                          ],
                                                          transform:
                                                              GradientRotation(
                                                                  0.8)),
                                                      width: 3.h)
                                                  : null,
                                            ),
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              data.image,
                                              width: 40.h,
                                              height: 40.h,
                                              color: isMatch
                                                  ? Colors.white
                                                  : Colors.white
                                                      .withOpacity(0.2),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            data.name,
                                            style: CustomFonts.slussen12W700(
                                                color: isMatch
                                                    ? Colors.white
                                                    : Colors.white
                                                        .withOpacity(0.1)),
                                            textAlign: TextAlign.center,
                                          ),
                                          Spacer(),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            width: 14.h,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                                color: isMatch
                                                    ? HexColor("#1A1435")
                                                    : Colors.white
                                                        .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(7.h)),
                                            padding: EdgeInsets.all(2.h),
                                            child: isMatch
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            HexColor("#FF65DE"),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7.h),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: HexColor(
                                                                      "#FF65DE")
                                                                  .withOpacity(
                                                                      0.4),
                                                              blurRadius: 15.h,
                                                              offset:
                                                                  Offset(0, 0)),
                                                          BoxShadow(
                                                              color: HexColor(
                                                                      "#FF65DE")
                                                                  .withOpacity(
                                                                      0.8),
                                                              blurRadius: 20.h,
                                                              offset:
                                                                  Offset(0, 0))
                                                        ]),
                                                  )
                                                : null,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 58.h,
                              ),
                              Wrap(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(50.h))),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 157.h, right: 20.h),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Text(
                                                          "Patients Sees This Message While Booking Appointments.",
                                                          style: CustomFonts
                                                              .metropolis12W600(
                                                                  color: HexColor(
                                                                      "#FF65DE")),
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Container(
                                                          height: 130.h,
                                                          child: Text(
                                                            controller.guidelineGetModel !=
                                                                    null
                                                                ? homeController
                                                                    .guidelineGetModel!
                                                                    .content
                                                                : "",
                                                            style: CustomFonts
                                                                .slussen14W700(
                                                                    color: HexColor(
                                                                        "#201A3F")),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        barrierColor: HexColor(
                                                                "#201A3F")
                                                            .withOpacity(0.8),
                                                        builder: (context) {
                                                          return DeleteDialog(
                                                            onTap: () {
                                                              homeController
                                                                  .deleteGuidelines(
                                                                      context,
                                                                      fToast)
                                                                  .then(
                                                                (value) {
                                                                  detailController
                                                                      .clear();
                                                                },
                                                              );
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/delete_circle.png",
                                                          width: 31.h,
                                                          height: 31.h,
                                                        ),
                                                        SizedBox(
                                                          height: 4.h,
                                                        ),
                                                        Text(
                                                          "Delete",
                                                          style: CustomFonts
                                                              .metropolis8W500(
                                                                  color: HexColor(
                                                                      "#201A3F")),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.h),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 15.h),
                                              decoration: BoxDecoration(
                                                  color: HexColor("#F2F7FB"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.h)),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 14.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Details",
                                                        style: CustomFonts
                                                            .metropolis16W700(
                                                                color: HexColor(
                                                                    "#201A3F")),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: HexColor(
                                                                    "#372F62")
                                                                .withOpacity(
                                                                    0.05),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        26.h)),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 7.h,
                                                                horizontal:
                                                                    13.h),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Edit",
                                                              style: CustomFonts
                                                                  .Lufga10W700(
                                                                      color: HexColor(
                                                                          "#372F62")),
                                                            ),
                                                            SizedBox(
                                                              width: 4.h,
                                                            ),
                                                            Image.asset(
                                                              "assets/images/edit_blue.png",
                                                              height: 5.h,
                                                              width: 5.h,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  TextField(
                                                    focusNode: _focusNode,
                                                    autofocus: false,
                                                    controller:
                                                        detailController,
                                                    style: CustomFonts
                                                        .metropolis12W600(
                                                            color: HexColor(
                                                                "#201A3F")),
                                                    textAlignVertical:
                                                        TextAlignVertical.top,
                                                    textAlign: TextAlign.start,
                                                    maxLines: 6,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        hintText:
                                                            "Write here...",
                                                        hintStyle: CustomFonts
                                                            .metropolis10W400(
                                                                color: HexColor(
                                                                    "#756D9E"))),
                                                  ),
                                                  SizedBox(
                                                    height: 34.h,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                        text:
                                                            "Consider the limit of ",
                                                        style: CustomFonts
                                                            .slussen9W500(
                                                                color: HexColor(
                                                                    "#201A3F")),
                                                        children: [
                                                          TextSpan(
                                                            text: "50 words",
                                                            style: CustomFonts
                                                                .slussen9W700(
                                                                    color: HexColor(
                                                                        "#E447C2")),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                " while writing details",
                                                            style: CustomFonts
                                                                .slussen9W500(
                                                                    color: HexColor(
                                                                        "#201A3F")),
                                                          )
                                                        ]),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                homeController.addGuideline({
                                                  "content":
                                                      detailController.text
                                                }, context, fToast).then(
                                                  (value) {
                                                    detailController.clear();
                                                  },
                                                );
                                              },
                                              child: Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.h),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            HexColor("#E7CB87"),
                                                            HexColor("#E49356")
                                                          ],
                                                          transform:
                                                              GradientRotation(
                                                                  0.8))),
                                                  padding: EdgeInsets.all(5.h),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.h),
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              HexColor(
                                                                  "#E49356"),
                                                              HexColor(
                                                                  "#E7CB87")
                                                            ],
                                                            transform:
                                                                GradientRotation(
                                                                    0.8))),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12.h,
                                                            horizontal: 43.h),
                                                    child: Text(
                                                      "Add",
                                                      style: CustomFonts
                                                          .slussen16W600(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30.h,
                                            ),
                                            Text(
                                              "This will be displayed on the upper part of the\n booking form to users.",
                                              style: CustomFonts.slussen10W700(
                                                  color: HexColor("#201A3F")),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 61.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: -37.h,
                                        left: 23.h,
                                        child: Image.asset(
                                          "assets/images/phone.png",
                                          height: 180.h,
                                          width: 90.h,
                                        ),
                                      ),
                                      Positioned(
                                        top: 40.h,
                                        left: 115.h,
                                        child: Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.identity()
                                            ..rotateX(math.pi),
                                          child: Image.asset(
                                            "assets/images/arrow.png",
                                            height: 27.h,
                                            width: 30.h,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
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
    );
  }
}
