import 'package:exercies1/models/student.dart';
import 'package:flutter/material.dart';

class RowList extends StatelessWidget {
  final Student student;
  final Function() onTap;
  const RowList({super.key, required this.student, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                student.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                student.school,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ]),
            const Spacer(),
            IconButton(onPressed: onTap, icon: const Icon(Icons.update)),
          ],
        ),
      ),
    );
  }
}
