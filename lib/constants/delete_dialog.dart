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
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
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
                  height: 8,
                  width: 60,
                  decoration: BoxDecoration(
                      color: HexColor("#F0F0F0"),
                      borderRadius: BorderRadius.circular(30)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      "assets/images/close_blue.png",
                      width: 26,
                      height: 26,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 34,
            ),
            Text(
              "Are you sure want to delete?",
              style: CustomFonts.slussen14W700(),
            ),

            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: 104,
                    decoration: BoxDecoration(
                        color: HexColor("#FF65DE").withOpacity(0.07),
                        borderRadius: BorderRadius.circular(32)),
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
                  width: 12,
                ),
                GestureDetector(
                  child: Container(
                    width: 104,
                    height: 50,
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
