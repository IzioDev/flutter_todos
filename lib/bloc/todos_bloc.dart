import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_flutter_uwp/model/todo_list.dart';
import 'package:todo_flutter_uwp/repository/todo_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodoRepository todoRepository;

  TodosBloc(this.todoRepository) : super(const TodosInitial([])) {
    // Load todos and emit a loaded event
    todoRepository.getTodos().then((todos) {
      add(TodosLoaded(todos));
    });

    on<TodosEvent>((event, emit) async {
      // On loaded
      if (event is TodosLoaded) {
        emit(TodosInitial(event.todoLists));
      }

      // List reorder
      if (event is TodosListReordered) {
        final newTodoLists = await todoRepository.reorderLists(
            event.oldListIndex, event.newListIndex);
        emit(TodosInitial(newTodoLists));
      }

      // Item reorder
      if (event is TodosItemReordered) {
        final newTodoLists = await todoRepository.reorderItems(
            event.oldListIndex,
            event.newListIndex,
            event.oldItemIndex,
            event.newItemIndex);
        emit(TodosInitial(newTodoLists));
      }

      if (event is TodosReloadRequested) {
        final todoLists = await todoRepository.getTodos();
        final newState = TodosInitial(todoLists);

        emit(newState);
      }
    });
  }
}
