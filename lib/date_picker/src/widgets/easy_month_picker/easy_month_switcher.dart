import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../constants/constants.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';

/// A widget that displays a button for switching to the previous or next month.
class EasyMonthSwitcher extends StatefulWidget {
  const EasyMonthSwitcher(
      {super.key,
      required this.locale,
      required this.value,
      this.onMonthChange,
      this.style,
      this.onChange});

  /// A `String` that represents the locale code to use for formatting the month name in the switcher.
  final String locale;

  /// The currently selected month.
  final EasyMonth? value;

  /// A callback function that is called when the selected month changes.
  final OnMonthChangeCallBack? onMonthChange;

  final VoidCallback? onChange;

  /// The text style applied to the month string.
  final TextStyle? style;

  @override
  State<EasyMonthSwitcher> createState() => _EasyMonthSwitcherState();
}

class _EasyMonthSwitcherState extends State<EasyMonthSwitcher> {
  List<EasyMonth> _yearMonths = [];
  int _currentMonth = 0;

  @override
  void initState() {
    super.initState();
    _yearMonths = EasyDateUtils.getYearMonths(DateTime.now(), widget.locale);

    _currentMonth = widget.value != null ? ((widget.value!.vale)) : 0;
  }

  bool get _isLastMonth => _currentMonth == _yearMonths.length - 1;

  bool get _isFirstMonth => _currentMonth == 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      // width: screenWidth * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _currentMonth == DateTime.now().month
              ? SizedBox()
              : GestureDetector(
                  onTap: () {
                    // print("sdsdsd======${_currentMonth}");
                    if (_isFirstMonth) {
                      return;
                    }
                    _currentMonth--;
                    widget.onMonthChange?.call(_yearMonths[_currentMonth - 1]);
                    widget.onChange!();
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Center(
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 20,
                        color: HexColor(primaryColor),
                      ),
                    ),
                  ),
                ),
          const SizedBox(
            width: 10,
          ),
          Text(
            _yearMonths[_currentMonth - 1].name,
            textAlign: TextAlign.center,
            style: widget.style,
            maxLines: 1,
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              if (_isLastMonth) {
                return;
              }
              _currentMonth++;
              widget.onMonthChange?.call(_yearMonths[_currentMonth - 1]);
              widget.onChange!();
            },
            child: Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 20,
                  color: HexColor(primaryColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
