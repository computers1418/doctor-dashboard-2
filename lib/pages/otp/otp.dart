import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:doctor_dashboard/widgets/neumorphic_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({ Key? key }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(primaryColor),
      body: SingleChildScrollView(
              child: Stack(alignment: Alignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
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
                    GradientText("OTP Verification", 
                    style: CustomFonts.slussen28W700(),
                    colors: [
                      HexColor(goldLightColor),
                      HexColor(goldDarkColor),
                    ]),
                    const SizedBox(height: 8,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Enter Pin Code sent to your registered Email and Phone no.",
                        style: CustomFonts.slussen14W400(
                          color: Colors.white.withOpacity(.5)
                        ),),
                      ),
                    ),
                    const SizedBox(height: 48,),
                    OTPTextField(outlineBorderRadius: 60,
                    otpFieldStyle: OtpFieldStyle(
                      backgroundColor: Colors.white.withOpacity(.05),
                      enabledBorderColor: Colors.white.withOpacity(.05),
                      borderColor: Colors.white.withOpacity(.05),
                      focusBorderColor: Colors.white.withOpacity(.05),
                      disabledBorderColor: Colors.white.withOpacity(.05),

                    ),
                      length: 4,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 66,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white
                      ),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      onChanged: (value) {
                        
                      },
                      onCompleted: (pin) {
                        if (kDebugMode) {
                          print("Completed: " + pin);
                        }
                      },
                    ),
                    const SizedBox(height: 64,),
                    Container(height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: Colors.white.withOpacity(.05),
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            HexColor(goldLightColor),
                            HexColor(goldDarkColor)
                          ])
                      ),
                      child: Center(
                        child: Text("Verify",
                        style: CustomFonts.slussen20W600(
                          color: Colors.white
                        ),),
                      )
                    ),
                    const SizedBox(height: 16,),
                    Text("Send Again?",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: HexColor(pinkColor),
                      color: HexColor(pinkColor)
                    ),)
                  ],
                ),
              ),
            ),
            Positioned(bottom: 0,
                child: Image.asset("lib/pages/otp/assets/otp-card.png",
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.38,)),
            Positioned(bottom: 0,
              child: Image.asset("lib/pages/otp/assets/img.png",
              fit: BoxFit.fill,
              // width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.32,))
          ],
        ),
      ));
  }
}