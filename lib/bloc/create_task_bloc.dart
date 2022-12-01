import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/main.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/repository/repository.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitialState()) {
    on<TaskCreatedEvent>((event, emit) async {
      emit(TaskInitialState());
      emit(TaskLoadingState());
      var task = Task(
        id: event.id,
        name: event.name,
        description: event.description,
        date: event.date,
        isFavourite: event.isFavourite,
      );
      var repository = Repository.getInstance();
      repository!.listTask!.add(task);
      await Future.delayed(const Duration(milliseconds: 200));
      emit(TaskLoadedState(repository.listTask!));
    });

    on<TaskSortedEvent>((event, emit) async {
      emit(TaskInitialState());
      emit(TaskLoadingState());
      var repository = Repository.getInstance();
      List<Task> list = repository!.listTask!;
      List<Task> listed = [];
      switch (event._sortType) {
        case SortType.allTasks:
          listed = list;
          break;
        case SortType.doneTasks:
          for (var element in list) {
            if (element.isDone == true) {
              listed.add(element);
            }
          }
          break;
        case SortType.favouriteTasks:
          for (var element in list) {
            if (element.isFavourite == true) {
              listed.add(element);
            }
          }
          break;
      }
      await Future.delayed(const Duration(milliseconds: 200));
      emit(TaskLoadedState(listed));
    });
  }
}
