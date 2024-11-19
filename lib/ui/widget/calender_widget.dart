import 'package:ems_app/common/base_components/base_assets.dart';
import 'package:ems_app/common/base_components/base_colors.dart';
import 'package:ems_app/common/base_components/base_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../common/utils/responsive.dart';
import '../../common/utils/utils_function.dart';

class CalendarDialog extends StatefulWidget {
  final bool isToday;
  final DateTime initialFocusedDay;
  final DateTime? firstDay, lastDay;
  final Function(DateTime?) onDaySelected;

  const CalendarDialog({
    super.key,
    this.isToday = false,
    this.firstDay,
    this.lastDay,
    required this.initialFocusedDay,
    required this.onDaySelected,
  });

  @override
  _CalendarDialogState createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  late DateTime focusedDay;
  DateTime? selectedDay;
  String? selectedButton; // Variable to track the selected button

  @override
  void initState() {
    super.initState();
    focusedDay = widget.initialFocusedDay;
    selectedDay = widget.initialFocusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth, // Take full width of the screen
          padding: EdgeInsets.all(mediaQueryWidth(context, 0.05)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Quick Selection Buttons
              if (widget.isToday)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: _buildQuickButton(context, "Today", () {
                        setState(() {
                          selectedDay = DateTime.now();
                          selectedButton = 'Today';
                        });
                      }),
                    ),
                    buildSizeWidth(mediaQueryWidth(context, 0.04)),
                    Expanded(
                      child: _buildQuickButton(context, "Next Monday", () {
                        setState(() {
                          selectedDay = _getNextMonday();
                          selectedButton = 'Next Monday';
                        });
                      }),
                    ),
                  ],
                ),
              if (widget.isToday)
                SizedBox(height: mediaQueryWidth(context, 0.02)),
              if (widget.isToday)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: _buildQuickButton(context, "Next Tuesday", () {
                        setState(() {
                          selectedDay = _getNextTuesday();
                          selectedButton = 'Next Tuesday';
                        });
                      }),
                    ),
                    buildSizeWidth(mediaQueryWidth(context, 0.04)),
                    Expanded(
                      child: _buildQuickButton(context, "After 1 week", () {
                        setState(() {
                          selectedDay =
                              DateTime.now().add(const Duration(days: 7));
                          selectedButton = 'After 1 week';
                        });
                      }),
                    ),
                  ],
                ),
              if (!widget.isToday)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: _buildQuickButton(context, "No Date", () {
                        setState(() {
                          selectedButton = 'No Date';
                          selectedDay = null;
                        });
                      }),
                    ),
                    buildSizeWidth(mediaQueryWidth(context, 0.04)),
                    Expanded(
                      child: _buildQuickButton(context, "Today", () {
                        setState(() {
                          selectedDay = DateTime.now();
                          selectedButton = 'Today';
                        });
                      }),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              // Calendar Widget
              TableCalendar(
                firstDay: widget.firstDay ?? DateTime.utc(2020, 1, 1),
                lastDay: widget.lastDay ?? DateTime.utc(2030, 12, 51),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                onDaySelected: (newSelectedDay, newFocusedDay) {
                  setState(() {
                    selectedDay = newSelectedDay;
                    focusedDay = newFocusedDay;
                    selectedButton =
                        null; // Clear button highlight when selecting a day from the calendar
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronIcon: SvgPicture.asset(BaseAssets.leftIcon),
                  rightChevronIcon: SvgPicture.asset(BaseAssets.rightIcon),
                  titleCentered: true,
                  leftChevronVisible: true,
                  rightChevronVisible: true,
                  titleTextStyle: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  titleTextFormatter: (date, locale) =>
                      DateFormat.yMMMM().format(date),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(height: 1, color: BaseColors.dividerColor),
              const SizedBox(height: 10),

              // Bottom Action Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(BaseAssets.calenderIcon, height: 25),
                      const SizedBox(width: 5),
                      BaseText(
                        value: selectedDay != null
                            ? DateFormat('d MMM y').format(selectedDay!)
                            : "No Date",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: BaseColors.textColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: !Responsive.isLargeMobile(context)
                            ? 50
                            : mediaQueryWidth(context, 0.08),
                        width: mediaQueryWidth(context, 0.2),
                        child: ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            backgroundColor: BaseColors.secondaryColor,
                          ),
                          onPressed: () {
                            Navigator.pop(
                                context); // Close dialog on Save click
                          },
                          child: const BaseText(
                              value: 'Cancel',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              textAlign: TextAlign.center,
                              color: BaseColors.primaryColor),
                        ),
                      ),
                      buildSizeWidth(mediaQueryWidth(context, 0.02)),
                      SizedBox(
                        height: !Responsive.isLargeMobile(context)
                            ? 50
                            : mediaQueryWidth(context, 0.08),
                        width: mediaQueryWidth(context, 0.2),
                        child: ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            backgroundColor: BaseColors.primaryColor,
                          ),
                          onPressed: () {
                            // if (selectedDay != null) {
                            widget.onDaySelected(selectedDay);
                            // }
                            Navigator.pop(
                                context); // Close dialog on Save click
                          },
                          child: const BaseText(
                              value: 'Save',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              textAlign: TextAlign.center,
                              color: BaseColors.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      height: !Responsive.isLargeMobile(context)
          ? 50
          : mediaQueryWidth(context, 0.08),
      width: mediaQueryWidth(context, 0.2),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.blue.shade100),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: text == selectedButton
              ? BaseColors.primaryColor
              : BaseColors.secondaryColor,
        ),
        child: BaseText(
          value: text,
          color: text == selectedButton
              ? BaseColors.whiteColor
              : BaseColors.primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }

  DateTime _getNextMonday() {
    DateTime today = DateTime.now();
    return today.add(Duration(days: (8 - today.weekday) % 7));
  }

  DateTime _getNextTuesday() {
    DateTime today = DateTime.now();
    return today.add(Duration(days: (9 - today.weekday) % 7));
  }
}
