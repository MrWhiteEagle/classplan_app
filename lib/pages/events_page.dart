import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
        title: Text('Wydarzenia'),
        titleTextStyle: onPrimaryBoldTextStyle(context),
        centerTitle: true,
      ),
    );
  }
}
