import 'package:flutter/material.dart';

class Compteur extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;

  const Compteur({

    Key? key,
    required this.completedTasks,
    required this.totalTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Text(
        "$completedTasks/$totalTasks",
        style: TextStyle(
            fontSize: 44, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
