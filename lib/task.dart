class Task {
  final String id;
  final String task;
  final bool isChecked;

  Task({required this.id, required this.task, required this.isChecked});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      task: json['title'],
      isChecked: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': task,
      'done': isChecked,
    };
  }
}
