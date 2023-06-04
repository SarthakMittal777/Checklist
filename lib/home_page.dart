import "package:checklist/data/database.dart";
import "package:checklist/util/dialog_box.dart";
import "package:checklist/util/todo_tile.dart";
import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  // text controller
  final _mybox = Hive.box('Mybox');
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
    if(_mybox.get("TODOLIST")==null) {
      db.createInitialData();
    }
    else
      {
        db.loadData();
      }
    super.initState();
  }
  final _controller = TextEditingController();
  //List toDoList= [["Make tutorial", false], ["to excersise", false],];

  //checkbox change
  void  checkBoxChanged(bool? value, int index)
  {
    setState(() {
      db.toDoList[index][1]=!db.toDoList[index][1];
    });
    db.updateDataBase();
  }
  //save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //create a  new task
  void createNewTask()
  {
    showDialog(
        context: context,
        builder: (context){
          return DialogBox(
            controller: _controller ,
            onSave: saveNewTask,
            onCancel: ()=>Navigator.of(context).pop(),

          );
        },
    );
  }

  //delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("SARTHAK'S TASK SCHEDULER"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
          child: Icon(Icons.add),
      ),
      body: ListView.builder(
    itemCount: db.toDoList.length,
    itemBuilder: (context,index){
      return ToDoTile(
        taskName: db.toDoList[index][0],
        taskCompleted:db.toDoList[index][1] ,
        onChanged: (value) => checkBoxChanged(value,index),
        deleteFunction: (context)=>deleteTask(index),
      );
       },

      ),
    );
  }
}
