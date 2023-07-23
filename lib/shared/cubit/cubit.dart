
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/shared/cubit/states.dart';
import 'package:todo/modules/arcieved_task.dart';
import 'package:todo/modules/completed_task.dart';
import 'package:todo/modules/task.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [Task(), Completed(), Arcived()];
  List<String> title = ["Tasks", "Completed Tasks", "Archived Tasks"];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState({
    @required bool? isShow,
    @required IconData? icon,
  }) {
    isBottomSheetShow = isShow!;
    fabIcon = icon!;
    emit(AppChangeBottomSheetState());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

// Create DataBase
  void CreateDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,description  TEXT, date TEXT, time TEXT, status TEXT )')
            .then((value) {
          // print('db created');
        }).catchError((error) {
          // print('Error when db created ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        // print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    }).catchError((error) {
      // print('Error while creating or opening the DB ${error.toString()}}');
    });
  }

  /// Insert Data To DataBase

  insertToDatabase({
    @required String? title,
    @required String? description,
    @required String? time,
    @required String? date,
  }) async {
    await database!
        .transaction((txn) => txn.rawInsert(
            'INSERT INTO tasks (title,description, date, time ,status) VALUES ("$title","$description","$date","$time","new")'))
        .then((value) {
      // print('$value inserted successfully');

      emit(AppInsertDatabaseState());
      getDataFromDatabase(database);
      emit(AppGetDatabaseState());
    }).catchError((error) {
      // print('Error when db created ${error.toString()}');
    });
  }

  /// Get Data From DataBase
  void getDataFromDatabase(database) {
    emit(AppGetDatabaseLoadingState());
    database!.rawQuery("SELECT * FROM tasks").then((value) {
      // print(value);
      newTasks = [];
      doneTasks = [];
      archivedTasks = [];
      value.forEach(
        (element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'Done') {
            doneTasks.add(element);
          } else {
            archivedTasks.add(element);
          }
        },
      );
      emit(AppGetDatabaseState());
    });
  }

  /// Update DataBase
  void updateData({
    required String status,
    required int id,
  }) {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [
      '$status',
      '$id',
    ]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  /// Delete Data From DataBase
  void deletaData({
    required int id,
  }) {
    database!
        .rawDelete('DELETE FROM  tasks WHERE id = ? ', ['$id']).then((value) {
      getDataFromDatabase(database);

      emit(AppDeleteDatabaseState());
    });
  }
}
