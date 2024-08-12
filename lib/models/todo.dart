class ToDo {
  String? id;
  String? toDoText;
  bool isDone;

  ToDo({required this.id, required this.toDoText, this.isDone = false});

  // Convert a ToDo object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'toDoText': toDoText,
      'isDone': isDone,
    };
  }

  // Convert a Map object into a ToDo object
  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      toDoText: map['toDoText'],
      isDone: map['isDone'],
    );
  }
}
