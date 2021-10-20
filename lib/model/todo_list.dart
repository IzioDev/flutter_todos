import 'package:equatable/equatable.dart';
import 'package:todo_flutter_uwp/model/todo.dart';

class TodoList extends Equatable {
  final String category;
  final List<Todo> todos;

  const TodoList(this.category, this.todos);

  @override
  List<Object?> get props => [category, todos];
}
