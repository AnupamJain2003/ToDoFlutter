import 'package:flutter/material.dart';
import 'package:todolist/widgets/appBar.dart';
import 'package:todolist/widgets/todoItem.dart';
import '../models/todo.dart';
import 'package:todolist/widgets/sharedPrefrence.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDo> toDoList = [];
  final _toDoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    super.initState();
    _loadToDoList();
  }

  void _loadToDoList() async {
    toDoList = await ToDoProvider.getToDoList();
    setState(() {
      _foundToDo = toDoList;
    });
  }

  void _addToDoList(String todo) async {
    setState(() {
      toDoList.add(ToDo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        toDoText: todo,
      ));
      _foundToDo = List.from(toDoList);
    });
    await ToDoProvider.saveToDoList(toDoList);
    _toDoController.clear();
  }

  void _handleTodoChange(ToDo todo) async {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    await ToDoProvider.saveToDoList(toDoList);
  }

  void _deleteToDoItem(String id) async {
    setState(() {
      toDoList.removeWhere((item) => item.id == id);
      _foundToDo = List.from(toDoList);
    });
    await ToDoProvider.saveToDoList(toDoList);
  }

  void _runFilter(String enterdKeyword){
    List<ToDo> results=[];
    if (enterdKeyword.isEmpty){
      results=toDoList;

    }
    else
      {
        results=toDoList.where((item)=>item.toDoText!.toLowerCase().contains(enterdKeyword.toLowerCase())).toList();
      }
    setState(() {
      _foundToDo=results;
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    onChanged: (value)=>_runFilter(value),
                      decoration: const InputDecoration(
                          hintText: 'Search', border: InputBorder.none)),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          'Task to be done',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todo in _foundToDo.reversed)
                        Todoitem(
                          todo: todo,
                          onDelteItem: _deleteToDoItem,
                          onToDoChanged: _handleTodoChange,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                      border: Border.all(color: Colors.deepPurple, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: _toDoController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: 'Add a new item',hintStyle: TextStyle(color: Colors.white), border: InputBorder.none,),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoList(_toDoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: const Size(60, 60)),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ] //children
            ));
  }
}
