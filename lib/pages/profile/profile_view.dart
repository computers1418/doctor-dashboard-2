import 'dart:ui';

import 'package:doctor_dashboard/pages/profile/widgets/list_item.dart';
import 'package:doctor_dashboard/pages/profile/widgets/location_popup.dart';
import 'package:doctor_dashboard/pages/profile/widgets/main_container.dart';
import 'package:doctor_dashboard/pages/profile/widgets/offer_popup.dart';
import 'package:doctor_dashboard/pages/profile/widgets/styled_wrapper.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List items = [
    "Education",
    "Specialization",
    "Experience",
    "Achievements",
    "Membership"
  ];

  int _currentShow = 0;

  List items2 = [
    {"header": "February, 2024"},
    {
      "title": "Deposit",
      "sub": "Received on 28 Feb, 10:45 PM",
      "status": "Credited",
      "amount": "+2000",
      "success": true,
      "download": true,
    },
    {
      "title": "Company",
      "sub": "Paid on 21 Feb, 09:37 AM",
      "status": "Debited",
      "amount": "-500",
      "success": false,
      "download": false,
    },
    {"header": "January, 2024"},
    {
      "title": "Company",
      "sub": "Paid on 21 Feb, 09:37 AM",
      "status": "Debited",
      "amount": "-500",
      "success": false,
      "download": false,
    },
    {
      "title": "Deposit",
      "sub": "Received on 28 Feb, 10:45 PM",
      "status": "Credited",
      "amount": "+2000",
      "success": true,
      "download": true,
    },
    {"header": "December, 2023"},
    {
      "title": "Deposit",
      "sub": "Received on 28 Feb, 10:45 PM",
      "status": "Credited",
      "amount": "+2000",
      "success": true,
      "download": true,
    },
    {
      "title": "Company",
      "sub": "Paid on 21 Feb, 09:37 AM",
      "status": "Debited",
      "amount": "-500",
      "success": false,
      "download": false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.002),
        body: ListView(
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: const Color(0xFFF2F7FB),
                      height: 200,
                    ),
                  ),
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.modulate,
                    ),
                    child: Image.asset(
                      "res/images/top_bg.png",
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Image.asset(
                        "res/images/avatar.png",
                        height: 118,
                        width: 118,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.002)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF15102E),
                                Color(0xFF2C2553),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              // showDialog(
                              //   barrierColor: const Color(0xFFF2F7FB),
                              //   context: context,
                              //   builder: (_) {
                              //     return const LocationPopup();
                              //   },
                              // )
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF392F70),
                                    Color(0xFF0D0823)
                                  ],
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const ImageIcon(
                                AssetImage("res/icons/back.png"),
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF15102E),
                                Color(0xFF2C2553),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                barrierColor: const Color(0xFFF2F7FB),
                                context: context,
                                builder: (_) {
                                  return const OfferPopup();
                                },
                              );
                            },
                            child: Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF392F70),
                                    Color(0xFF0D0823)
                                  ],
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const ImageIcon(
                                AssetImage("res/icons/menu.png"),
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(0xFFF2F7FB),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Dr. Mitchell Adams",
                        style: TextStyle(
                          fontFamily: "Slussen",
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Color(0xFF201A3F),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "(BDS,MDS)",
                        style: TextStyle(
                          fontFamily: "Slussen",
                          fontWeight: FontWeight.w800,
                          fontSize: 8,
                          color: Color(0xFFFF65DE),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        MainContainer(
                            icon: "res/icons/calendar.png",
                            sub: "patients Treated",
                            title: "10K+"),
                        SizedBox(
                          width: 15,
                        ),
                        MainContainer(
                            icon: "res/icons/reminder.png",
                            sub: "years exp",
                            title: "6+",
                            invert: true),
                        SizedBox(
                          width: 15,
                        ),
                        MainContainer(
                          icon: "res/icons/tools.png",
                          sub: "Awards",
                          title: "30+",
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 35),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: const Color(0xFF201A3F),
                          borderRadius: BorderRadius.circular(35)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return const LinearGradient(
                                      colors: [
                                        Color(0xFFE7CB87),
                                        Color(0xFFE49356)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ).createShader(bounds);
                                  },
                                  child: const Text(
                                    "Smile Dental Clinic",
                                    style: TextStyle(
                                      fontFamily: "Slussen",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  "12/2, Mathura Road, Sector 37, Faridabad,Delhi - 101213",
                                  style: TextStyle(
                                    fontFamily: "Slussen",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    color: Color(0x80FFFFFF),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.2),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: const ImageIcon(
                                        AssetImage("res/icons/phone.png"),
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Expanded(
                                      child: Text(
                                        "+91 90876 54321",
                                        style: TextStyle(
                                          fontFamily: "Slussen",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.2),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: const ImageIcon(
                                        AssetImage("res/icons/email.png"),
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Expanded(
                                      child: Text(
                                        "drmitchadams1414@gmail.com",
                                        style: TextStyle(
                                          fontFamily: "Slussen",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 4,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Image.asset(
                                    "res/images/image.png",
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        decoration: BoxDecoration(
                                            color: const Color(0x80FF65DE),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Text(
                                          "3rd floor",
                                          style: TextStyle(
                                            fontFamily: "Slussen",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Text(
                      "More About You",
                      style: TextStyle(
                        fontFamily: "Slussen",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFFE49356),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    StyledWrapper(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentShow = _currentShow == 0 ? -1 : 0;
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Text(
                                    "About",
                                    style: TextStyle(
                                      fontFamily: "Slussen",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: Color(0xFF201A3F),
                                    ),
                                  ),
                                ),
                                Icon(
                                  _currentShow == 0
                                      ? Icons.keyboard_arrow_down_rounded
                                      : Icons.keyboard_arrow_up_rounded,
                                  color: const Color(0xFF201A3F),
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                          if (_currentShow == 0) ...[
                            const SizedBox(height: 10),
                            const Text(
                              "Jorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
                              style: TextStyle(
                                fontFamily: "Slussen",
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: Color(0xFF201A3F),
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ...items.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: StyledWrapper(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _currentShow =
                                        _currentShow == items.indexOf(e) + 1
                                            ? -1
                                            : items.indexOf(e) + 1;
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '$e',
                                        style: const TextStyle(
                                          fontFamily: "Slussen",
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: Color(0xFF201A3F),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      _currentShow == items.indexOf(e) + 1
                                          ? Icons.keyboard_arrow_up_rounded
                                          : Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xFF201A3F),
                                      size: 24,
                                    )
                                  ],
                                ),
                              ),
                              if (_currentShow == items.indexOf(e) + 1) ...[
                                const SizedBox(height: 10),
                                const Text(
                                  "Jorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
                                  style: TextStyle(
                                    fontFamily: "Slussen",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    color: Color(0xFF201A3F),
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(0xFFF2F7FB),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  color: Color(0xFF201A3F),
                ),
              ),
            ),
            Container(
              color: const Color(0xFF201A3F),
              child: Column(
                children: [
                  Container(
                    color: const Color(0xFF201A3F),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Previous',
                                style: TextStyle(
                                  fontFamily: "Slussen",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0x80FFFFFF),
                                ),
                              ),
                              Text(
                                'Transactions',
                                style: TextStyle(
                                  fontFamily: "Slussen",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: Color(0xFFFFFFFF),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: const DecorationImage(
                              image: AssetImage("res/images/card_bg.png"),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(
                                        0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(30, 25, 30, 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ImageIcon(
                                          AssetImage("res/icons/chip.png"),
                                          color: Colors.white,
                                          size: 45,
                                        ),
                                        ImageIcon(
                                          AssetImage("res/images/visa.png"),
                                          color: Colors.white,
                                          size: 65,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 70),
                                    Text(
                                      "Dr. Mitchell Adams",
                                      style: TextStyle(
                                        fontFamily: "Slussen",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "1818   8372   7366   ****",
                                      style: TextStyle(
                                        fontFamily: "Slussen",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF65DE),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 7,
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Your view is limited to the",
                                style: TextStyle(
                                  fontFamily: "Slussen",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              TextSpan(
                                text: " last two transactions for each month.",
                                style: TextStyle(
                                  fontFamily: "Slussen",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 10,
                                  color: Color(0xFFE7CB87),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ...items2.map(
                    (e) => ListItem(
                      header: e["header"],
                      sub: e["sub"],
                      title: e["title"],
                      download: e["download"],
                      amount: e["amount"],
                      success: e["success"],
                      status: e["status"],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
