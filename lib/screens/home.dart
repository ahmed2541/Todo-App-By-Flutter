import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/modules/arcieved_task.dart';
import 'package:todo/modules/completed_task.dart';
import 'package:todo/modules/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import '../shared/consistant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> screens = [Task(), Completed(), Arcived()];
  List<String> title = ["Tasks", "Completed Tasks", "Archived tasks"];
  static const Color color = Color.fromARGB(255, 8, 83, 144);

  Database? database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.edit;

  @override
  void initState() {
    super.initState();
    CreateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: color,
        leading: Text(''),
        title: Text(
          title[currentIndex],
          style: TextStyle(fontSize: 25),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            if (isBottomSheetShow) {
              if (formKey.currentState!.validate()) {
                insertToDatabase(
                        title: titleController.text,
                        description: descriptionController.text,
                        time: timeController.text,
                        date: dateController.text)
                    .then((value) {
                  getDataFromDatabase(database).then((value) {
                    Navigator.pop(context);

                    setState(() {
                      isBottomSheetShow = false;
                      tasks = value;
                      fabIcon = Icons.edit;
                      print(tasks); 
                    });
                  });
                });
              }
            } else {
              scaffoldKey.currentState!
                  .showBottomSheet(
                      elevation: 15,
                      (context) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              color: Colors.blue.withOpacity(0.2),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      cursorColor:
                                          Color.fromARGB(255, 0, 42, 77),
                                      controller: titleController,
                                      keyboardType: TextInputType.text,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'title must not be empty';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Task Tile',
                                          prefixIcon: Icon(Icons.title),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      onTap: () {
                                        print('title tapped');
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      cursorColor:
                                          Color.fromARGB(255, 0, 42, 77),
                                      controller: descriptionController,
                                      keyboardType: TextInputType.text,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'description must not be empty';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Task Description',
                                          prefixIcon: Icon(Icons.description),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      onTap: () {
                                        print('description tapped');
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      cursorColor:
                                          Color.fromARGB(255, 0, 42, 77),
                                      controller: timeController,
                                      keyboardType: TextInputType.datetime,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'time must not be empty';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Task Time',
                                          prefixIcon:
                                              Icon(Icons.watch_later_outlined),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeController.text =
                                              value!.format(context).toString();
                                          // print(value!.format(context));
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      cursorColor:
                                          Color.fromARGB(255, 0, 42, 77),
                                      controller: dateController,
                                      keyboardType: TextInputType.datetime,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Date must not be empty';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Task Date',
                                          prefixIcon:
                                              Icon(Icons.watch_later_outlined),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2023-08-14'))
                                            .then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                  .closed
                  .then((value) {
                isBottomSheetShow = false;
                setState(() {
                  fabIcon = Icons.edit;
                });
              });
              isBottomSheetShow = true;
              setState(() {
                fabIcon = Icons.add;
              });
            }
          },
          backgroundColor: color,
          elevation: 0,
          child: Icon(fabIcon)),
      body: ConditionalBuilder(
        condition: tasks.length > 0,
        builder: (context) => screens[currentIndex],
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 232, 232, 232),
          selectedFontSize: 17,
          elevation: 2,
          selectedItemColor: Color.fromARGB(255, 56, 167, 222),
          unselectedItemColor: color,
          currentIndex: currentIndex,
          iconSize: 26,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.task),
                label: 'Task',
                backgroundColor: Colors.transparent),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.done,
                ),
                label: 'Completed'),
            BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Arcive'),
          ]),
    );
  }

  void CreateDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,description  TEXT, date TEXT, time TEXT, status TEXT )')
            .then((value) {
          print('db created');
        }).catchError((error) {
          print('Error when db created ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          setState(() {
            tasks = value;
          });
          // print(tasks);
        });
        print('database opened');
      },
    );
  }

  Future insertToDatabase({
    @required String? title,
    @required String? description,
    @required String? time,
    @required String? date,
  }) async {
    return await database!
        .transaction((txn) => txn.rawInsert(
            'INSERT INTO tasks (title,description, date, time ,status) VALUES ("$title","$description","$date","$time","new")'))
        .then((value) {
      print('$value inserted successfully');
    }).catchError((error) {
      print('Error when db created ${error.toString()}');
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database!.rawQuery("SELECT * FROM tasks");
  }
}
