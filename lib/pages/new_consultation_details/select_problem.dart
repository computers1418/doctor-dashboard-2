import 'package:doctor_dashboard/constants/constants.dart';
import 'package:doctor_dashboard/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

class SelectProblem extends StatefulWidget {
  final Function callback;

  const SelectProblem({Key? key, required this.callback}) : super(key: key);

  @override
  State<SelectProblem> createState() => _SelectProblemState();
}

class _SelectProblemState extends State<SelectProblem> {
  List problems = [
    'Dental Braces',
    'Decayed Tooth',
    'Tooth Extraction',
    'Dental Crown',
    'Gum Treatment',
    'Dental Cleaning',
    'Teeth Straightening',
  ];
  int selectedProblem = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.callback(problems[selectedProblem]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      "Problems",
                      style: CustomFonts.slussen28W700(
                          color: HexColor(primaryColor)),
                    ),
                  ),
                  Text(
                    "Select",
                    style: CustomFonts.slussen14W700(
                        color: HexColor(primaryColor)),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: HexColor(pinkColor),
                  ),
                  child: Text(
                    'DONE',
                    style: CustomFonts.slussen12W700(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: DynMouseScroll(
              durationMS: 5000,
              scrollSpeed: -4.4,
              builder: (context, controller, physics) => Scrollbar(
                thickness: 10.0,
                trackVisibility: true,
                thumbVisibility: true,
                controller: controller,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ListView(
                    controller: controller,
                    physics: physics,
                    children: [
                      Column(
                        children: [
                          for (int i = 0; i < problems.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  selectedProblem = i;
                                  widget.callback(problems[selectedProblem]);
                                }),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(45),
                                      color: selectedProblem == i
                                          ? HexColor("#E49356")
                                          : Colors.white),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: selectedProblem == i
                                                ? Colors.white
                                                : HexColor(primaryColor)),
                                        child: Image.asset(
                                            "lib/pages/new_consultation_details/assets/${problems[i]}.png",
                                            color: selectedProblem == i
                                                ? HexColor(primaryColor)
                                                : Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              problems[i],
                                              style: CustomFonts.slussen16W700(
                                                  color: selectedProblem == i
                                                      ? Colors.white
                                                      : HexColor(primaryColor)),
                                            ),
                                            Container(
                                              width: 68,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      HexColor(goldDarkColor),
                                                      HexColor(goldLightColor)
                                                    ]),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Rs. 1000",
                                                  style:
                                                      CustomFonts.slussen10W500(
                                                          color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        height: selectedProblem == i ? 42 : 30,
                                        width: selectedProblem == i ? 42 : 30,
                                        padding: EdgeInsets.all(
                                            selectedProblem == i ? 10 : 6),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: HexColor(pinkColor)
                                                .withOpacity(
                                                    selectedProblem == i
                                                        ? 1
                                                        : .2)),
                                        child: Image.asset(
                                            "lib/pages/new_consultation_details/assets/${selectedProblem == i ? 'done' : 'add'}.png"),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
