import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';

class EventCreatePage extends StatelessWidget {
  const EventCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    DateTime selectedDate = today;
    TimeOfDay time = TimeOfDay.now();
    TimeOfDay reminderTime = TimeOfDay(
      hour: time.hour - 1,
      minute: time.minute,
    );

    final eventNameCtrl = TextEditingController();
    final eventDescCtrl = TextEditingController();

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
                        showDatePicker(
                          context: context,
                          firstDate: today,
                          lastDate: DateTime(
                            today.year + 2,
                            today.month,
                            today.day,
                          ),
                        );
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
                        showTimePicker(
                          context: context,
                          initialTime: reminderTime,
                        );
                      },
                      label: Text(
                        '${time.hour}:${time.minute}',
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
                        showTimePicker(
                          context: context,
                          initialTime: reminderTime,
                        );
                      },
                      label: Text(
                        '${reminderTime.hour}:${reminderTime.minute}',
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
                      onPressed: () {},
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
