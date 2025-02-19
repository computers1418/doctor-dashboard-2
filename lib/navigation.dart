import 'dart:io';

import 'package:doctor_dashboard/constants/common_methods.dart';
import 'package:doctor_dashboard/controller/consultation_controller.dart';
import 'package:doctor_dashboard/controller/problem_controller.dart';
import 'package:doctor_dashboard/model/set_problem_model.dart';
import 'package:doctor_dashboard/pages/appointment_history/appointment_history.dart';
import 'package:doctor_dashboard/pages/consultation/choose_consultation_view.dart';
import 'package:doctor_dashboard/pages/dashboard/dashboard.dart';
import 'package:doctor_dashboard/pages/forgot_password/forgot_password.dart';
import 'package:doctor_dashboard/pages/history/history_view.dart';
import 'package:doctor_dashboard/pages/login/login.dart';
import 'package:doctor_dashboard/pages/mode_of_treatment/mode_of_treatment.dart';
import 'package:doctor_dashboard/pages/new_consultation_details/new_consultation_details.dart';
import 'package:doctor_dashboard/pages/notification/notification_screen.dart';
import 'package:doctor_dashboard/pages/previous_schedules/previous_schedules.dart';
import 'package:doctor_dashboard/pages/problem_icons/problem_icons.dart';
import 'package:doctor_dashboard/pages/profile/profile_view.dart';
import 'package:doctor_dashboard/pages/saved_schedules/saved_schedules.dart';
import 'package:doctor_dashboard/pages/search_result/search_result.dart';
import 'package:doctor_dashboard/pages/set_password/set_password.dart';
import 'package:doctor_dashboard/pages/set_problem/set_problem.dart';
import 'package:doctor_dashboard/pages/set_schedule/set_schedule.dart';
import 'package:doctor_dashboard/pages/sms_voice_note/sms_voice_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

import 'constants/constants.dart';
import 'constants/text_style.dart';
import 'pages/new_consultation_details/select_problem.dart';
import 'pages/otp/otp.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  ProblemController problemController = Get.put(ProblemController());
  ConsultationController consultationController =
      Get.put(ConsultationController());

  // List problems = [
  // List<dynamic> problems = [
  //   {
  //     "image": "Dental Braces",
  //     "price": "Rs. 1000 - 2000",
  //   },
  //   {
  //     "image": "Decayed Tooth",
  //     "price": "Rs. 3500",
  //   },
  //   {
  //     "image": "Tooth Extraction",
  //     "price": "Starting @ Rs. 10000",
  //   },
  //   {
  //     "image": "Dental Crown",
  //     "price": "Rs. 3000 - 5000",
  //   },
  //   {
  //     "image": "Gum Treatment",
  //     "price": "Rs. 500 - 5000",
  //   },
  //   {
  //     "image": "Dental Cleaning",
  //     "price": "Starting @ Rs. 8000",
  //   },
  //   {
  //     "image": "Teeth Straightening",
  //     "price": "Starting @ Rs. 8000",
  //   },
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard())),
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
                          builder: (context) => const NotificationScreen())),
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: const Text("Notification"),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SmsVoiceNote())),
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: const Text("SMS & Voice Notes"),
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
                          builder: (context) => NewConsultationDetails(
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
                // InkWell(
                //   onTap: () => Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => NewConsultationDetails(
                //                 isNew: false,
                //               ))),
                //   child: Card(
                //     child: Container(
                //       width: double.infinity,
                //       padding: const EdgeInsets.all(10.0),
                //       child: const Text("Existing Consultation Details"),
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () => CommonMethods.showProblemBottomSheet(
                      context, problemController, consultationController),
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
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OtpScreen())),
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
                          builder: (context) => PreviousSchedules())),
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: const Text("Previous Schedules"),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SetSchedule())),
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
      ),
    );
  }
}
