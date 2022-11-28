// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_task_bloc.dart';

@immutable
abstract class CreateTaskEvent extends Equatable {}

class TaskCreated extends CreateTaskEvent {
  TaskCreated(
      {required this.id,
      required this.name,
      required this.description,
      required this.date,
      required this.isFavourite});
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final bool isFavourite;

  @override
  List<Object?> get props => [];
}
