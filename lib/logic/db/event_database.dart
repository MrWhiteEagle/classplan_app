import 'package:classplan_new/logic/isar_service.dart';
import 'package:classplan_new/models/event.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class EventDatabase extends ChangeNotifier {
  final isarService = IsarService();
  final List<Event> fetchedEvents = [];
  final List<Event> dayFetchedEvents = [];
  Event? fetchedEvent;

  //CREATE EVENT
  Future<void> createEvent(Event newEvent) async {
    if (newEvent != null) {
      await isarService.isar.writeTxn(
        () => isarService.isar.events.put(newEvent),
      );
      debugPrint('Created new event: ${newEvent.title}');
    } else {
      debugPrint('New event was null, not saved.');
    }
    notifyListeners();
  }

  //FETCH ALL EVENTS
  Future<void> readEvents() async {
    final events = await isarService.isar.events.where().findAll();
    fetchedEvents.clear();
    fetchedEvents.addAll(events);
    debugPrint('[READ] Fetched ${events.length} events!');
  }

  //FETCH ALL EVENTS BY DAY
  Future<void> fetchEventsByDate(DateTime date) async {
    final startDay = DateTime(date.year, date.month, date.day);
    final endDay = startDay.add(const Duration(days: 1));
    final events =
        await isarService.isar.events
            .filter()
            .dateBetween(startDay, endDay)
            .findAll();
    dayFetchedEvents.clear();
    dayFetchedEvents.addAll(events);
    notifyListeners();
  }

  //FETCH ONE EVGENT
  Future<void> fetchEvent(int id) async {
    final event = await isarService.isar.events.get(id);
    if (event != null) {
      fetchedEvent = event;
      debugPrint('[READ] Found event ${event.title}! id: ${event.id}');
    } else {
      debugPrint('[ERROR][READ] Fetched event was null');
    }
    notifyListeners();
  }

  //UPDATE EVENT
  Future<void> updateEvent(Event event) async {
    final newEvent = event;
    debugPrint(
      '[UPDATE] Starting updating sequence for event ${event.title} id:${event.id}',
    );
    await isarService.isar.writeTxn(
      () => isarService.isar.events.put(newEvent),
    );
    debugPrint('[UPDATE] Update event successful!');
    notifyListeners();
  }

  //DELETE EVENT
  Future<void> deleteEvent(int id) async {
    debugPrint('[DELETE] Starting delete of event ${id}');
    await isarService.isar.writeTxn(() => isarService.isar.events.delete(id));
    debugPrint('[DELETE] Sequence finished!');
    notifyListeners();
  }

  //RESET EVENT DB
  Future<void> resetEventDatabase() async {
    debugPrint('[RESET] RESETTING EVENT DATABASE...');
    await isarService.isar.writeTxn(() => isarService.isar.events.clear());
    debugPrint('[RESET] Reset sequence done');
    notifyListeners();
  }
}
