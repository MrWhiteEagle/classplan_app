import 'package:classplan_new/logic/db/event_database.dart';
import 'package:classplan_new/models/event.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCreatePage extends StatefulWidget {
  const EventCreatePage({super.key});

  @override
  State<EventCreatePage> createState() => _EventCreatePageState();
}

class _EventCreatePageState extends State<EventCreatePage> {
  DateTime today = DateTime.now();
  late DateTime selectedDate;
  TimeOfDay selectedTime = TimeOfDay.now();
  late TimeOfDay reminderTime;

  final eventNameCtrl = TextEditingController();
  final eventDescCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = today;
    reminderTime = TimeOfDay(
      hour: selectedTime.hour - 1,
      minute: selectedTime.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nowe Wydarzenie'),
        titleTextStyle: onPrimaryBoldTextStyle(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tytuł:',
                      style: primaryBoldTextStyle(
                        context,
                      ).copyWith(fontSize: 18),
                    ),
                    SizedBox(width: 30),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: eventNameCtrl,
                        maxLength: 30,
                        decoration: InputDecoration(
                          label: Text('Nazwa'),
                          labelStyle: TextStyle(color: Colors.grey),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelStyle: primaryTextStyle(
                            context,
                          ).copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Opis',
                  style: primaryBoldTextStyle(context).copyWith(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: eventDescCtrl,
                  decoration: InputDecoration(
                    labelText: 'Treść',
                    labelStyle: TextStyle(color: Colors.grey),
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    floatingLabelStyle: primaryTextStyle(
                      context,
                    ).copyWith(fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Data:',
                        style: primaryBoldTextStyle(
                          context,
                        ).copyWith(fontSize: 18),
                      ),
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      onPressed: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          firstDate: selectedDate,
                          lastDate: DateTime(
                            today.year + 2,
                            today.month,
                            today.day,
                          ),
                        );
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                          });
                        }
                      },
                      label: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: secondaryTextStyle(
                          context,
                        ).copyWith(fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      iconAlignment: IconAlignment.end,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Godzina:',
                        style: primaryBoldTextStyle(
                          context,
                        ).copyWith(fontSize: 18),
                      ),
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      onPressed: () async {
                        final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (time != null) {
                          setState(() {
                            selectedTime = time;
                          });
                        }
                      },
                      label: Text(
                        selectedTime.format(context),
                        style: secondaryTextStyle(
                          context,
                        ).copyWith(fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.schedule,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      iconAlignment: IconAlignment.end,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Przypomnienie:',
                      style: primaryBoldTextStyle(
                        context,
                      ).copyWith(fontSize: 18),
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      onPressed: () async {
                        final TimeOfDay? reminder = await showTimePicker(
                          context: context,
                          initialTime: reminderTime,
                        );
                        if (reminder != null) {
                          setState(() {
                            reminderTime = reminder;
                          });
                        }
                      },
                      label: Text(
                        reminderTime.format(context),
                        style: secondaryTextStyle(
                          context,
                        ).copyWith(fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.schedule,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      iconAlignment: IconAlignment.end,
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        eventNameCtrl.clear();
                        eventDescCtrl.clear();
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: Text('Anuluj'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final DateTime finalDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                        final DateTime finalReminder = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          reminderTime.hour,
                          reminderTime.minute,
                        );
                        debugPrint(finalDateTime.toString());
                        debugPrint(finalReminder.toString());
                        final Event newEvent =
                            Event()
                              ..title = eventNameCtrl.text
                              ..description = eventDescCtrl.text
                              ..date = finalDateTime
                              ..reminder = finalReminder;
                        await Provider.of<EventDatabase>(
                          context,
                          listen: false,
                        ).createEvent(newEvent);
                        await Provider.of<EventDatabase>(
                          context,
                          listen: false,
                        ).readEvents();
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: Text('Zapisz'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void throwErrorNotify(int i, BuildContext context) {
  // switch (i) {
  //   case 0:
  //     Fluttertoast.showToast(
  //       msg: 'Puste pole: Tytuł',
  //       backgroundColor: Theme.of(context).colorScheme.error,
  //     );
  //   case 1:
  //     Fluttertoast.showToast(
  //       msg: 'Wybrano przeszłą datę.',
  //       backgroundColor: Theme.of(context).colorScheme.error,
  //     );
  //   case 2:
  //     Fluttertoast.showToast(
  //       msg: 'Przypomnienie nie może być później niż wybrana godzina',
  //       backgroundColor: Theme.of(context).colorScheme.error,
  //     );
  // }
}
