import 'package:classplan_new/logic/methods/gradeTypeConversion.dart';
import 'package:classplan_new/models/grade.dart';
import 'package:classplan_new/models/grade_database.dart';
import 'package:classplan_new/models/student.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//enum for selecting a tristate icon button for addition to the grade (-/none/+)
enum GradeAdditionState { minus, none, plus }

Future createGradeAlert(BuildContext context, Student student) {
  //new grade instance with empty/default values and an already written student id;
  Grade newGrade =
      Grade()
        ..studentId = student.studentId
        ..grade = ''
        ..type = GradeType.other
        ..gradeAdd = ''
        ..title = '';

  //a set of selections for the gradetype segmented button - default to other
  Set<String> gradeTypeSelection = {gradeTypeToString(newGrade.type)};

  final gradeNameContoller = TextEditingController();
  gradeNameContoller.clear();

  return showDialog(
    context: context,
    builder:
        (context) => StatefulBuilder(
          builder: (context, setState) {
            void receiveGradeAddFromTriStateButton(String value) {
              newGrade.gradeAdd = value;
              setState(() {});
            }

            Color getGradeTypeColor(GradeType type) {
              Color color = Theme.of(context).colorScheme.primary;
              switch (type) {
                case GradeType.test:
                  color = const Color.fromARGB(255, 207, 14, 0);
                case GradeType.quiz:
                  color = const Color.fromARGB(255, 0, 151, 5);
                case GradeType.activity:
                  color = const Color.fromARGB(255, 0, 140, 255);
                case GradeType.lesson:
                  color = const Color.fromARGB(255, 0, 194, 201);
                case GradeType.other:
                  color = const Color.fromARGB(255, 96, 36, 199);
              }
              return color;
            }

            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dodaj ocenę", style: primaryBoldTextStyle(context)),
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
                    controller: gradeNameContoller,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownMenu(
                        hintText: 'Ocena',
                        textStyle: higherContentTextStyle(
                          context,
                        ).copyWith(color: getGradeTypeColor(newGrade.type)),
                        inputDecorationTheme: InputDecorationTheme(
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                        ),
                        dropdownMenuEntries: <DropdownMenuEntry<int>>[
                          DropdownMenuEntry(value: 0, label: '0   nb/nz'),
                          DropdownMenuEntry(value: 1, label: '1   ndst'),
                          DropdownMenuEntry(value: 2, label: '2   dop'),
                          DropdownMenuEntry(value: 3, label: '3   dst'),
                          DropdownMenuEntry(value: 4, label: '4   db'),
                          DropdownMenuEntry(value: 5, label: '5   bdb'),
                          DropdownMenuEntry(value: 6, label: '6   cel'),
                        ],
                        onSelected: (value) {
                          setState(() {
                            newGrade.grade = value.toString();
                          });
                        },
                      ),
                      SizedBox(width: 75),
                      Column(
                        children: [
                          Text(
                            '+/-',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          GradeAddTriStateWidget(
                            onUpdate: receiveGradeAddFromTriStateButton,
                            gradeAdd: newGrade.gradeAdd,
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
                            return const Color.fromARGB(
                              255,
                              207,
                              14,
                              0,
                            ); // Set color for "T"
                          } else if (gradeTypeSelection.contains("K")) {
                            return const Color.fromARGB(
                              255,
                              0,
                              151,
                              5,
                            ); // Set color for "K"
                          } else if (gradeTypeSelection.contains("A")) {
                            return const Color.fromARGB(
                              255,
                              0,
                              140,
                              255,
                            ); // Set color for "A"
                          } else if (gradeTypeSelection.contains("P")) {
                            return const Color.fromARGB(
                              255,
                              0,
                              194,
                              201,
                            ); // Set color for "P"
                          } else if (gradeTypeSelection.contains("I")) {
                            return const Color.fromARGB(
                              255,
                              96,
                              36,
                              199,
                            ); // Set color for "I"
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
                        newGrade.type = stringToGradeType(newSel.join(''));
                      });
                    },
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  child: Text('Anuluj'),
                  onPressed: () {
                    gradeNameContoller.clear();
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  onPressed: () {
                    newGrade.title = gradeNameContoller.text;
                    Provider.of<GradeDatabase>(
                      context,
                      listen: false,
                    ).createGrade(student.studentId, newGrade);
                    gradeNameContoller.clear();
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
  const GradeAddTriStateWidget({
    super.key,
    required this.onUpdate,
    required this.gradeAdd,
  });
  final Function(String) onUpdate;
  final String gradeAdd;
  @override
  State<GradeAddTriStateWidget> createState() => _GradeAddTriStateWidgetState();
}

class _GradeAddTriStateWidgetState extends State<GradeAddTriStateWidget> {
  //initial value + variable for storing;
  late String localGradeAdd;

  @override
  void initState() {
    super.initState();
    localGradeAdd = widget.gradeAdd;
  }

  void toggleState() {
    setState(() {
      switch (localGradeAdd) {
        case '-':
          localGradeAdd = '';
        case '':
          localGradeAdd = '+';
        case '+':
          localGradeAdd = '-';
      }
      ;
    });
    widget.onUpdate(localGradeAdd);
  }

  IconData getIconForState() {
    switch (localGradeAdd) {
      case '-':
        return Icons.remove_circle_outline;
      case '':
        return Icons.circle_outlined;
      case '+':
        return Icons.add_circle_outline;
      default:
        return Icons.circle_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleState,
      child: Icon(
        getIconForState(),
        color: Theme.of(context).colorScheme.primary,
        size: 30,
      ),
    );
  }
}
