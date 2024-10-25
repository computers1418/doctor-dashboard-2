import 'dart:math';

import 'package:doctor_dashboard/constants/common_methods.dart';
import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/controller/consultation_controller.dart';
import 'package:doctor_dashboard/controller/problem_controller.dart';
import 'package:doctor_dashboard/widgets/custom_appbar.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:slider_button/slider_button.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

import '../../model/phone_email_consult_model.dart';
import '../../widgets/drawer.dart';
import 'select_problem.dart';

class NewConsultationDetails extends StatefulWidget {
  final bool isNew;
  PhoneEmailConsultModel? model;

  NewConsultationDetails({Key? key, required this.isNew, this.model})
      : super(key: key);

  @override
  State<NewConsultationDetails> createState() => _NewConsultationDetailsState();
}

class _NewConsultationDetailsState extends State<NewConsultationDetails>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  ProblemController problemController = Get.put(ProblemController());
  ConsultationController consultationController =
      Get.put(ConsultationController());

  final _scrollController = ScrollController();
  double _currentOffset = 0.0;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dateTextController = TextEditingController();
  final timeTextController = TextEditingController();
  final treatmentType = TextEditingController();
  final problemTextController = TextEditingController();
  final testTextController = TextEditingController();
  final surgeryTextController = TextEditingController();
  final medicineTextController = TextEditingController();
  final summary = TextEditingController();
  final costTextController = TextEditingController();
  String selectedItem = "Send OTP";
  FToast? fToast;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.light, //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    fToast = FToast();
    fToast?.init(context);
    if (!widget.isNew) {
      initializeFields();
    } else {
      consultationController.clearData();
    }
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
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

  initializeFields() {
    // setState(() {
    nameController.text = widget.model!.name!;
    emailController.text = widget.model!.emailId ?? "";
    phoneController.text = widget.model!.phoneNumber! ?? "";
    dateTextController.text =
        DateFormat('yyyy-MM-dd').format(widget.model!.dateTime!);
    timeTextController.text =
        DateFormat('hh:mm a').format(widget.model!.dateTime!);
    consultationController.addProblem(widget.model!.problem!);
    consultationController.addTest(widget.model!.test!);
    consultationController.addMedicine(widget.model!.meds!);
    consultationController.addSurgery(widget.model!.surgery!);
    problemTextController.text = widget.model!.problem!.join(",");
    testTextController.text = widget.model!.test!.join(",");
    surgeryTextController.text = widget.model!.surgery!.join(",");
    medicineTextController.text = widget.model!.meds!.join(",");
    // treatmentType.text =
    // date.text = "27 Feb, Tuesday";
    // time.text = "10:00 am";
    // consultationType.text = "Clinic Visit";
    // problemTextController.text = "Dental Braces";
    // test.text = "None";
    // surgery.text = "None";
    // medicine.text = "Chloraseptic";
    // summary.text =
    //     "Jorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.";
    // });
  }

  // setProblemField(selectedProblem) {
  //   setState(() {
  //     problem.text = selectedProblem;
  //   });
  // }

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
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      right: isCollapsed ? 0 : -0.5 * screenWidth,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0175),
                                        child: Text(
                                          !widget.isNew
                                              ? "Consultation Info"
                                              : "Consultation",
                                          style: CustomFonts.slussen32W700(
                                              color: HexColor("#FFFFFF")),
                                        ),
                                      ),
                                      Text(
                                        !widget.isNew ? "Existing" : "New",
                                        style: CustomFonts.slussen14W500(
                                            color: HexColor("#FFFFFF")
                                                .withOpacity(.5)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * .02,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth * .04,
                                      right: screenWidth * .04),
                                  child: Container(
                                    height: screenHeight * .28125,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(screenHeight * .02),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          HexColor("#E7CB87"),
                                          HexColor("#E49356")
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: screenWidth * .02),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Patient Data",
                                                  style:
                                                      CustomFonts.slussen16W700(
                                                          color: HexColor(
                                                              "#201A3F")),
                                                ),
                                                SizedBox(
                                                  height: screenHeight * .01,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Name",
                                                            style: CustomFonts.slussen10W500(
                                                                color: HexColor(
                                                                        "#201A3F")
                                                                    .withOpacity(
                                                                        .6)),
                                                          ),
                                                          Text(
                                                            "Age",
                                                            style: CustomFonts.slussen10W500(
                                                                color: HexColor(
                                                                        "#201A3F")
                                                                    .withOpacity(
                                                                        .6)),
                                                          ),
                                                          Text(
                                                            "Email ID",
                                                            style: CustomFonts.slussen10W500(
                                                                color: HexColor(
                                                                        "#201A3F")
                                                                    .withOpacity(
                                                                        .6)),
                                                          ),
                                                          Text(
                                                            "Phone No.",
                                                            style: CustomFonts.slussen10W500(
                                                                color: HexColor(
                                                                        "#201A3F")
                                                                    .withOpacity(
                                                                        .6)),
                                                          ),
                                                          Text(
                                                            "Doctor ID",
                                                            style: CustomFonts.slussen10W500(
                                                                color: HexColor(
                                                                        "#201A3F")
                                                                    .withOpacity(
                                                                        .6)),
                                                          ),
                                                          Text(
                                                            "User ID",
                                                            style: CustomFonts.slussen10W500(
                                                                color: HexColor(
                                                                        "#201A3F")
                                                                    .withOpacity(
                                                                        .6)),
                                                          ),
                                                          Text(
                                                            "Appointment No.",
                                                            style: CustomFonts.slussen10W500(
                                                                color: HexColor(
                                                                        "#201A3F")
                                                                    .withOpacity(
                                                                        .6)),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * .04,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            TextField(
                                                              controller:
                                                                  nameController,
                                                              style: CustomFonts
                                                                  .slussen10W700(
                                                                      color: HexColor(
                                                                          primaryColor)),
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                hintText:
                                                                    "Enter Name",
                                                                hintStyle:
                                                                    CustomFonts
                                                                        .slussen10W700(
                                                                  color: HexColor(
                                                                          primaryColor)
                                                                      .withOpacity(
                                                                          .4),
                                                                ),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                            Text(
                                                              "29",
                                                              style: CustomFonts
                                                                  .slussen10W700(
                                                                      color: HexColor(
                                                                          "#201A3F")),
                                                              maxLines: 1,
                                                            ),
                                                            // Text(
                                                            //   "Arnold111M@gmail.com",
                                                            //   style: CustomFonts
                                                            //       .slussen10W700(
                                                            //           color: HexColor(
                                                            //               "#201A3F")),
                                                            //   maxLines: 1,
                                                            // ),
                                                            TextField(
                                                              controller:
                                                                  emailController,
                                                              style: CustomFonts
                                                                  .slussen10W700(
                                                                      color: HexColor(
                                                                          primaryColor)),
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                hintText:
                                                                    "Enter Email",
                                                                hintStyle:
                                                                    CustomFonts
                                                                        .slussen10W700(
                                                                  color: HexColor(
                                                                          primaryColor)
                                                                      .withOpacity(
                                                                          .4),
                                                                ),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                            // Text(
                                                            //   "+91 9087654321",
                                                            //   style: CustomFonts
                                                            //       .slussen10W700(
                                                            //           color: HexColor(
                                                            //               "#201A3F")),
                                                            //   maxLines: 1,
                                                            // ),
                                                            TextField(
                                                              controller:
                                                                  phoneController,
                                                              style: CustomFonts
                                                                  .slussen10W700(
                                                                      color: HexColor(
                                                                          primaryColor)),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly
                                                              ],
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                hintText:
                                                                    "Enter Phone",
                                                                hintStyle:
                                                                    CustomFonts
                                                                        .slussen10W700(
                                                                  color: HexColor(
                                                                          primaryColor)
                                                                      .withOpacity(
                                                                          .4),
                                                                ),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                            Text(
                                                              "HD35KS39OOS1",
                                                              style: CustomFonts
                                                                  .slussen10W700(
                                                                      color: HexColor(
                                                                          "#201A3F")),
                                                              maxLines: 1,
                                                            ),
                                                            Text(
                                                              "AX3485JK251SL",
                                                              style: CustomFonts
                                                                  .slussen10W700(
                                                                      color: HexColor(
                                                                          "#201A3F")),
                                                              maxLines: 1,
                                                            ),
                                                            Text(
                                                              "JD628FHREU29F",
                                                              style: CustomFonts
                                                                  .slussen10W700(
                                                                      color: HexColor(
                                                                          "#201A3F")),
                                                              maxLines: 1,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: screenHeight * .0125,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * .04,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: HexColor("#201A3F"),
                                                    width: 1),
                                              ),
                                              child: Image.asset(
                                                "lib/pages/new_consultation_details/assets/share.png",
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: HexColor("#201A3F"),
                                                    width: 1),
                                              ),
                                              child: Image.asset(
                                                "lib/pages/new_consultation_details/assets/copy.png",
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor("#201A3F")),
                                              child: Image.asset(
                                                "lib/pages/new_consultation_details/assets/edit.png",
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            Spacer(),
                                            PopupMenuButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              color: HexColor("#201A3F")
                                                  .withOpacity(0.6),
                                              onSelected: (value) {
                                                setState(() {
                                                  selectedItem = value;
                                                });
                                              },
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    child: Text(
                                                      "Send to Email",
                                                      style: CustomFonts
                                                          .slussen8W700(
                                                              color:
                                                                  Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    value: 'Send to Email',
                                                    height: 30,
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text(
                                                      "Send to Phone",
                                                      style: CustomFonts
                                                          .slussen8W700(
                                                              color:
                                                                  Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    value: 'Send to Phone',
                                                    height: 30,
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text(
                                                      "Send to both",
                                                      style: CustomFonts
                                                          .slussen8W700(
                                                              color:
                                                                  Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    value: 'Send to both',
                                                    height: 30,
                                                  ),
                                                ];
                                              },
                                              offset: Offset(0, 40),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      selectedItem,
                                                      style: CustomFonts
                                                          .slussen7W700(
                                                              color: HexColor(
                                                                  "#201A3F")),
                                                    ),
                                                    SizedBox(
                                                      width: 1,
                                                    ),
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 10,
                                                      color:
                                                          HexColor("#201A3F"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
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
                                      Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 14),
                                            child: Text(
                                              "Details",
                                              style: CustomFonts.slussen30W700(
                                                  color: HexColor("#201A3F")),
                                            ),
                                          ),
                                          Text(
                                            !widget.isNew ? "More" : "Add",
                                            style: CustomFonts.slussen14W700(
                                                color: HexColor("#201A3F")),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: screenHeight * .02,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: HexColor("#F2F7FB"),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xffFFFFFF),
                                                    offset: Offset(-5.0, -5.0),
                                                    blurRadius: 7,
                                                    spreadRadius: 0.0,
                                                  ),
                                                  BoxShadow(
                                                    color: Color(0xffE1EAF1),
                                                    offset: Offset(5.0, 5.0),
                                                    blurRadius: 7,
                                                    spreadRadius: 0.0,
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                controller: dateTextController,
                                                readOnly: true,
                                                onTap: () async {
                                                  DateTime? selectedDate =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2100),
                                                  );

                                                  if (selectedDate != null) {
                                                    // Format the selected date and set it in the TextField
                                                    String formattedDate =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(
                                                                selectedDate);
                                                    setState(() {
                                                      dateTextController.text =
                                                          formattedDate;
                                                    });
                                                  }
                                                },
                                                style:
                                                    CustomFonts.slussen14W700(
                                                        color: HexColor(
                                                            primaryColor)),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                screenWidth *
                                                                    .04,
                                                            vertical: 12),
                                                    hintText: "Select Date",
                                                    hintStyle: CustomFonts
                                                        .slussen14W700(
                                                      color:
                                                          HexColor(primaryColor)
                                                              .withOpacity(.4),
                                                    ),
                                                    border: InputBorder.none,
                                                    suffixIcon:
                                                        dateTextController
                                                                .text.isNotEmpty
                                                            ? null
                                                            : IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down),
                                                                color: HexColor(
                                                                    primaryColor),
                                                              )),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: HexColor("#F2F7FB"),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xffFFFFFF),
                                                    offset: Offset(-5.0, -5.0),
                                                    blurRadius: 7,
                                                    spreadRadius: 0.0,
                                                  ),
                                                  BoxShadow(
                                                    color: Color(0xffE1EAF1),
                                                    offset: Offset(5.0, 5.0),
                                                    blurRadius: 7,
                                                    spreadRadius: 0.0,
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                controller: timeTextController,
                                                readOnly: true,
                                                onTap: () async {
                                                  TimeOfDay? selectedTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                  );

                                                  if (selectedTime != null) {
                                                    final now = DateTime.now();
                                                    final formattedTime =
                                                        DateFormat('hh:mm a')
                                                            .format(DateTime(
                                                      now.year,
                                                      now.month,
                                                      now.day,
                                                      selectedTime.hour,
                                                      selectedTime.minute,
                                                    ));
                                                    setState(() {
                                                      timeTextController.text =
                                                          formattedTime;
                                                    });
                                                  }
                                                },
                                                style:
                                                    CustomFonts.slussen14W700(
                                                        color: HexColor(
                                                            primaryColor)),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                screenWidth *
                                                                    .04,
                                                            vertical: 12),
                                                    hintText: "Time",
                                                    hintStyle: CustomFonts
                                                        .slussen14W700(
                                                      color:
                                                          HexColor(primaryColor)
                                                              .withOpacity(.4),
                                                    ),
                                                    border: InputBorder.none,
                                                    suffixIcon:
                                                        timeTextController
                                                                .text.isNotEmpty
                                                            ? null
                                                            : IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down),
                                                                color: HexColor(
                                                                    primaryColor),
                                                              )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: HexColor("#F2F7FB"),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xffFFFFFF),
                                                    offset: Offset(-5.0, -5.0),
                                                    blurRadius: 7,
                                                    spreadRadius: 0.0,
                                                  ),
                                                  BoxShadow(
                                                    color: Color(0xffE1EAF1),
                                                    offset: Offset(5.0, 5.0),
                                                    blurRadius: 7,
                                                    spreadRadius: 0.0,
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                controller: treatmentType,
                                                style:
                                                    CustomFonts.slussen14W700(
                                                        color: HexColor(
                                                            primaryColor)),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                screenWidth *
                                                                    .04,
                                                            vertical: 12),
                                                    hintText: "Treatment Type",
                                                    hintStyle: CustomFonts
                                                        .slussen14W700(
                                                      color:
                                                          HexColor(primaryColor)
                                                              .withOpacity(.4),
                                                    ),
                                                    border: InputBorder.none,
                                                    suffixIcon: treatmentType
                                                            .text.isNotEmpty
                                                        ? null
                                                        : IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(Icons
                                                                .keyboard_arrow_down),
                                                            color: HexColor(
                                                                primaryColor),
                                                          )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: HexColor("#F2F7FB"),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0xffFFFFFF),
                                              offset: Offset(-5.0, -5.0),
                                              blurRadius: 7,
                                              spreadRadius: 0.0,
                                            ),
                                            BoxShadow(
                                              color: Color(0xffE1EAF1),
                                              offset: Offset(5.0, 5.0),
                                              blurRadius: 7,
                                              spreadRadius: 0.0,
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          onTap: () {
                                            CommonMethods
                                                    .showProblemBottomSheet(
                                                        context,
                                                        problemController,
                                                        consultationController)
                                                .then(
                                              (value) {
                                                problemTextController.setText(
                                                    consultationController
                                                        .selectProblem
                                                        .join(","));
                                              },
                                            );
                                          },
                                          readOnly: true,
                                          controller: problemTextController,
                                          style: CustomFonts.slussen14W700(
                                              color: HexColor(primaryColor)),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal:
                                                          screenWidth * .04,
                                                      vertical: 12),
                                              hintText: "Select Problem",
                                              hintStyle:
                                                  CustomFonts.slussen14W700(
                                                color: HexColor(primaryColor)
                                                    .withOpacity(.4),
                                              ),
                                              border: InputBorder.none,
                                              suffixIcon: problemTextController
                                                      .text.isNotEmpty
                                                  ? null
                                                  : IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      color: HexColor(
                                                          primaryColor),
                                                    )),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: HexColor("#F2F7FB"),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0xffFFFFFF),
                                              offset: Offset(-5.0, -5.0),
                                              blurRadius: 7,
                                              spreadRadius: 0.0,
                                            ),
                                            BoxShadow(
                                              color: Color(0xffE1EAF1),
                                              offset: Offset(5.0, 5.0),
                                              blurRadius: 7,
                                              spreadRadius: 0.0,
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          readOnly: true,
                                          onTap: () {
                                            CommonMethods.showTestBottomSheet(
                                                    context,
                                                    problemController,
                                                    consultationController)
                                                .then(
                                              (value) {
                                                testTextController.setText(
                                                    consultationController
                                                        .selectTest
                                                        .join(","));
                                              },
                                            );
                                          },
                                          controller: testTextController,
                                          style: CustomFonts.slussen14W700(
                                              color: HexColor(primaryColor)),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal:
                                                          screenWidth * .04,
                                                      vertical: 12),
                                              hintText: "Select Test",
                                              hintStyle:
                                                  CustomFonts.slussen14W700(
                                                color: HexColor(primaryColor)
                                                    .withOpacity(.4),
                                              ),
                                              border: InputBorder.none,
                                              suffixIcon: testTextController
                                                      .text.isNotEmpty
                                                  ? null
                                                  : IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      color: HexColor(
                                                          primaryColor),
                                                    )),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: HexColor("#F2F7FB"),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xffFFFFFF),
                                                    offset: Offset(-5.0, -5.0),
                                                    blurRadius: 7,
                                                    spreadRadius: 0.0,
                                                  ),
                                                  BoxShadow(
                                                    color: Color(0xffE1EAF1),
                                                    offset: Offset(5.0, 5.0),
                                                    blurRadius: 7,
                                                    spreadRadius: 0.0,
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                onTap: () {
                                                  CommonMethods
                                                          .showSurgeryBottomSheet(
                                                              context,
                                                              problemController,
                                                              consultationController)
                                                      .then(
                                                    (value) {
                                                      surgeryTextController.setText(
                                                          consultationController
                                                              .selectSurgery
                                                              .join(","));
                                                    },
                                                  );
                                                },
                                                controller:
                                                    surgeryTextController,
                                                readOnly: true,
                                                style:
                                                    CustomFonts.slussen14W700(
                                                        color: HexColor(
                                                            primaryColor)),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                screenWidth *
                                                                    .04,
                                                            vertical: 12),
                                                    hintText: "Select Surgery",
                                                    hintStyle: CustomFonts
                                                        .slussen14W700(
                                                      color:
                                                          HexColor(primaryColor)
                                                              .withOpacity(.4),
                                                    ),
                                                    border: InputBorder.none,
                                                    suffixIcon:
                                                        surgeryTextController
                                                                .text.isNotEmpty
                                                            ? null
                                                            : IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down),
                                                                color: HexColor(
                                                                    primaryColor),
                                                              )),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: HexColor("#F2F7FB"),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xffFFFFFF),
                                                    offset: Offset(-5.0, -5.0),
                                                    blurRadius: 7,
                                                    spreadRadius: 0.0,
                                                  ),
                                                  BoxShadow(
                                                    color: Color(0xffE1EAF1),
                                                    offset: Offset(5.0, 5.0),
                                                    blurRadius: 7,
                                                    spreadRadius: 0.0,
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                readOnly: true,
                                                onTap: () {
                                                  CommonMethods
                                                          .showMedicineBottomSheet(
                                                              context,
                                                              problemController,
                                                              consultationController)
                                                      .then(
                                                    (value) {
                                                      medicineTextController.setText(
                                                          consultationController
                                                              .selectMedicine
                                                              .join(","));
                                                    },
                                                  );
                                                },
                                                controller:
                                                    medicineTextController,
                                                style:
                                                    CustomFonts.slussen14W700(
                                                        color: HexColor(
                                                            primaryColor)),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                screenWidth *
                                                                    .04,
                                                            vertical: 12),
                                                    hintText: "Medicine",
                                                    hintStyle: CustomFonts
                                                        .slussen14W700(
                                                      color:
                                                          HexColor(primaryColor)
                                                              .withOpacity(.4),
                                                    ),
                                                    border: InputBorder.none,
                                                    suffixIcon:
                                                        medicineTextController
                                                                .text.isNotEmpty
                                                            ? null
                                                            : IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down),
                                                                color: HexColor(
                                                                    primaryColor),
                                                              )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Stack(
                                        children: [
                                          Image.asset(
                                            "lib/pages/new_consultation_details/assets/box-bg.png",
                                            height: screenHeight * .375,
                                            width: double.infinity,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 0),
                                            child: TextField(
                                              controller: summary,
                                              maxLines: 10,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal:
                                                            screenWidth * .04,
                                                        vertical: 36),
                                                hintText: "Summery",
                                                hintStyle:
                                                    CustomFonts.slussen14W700(
                                                  color: HexColor(primaryColor)
                                                      .withOpacity(.4),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              style: CustomFonts.slussen14W500(
                                                color: HexColor(primaryColor)
                                                    .withOpacity(.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 115,
                                            decoration: BoxDecoration(
                                                color: HexColor("#E957C9"),
                                                borderRadius:
                                                    BorderRadius.circular(21)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 6),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "lib/pages/new_consultation_details/assets/sms.png",
                                                    height: 18,
                                                    width: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Send SMS",
                                                    style: CustomFonts
                                                        .slussen10W700(
                                                            color:
                                                                Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 40,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: HexColor("#E957C9"),
                                                borderRadius:
                                                    BorderRadius.circular(21)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 6),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "lib/pages/new_consultation_details/assets/mail-filled.png",
                                                    height: 18,
                                                    width: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Send Email",
                                                    style: CustomFonts
                                                        .slussen10W700(
                                                            color:
                                                                Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 40,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: HexColor("#E957C9"),
                                                borderRadius:
                                                    BorderRadius.circular(21)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 6),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "lib/pages/new_consultation_details/assets/call.png",
                                                    height: 18,
                                                    width: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Voice Call",
                                                    style: CustomFonts
                                                        .slussen10W700(
                                                            color:
                                                                Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "amount",
                                                  style:
                                                      CustomFonts.slussen14W700(
                                                          color: HexColor(
                                                                  "#201A3F")
                                                              .withOpacity(.6)),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Rs. ",
                                                      style: CustomFonts
                                                          .slussen30W700(
                                                              color: HexColor(
                                                                  "#201A3F")),
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        controller:
                                                            costTextController,
                                                        style: CustomFonts
                                                            .slussen30W700(
                                                                color: HexColor(
                                                                    "#201A3F")),
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    "Cost",
                                                                isDense: true),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              Container(
                                                width: 160,
                                                height: 61,
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      HexColor("#E7CB87"),
                                                      HexColor("#E49356"),
                                                    ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                              ),
                                              SliderButton(
                                                action: () async {
                                                  if (widget.isNew) {
                                                    if (phoneController
                                                            .text.isNotEmpty &&
                                                        emailController
                                                            .text.isNotEmpty) {
                                                      consultationController
                                                          .createConsult(
                                                        {
                                                          "name": nameController
                                                              .text,
                                                          "doctorId":
                                                              "66bf3adcdd3df57c89074fe1",
                                                          "dateTime":
                                                              "${dateTextController.text} ${timeTextController.text}",
                                                          "problem":
                                                              consultationController
                                                                  .selectProblem,
                                                          "meds":
                                                              consultationController
                                                                  .selectMedicine,
                                                          "test":
                                                              consultationController
                                                                  .selectTest,
                                                          "surgery":
                                                              consultationController
                                                                  .selectSurgery,
                                                          "modeOfPayment":
                                                              "Cash",
                                                          "phoneNumber":
                                                              "${phoneController.text}",
                                                          "emailId":
                                                              "${emailController.text}",
                                                          "modeOfTreatment":
                                                              treatmentType.text
                                                        },
                                                        context,
                                                        fToast,
                                                        (p0) {
                                                          saveBottomSheet(p0);
                                                        },
                                                      );
                                                    } else if (phoneController
                                                        .text.isEmpty) {
                                                      consultationController
                                                          .createConsult(
                                                        {
                                                          "name": nameController
                                                              .text,
                                                          "doctorId":
                                                              "66bf3adcdd3df57c89074fe1",
                                                          "dateTime":
                                                              "${dateTextController.text} ${timeTextController.text}",
                                                          "problem":
                                                              consultationController
                                                                  .selectProblem,
                                                          "meds":
                                                              consultationController
                                                                  .selectMedicine,
                                                          "test":
                                                              consultationController
                                                                  .selectTest,
                                                          "surgery":
                                                              consultationController
                                                                  .selectSurgery,
                                                          "modeOfPayment":
                                                              "Cash",
                                                          "emailId":
                                                              "${emailController.text}",
                                                          "modeOfTreatment":
                                                              treatmentType.text
                                                        },
                                                        context,
                                                        fToast,
                                                        (p0) {
                                                          saveBottomSheet(p0);
                                                        },
                                                      );
                                                    } else if (emailController
                                                        .text.isEmpty) {
                                                      consultationController
                                                          .createConsult(
                                                        {
                                                          "name": nameController
                                                              .text,
                                                          "doctorId":
                                                              "66bf3adcdd3df57c89074fe1",
                                                          "dateTime":
                                                              "${dateTextController.text} ${timeTextController.text}",
                                                          "problem":
                                                              consultationController
                                                                  .selectProblem,
                                                          "meds":
                                                              consultationController
                                                                  .selectMedicine,
                                                          "test":
                                                              consultationController
                                                                  .selectTest,
                                                          "surgery":
                                                              consultationController
                                                                  .selectSurgery,
                                                          "modeOfPayment":
                                                              "Cash",
                                                          "phoneNumber":
                                                              "${phoneController.text}",
                                                          "modeOfTreatment":
                                                              treatmentType.text
                                                        },
                                                        context,
                                                        fToast,
                                                        (p0) {
                                                          saveBottomSheet(p0);
                                                        },
                                                      );
                                                    }
                                                  } else {
                                                    if (phoneController
                                                            .text.isNotEmpty &&
                                                        emailController
                                                            .text.isNotEmpty) {
                                                      consultationController
                                                          .updatebyDoc({
                                                        "name":
                                                            nameController.text,
                                                        "dateTime":
                                                            "${dateTextController.text} ${timeTextController.text}",
                                                        "problem":
                                                            consultationController
                                                                .selectProblem,
                                                        "meds":
                                                            consultationController
                                                                .selectMedicine,
                                                        "test":
                                                            consultationController
                                                                .selectTest,
                                                        "surgery":
                                                            consultationController
                                                                .selectSurgery,
                                                        "modeOfPayment": "Cash",
                                                        "phoneNumber":
                                                            "${phoneController.text}",
                                                        "emailId":
                                                            "${emailController.text}",
                                                        "modeOfTreatment":
                                                            treatmentType.text,
                                                        "cost":
                                                            costTextController
                                                                .text,
                                                        "summary": summary.text
                                                      }, context, fToast, (p0) {
                                                        saveBottomSheet(p0);
                                                      }, widget.model!.id);
                                                    } else if (phoneController
                                                        .text.isEmpty) {
                                                      consultationController
                                                          .updatebyDoc({
                                                        "name":
                                                            nameController.text,
                                                        "dateTime":
                                                            "${dateTextController.text} ${timeTextController.text}",
                                                        "problem":
                                                            consultationController
                                                                .selectProblem,
                                                        "meds":
                                                            consultationController
                                                                .selectMedicine,
                                                        "test":
                                                            consultationController
                                                                .selectTest,
                                                        "surgery":
                                                            consultationController
                                                                .selectSurgery,
                                                        "modeOfPayment": "Cash",
                                                        "emailId":
                                                            "${emailController.text}",
                                                        "modeOfTreatment":
                                                            treatmentType.text,
                                                        "cost":
                                                            costTextController
                                                                .text,
                                                        "summary": summary.text
                                                      }, context, fToast, (p0) {
                                                        saveBottomSheet(p0);
                                                      }, widget.model!.id);
                                                    } else if (emailController
                                                        .text.isEmpty) {
                                                      consultationController
                                                          .updatebyDoc({
                                                        "name":
                                                            nameController.text,
                                                        "dateTime":
                                                            "${dateTextController.text} ${timeTextController.text}",
                                                        "problem":
                                                            consultationController
                                                                .selectProblem,
                                                        "meds":
                                                            consultationController
                                                                .selectMedicine,
                                                        "test":
                                                            consultationController
                                                                .selectTest,
                                                        "surgery":
                                                            consultationController
                                                                .selectSurgery,
                                                        "modeOfPayment": "Cash",
                                                        "phoneNumber":
                                                            "${phoneController.text}",
                                                        "modeOfTreatment":
                                                            treatmentType.text,
                                                        "cost":
                                                            costTextController
                                                                .text,
                                                        "summary": summary.text
                                                      }, context, fToast, (p0) {
                                                        saveBottomSheet(p0);
                                                      }, widget.model!.id);
                                                    }
                                                  }

                                                  return false;
                                                },
                                                buttonSize: 50,
                                                width: 160,
                                                height: 61,
                                                label: Center(
                                                  child: Text(
                                                    "\t\t\tSave",
                                                    style: CustomFonts
                                                        .slussen20W700(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                                icon: Center(
                                                    child: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: HexColor(primaryColor),
                                                  size: 20.0,
                                                )),
                                                radius: 40,
                                                buttonColor: Colors.white,
                                                backgroundColor:
                                                    Colors.transparent,
                                                highlightedColor: Colors.grey,
                                                baseColor: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
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

  Future saveBottomSheet(Map<String, dynamic> data) {
    TextEditingController pinController = TextEditingController();
    pinController.setText(data["otp"]);
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 8,
                    width: 60,
                    decoration: BoxDecoration(
                        color: HexColor("#F0F0F0"),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        "assets/images/close_blue.png",
                        width: 26,
                        height: 26,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 23,
              ),
              RichText(
                  text: TextSpan(
                      text: "Confirm ",
                      style:
                          CustomFonts.slussen28W700(color: HexColor("#201A3F")),
                      children: [
                    TextSpan(
                      text: "Code",
                      style:
                          CustomFonts.slussen28W700(color: HexColor("#FF65DE")),
                    )
                  ])),
              SizedBox(
                height: 16,
              ),
              Pinput(
                controller: pinController,
                defaultPinTheme: PinTheme(
                  width: 70,
                  height: 74,
                  textStyle:
                      CustomFonts.slussen20W700(color: HexColor("#201A3F")),
                  decoration: BoxDecoration(
                    color: HexColor("#F2F7FB"),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
                disabledPinTheme: PinTheme(
                  width: 70,
                  height: 74,
                  textStyle:
                      CustomFonts.slussen20W700(color: HexColor("#201A3F")),
                  decoration: BoxDecoration(
                    color: HexColor("#F2F7FB"),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
                focusedPinTheme: PinTheme(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 70,
                  height: 74,
                  textStyle:
                      CustomFonts.slussen20W700(color: HexColor("#201A3F")),
                  decoration: BoxDecoration(
                    border: Border.all(color: HexColor("#201A3F")),
                    color: HexColor("#F2F7FB"),
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text:
                          "User has verified the code successfully \nsent to ",
                      style:
                          CustomFonts.slussen14W400(color: HexColor("#201A3F")),
                      children: phoneController.text.isNotEmpty &&
                              emailController.text.isNotEmpty
                          ? [
                              TextSpan(
                                text: "${phoneController.text}",
                                style: CustomFonts.slussen14W700(
                                    color: HexColor("#201A3F")),
                              ),
                              TextSpan(
                                text: " and ",
                                style: CustomFonts.slussen14W400(
                                    color: HexColor("#201A3F")),
                              ),
                              TextSpan(
                                text: "${emailController.text}",
                                style: CustomFonts.slussen14W700(
                                    color: HexColor("#201A3F")),
                              )
                            ]
                          : phoneController.text.isEmpty
                              ? [
                                  TextSpan(
                                    text: "${emailController.text}",
                                    style: CustomFonts.slussen14W700(
                                        color: HexColor("#201A3F")),
                                  )
                                ]
                              : [
                                  TextSpan(
                                    text: "${phoneController.text}",
                                    style: CustomFonts.slussen14W700(
                                        color: HexColor("#201A3F")),
                                  )
                                ])),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 37),
                      decoration: BoxDecoration(
                          color: HexColor("#FF65DE"),
                          borderRadius: BorderRadius.circular(32)),
                      alignment: Alignment.center,
                      child: Text(
                        "OK",
                        style: CustomFonts.slussen16W700(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      consultationController.otpVerification({
                        "consultationId": data["_id"],
                        "otp": pinController.text
                      }, context, fToast);
                      // showDifferentToast(fToast!, "Code Verified", false);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 33,
              ),
            ],
          ),
        );
      },
    );
  }
}

//   void showBottomSheet() {
//     showModalBottomSheet<void>(
//       // barrierColor: Colors.white.withOpacity(.00000000001),
//       backgroundColor: Colors.white.withOpacity(.0000000001),
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return SizedBox(
//           height: MediaQuery.of(context).size.height * .8,
//           child: Column(
//             children: [
//               Container(
//                 width: 40,
//                 height: 6,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(45),
//                     color: Colors.white),
//               ),
//               Expanded(
//                 child: Container(
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             fit: BoxFit.fill,
//                             image: AssetImage(
//                                 "lib/pages/new_consultation_details/assets/bottom-sheet-bg.png"))),
//                     child: SelectProblem(
//                       callback: setProblemField,
//                     )),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
