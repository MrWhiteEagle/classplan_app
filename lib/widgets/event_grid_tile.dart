import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';

class EventGridTile extends StatelessWidget {
  const EventGridTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Container(
        padding: EdgeInsets.all(10),
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Zebranie z rodzicami',
              textAlign: TextAlign.center,
              style: onPrimaryBoldContainerTextStyle(
                context,
              ).copyWith(fontSize: 18),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '14',
                  style: onPrimaryContainerTextStyle(
                    context,
                  ).copyWith(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'MAJ',
                    style: onPrimaryContainerTextStyle(
                      context,
                    ).copyWith(fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EventMoreTile extends StatelessWidget {
  final VoidCallback switchPageCallback;
  const EventMoreTile({super.key, required this.switchPageCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switchPageCallback();
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Container(
          padding: EdgeInsets.all(10),
          width: 100,
          height: 100,
          child: Center(
            child: Text(
              'Wszystkie...',
              style: onPrimaryBoldContainerTextStyle(
                context,
              ).copyWith(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
