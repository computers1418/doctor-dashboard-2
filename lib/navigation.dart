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

import 'pages/new_consultation_details/select_problem.dart';
import 'pages/otp/otp.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

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
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChooseConsultationView(),
                  ),
                ),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Choose Consultation"),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ModeOfTreatment())),
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
        return SizedBox(
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
                    child: SelectProblem(
                      callback: () {},
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
