class Task {
  final String? id;
  final String? name;
  final String? description;
  final String? date;
  Task({
    this.id,
    this.name,
    this.description,
    this.date,
  });
  static List<Task> listTasks = [];
}
