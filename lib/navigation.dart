import 'package:doctor_dashboard/pages/appointment_history/appointment_history.dart';
import 'package:doctor_dashboard/pages/consultation/choose_consultation_view.dart';
import 'package:doctor_dashboard/pages/dashboard/dashboard.dart';
import 'package:doctor_dashboard/pages/forgot_password/forgot_password.dart';
import 'package:doctor_dashboard/pages/history/history_view.dart';
import 'package:doctor_dashboard/pages/login/login.dart';
import 'package:doctor_dashboard/pages/mode_of_treatment/mode_of_treatment.dart';
import 'package:doctor_dashboard/pages/new_consultation_details/new_consultation_details.dart';
import 'package:doctor_dashboard/pages/previous_schedules/previous_schedules.dart';
import 'package:doctor_dashboard/pages/problem_icons/problem_icons.dart';
import 'package:doctor_dashboard/pages/profile/profile_view.dart';
import 'package:doctor_dashboard/pages/saved_schedules/saved_schedules.dart';
import 'package:doctor_dashboard/pages/search_result/search_result.dart';
import 'package:doctor_dashboard/pages/set_password/set_password.dart';
import 'package:doctor_dashboard/pages/set_problem/set_problem.dart';
import 'package:doctor_dashboard/pages/set_schedule/set_schedule.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

import 'constants/constants.dart';
import 'constants/text_style.dart';
import 'pages/new_consultation_details/select_problem.dart';
import 'pages/otp/otp.dart';

class Navigation extends StatelessWidget {
  Navigation({Key? key}) : super(key: key);

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
    {
      "image": "Teeth Straightening",
      "price": "Starting @ Rs. 8000",
    },
  ];
  int selectedProblem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Dashboard())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Dashboard"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchResult())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Search Result"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AppointmentHistory())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Appointment History"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewConsultationDetails(
                              isNew: true,
                            ))),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("New Consultation Details"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewConsultationDetails(
                              isNew: false,
                            ))),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Existing Consultation Details"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => showBottomSheet(context),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Select Problem"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SetProblem(),
                  ),
                ),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Set Problem"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProblemIcons())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Problem Icons"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Login"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const OtpScreen())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("OTP"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Forgot Password"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SetPasswordScreen())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Set Password"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SavedSchedules())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Saved Schedules"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PreviousSchedules())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Previous Schedules"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SetSchedule())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Set Schedules"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileView(),
                  ),
                ),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Profile View"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryView(),
                  ),
                ),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("History View"),
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const ChooseConsultationView(),
              //     ),
              //   ),
              //   child: Card(
              //     child: Container(
              //       width: double.infinity,
              //       padding: const EdgeInsets.all(10.0),
              //       child: const Text("Choose Consultation"),
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ModeOfTreatment())),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Mode of Treatment"),
                  ),
                ),
              ),
              // InkWell(onTap: () => Navigator.push(context,
              // MaterialPageRoute(builder: (context) => const Profile(

              // ))),
              //   child: Card(
              //     child: Container(
              //       width: double.infinity,
              //       padding: const EdgeInsets.all(10.0),
              //       child: const Text("Profile"),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet<void>(
      // barrierColor: Colors.white.withOpacity(.00000000001),
      backgroundColor: Colors.white.withOpacity(.0000000001),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  onTap: () => Navigator.pop(context),
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
                                    child: ListView(
                                      controller: controller,
                                      physics: physics,
                                      children: [
                                        Column(
                                          children: [
                                            for (int i = 0;
                                                i < problems.length;
                                                i++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 12),
                                                child: GestureDetector(
                                                  onTap: () => setState(() {
                                                    selectedProblem = i;
                                                    // widget.callback(problems[
                                                    //     selectedProblem]);
                                                  }),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(45),
                                                        color:
                                                            selectedProblem == i
                                                                ? HexColor(
                                                                    "#E49356")
                                                                : Colors.white),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          height: 60,
                                                          width: 60,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: selectedProblem ==
                                                                      i
                                                                  ? Colors.white
                                                                  : HexColor(
                                                                      primaryColor)),
                                                          child: Image.asset(
                                                              "lib/pages/new_consultation_details/assets/${problems[i]["image"]}.png",
                                                              color: selectedProblem ==
                                                                      i
                                                                  ? HexColor(
                                                                      primaryColor)
                                                                  : Colors
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
                                                            children: [
                                                              Text(
                                                                problems[i]
                                                                    ["image"],
                                                                style: CustomFonts.slussen16W700(
                                                                    color: selectedProblem ==
                                                                            i
                                                                        ? Colors
                                                                            .white
                                                                        : HexColor(
                                                                            primaryColor)),
                                                              ),
                                                              Container(
                                                                // width: 68,
                                                                padding: const EdgeInsets
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
                                                                  problems[i]
                                                                      ["price"],
                                                                  style: CustomFonts
                                                                      .slussen10W500(
                                                                          color:
                                                                              Colors.white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Container(
                                                          height:
                                                              selectedProblem ==
                                                                      i
                                                                  ? 42
                                                                  : 30,
                                                          width:
                                                              selectedProblem ==
                                                                      i
                                                                  ? 42
                                                                  : 30,
                                                          padding: EdgeInsets.all(
                                                              selectedProblem ==
                                                                      i
                                                                  ? 10
                                                                  : 6),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: HexColor(
                                                                      pinkColor)
                                                                  .withOpacity(
                                                                      selectedProblem ==
                                                                              i
                                                                          ? 1
                                                                          : .2)),
                                                          child: Image.asset(
                                                              "lib/pages/new_consultation_details/assets/${selectedProblem == i ? 'done' : 'add'}.png"),
                                                        ),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                      ],
                                                    ),
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
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
