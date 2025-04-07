import 'package:classplan_new/models/class_database.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassDetailsPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ClassDetailsPageAppBar({
    super.key,
    required this.classId,
    required this.sortButtonKey,
  });

  final int classId;
  final GlobalKey<State<StatefulWidget>> sortButtonKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
      backgroundColor: Theme.of(context).colorScheme.primary,
      centerTitle: false,
      title: Text(
        "Informacje o klasie",
        style: onPrimaryBoldTextStyle(context),
      ),
      actions: [
        IconButton(
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            Provider.of<StudentDatabase>(
              context,
              listen: false,
            ).deleteClassFromAllStudents(classId);
            Provider.of<ClassDatabase>(
              context,
              listen: false,
            ).deleteClass(classId);
            Navigator.pop(context);
          },
          icon: Icon(Icons.delete),
        ),
        TextButton.icon(
          key: sortButtonKey,
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (sortButtonKey.currentContext != null) {
                final RenderBox buttonRender =
                    sortButtonKey.currentContext!.findRenderObject()
                        as RenderBox;
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
                          () => Provider.of<StudentDatabase>(
                            context,
                            listen: false,
                          ).readStudents(classId),
                    ),
                    PopupMenuItem(
                      child: Text(
                        'Po imieniu',
                        style: primaryTextStyle(context).copyWith(fontSize: 15),
                      ),
                      onTap:
                          () =>
                              Provider.of<StudentDatabase>(
                                context,
                                listen: false,
                              ).sortStudentsAlpha(),
                    ),
                    PopupMenuItem(
                      child: Text(
                        'Po nazwisku',
                        style: primaryTextStyle(context).copyWith(fontSize: 15),
                      ),
                      onTap:
                          () =>
                              Provider.of<StudentDatabase>(
                                context,
                                listen: false,
                              ).sortStudentsLastNameAlpha(),
                    ),
                  ],
                );
              } else {
                debugPrint('Button not laid out');
              }
            });
          },
          label: Text(
            'Sortuj',
            style: onPrimaryTextStyle(context).copyWith(fontSize: 15),
          ),
          icon: Icon(
            Icons.sort,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
