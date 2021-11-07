import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// @TODO: try to find a way to display a headColor on the top card
//        that don't need too much hack
//        either make this works or find a better way
import 'package:morphable_shape/morphable_shape.dart';
import 'package:todo_flutter_uwp/bloc/todo_mutation_bloc.dart';
import 'package:todo_flutter_uwp/bloc/todos_bloc.dart';
import 'package:todo_flutter_uwp/colors.dart';
import 'package:todo_flutter_uwp/enum/mutations.dart';
import 'package:todo_flutter_uwp/model/todo.dart';
import 'package:todo_flutter_uwp/widgets/todo_card.dart';
import 'package:todo_flutter_uwp/widgets/todo_card_editable.dart';
import 'package:todo_flutter_uwp/widgets/todo_reordable_list.dart';

// var border = DynamicBorderSide(
//   width: 10,
//   gradient: LinearGradient(colors: [Colors.red, Colors.green]),
// );

// ShapeBorder topShapeBorder = RectangleShapeBorder(
//   border: border,
// );

// Decoration topShapeBorderDecoration =
//     ShapeDecoration(shape: topShapeBorder, color: Colors.red);

class TodosList extends StatefulWidget {
  final String title;
  final Color headColor;
  final List<Todo> todos;
  final int index;

  const TodosList(
      {Key? key,
      required this.index,
      required this.title,
      required this.todos,
      required this.headColor})
      : super(key: key);

  @override
  _TodosListState createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  Widget buildTodoEditionCard(bool isEditing) {
    if (isEditing) {
      return TodoCardEditable();
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    final todoMutationBloc = BlocProvider.of<TodoMutationBloc>(context);

    return Container(
      width: MediaQuery.of(context).size.width / 5,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kBackgroundAccent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.post_add_rounded,
                  color: Colors.green,
                ),
                onPressed: () {
                  todoMutationBloc.add(TodoMutationInitiated(
                      mutation: Mutation.insert, listIndex: widget.index));
                },
              )
            ],
          ),
          // Todo Card Edit
          BlocBuilder<TodoMutationBloc, TodoMutationState>(
            builder: (context, state) {
              final isEditing = todoMutationBloc.isEditing();

              return buildTodoEditionCard(isEditing);
            },
          ),
          Expanded(
            child: Container(
              // @TODO: swap to ReorderableSilverList
              // https://api.flutter.dev/flutter/widgets/SliverReorderableList-class.html
              child: TodoReorderableList(
                  freeDrag: true,
                  primary: false,
                  itemBuilder: (context, index) => TodoCard(
                        key: ValueKey(widget.todos[index].id),
                        index: index,
                        title: widget.todos[index].title,
                      ),
                  itemCount: widget.todos.length,
                  onReorder: (oldItemIndex, newItemIndex) {
                    if (oldItemIndex == newItemIndex) {
                      return;
                    }

                    // These two lines are workarounds for onReorder behaviour
                    // Thanks to https://stackoverflow.com/a/54164333
                    if (newItemIndex > widget.todos.length) {
                      newItemIndex = widget.todos.length;
                    }
                    if (oldItemIndex < newItemIndex) newItemIndex--;

                    todosBloc.add(TodosItemReordered(oldItemIndex, newItemIndex,
                        widget.index, widget.index));
                  }),
              alignment: Alignment.topLeft,
            ),
          )
        ],
      ),
    );
  }
}
