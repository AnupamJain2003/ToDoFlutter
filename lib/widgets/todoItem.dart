import 'package:flutter/material.dart';
import '../models/todo.dart';

class Todoitem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDelteItem;
  const Todoitem({
    super.key,
    required this.todo,
    this.onToDoChanged,
    this.onDelteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurple, width: 1),
            borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.blue,
          ),
          title: Text(
            todo.toDoText!,
            style: TextStyle(
                fontSize: 16,
                decoration: todo.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
                onPressed: () {
                  onDelteItem(todo.id);
                },
                color: Colors.white,
                iconSize: 18,
                icon: const Icon(Icons.delete)),
          ),
        ));
  }
}
