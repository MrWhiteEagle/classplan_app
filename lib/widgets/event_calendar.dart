import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:classplan_new/themes/app_theme.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key});

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  DateTime today = DateTime.now();
  DateTime? pickedDay;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'pl_PL',
      focusedDay: pickedDay ?? today,
      selectedDayPredicate: (day) {
        return isSameDay(pickedDay, day);
      },
      firstDay: DateTime(2025, 1, 1),
      lastDay: DateTime(today.year + 2, today.month, today.day),
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextFormatter: (date, locale) => formatMonthYear(date),
        // titleTextStyle: tertiaryBoldContainerTextStyle(
        //   context,
        // ).copyWith(fontSize: 20),
        leftChevronPadding: EdgeInsets.all(15),
        rightChevronPadding: EdgeInsets.all(15),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: Theme.of(context).colorScheme.primary,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      daysOfWeekHeight: 50,
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          pickedDay = selectedDay;
        });
      },
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          shape: BoxShape.circle,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        //CUSTOM BUILDER FOR TODAY HIGHLIGHT
        defaultBuilder: (context, day, focusedDay) {
          final isToday = isSameDay(day, today);
          if (isToday) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      width: 2,
                    ),
                  ),
                  width: 38,
                  height: 38,
                ),
                Center(
                  child: Text(
                    '${day.day}',
                    style: onSurfaceTextStyle(context).copyWith(fontSize: 16),
                  ),
                ),
              ],
            );
          } else {
            return null;
          }
        },
      ),
    );
  }
}

String formatMonthYear(DateTime date) {
  final year = DateFormat('yyyy').format(date); // Get the year
  final monthIndex = date.month - 1; // Month index (0-11)
  final polishMonths = [
    'Styczeń',
    'Luty',
    'Marzec',
    'Kwiecień',
    'Maj',
    'Czerwiec',
    'Lipiec',
    'Sierpień',
    'Wrzesień',
    'Październik',
    'Listopad',
    'Grudzień',
  ];
  final monthName = polishMonths[monthIndex]; // Get the correct month name
  return '$monthName $year'; // Combine and return
}
