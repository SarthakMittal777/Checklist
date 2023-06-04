import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{
  List toDoList=[];
  // refrence box
  final _myBox=Hive.box("Mybox");

  //  run this while opening app
  void createInitialData(){
    toDoList = [
      ["make Tutorial",false],
      ["Do Excercise",false],
    ];
  }
  //load data
void loadData() {
    toDoList=_myBox.get("TODOLIST");

}
void updateDataBase(){
    _myBox.put("TODOLIST", toDoList);

}
}