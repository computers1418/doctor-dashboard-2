import 'package:doctor_dashboard/pages/profile/widgets/styled_wrapper_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class LocationPopup extends StatelessWidget {
  const LocationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> cities = [
      'Bengaluru', // Tech and IT hub, startups
      'Mumbai', // Finance, Bollywood, and entertainment
      'Hyderabad', // IT, pharmaceuticals
      'Pune', // IT, automotive
      'Chennai', // Manufacturing, IT
      'Noida', // IT, media
      'Delhi', // Government jobs, IT, education
      'Kolkata', // Cultural hub, manufacturing, education
      'Ahmedabad', // Textiles, education
      'Chandigarh', // IT, education
      'Coimbatore', // Textiles, manufacturing, IT
      'Jaipur', // Tourism, manufacturing
      'Indore', // IT, education
      'Lucknow', // Government jobs, IT, education
      'Bhubaneswar', // Education, IT
      'Kochi', // IT, tourism
      'Visakhapatnam', // Industrial, IT
      'Nagpur', // Logistics, IT
    ];

    ValueNotifier<String?> selected = ValueNotifier(null);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F7FB),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              color: Color(0xFFAEC4D6),
              blurRadius: 20,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const StyledWrapper2(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(AssetImage("res/icons/cup.png"),
                            color: Color(0xFFFF8412), size: 18),
                        SizedBox(width: 4),
                        Text(
                          "50 Cities",
                          style: TextStyle(
                            fontFamily: "Kumbhsans",
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
                            color: Color(0xFF211F2B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(AssetImage("res/icons/flower.png"),
                            color: Color(0xFFFF8412), size: 18),
                        SizedBox(width: 4),
                        Text(
                          "1 Lakh Patients",
                          style: TextStyle(
                            fontFamily: "Kumbhsans",
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
                            color: Color(0xFF211F2B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(AssetImage("res/icons/badge.png"),
                            color: Color(0xFFFF8412), size: 18),
                        SizedBox(width: 4),
                        Text(
                          "60 Clinics",
                          style: TextStyle(
                            fontFamily: "Kumbhsans",
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
                            color: Color(0xFF211F2B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            StyledWrapper2(
              child: Container(
                height: 260,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("res/images/map.png"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            ValueListenableBuilder(
              valueListenable: selected,
              builder: (_, val, __) {
                return StyledWrapper2(
                    child: Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      value: val,
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 400,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFF2F7FB),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 20,
                              spreadRadius: 0,
                              color: Color(
                                0x40323232,
                              ),
                            ),
                          ],
                        ),
                        offset: const Offset(0, 400),
                        scrollPadding: const EdgeInsets.only(right: 20),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          minThumbLength: 40,
                          trackVisibility: const MaterialStatePropertyAll(true),
                          trackColor:
                              const MaterialStatePropertyAll(Color(0xFFC9DFF0)),
                          thickness: MaterialStateProperty.all(2),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                      items: cities
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontFamily: "Kumbhsans",
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        color: Color(0xFF171632),
                                      ),
                                    ),
                                  ),
                                  // Icon can be placed outside Row for a different effect
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (item) => selected.value = item,
                      hint: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Select Item',
                            style: TextStyle(
                                fontFamily: "Kumbhsans",
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: Color(0xFF171632)),
                          ),
                          // Icon can be placed outside Row for a different effect
                        ],
                      ),
                    ),
                  ),
                ));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFACA4FE),
                    Color(0xFF5C55AB),
                    Color(0xFF2B275A)
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: Color(0xFFFFFFFF),
                  ),
                  BoxShadow(
                    offset: Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: Color(0xFFE1EAF1),
                  )
                ],
              ),
              child: const Text(
                "Done",
                style: TextStyle(
                  fontFamily: "Kumbhsans",
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
