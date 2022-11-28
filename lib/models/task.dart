class Task {
  final String? id;
  final String? name;
  final String? description;
  final DateTime? date;
  bool isDone = false;
  bool? isFavourite = false;

  Task({
    this.id,
    this.name,
    this.description,
    this.date,
    this.isFavourite,
  });
  static List<Task> listTasks = [];
}
