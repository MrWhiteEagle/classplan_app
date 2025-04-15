import 'package:classplan_new/logic/db/event_database.dart';
import 'package:classplan_new/pages/events_subpages/event_create_page.dart';
import 'package:classplan_new/pages/events_subpages/event_list_page.dart';
import 'package:classplan_new/pages/events_subpages/events_main_page.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<EventDatabase>(context, listen: false).readEvents();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    //navigation for the navBar
    navigation(int index, BuildContext context) {
      switch (index) {
        case 0:
          Provider.of<EventDatabase>(context, listen: false).readEvents();
          return EventsMainPage(
            switchPageCallback: () {
              setState(() {
                currentPageIndex = 1;
              });
            },
          );
        case 1:
          Provider.of<EventDatabase>(context, listen: false).readEvents();
          return EventListPage();
      }
    }

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        overlayColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.tertiary,
        ),
        indicatorColor: Theme.of(context).colorScheme.tertiaryContainer,
        labelTextStyle: WidgetStatePropertyAll(
          onPrimaryBoldTextStyle(context).copyWith(fontSize: 12),
        ),
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.calendar_month, color: Colors.white),
            label: 'Główna',
          ),
          NavigationDestination(
            icon: Icon(Icons.list, color: Colors.white),
            label: 'Wydarzenia',
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
        title: Text('Wydarzenia', style: onPrimaryBoldTextStyle(context)),
        titleTextStyle: onPrimaryBoldTextStyle(context),
        centerTitle: true,
        actions: [
          TextButton.icon(
            label: Text(
              'Dodaj',
              style: onPrimaryBoldTextStyle(context).copyWith(fontSize: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventCreatePage()),
              );
            },
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: navigation(currentPageIndex, context),
    );
  }
}
