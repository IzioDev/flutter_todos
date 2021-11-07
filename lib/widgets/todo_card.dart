import 'package:context_menus/context_menus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter_uwp/colors.dart';
import 'package:todo_flutter_uwp/widgets/todo_reordable_list.dart';

class TodoCard extends StatefulWidget {
  final int index;
  final String title;

  TapUpDetails? tapUpDetails;

  TodoCard({Key? key, required this.index, required this.title})
      : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @protected
  MultiDragGestureRecognizer createRecognizer() {
    return ImmediateMultiDragGestureRecognizer(debugOwner: this);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onSecondaryTapUp: (tapUpDetails) {
              setState(() {
                widget.tapUpDetails = tapUpDetails;
                // ContextMenuOverlay.of(context).show(
                //     Container(width: 100, height: 100, color: Colors.red));
              });
            },
            child: Listener(
              onPointerDown: (PointerDownEvent event) {
                final TodoReorderableListState? list =
                    TodoReorderableList.maybeOf(context);
                list?.startItemDragReorder(
                  index: widget.index,
                  event: event,
                  recognizer: createRecognizer(),
                );
              },
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
            ),
          ),
        ));
  }
}
