part of 'todos_bloc.dart';

@immutable
abstract class TodosEvent {}

class TodosLoaded extends TodosEvent {
  final List<TodoList> todoLists;

  TodosLoaded(this.todoLists);
}

class TodosItemReordered extends TodosEvent {
  final int oldItemIndex;
  final int newItemIndex;

  final int oldListIndex;
  final int newListIndex;

  TodosItemReordered(this.oldItemIndex, this.newItemIndex, this.oldListIndex,
      this.newListIndex);
}

class TodosListReordered extends TodosEvent {
  final int oldListIndex;
  final int newListIndex;

  TodosListReordered(this.oldListIndex, this.newListIndex);
}
