import 'package:flutter/material.dart';

Widget buildTaskItems(
  Map model,
  {
  Function? checked,
  
}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Text(
              '${model['id']}',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            radius: 25,
            backgroundColor: Color.fromARGB(255, 104, 145, 165),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  maxLines: 1,
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  '${model['description']}',
                  style: TextStyle(fontSize: 19, color: Colors.black38),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          fillColor: MaterialStatePropertyAll(Colors.green),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          checkColor: Color.fromARGB(255, 15, 59, 94),
                          value: false,
                          onChanged: (value) {
                            checked;
                          }),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
