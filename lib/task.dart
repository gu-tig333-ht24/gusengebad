class Task {
  final int id;
  final String task;
  final bool isChecked;

  Task({required this.id, required this.task, required this.isChecked});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      task: json['task'],
      isChecked: json['isChecked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'isChecked': isChecked,
    };
  }
}
