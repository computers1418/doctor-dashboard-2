import 'package:doctor_dashboard/extensions/string_exten.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../constants/colors_const.dart';

class SingleSelect extends StatefulWidget {
  final List<String> items;
  final String label;
  final bool enable;

  const SingleSelect(
      {super.key,
      required this.items,
      required this.label,
      this.enable = true});

  @override
  State<SingleSelect> createState() => _SingleSelectState();
}

class _SingleSelectState extends State<SingleSelect> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !widget.enable,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.enable
                    ? ColorsConst.secondary
                    : ColorsConst.secondary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(32)),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                selectedValue ?? widget.label,
                style: TextStyle(
                    fontFamily: 'Slussen',
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: widget.enable
                        ? Colors.white
                        : Colors.white.withOpacity(0.4)),
                textAlign:
                    TextAlign.center, // Ensure dropdown item text is centered
              ),
            ),
          ),
          selectedItemBuilder: (_) {
            return widget.items.map((item) {
              return Align(
                alignment: Alignment.center,
                child: item == "No SMS Template"
                    ? item.semibold12(color: const Color(0x4D201A3F))
                    : item.semibold12(color: ColorsConst.secondary),
              );
            }).toList();
          },
          items: widget.items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Align(
                      alignment: Alignment.center,
                      child: item == "No SMS Template"
                          ? item.semibold12(color: const Color(0x4D201A3F))
                          : item.semibold12(
                              color: selectedValue == item
                                  ? ColorsConst.secondary
                                  : ColorsConst.primary),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            // This is necessary for the ink response to match our customButton radius.
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 240,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            offset: const Offset(0, 0),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 36,
            padding: EdgeInsets.only(left: 0, right: 0),
          ),
        ),
      ),
    );
  }
}
