import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/event_calendar.dart';
import 'package:classplan_new/widgets/event_grid_tile.dart';
import 'package:flutter/material.dart';

class EventsMainPage extends StatefulWidget {
  final VoidCallback switchPageCallback;
  const EventsMainPage({super.key, required this.switchPageCallback});

  @override
  State<EventsMainPage> createState() => _EventsMainPageState();
}

class _EventsMainPageState extends State<EventsMainPage> {
  //final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Najbliższe',
              textAlign: TextAlign.center,
              style: onPrimaryBoldTextStyle(context).copyWith(fontSize: 20),
            ),
          ),
        ),
        Flexible(
          child: GridView(
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            children: [
              EventGridTile(),
              EventMoreTile(switchPageCallback: widget.switchPageCallback),
            ],
          ),
        ),
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Kalendarz',
              style: onPrimaryBoldTextStyle(context).copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        EventCalendar(),
      ],
    );
  }
}
