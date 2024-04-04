import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../constants/constants.dart';
import '../constants/text_style.dart';

class CustomDrawer extends StatefulWidget {
  final Function callback;
  const CustomDrawer({ Key? key, required this.callback }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.callback(),
      child: Container(color: HexColor(primaryColor),
      width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 14, top: 80),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/img.png",
                    height: 100, width: 100,),
                    const SizedBox(height:  16,),
                    GradientText("Dr. Mitchell Adams ",
                    colors: [
                      HexColor(goldLightColor),
                      HexColor(goldDarkColor)
                    ],
                    style: CustomFonts.slussen18W700(),
                    ),
                    Text("ID - UY2097PR100",
                    style: CustomFonts.slussen12W400(
                      color: Colors.white.withOpacity(.5)
                    ),),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              ListTile(
                title: Text("Account",
                style: CustomFonts.slussen16W500(
                  color: Colors.white
                ),),
              ),
              ListTile(
                title: Text("New Consultation",
                style: CustomFonts.slussen16W500(
                  color: Colors.white
                ),),
              ),
              ListTile(
                title: Text("Super Scheduling",
                style: CustomFonts.slussen16W500(
                  color: Colors.white
                ),),
              ),
              ListTile(
                title: Text("Super Specialization",
                style: CustomFonts.slussen16W500(
                  color: Colors.white
                ),),
              ),
              ListTile(
                title: Text("Bookings",
                style: CustomFonts.slussen16W500(
                  color: Colors.white
                ),),
              ),
              ListTile(
                title: Text("Notifications",
                style: CustomFonts.slussen16W500(
                  color: Colors.white
                ),),
              ),
              ListTile(
                title: Text("Get Help",
                style: CustomFonts.slussen16W500(
                  color: Colors.white
                ),),
              ),
              const SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(height: 40,
                width: 127,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: HexColor(pinkColor)
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/logout.png",),
                      Text("Logout",
                      style: CustomFonts.slussen10W700(
                        color: Colors.white
                      ),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}