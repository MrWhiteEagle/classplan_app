import 'package:classplan_new/logic/methods/gradeTypeConversion.dart';
import 'package:classplan_new/models/grade_database.dart';
import 'package:classplan_new/models/student.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//enum for selecting a tristate icon button for addition to the grade (-/none/+)
enum GradeAdditionState { minus, none, plus }

Future createGrade(
  BuildContext context,
  TextEditingController gradeIdCtrl,
  Student student,
) {
  //a set of selections for the gradetype segmented button
  Set<String> gradeTypeSelection = {'I'};

  //Final grade properties
  String gradeVal = '';
  String gradeType = 'I';
  String gradeAdd = '';

  return showDialog(
    context: context,
    builder:
        (context) => StatefulBuilder(
          builder: (context, setState) {
            void receiveGradeAddFromTriStateButton(String value) {
              gradeAdd = value;
              setState(() {});
            }

            Color getGradeTypeColor(String type) {
              Color color = Theme.of(context).colorScheme.primary;
              switch (type) {
                case 'T':
                  color = Colors.red;
                case 'K':
                  color = Colors.green;
                case 'A':
                  color = Colors.blue;
                case 'P':
                  color = Colors.lightBlue;
                case 'I':
                  color = Colors.deepPurple;
                default:
                  color = Theme.of(context).colorScheme.primary;
              }
              return color;
            }

            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dodaj ocenę"),
                  Icon(
                    Icons.assignment_add,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Nazwa oceny",
                    style: higherContentTextStyle(
                      context,
                    ).copyWith(fontSize: 14),
                  ),
                  TextField(
                    controller: gradeIdCtrl,
                    style: higherContentTextStyle(
                      context,
                    ).copyWith(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: "np. Praca na lekcji 1",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade500),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownMenu(
                        hintText: 'Ocena',
                        textStyle: higherContentTextStyle(
                          context,
                        ).copyWith(color: getGradeTypeColor(gradeType)),
                        inputDecorationTheme: InputDecorationTheme(
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                        ),
                        dropdownMenuEntries: <DropdownMenuEntry<int>>[
                          DropdownMenuEntry(value: 0, label: '0   (nb/nz)'),
                          DropdownMenuEntry(value: 1, label: '1   (ndst)'),
                          DropdownMenuEntry(value: 2, label: '2   (dop)'),
                          DropdownMenuEntry(value: 3, label: '3   (dst)'),
                          DropdownMenuEntry(value: 4, label: '4   (db)'),
                          DropdownMenuEntry(value: 5, label: '5   (bdb)'),
                          DropdownMenuEntry(value: 6, label: '6   (cel)'),
                        ],
                        onSelected: (value) {
                          setState(() {
                            gradeVal = value.toString();
                          });
                        },
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          Text(
                            '+/-',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GradeAddTriStateWidget(
                            onUpdate: receiveGradeAddFromTriStateButton,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  SegmentedButton<String>(
                    showSelectedIcon: false,
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(
                        BorderSide(
                          color:
                              Colors
                                  .transparent, //Theme.of(context).colorScheme.primary,
                          width: 0,
                        ),
                      ),
                      elevation: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return 6.0;
                        }
                        return 2.0;
                      }),
                      backgroundColor: WidgetStateProperty.resolveWith((
                        states,
                      ) {
                        Color defCol =
                            Color.lerp(
                              Theme.of(context).colorScheme.primary,
                              Colors.white,
                              0.9,
                            )!;

                        if (states.contains(WidgetState.selected)) {
                          // You can return different colors based on the selected value
                          if (gradeTypeSelection.contains("T")) {
                            return Colors.red; // Set color for "T"
                          } else if (gradeTypeSelection.contains("K")) {
                            return Colors.green; // Set color for "K"
                          } else if (gradeTypeSelection.contains("A")) {
                            return Colors.blue; // Set color for "A"
                          } else if (gradeTypeSelection.contains("P")) {
                            return Colors.lightBlue; // Set color for "P"
                          } else if (gradeTypeSelection.contains("I")) {
                            return Colors.deepPurple; // Set color for "I"
                          }
                        }
                        return defCol; // Default color when not selected
                      }),
                    ),

                    segments: [
                      ButtonSegment(
                        value: "T",
                        label: Text(
                          "T",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ButtonSegment(
                        value: "K",
                        label: Text(
                          "K",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ButtonSegment(
                        value: "A",
                        label: Text(
                          "A",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ButtonSegment(
                        value: "P",
                        label: Text(
                          "P.N.L.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ButtonSegment(
                        value: "I",
                        label: Text(
                          "Inne",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    selected: gradeTypeSelection,
                    onSelectionChanged: (Set<String> newSel) {
                      setState(() {
                        gradeTypeSelection = newSel;
                        gradeType = newSel.join('');
                      });
                    },
                  ),
                  Text('Ocena: $gradeVal$gradeAdd typ $gradeType'),
                ],
              ),
              actions: [
                MaterialButton(
                  child: Text('Anuluj'),
                  onPressed: () => Navigator.pop(context),
                ),
                MaterialButton(
                  onPressed: () {
                    Provider.of<GradeDatabase>(
                      context,
                      listen: false,
                    ).createGrade(
                      student.studentId,
                      gradeIdCtrl.text,
                      stringToGradeType(gradeType),
                      gradeVal,
                      gradeAdd,
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Zapisz', style: higherContentTextStyle(context)),
                ),
              ],
            );
          },
        ),
  );
}

class GradeAddTriStateWidget extends StatefulWidget {
  const GradeAddTriStateWidget({super.key, required this.onUpdate});
  final Function(String) onUpdate;
  @override
  State<GradeAddTriStateWidget> createState() => _GradeAddTriStateWidgetState();
}

class _GradeAddTriStateWidgetState extends State<GradeAddTriStateWidget> {
  //initial value + variable for storing
  GradeAdditionState checkstate = GradeAdditionState.none;
  String valueForParent = '';

  void toggleState() {
    setState(() {
      checkstate =
          GradeAdditionState.values[(checkstate.index + 1) %
              GradeAdditionState.values.length];
    });
    switch (checkstate) {
      case GradeAdditionState.minus:
        valueForParent = '-';
        break;
      case GradeAdditionState.none:
        valueForParent = '';
        break;
      case GradeAdditionState.plus:
        valueForParent = '+';
        break;
    }
    widget.onUpdate(valueForParent);
  }

  IconData getIconForState() {
    switch (checkstate) {
      case GradeAdditionState.minus:
        return Icons.remove_circle_outline;
      case GradeAdditionState.none:
        return Icons.circle_outlined;
      case GradeAdditionState.plus:
        return Icons.add_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleState,
      child: Icon(
        getIconForState(),
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
