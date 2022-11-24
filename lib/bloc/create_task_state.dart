part of 'create_task_bloc.dart';

@immutable
abstract class CreateTaskState {}

class CreateTaskInitial extends CreateTaskState {
  CreateTaskInitial();
}

class CreateTaskLoading extends CreateTaskState {
  CreateTaskLoading();
}

class CreateTaskLoaded extends CreateTaskState {
  CreateTaskLoaded(this.listTask);
  List<Task> listTask;
}
