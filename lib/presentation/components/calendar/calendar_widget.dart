import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import 'package:intl/intl.dart';

import '../../../core/theme/app_primary_theme.dart';
import '../button/icon_primary_button_no_text.dart';

EventList<Event> _markedDateMap = EventList<Event>(
  events: {
    DateTime(2019, 2, 10): [
      Event(
        date: DateTime(2019, 2, 10),
        title: 'Event 1',
        dot: Container(
          margin: const EdgeInsets.symmetric(horizontal: 1.0),
          color: Colors.red,
          height: 5.0,
          width: 5.0,
        ),
      ),
      Event(
        date: DateTime(2019, 2, 10),
        title: 'Event 2',
      ),
      Event(
        date: DateTime(2019, 2, 10),
        title: 'Event 3',
      ),
    ],
  },
);

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _currentDate = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                _currentMonth,
                style: AppTheme.subTitle,
              )),
              IconPrimaryButton(
                  context: context,
                  isEnabled: true,
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month - 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                  paddingHorizontal: 0,
                  icon: Icons.arrow_back_ios_new),
              const SizedBox(
                width: 8,
              ),
              IconPrimaryButton(
                  context: context,
                  isEnabled: true,
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month + 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                  paddingHorizontal: 0,
                  icon: Icons.arrow_forward_ios),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              setState(() => _currentDate = date);
            },
            weekendTextStyle: const TextStyle(
              color: Colors.red,
            ),
            weekdayTextStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            dayPadding: 0,
            thisMonthDayBorderColor: AppTheme.borderColor,
            selectedDayButtonColor: AppTheme.primaryColorLighter,
            customDayBuilder: (
              bool isSelectable,
              int index,
              bool isSelectedDay,
              bool isToday,
              bool isPrevMonthDay,
              TextStyle textStyle,
              bool isNextMonthDay,
              bool isThisMonthDay,
              DateTime day,
            ) {
              return null;
            },
            weekFormat: false,
            markedDatesMap: _markedDateMap,
            height: 310.0,
            targetDateTime: _targetDateTime,
            selectedDateTime: _currentDate,
            disableDayPressed: true,
            showHeader: false,
            customGridViewPhysics: const NeverScrollableScrollPhysics(),
            onCalendarChanged: (DateTime date) {
              setState(() {
                _targetDateTime = date;
                _currentMonth = DateFormat.yMMM().format(_targetDateTime);
              });
            },
            daysHaveCircularBorder: false,

            /// null for not rendering any border, true for circular border, false for rectangular border
          ),
        ),
      ],
    );
  }
}
