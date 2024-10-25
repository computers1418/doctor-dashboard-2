import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../widgets/neumorphic_widgets.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  LoginController loginController = LoginController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController rewritePassword = TextEditingController();
  FToast? fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor(primaryColor),
        body: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) => SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                NeumorphicWidgets(
                                    hasShadow: false,
                                    type: 2,
                                    height: 56,
                                    width: 56,
                                    colors: [
                                      HexColor("#392F70"),
                                      HexColor("#0D0823")
                                    ],
                                    radius: 82,
                                    child: const SizedBox(
                                      height: 82,
                                      width: 82,
                                    )),
                                NeumorphicWidgets(
                                    hasShadow: false,
                                    type: 3,
                                    height: 52,
                                    width: 52,
                                    colors: [
                                      HexColor("#392F70"),
                                      HexColor("#0D0823")
                                    ],
                                    radius: 52,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Image.asset(
                                        "assets/images/arrow-back.png",
                                        height: 24,
                                        width: 24,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GradientText("Create Password",
                            style: CustomFonts.slussen28W700(),
                            colors: [
                              HexColor(goldLightColor),
                              HexColor(goldDarkColor),
                            ]),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "New password can’t be same as previous password.",
                              textAlign: TextAlign.center,
                              style: CustomFonts.slussen14W400(
                                  color: Colors.white.withOpacity(.5)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.05),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: newPassword,
                            style:
                                CustomFonts.slussen14W500(color: Colors.white),
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                border: InputBorder.none,
                                hintText: "New Password",
                                hintStyle: CustomFonts.slussen14W500(
                                    color: Colors.white.withOpacity(.5))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.05),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: rewritePassword,
                            style:
                                CustomFonts.slussen14W500(color: Colors.white),
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                border: InputBorder.none,
                                hintText: "Rewrite Password",
                                hintStyle: CustomFonts.slussen14W500(
                                    color: Colors.white.withOpacity(.5))),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (newPassword.text.isEmpty) {
                              showToast(
                                  fToast!, "Please enter new password.", true);
                            } else if (rewritePassword.text.isEmpty) {
                              showToast(fToast!,
                                  "Please enter rewrite password.", true);
                            } else if (newPassword.text !=
                                rewritePassword.text) {
                              showToast(
                                  fToast!, 'Passwords do not match.', true);
                            } else {
                              loginController.changePasswordApi({
                                "onboardingOtp": controller.otpText,
                                "userName": controller.username,
                                "password": rewritePassword.text
                              }, context, fToast, rewritePassword.text, () {});
                            }
                          },
                          child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  // color: Colors.white.withOpacity(.05),
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(colors: [
                                    HexColor(goldLightColor),
                                    HexColor(goldDarkColor)
                                  ])),
                              child: Center(
                                child: Text(
                                  "Save Password",
                                  style: CustomFonts.slussen20W600(
                                      color: Colors.white),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Image.asset(
                      "lib/pages/set_password/assets/set-password.png",
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                    )),
                Positioned(
                    bottom: 0,
                    child: Image.asset(
                      "lib/pages/set_password/assets/img.png",
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height * 0.35,
                    ))
              ],
            ),
          ),
        ));
  }
}
