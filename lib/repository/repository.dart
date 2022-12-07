import '../models/task.dart';

class Repository {
  static Repository? _repository;
  List<Task>? listTask = [];

  static Repository? getInstance() {
    _repository ??= Repository();
    return _repository;
  }
}

enum SortType {
  during,
  allTasks,
  favouriteTasks,
  doneTasks,
}
