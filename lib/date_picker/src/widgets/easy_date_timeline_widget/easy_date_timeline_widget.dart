import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/text_style.dart';
import '../../models/models.dart';
import '../../properties/properties.dart';
import '../../utils/utils.dart';
import '../easy_month_picker/easy_month_picker.dart';
import '../time_line_widget/timeline_widget.dart';
import 'selected_date_widget.dart';

/// Represents a timeline widget for displaying dates in a horizontal line.
class EasyDateTimeLine extends StatefulWidget {
  const EasyDateTimeLine(
      {super.key,
      required this.initialDate,
      this.disabledDates,
      this.headerProps = const EasyHeaderProps(),
      this.timeLineProps = const EasyTimeLineProps(),
      this.dayProps = const EasyDayProps(),
      this.onDateChange,
      this.itemBuilder,
      this.activeColor,
      this.locale = "en_US",
      required this.onTap});

  final VoidCallback onTap;

  /// Represents the initial date for the timeline widget.
  /// This is the date that will be displayed as the first day in the timeline.
  final DateTime initialDate;

  /// Represents a list of inactive dates for the timeline widget.
  /// Note that all the dates defined in the `disabledDates` list will be deactivated.
  final List<DateTime>? disabledDates;

  /// The color for the active day.
  final Color? activeColor;

  /// Contains properties for configuring the appearance and behavior of the timeline header.
  final EasyHeaderProps headerProps;

  /// Contains properties for configuring the appearance and behavior of the timeline widget.
  final EasyTimeLineProps timeLineProps;

  /// Contains properties for configuring the appearance and behavior of the day widgets in the timeline.
  /// This includes properties such as the width and height of each day widget,
  /// the color of the text and background, and the font size.
  final EasyDayProps dayProps;

  /// Called when the selected date in the timeline changes.
  /// This function takes a `DateTime` object as its parameter, which represents the new selected date.
  final OnDateChangeCallBack? onDateChange;

  /// > **NOTE:**
  /// > When utilizing the `itemBuilder`, it is essential to provide the width of each day for the date timeline widget.
  /// >
  ///
  /// For example:
  /// ```dart
  /// dayProps: const EasyDayProps(
  ///  // You must specify the width in this case.
  ///  width: 124.0,
  /// )
  /// ```

  final ItemBuilderCallBack? itemBuilder;

  /// A `String` that represents the locale code to use for formatting the dates in the timeline.
  final String locale;

  @override
  State<EasyDateTimeLine> createState() => _EasyDateTimeLineState();
}

class _EasyDateTimeLineState extends State<EasyDateTimeLine> {
  late EasyMonth _easyMonth;
  late int _initialDay;

  late ValueNotifier<DateTime?> _focusedDateListener;
  late ScrollController _controller;

  DateTime get initialDate => widget.initialDate;

  @override
  void initState() {
    // Init easy date timeline locale
    initializeDateFormatting(widget.locale, null);
    super.initState();
    // Get initial month
    _easyMonth =
        EasyDateUtils.convertDateToEasyMonth(widget.initialDate, widget.locale);
    _initialDay = widget.initialDate.day;
    _focusedDateListener = ValueNotifier(initialDate);
    _controller = ScrollController(
      initialScrollOffset: _calculateDateOffset(widget.initialDate),
    );
  }

  void _onFocusedDateChanged(DateTime date) {
    _focusedDateListener.value = date;
    widget.onDateChange?.call(date);
  }

  @override
  void dispose() {
    _focusedDateListener.dispose();
    _controller.dispose();
    super.dispose();
  }

  EasyHeaderProps get _headerProps => widget.headerProps;

  @override
  Widget build(BuildContext context) {
    /// activeDayColor is initialized to the value of widget.activeColor if it is not null,
    /// or to the primary color of the current theme if widget.activeColor is null.
    /// This provides a fallback color if no active color is explicitly provided.
    final activeDayColor = widget.activeColor ?? Theme.of(context).primaryColor;

    /// brightness is initialized to the brightness of the active color or the fallback color,
    /// using the ThemeData.estimateBrightnessForColor method.
    /// This method returns Brightness.dark if the color is closer to black,
    ///  and Brightness.light if the color is closer to white.
    final brightness = ThemeData.estimateBrightnessForColor(
      widget.activeColor ?? activeDayColor,
    );

    /// activeDayTextColor is initialized to EasyColors.dayAsNumColor if the brightness is Brightness.light,
    ///  indicating that the active color is light, or to Colors.white if the brightness is Brightness.dark,
    /// indicating that the active color is dark.
    final activeDayTextColor = brightness == Brightness.light
        ? EasyColors.dayAsNumColor
        : Colors.white;
    return ValueListenableBuilder(
      valueListenable: _focusedDateListener,
      builder: (context, focusedDate, child) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_headerProps.showHeader)
            Padding(
              padding: _headerProps.padding ??
                  const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 20,
                  ),
              child: Row(
                mainAxisAlignment: _headerProps.centerHeader == true
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (_showMonthPicker(pickerType: MonthPickerType.switcher))
                    EasyMonthSwitcher(
                      locale: widget.locale,
                      value: _easyMonth,
                      onMonthChange: _onMonthChange,
                      style: _headerProps.monthStyle,
                      onChange: () {
                        _controller.animateTo(
                          0.0, // Scroll to the start (offset 0.0)
                          duration: Duration(seconds: 1),
                          // Duration of the scroll animation
                          curve: Curves.easeInOut, // Curve for the animation
                        );
                      },
                    ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: HexColor(pinkColor)),
                      child: Center(
                        child: Text(
                          "DONE",
                          style: CustomFonts.slussen12W700(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          TimeLineWidget(
            initialDate: initialDate.copyWith(
              month: _easyMonth.vale,
              day: _initialDay,
            ),
            inactiveDates: widget.disabledDates,
            focusedDate: focusedDate,
            onDateChange: _onFocusedDateChanged,
            timeLineProps: widget.timeLineProps,
            dayProps: widget.dayProps,
            itemBuilder: widget.itemBuilder,
            activeDayTextColor: activeDayTextColor,
            activeDayColor: activeDayColor,
            locale: widget.locale,
            controller: _controller,
          ),
        ],
      ),
      child: EasyMonthDropDown(
        value: _easyMonth,
        locale: widget.locale,
        onMonthChange: _onMonthChange,
        style: _headerProps.monthStyle,
      ),
    );
  }

  void _onMonthChange(month) {
    setState(() {
      _initialDay = 1;
      _easyMonth = month!;
    });
  }

  double _calculateDateOffset(DateTime date) {
    final startDate = DateTime.now().month == widget.initialDate.month
        ? DateTime(DateTime.now().year, DateTime.now().month, dayCount())
        : widget.initialDate;
    int offset = date.difference(startDate).inDays;
    double adjustedHPadding =
        widget.timeLineProps.hPadding > EasyConstants.timelinePadding
            ? (widget.timeLineProps.hPadding - EasyConstants.timelinePadding)
            : 0.0;
    if (offset == 0) {
      return 0.0;
    }
    return (offset *
            (widget.dayProps.landScapeMode
                ? widget.dayProps.height
                : widget.dayProps.width)) +
        (offset * widget.timeLineProps.separatorPadding) +
        adjustedHPadding;
  }

  int dayCount() {
    DateTime endDate = DateTime.now();
    DateTime startDate = DateTime(endDate.year, endDate.month, 1);

    Duration difference = endDate.difference(startDate);

    int daysCount = difference.inDays + 1;
    return daysCount;
  }

  /// The method returns a boolean value, which indicates whether the month picker
  /// should be displayed. If the _headerProps object is not null and its monthPickerType property
  /// matches the pickerType parameter,
  /// or if _headerProps is null and the isDefaultPicker parameter is true,
  /// then the method returns true. Additionally,
  /// if the showMonthPicker property of _headerProps is true when _headerProps is not null,
  /// then the method also returns true. Otherwise, it returns false.
  ///
  /// This method used to determine whether to display the month picker in the header of the EasyDateTimeLineWidget.
  bool _showMonthPicker({required MonthPickerType pickerType}) {
    /// Get a boolean flag `useCustomHeader` that is true if `_headerProps` exists
    /// and its `showMonthPicker` property is true, otherwise set it to true.
    final bool showMonthPicker = _headerProps.showMonthPicker;

    /// Return true if the month picker type in `_headerProps` matches `pickerType`
    /// or if `isDefault` is true and `useCustomHeader` is true.
    return _headerProps.monthPickerType == pickerType && showMonthPicker;
  }
}
