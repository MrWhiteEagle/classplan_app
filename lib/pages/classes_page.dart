import 'package:classplan_new/models/class_database.dart';
import 'package:classplan_new/pages/class_details_page.dart';
// ignore: unused_import
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final textController = TextEditingController();
  GlobalKey sortButtonKey = GlobalKey();

  //Sorting types for classlist
  //0 == default from db
  //1 == alpha
  //2 == anti-alpha
  int sortType = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<ClassDatabase>(context, listen: false).readClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista klas"),
        titleTextStyle: onPrimaryBoldTextStyle(context),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
        actions: [
          TextButton.icon(
            key: sortButtonKey,
            label: Text(
              'Sortuj',
              style: onPrimaryTextStyle(context).copyWith(fontSize: 15),
            ),
            icon: Icon(
              Icons.sort,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              final RenderBox buttonRender =
                  sortButtonKey.currentContext!.findRenderObject() as RenderBox;
              final Offset offset = buttonRender.localToGlobal(Offset.zero);

              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  offset.dx,
                  offset.dy + buttonRender.size.height,
                  offset.dx + buttonRender.size.width,
                  offset.dy + buttonRender.size.height * 2,
                ),
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                items: [
                  PopupMenuItem(
                    child: Text(
                      'Domyślne',
                      style: primaryTextStyle(context).copyWith(fontSize: 15),
                    ),
                    onTap:
                        () =>
                            Provider.of<ClassDatabase>(
                              context,
                              listen: false,
                            ).readClasses(),
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Alfabetycznie',
                      style: primaryTextStyle(context).copyWith(fontSize: 15),
                    ),
                    onTap:
                        () =>
                            Provider.of<ClassDatabase>(
                              context,
                              listen: false,
                            ).sortClassesAlpha(),
                  ),
                  PopupMenuItem(
                    child: Text(
                      'A-Alfabetycznie',
                      style: primaryTextStyle(context).copyWith(fontSize: 15),
                    ),
                    onTap:
                        () =>
                            Provider.of<ClassDatabase>(
                              context,
                              listen: false,
                            ).sortClassesRevAlpha(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createClass(context, textController),
        child: Icon(Icons.add),
      ),
      //Consumer causes rebuild on every classDatabase entry change
      body: Consumer<ClassDatabase>(
        builder: (context, classDatabase, child) {
          //Read classes on every rebuild
          // classDatabase.readClasses();
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: classDatabase.classList.length,
            itemBuilder: (context, index) {
              //get every class iteration
              final classObj = classDatabase.classList[index];

              //return every class as a card
              return Card(
                elevation: 5,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: ListTile(
                  title: Text(
                    classObj.name,
                    style: onPrimaryBoldContainerTextStyle(
                      context,
                    ).copyWith(fontSize: 20),
                  ),
                  subtitle: Text(
                    classObj.careTeacher == ''
                        ? "Wychowawca: Nie podano"
                        : "Wychowawca: ${classObj.careTeacher}",
                    style: onPrimaryBoldContainerTextStyle(
                      context,
                    ).copyWith(fontSize: 16),
                  ),
                  trailing: Icon(
                    Icons.groups,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  ClassDetailsPage(classId: classObj.id),
                        ),
                      ).then((_) => classDatabase.readClasses()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void createClass(BuildContext context, TextEditingController textController) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          title: Text(
            "Nazwij nową klasę:",
            style: primaryBoldTextStyle(context).copyWith(fontSize: 20),
          ),
          content: TextField(controller: textController),
          actions: [
            MaterialButton(
              child: Text(
                "Anuluj",
                style: onSurfaceTextStyle(context).copyWith(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pop(context);
                textController.clear();
              },
            ),
            TextButton.icon(
              label: Text(
                "Utwórz",
                style: tertiaryBoldContainerTextStyle(
                  context,
                ).copyWith(fontSize: 18),
              ),
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              onPressed: () {
                //Add class to database
                Provider.of<ClassDatabase>(
                  context,
                  listen: false,
                ).addClass(textController.text);
                Navigator.pop(context);
                textController.clear();
              },
            ),
          ],
        ),
  );
}
