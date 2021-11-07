import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_flutter_uwp/bloc/todos_bloc.dart';
import 'package:todo_flutter_uwp/enum/mutations.dart';
import 'package:todo_flutter_uwp/model/todo.dart';
import 'package:todo_flutter_uwp/repository/todo_repository.dart';

part 'todo_mutation_event.dart';
part 'todo_mutation_state.dart';

class TodoMutationBloc extends Bloc<TodoMutationEvent, TodoMutationState> {
  final TodoRepository _todoRepository;
  final TodosBloc todosBloc;

  TodoMutationBloc(this._todoRepository, this.todosBloc)
      : super(TodoMutationInitial()) {
    on<TodoMutationEvent>((event, emit) async {
      if (event is TodoMutationInitiated) {
        // @TODO: maybe cancel if already in progress
        final Todo todo;

        if (event.mutation == Mutation.insert) {
          todo = Todo(id: -1, title: "");
        } else {
          todo = event.todo!;
        }

        emit(TodoMutationInitialized(
            listIndex: event.listIndex, todo: todo, mutation: event.mutation));
      }

      if (event is TodoMutationCanceled) {
        emit(TodoMutationInitial());
      }

      if (event is TodoMutationRequested) {
        // @TODO: treat other cases
        // where a todo mutation occured before an initalization ?
        print("TodoMutationRequested with state: ${state.toString()}");

        final _state = state;
        if (_state is TodoMutationInitialized) {
          print("TodoMutationRequested for listIndex: ${_state.listIndex}");
          await _todoRepository.addTodo(
              _state.listIndex, Todo(id: -1, title: event.title));
          todosBloc.add(TodosReloadRequested());

          emit(TodoMutationInitial());
        }
      }
    });
  }

  bool isEditing() {
    return state is TodoMutationInitialized;
  }
}
