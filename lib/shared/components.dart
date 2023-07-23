import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit.dart';

Widget buildTaskItems(
  Map model,
  context, {
  Function? checked,
}) =>
    Dismissible(
      key: Key(model['id'].toString()),
      background: model['status'] == 'new'
          ? buildSwipeActionLeft()
          : buildSwipeActionLeft(icon: Icons.delete, col: Colors.red),
      secondaryBackground: model['status'] != "archive"
          ? buildSwipeActionRight()
          : buildSwipeActionRight(icon: Icons.delete, col: Colors.red),
      onDismissed: (direction) {
        if (model['status'] == 'new') {
          if (direction == DismissDirection.endToStart) {
            AppCubit.get(context)
                .updateData(status: 'archive', id: model['id']);
          } else {
            AppCubit.get(context).updateData(status: 'Done', id: model['id']);
          }
        } else if (model['status'] == 'Done') {
          if (direction == DismissDirection.endToStart) {
            AppCubit.get(context)
                .updateData(status: 'archive', id: model['id']);
          } else if (direction == DismissDirection.down) {}
        } else if (model['status'] == 'archive') {
          AppCubit.get(context).deletaData(id: model['id']);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']} ${model['time']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    textAlign: TextAlign.justify,
                    '${model['description']}',
                    style: TextStyle(fontSize: 19, color: Colors.black38),
                  ),
                ],
              ),
            ),
            Align(
                child: model['status'] == 'new'
                    ? IconButton(
                        onPressed: () {
                          AppCubit.get(context).deletaData(id: model['id']);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 27,
                        ))
                    : Container())
          ],
        ),
      ),
    );

Widget buildSwipeActionLeft({
  IconData icon = Icons.done_sharp,
  Color col = Colors.green,
}) =>
    Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: col,
      child: Icon(
        icon,
        size: 35,
        color: Colors.white,
      ),
    );

Widget buildSwipeActionRight({
  IconData icon = Icons.archive_sharp,
  Color col = Colors.black45,
}) =>
    Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: col,
      child: Icon(
        icon,
        size: 35,
        color: Colors.white,
      ),
    );

Widget buildConditionIFNoDatabase({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.builder(
          itemBuilder: (context, index) {
            return buildTaskItems(tasks[index], context);
          },
          itemCount: tasks.length),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book,
              size: 200,
              color: Colors.blueGrey,
            ),
            Text(
              'No Tasks Yet, Add Your Tasks Now!',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontFamily: 'Kalam',
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
