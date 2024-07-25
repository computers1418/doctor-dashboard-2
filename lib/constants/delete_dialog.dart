import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../constants/text_style.dart';

class DeleteDialog extends StatefulWidget {
  final VoidCallback onTap;

  const DeleteDialog({
    super.key,
    required this.onTap,
  });

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.h)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20.h,
            ),
            // Image.asset(
            //   "assets/images/icon.png",
            //   height: 68,
            //   width: 68,
            // ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 8.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                      color: HexColor("#F0F0F0"),
                      borderRadius: BorderRadius.circular(30.h)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      "assets/images/close_blue.png",
                      width: 26.h,
                      height: 26.h,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 34.h,
            ),
            Text(
              "Are you sure want to delete?",
              style: CustomFonts.slussen14W700(),
            ),

            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    height: 50.h,
                    width: 104.h,
                    decoration: BoxDecoration(
                        color: HexColor("#FF65DE").withOpacity(0.07),
                        borderRadius: BorderRadius.circular(32.h)),
                    child: Text(
                      "NO",
                      style:
                          CustomFonts.slussen14W700(color: HexColor("#FF65DE")),
                    ),
                    alignment: Alignment.center,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 12.h,
                ),
                GestureDetector(
                  child: Container(
                    width: 104.h,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: HexColor("#FF65DE"),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "YES",
                      style: CustomFonts.slussen14W700(color: Colors.white),
                    ),
                    alignment: Alignment.center,
                  ),
                  onTap: widget.onTap,
                )
              ],
            ),
            SizedBox(
              height: 47,
            ),
          ],
        ));
  }
}
