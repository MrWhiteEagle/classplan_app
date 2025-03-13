import 'package:classplan_new/widgets/appBar.dart';
import 'package:classplan_new/widgets/drawer.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBar(title: "Strona Główna"),
      drawer: UniversalDrawer(),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridTile(
              child: Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    side: BorderSide(
                      color:
                          Color.lerp(
                            Theme.of(context).colorScheme.primary,
                            Colors.white,
                            0.2,
                          )!,
                      width: 5,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 45,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "K L A S Y",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
