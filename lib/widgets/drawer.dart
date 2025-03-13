import 'package:classplan_new/pages/classes_page.dart';
import 'package:flutter/material.dart';
import 'package:classplan_new/pages/settings_page.dart';

class UniversalDrawer extends StatelessWidget {
  const UniversalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Container(
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                "C L A S S P L A N",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.book_outlined),
            title: Text("K L A S Y"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ClassesPage();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_month_outlined),
            title: Text("W Y D A R Z E N I A"),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text("Z B I Ó R K I"),
          ),
          ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text("T E S T Y  I  K A R T K Ó W K I"),
          ),
          ListTile(leading: Icon(Icons.edit), title: Text("Z A D A N I A")),
          SizedBox(height: 60),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("U S T A W I E N I A"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsPage();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("O   A P L I K A C J I"),
          ),
        ],
      ),
    );
  }
}
