part of 'todos_bloc.dart';

@immutable
abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosInitial extends TodosState {
  final List<TodoList> todoLists;

  const TodosInitial(this.todoLists);

  @override
  List<Object> get props => [todoLists];
}
