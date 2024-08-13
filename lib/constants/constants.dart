import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

const String lightColor1 = "#E7CB87";
const String lightColor2 = "#E49356";
const String primaryColor = "#201A3F";
const String goldLightColor = "#E7CB87";
const String goldDarkColor = "#E49356";
const String pinkColor = "#FF65DE";

// String baseUrl = 'http://13.127.57.197';
// String baseUrl = 'http://www.health24.fun';
String baseUrl = 'https://162.240.106.108:9091';

showToast(FToast fToast, String text, bool error) {
  return fToast.showToast(
    // toastDuration: Duration(seconds: 3),
    child: Container(
      decoration: BoxDecoration(
          color: HexColor("#201A3F"), borderRadius: BorderRadius.circular(45)),
      padding: EdgeInsets.all(7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              fToast.removeCustomToast();
            },
            child: Image.asset(
                error
                    ? "assets/images/close_red.png"
                    : "assets/images/check.png",
                width: 24,
                height: 24),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: Text(
              text,
              style: CustomFonts.slussen12W700(
                  color: error ? HexColor("#FF4D5C") : HexColor("#76FF5F")),
            ),
          ),
        ],
      ),
    ),
    gravity: ToastGravity.BOTTOM,
  );
}

showDifferentToast(FToast fToast, String text, bool error) {
  return fToast.showToast(
    toastDuration: Duration(seconds: 3),
    child: Container(
      decoration: BoxDecoration(
          color: error ? HexColor("#FF5462") : HexColor("#65FF7E"),
          borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(right: 14, left: 4, top: 4, bottom: 4),
      child: Wrap(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  fToast.removeCustomToast();
                },
                child: Image.asset(
                    error
                        ? "assets/images/failed.png"
                        : "assets/images/success.png",
                    width: 24,
                    height: 24),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                text,
                style: CustomFonts.slussen12W700(
                    color: error ? HexColor("#FFFFFF") : HexColor("#201A3F")),
              ),
            ],
          ),
        ],
      ),
    ),
    gravity: ToastGravity.TOP,
  );
}
