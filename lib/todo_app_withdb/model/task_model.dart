class Task {
  int? id;
  String taskName;
  bool isDone;
  String? note;
  int priority;

  Task({
    this.id,
    required this.taskName,
    required this.isDone,
    this.note,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_name': taskName,
      'is_done': isDone ? 1 : 0,
      'note': note,
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      taskName: map['task_name'],
      isDone: map['is_done'] == 1,
      note: map['note'],
      priority: map['priority'],
    );
  }
}
