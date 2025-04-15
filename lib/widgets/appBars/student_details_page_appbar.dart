import 'package:classplan_new/logic/db/grade_database.dart';
import 'package:classplan_new/models/student.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/student_grade_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDetailsPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const StudentDetailsPageAppBar({
    super.key,
    required this.sortButtonKey,
    required this.student,
  });

  final GlobalKey<State<StatefulWidget>> sortButtonKey;
  final Student? student;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
      title: Text(
        student != null
            ? 'Informacje o uczniu'
            //error - student is null appbar indicator
            : 'Błąd, Nie można załadować informacji',
        style: onPrimaryBoldTextStyle(context),
      ),
      actions: [
        IconButton(
          onPressed:
              () => deletionConfirmationDialog(
                context,
                student!.studentId,
                '${student!.name} ${student!.lastName}',
              ),
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
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
                          () => Provider.of<GradeDatabase>(
                            context,
                            listen: false,
                          ).readStudentGrades(student!.studentId),
                    ),
                    PopupMenuItem(
                      child: Text(
                        'Po Nazwie',
                        style: primaryTextStyle(context).copyWith(fontSize: 15),
                      ),
                      onTap:
                          () =>
                              Provider.of<GradeDatabase>(
                                context,
                                listen: false,
                              ).sortGradesByTitle(),
                    ),
                    PopupMenuItem(
                      child: Text(
                        'Po Typie',
                        style: primaryTextStyle(context).copyWith(fontSize: 15),
                      ),
                      onTap:
                          () =>
                              Provider.of<GradeDatabase>(
                                context,
                                listen: false,
                              ).sortGradesByType(),
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
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
