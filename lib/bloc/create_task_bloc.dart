import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todolist/models/task.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc() : super(CreateTaskInitial()) {
    on<TaskCreated>((event, emit) async {
      emit(CreateTaskInitial());
      emit(CreateTaskLoading());
      var task = Task(
        id: event.id,
        name: event.name,
        description: event.description,
        date: event.date,
        isFavourite: event.isFavourite,
      );

      Task.listTasks.add(task);
      await Future.delayed(const Duration(milliseconds: 200));
      emit(CreateTaskLoaded(Task.listTasks));
    });
  }
}
