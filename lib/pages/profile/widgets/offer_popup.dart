import 'package:flutter/material.dart';

class OfferPopup extends StatelessWidget {
  const OfferPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFF2F7FB),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 0),
                  color: Colors.transparent,
                  blurRadius: 20)
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 480,
              child: Stack(
                children: [
                  Container(
                    height: 430,
                    margin: const EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF2F7FB),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Color(0xFFAEC4D6),
                              blurRadius: 20)
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      "res/images/offer_bg.png",
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 130,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                    ),
                  ),
                  Positioned(
                    right: 6,
                    top: 0,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("res/images/star.png"))),
                      alignment: Alignment.center,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("HURRY",
                              style: TextStyle(
                                  fontFamily: "Kumbhsans",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: Colors.white)),
                          Text("UP",
                              style: TextStyle(
                                  fontFamily: "Kumbhsans",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 36, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const ImageIcon(
                                AssetImage("res/icons/close.png"),
                                color: Color(0xFFFFFFFF),
                                size: 18)),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Text(
                              "Top-notch treatment, starting low."
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontFamily: "Kumbhsans",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                  color: Color(0xFFFFFFFF))),
                        ),
                        Text("50%".toUpperCase(),
                            style: const TextStyle(
                                fontFamily: "Kumbhsans",
                                fontWeight: FontWeight.w900,
                                fontSize: 64,
                                color: Color(0xFFFF8412))),
                        Text("OFF".toUpperCase(),
                            style: const TextStyle(
                                fontFamily: "Kumbhsans",
                                fontWeight: FontWeight.w900,
                                fontSize: 36,
                                color: Color(0xFFFFFFFF)))
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 130, right: 20),
                          child: Image.asset(
                            "res/images/img2.png",
                            height: 160,
                          ))),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          Image.asset(
                            "res/images/img1.png",
                            height: 160,
                          ),
                          const Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 8, right: 16, top: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: 8, bottom: 4),
                                    child: Text(
                                        "Easy quick booking, Book in minutes.",
                                        style: TextStyle(
                                            fontFamily: "Kumbhsans",
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                            color: Color(0xFFFF8412))),
                                  ),
                                  Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie.",
                                    style: TextStyle(
                                      fontFamily: "Kumbhsans",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 8,
                                      color: Color(0xFF211F2B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
