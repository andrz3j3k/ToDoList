part of 'create_task_bloc.dart';

abstract class TaskEvent extends Equatable {}

class TaskCreatedEvent extends TaskEvent {
  TaskCreatedEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.isFavourite,
  });
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final bool isFavourite;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        date,
        isFavourite,
      ];
}

class TaskSortedEvent extends TaskEvent {
  final SortType _sortType;
  TaskSortedEvent(this._sortType);

  @override
  List<Object?> get props => [_sortType];
}
