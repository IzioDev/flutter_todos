import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphable_shape/morphable_shape.dart';
import 'package:todo_flutter_uwp/bloc/todos_bloc.dart';
import 'package:todo_flutter_uwp/colors.dart';
import 'package:todo_flutter_uwp/model/todo.dart';
import 'package:todo_flutter_uwp/widgets/todo_card.dart';

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

  const TodosList(
      {Key? key,
      required this.title,
      required this.todos,
      required this.headColor})
      : super(key: key);

  @override
  _TodosListState createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  List<Widget> TodoCardList(List<Todo> todos) {
    final todoCardList = <Widget>[];

    for (var i = 0; i < todos.length; i++) {
      todoCardList.add(TodoCard(key: ValueKey(todos[i].id)));
    }
    return todoCardList;
  }

  @override
  Widget build(BuildContext context) {
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
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height - 187,
              child: ReorderableListView(
                scrollDirection: Axis.vertical,
                // onReorder: (int oldIndex, int newIndex) {
                //   BlocProvider.of<TodosBloc>(context).add(
                //     TodosReorder(oldIndex: oldIndex, newIndex: newIndex),
                //   );
                // },
                onReorder: (int oldIndex, int newIndex) {},
                children: TodoCardList(widget.todos),
              ))
        ],
      ),
    );
  }
}
