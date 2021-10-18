import 'package:flutter/material.dart';
import 'package:todo_flutter_uwp/colors.dart';

class TodoCard extends StatefulWidget {
  final int index;
  final String title;

  const TodoCard({Key? key, required this.index, required this.title})
      : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            const BoxConstraints(minWidth: double.infinity, minHeight: 50),
        child: ReorderableDragStartListener(
          index: widget.index,
          child: Card(
            margin: const EdgeInsets.only(top: 10),
            shadowColor: Colors.black,
            color: kBackground,
            elevation: 2,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
        ));
  }
}
