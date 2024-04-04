import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor(primaryColor),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32,),
                    Align(alignment: Alignment.centerLeft,
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
                    const SizedBox(height: 16,),
                      GradientText("Forgot Password?",
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
                            "Enter your registered Email ID or Phone number.",
                            textAlign: TextAlign.center,
                            style: CustomFonts.slussen14W400(
                                color: Colors.white.withOpacity(.5)),
                          ),
                        ),
                      ),
                      Image.asset(
                        "lib/pages/forgot_password/assets/img.png",
                        width: 280,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.05),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          style: CustomFonts.slussen14W500(color: Colors.white),
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              border: InputBorder.none,
                              hintText: "Email ID or Phone no.",
                              hintStyle: CustomFonts.slussen14W500(
                                  color: Colors.white.withOpacity(.5))),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
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
                              "Send",
                              style: CustomFonts.slussen20W600(
                                  color: Colors.white),
                            ),
                          )),
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
                    "lib/pages/forgot_password/assets/forgot-password.png",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                  ))
            ],
          ),
        ));
  }
}
