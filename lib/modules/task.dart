import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/shared/components.dart';
import 'package:todo/shared/consistant.dart';

class Task extends StatefulWidget {
  Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  // bool checked = false;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => buildTaskItems(
              tasks[index],
            ),
        separatorBuilder: (context, index) => Divider(
              height: 5,
              indent: 20,
              endIndent: 10,
              color: Colors.grey[400],
            ),
        itemCount: tasks.length);
  }
}
