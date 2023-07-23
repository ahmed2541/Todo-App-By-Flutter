import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static const Color color = Color.fromARGB(255, 8, 83, 144);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: color,
              leading: Text(''),
              title: Text(
                cubit.title[cubit.currentIndex],
                style: TextStyle(fontSize: 25),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  if (cubit.isBottomSheetShow) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(
                          title: titleController.text,
                          description: descriptionController.text,
                          time: timeController.text,
                          date: dateController.text);
                      // Navigator.pop(context);
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                            elevation: 15,
                            (context) => Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    Positioned(
                                        top: -11,
                                        left: -11,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            size: 25,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )),
                                    Padding(
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
                                                cursorColor: Color.fromARGB(
                                                    255, 0, 42, 77),
                                                controller: titleController,
                                                keyboardType:
                                                    TextInputType.text,
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'title must not be empty';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    labelText: 'Task Tile',
                                                    prefixIcon:
                                                        Icon(Icons.title),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5))),
                                                onTap: () {
                                                  print('title tapped');
                                                },
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              TextFormField(
                                                cursorColor: Color.fromARGB(
                                                    255, 0, 42, 77),
                                                controller:
                                                    descriptionController,
                                                keyboardType:
                                                    TextInputType.text,
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return null;
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    labelText:
                                                        'Task Description',
                                                    prefixIcon:
                                                        Icon(Icons.description),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5))),
                                                onTap: () {
                                                  print('description tapped');
                                                },
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              TextFormField(
                                                cursorColor: Color.fromARGB(
                                                    255, 0, 42, 77),
                                                controller: timeController,
                                                keyboardType:
                                                    TextInputType.datetime,
                                                validator: (String? value) {
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    labelText: 'Task Time',
                                                    prefixIcon: Icon(Icons
                                                        .watch_later_outlined),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5))),
                                                onTap: () {
                                                  showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now())
                                                      .then((value) {
                                                    if (value != null) {
                                                      timeController.text =
                                                          value
                                                              .format(context)
                                                              .toString();
                                                    } else {
                                                      return null;
                                                    }
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              TextFormField(
                                                cursorColor: Color.fromARGB(
                                                    255, 0, 42, 77),
                                                controller: dateController,
                                                keyboardType:
                                                    TextInputType.datetime,
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'Date must not be empty';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    labelText: 'Task Date',
                                                    prefixIcon: Icon(Icons
                                                        .watch_later_outlined),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5))),
                                                onTap: () {
                                                  showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime(2100))
                                                      .then((value) {
                                                    if (value != null) {
                                                      dateController.text =
                                                          DateFormat.yMd()
                                                              .format(value);
                                                    } else {
                                                      return null;
                                                    }
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    });

                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  }
                },
                backgroundColor: color,
                elevation: 0,
                child: Icon(cubit.fabIcon)),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Color.fromARGB(255, 232, 232, 232),
                selectedFontSize: 17,
                selectedIconTheme: IconThemeData(size: 28),
                elevation: 5,
                selectedItemColor: Color.fromARGB(255, 56, 167, 222),
                unselectedItemColor: color,
                currentIndex: cubit.currentIndex,
                iconSize: 26,
                onTap: (index) {
                  cubit.changeIndex(index);
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
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: 'Arcive'),
                ]),
          );
        },
      ),
    );
  }
}
