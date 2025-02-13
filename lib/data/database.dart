import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference out box
  final _myBox = Hive.box('mybox');

  // create this method if this is the first time ever opening the app
  void createInitialData() {
    toDoList = [
      ["add task", false],
    ];
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
