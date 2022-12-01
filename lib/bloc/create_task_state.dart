part of 'create_task_bloc.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {
  TaskInitialState();
}

class TaskLoadingState extends TaskState {
  TaskLoadingState();
}

class TaskLoadedState extends TaskState {
  TaskLoadedState(this.listTask);
  List<Task> listTask;
}
