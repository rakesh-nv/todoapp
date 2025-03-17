import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/database.dart';

class HomeProvider extends ChangeNotifier {
  final _controller = TextEditingController();
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  bool _isLoading = false;


  TextEditingController get controller => _controller;
  bool get isLoading => _isLoading;
  List get toDoList => db.toDoList;

  Future<void> initializeData() async {
    _isLoading = true;
    notifyListeners();
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    _isLoading = false;
    notifyListeners();
  }

  void checkBoxChanged(bool? value, int index) {
    db.toDoList[index][1] = !db.toDoList[index][1];
    db.updateDataBase();
    notifyListeners();
  }

  void saveNewTask() {
    if (_controller.text.trim().isNotEmpty) {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
      db.updateDataBase();
      notifyListeners();
    }
  }

  void deleteTask(int index) {
    db.toDoList.removeAt(index);
    db.updateDataBase();
    notifyListeners();
  }

  void editTask(int index, String newText) {
    if (newText.trim().isNotEmpty) {
      db.toDoList[index][0] = newText;
      db.updateDataBase();
      notifyListeners();
    }
  }

  // Add task priority
  void togglePriority(int index) {
    if (db.toDoList[index].length < 3) {
      db.toDoList[index].add(false); // Add priority field if doesn't exist
    }
    db.toDoList[index][2] = !db.toDoList[index][2];
    db.updateDataBase();
    notifyListeners();
  }
}



