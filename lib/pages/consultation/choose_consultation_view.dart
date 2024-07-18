import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/pages/history/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChooseConsultationView extends StatefulWidget {
  const ChooseConsultationView({super.key});

  @override
  State<ChooseConsultationView> createState() => _ChooseConsultationViewState();
}

class _ChooseConsultationViewState extends State<ChooseConsultationView> {
  List<String> icons = [
    "call",
    "video_call",
    "clinic",
    "home",
  ];
  List<String> names = [
    "Voice Call",
    "Video Call",
    "Clinic Visit",
    "Home Visit",
  ];
  List<int> isActive = [0, 1, 2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(primaryColor),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              callback: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Choose ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        "Type of Consultation",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < icons.length; i++) ...[
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: isActive.contains(i)
                                      ? const LinearGradient(
                                          colors: [
                                            Colors.white,
                                            Color(0xffFF65DE),
                                          ],
                                        )
                                      : null,
                                  color: isActive.contains(i)
                                      ? Colors.white
                                      : Colors.transparent.withOpacity(0.1),
                                ),
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isActive.contains(i)
                                        ? HexColor(primaryColor)
                                            .withOpacity(0.9)
                                        : Colors.white.withOpacity(0.1),
                                  ),
                                  padding: const EdgeInsets.all(25),
                                  child: Image.asset(
                                    'res/icons/${icons[i]}.png',
                                    height: 40,
                                    width: 40,
                                    color: isActive.contains(i)
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                names[i],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: isActive.contains(i)
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.2),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 16,
                                width: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: isActive.contains(i)
                                      ? const Color(0xffFF65DE)
                                      : Colors.white.withOpacity(0.2),
                                  boxShadow: isActive.contains(i)
                                      ? [
                                          BoxShadow(
                                            color: const Color(0xffFF65DE)
                                                .withOpacity(.8),
                                            blurRadius: 20,
                                          ),
                                          BoxShadow(
                                            color: const Color(0xffFF65DE)
                                                .withOpacity(.4),
                                            blurRadius: 15,
                                          ),
                                        ]
                                      : [],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 140,
                                right: 20,
                                top: 10,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "What's Displayed",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor(pinkColor),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: HexColor("#372F62")
                                                .withOpacity(0.05),
                                            radius: 20,
                                            child: Icon(
                                              Icons.delete,
                                              size: 11,
                                              color: HexColor(primaryColor),
                                            ),
                                          ),
                                          Text(
                                            "Delete",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor("#201A3F"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Treatment starting at as low as 2oo Rs. per session.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("#201A3F"),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: HexColor("#F2F7FB"),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Details",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: HexColor("#201A3F"),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: HexColor("#372F62")
                                              .withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(26),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 7,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Edit",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("#372F62"),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.edit,
                                              size: 10,
                                              color: HexColor("#372F62"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Write here...",
                                      hintStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: HexColor("#756D9E"),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 4,
                                    minLines: 4,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Consider the limit of",
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                            color: HexColor("#201A3F"),
                                          ),
                                        ),
                                        TextSpan(
                                          text: " 50 words ",
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w900,
                                            color: HexColor("#E447C2"),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "while writing details",
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                            color: HexColor("#201A3F"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: HexColor("#F4F4F5"),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  width: 5,
                                  color: HexColor("#E49356"),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    HexColor("#E49356"),
                                    HexColor("E7CB87"),
                                  ],
                                ),
                              ),
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 70),
                              child: Text(
                                "This will be displayed on the upper part of the booking form to users.",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("#201A3F"),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // const SizedBox(
                            //   height: 30,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 26,
                      top: -37,
                      child: Image.asset(
                        'res/icons/phone_tilted.png',
                        height: 180,
                        width: 90,
                      ),
                    ),
                    Positioned(
                      left: 120,
                      top: 9,
                      child: Image.asset(
                        'res/icons/cursor.png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
