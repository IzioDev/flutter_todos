part of 'todos_bloc.dart';

@immutable
abstract class TodosState extends Equatable {
  final List<TodoList> todoLists;

  const TodosState(this.todoLists);
}

class TodosInitial extends TodosState {
  const TodosInitial(List<TodoList> todoLists) : super(todoLists);

  @override
  List<Object?> get props => [todoLists];
}
