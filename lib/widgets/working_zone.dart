import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_uwp/bloc/todo_mutation_bloc.dart';
import 'package:todo_flutter_uwp/bloc/todos_bloc.dart';
import 'package:todo_flutter_uwp/model/todo_list.dart';
import 'package:todo_flutter_uwp/repository/todo_repository.dart';
import 'package:todo_flutter_uwp/widgets/todos_list.dart';

class WorkingZone extends StatefulWidget {
  const WorkingZone({Key? key}) : super(key: key);

  @override
  _WorkingZoneState createState() => _WorkingZoneState();
}

class _WorkingZoneState extends State<WorkingZone> {
  List<Widget> buildTodoLists(List<TodoList> todoLists,
      TodoRepository todoRepository, TodosBloc todosBloc) {
    var index = -1;
    return todoLists.map((todoList) {
      index++;

      final todos = todoList.todos;
      final category = todoList.category;
      return BlocProvider(
          create: (context) => TodoMutationBloc(todoRepository, todosBloc),
          child: TodosList(
            title: category,
            todos: todos,
            headColor: Colors.red,
            index: index,
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final TodoRepository todoRepository =
        RepositoryProvider.of<TodoRepository>(context);
    final todosBloc = BlocProvider.of<TodosBloc>(context);

    return Container(
        padding: EdgeInsets.all(20),
        // @TODO: clean height calculation based on something real
        height: MediaQuery.of(context).size.height - 80,
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            print('TodosState changed ? ${state}');
            return ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children:
                  buildTodoLists(state.todoLists, todoRepository, todosBloc),
            );
          },
        ));
  }
}
