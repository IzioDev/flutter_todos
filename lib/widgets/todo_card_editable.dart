import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_uwp/bloc/todo_mutation_bloc.dart';
import 'package:todo_flutter_uwp/colors.dart';

class TodoCardEditable extends StatefulWidget {
  final int? index;
  final String? title;

  const TodoCardEditable({Key? key, this.index, this.title}) : super(key: key);

  @override
  _TodoCardEditableState createState() => _TodoCardEditableState();
}

class _TodoCardEditableState extends State<TodoCardEditable> {
  Widget buildTextField(TodoMutationBloc todoMutationBloc) {
    final focusNode = FocusNode();
    final controller = TextEditingController(text: widget.title);

    return TextField(
      controller: controller,
      focusNode: focusNode
        ..addListener(() {
          if (!focusNode.hasFocus) {
            if (controller.value.text == "") {
              return todoMutationBloc.add(TodoMutationCanceled());
            }
            todoMutationBloc.add(TodoMutationRequested(controller.value.text));
          }
        }),
      maxLines: null,
      autofocus: true,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoMutationBloc = BlocProvider.of<TodoMutationBloc>(context);

    return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: Card(
          margin: const EdgeInsets.only(top: 10),
          shadowColor: Colors.black,
          color: kBackground,
          elevation: 2,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTextField(todoMutationBloc),
              ],
            ),
          ),
        ));
  }
}
