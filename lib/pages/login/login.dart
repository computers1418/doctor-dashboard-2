import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../widgets/neumorphic_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      const SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: Text(
                          "Hi, There!",
                          style: CustomFonts.slussen14W400(
                              color: Colors.white.withOpacity(.5)),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GradientText("Let’s Get Started",
                          style: CustomFonts.slussen28W700(),
                          colors: [
                            HexColor(goldLightColor),
                            HexColor(goldDarkColor),
                          ]),
                      const SizedBox(
                        height: 32,
                      ),
                      Image.asset(
                        "lib/pages/login/assets/img1.png",
                        height: 80,
                      ),
                      Image.asset(
                        "lib/pages/login/assets/img2.png",
                        width: 320,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GradientText("Sign In",
                          style: CustomFonts.slussen24W600(),
                          colors: [
                            HexColor(goldLightColor),
                            HexColor(goldDarkColor),
                          ]),
                      const SizedBox(
                        height: 16,
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
                              hintText: "User Name",
                              hintStyle: CustomFonts.slussen14W500(
                                  color: Colors.white.withOpacity(.5))),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
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
                              hintText: "Password",
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
                              "Sign In",
                              style: CustomFonts.slussen20W600(
                                  color: Colors.white),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: HexColor(pinkColor),
                            color: HexColor(pinkColor)),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Image.asset(
                    "lib/pages/login/assets/login-card.png",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                  ))
            ],
          ),
        ));
  }
}
