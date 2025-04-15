import 'package:classplan_new/logic/db/event_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventDatabase>(
      builder: (context, eventsDb, child) {
        if (eventsDb.fetchedEvents.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text('Pusto tu coś....'),
                Text('Nie masz żadnych nadchodzących wydarzeń'),
              ],
            ),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(eventsDb.fetchedEvents[index].title),
              subtitle: Text(eventsDb.fetchedEvents[index].date.toString()),
            );
          },
        );
      },
    );
  }
}
