import 'package:todo_flutter_uwp/model/todo.dart';
import 'package:todo_flutter_uwp/model/todo_list.dart';

class TodoRepository {
  // @MOCKING
  List<Todo> todos1 = List.generate(100, (i) {
    return Todo(
      id: i,
      title: 'Todo $i',
      isDone: false,
    );
  });

  List<Todo> todos2 = List.generate(100, (i) {
    return Todo(
      id: i,
      title: 'Todo $i',
      isDone: false,
    );
  });

  List<TodoList> todoLists = [];

  TodoRepository() {
    todoLists.add(TodoList("Category1", todos1));
    todoLists.add(TodoList("Category2", todos2));
  }

  Future<List<TodoList>> getTodos() async {
    return todoLists;
  }

  Future<List<TodoList>> reorderLists(
      int oldListIndex, int newListIndex) async {
    TodoList todoList = todoLists[oldListIndex];
    todoLists.removeAt(oldListIndex);
    todoLists.insert(newListIndex, todoList);
    return todoLists;
  }

  Future<List<TodoList>> reorderItems(int oldListIndex, int newListIndex,
      int oldItemIndex, int newItemIndex) async {
    print(
        'Reordering list $oldListIndex:$newListIndex.\n\tOld Position $oldItemIndex\n\tNewPosition $newItemIndex');
    TodoList todoList = todoLists[oldListIndex];
    Todo item = todoList.todos[oldItemIndex];
    todoList.todos.removeAt(oldItemIndex);
    todoList.todos.insert(newItemIndex, item);
    return todoLists;
  }
}
