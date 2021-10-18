import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:todo_flutter_uwp/colors.dart';
import 'package:todo_flutter_uwp/widgets/working_zone.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1200, 800);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Universal Todos";
    win.show();
  });
}

// Scrollable Behavior
// @TODO: change it and set is per widget instead
// https://flutter.dev/docs/release/breaking-changes/default-scroll-behavior-drag
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: WindowBorder(
                color: kBackgroundAccent,
                width: 1,
                child: Row(children: const [WindowContainer()]))));
  }
}

class WindowContainer extends StatelessWidget {
  const WindowContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: const BoxDecoration(
              color: kBackground,
            ),
            alignment: Alignment.topLeft,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              WindowTitleBarBox(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(color: kBackgroundAccent.withOpacity(0.2)),
                  ),
                ),
                child: Row(children: [
                  Expanded(child: MoveWindow()),
                  const WindowButtons(),
                ]),
              )),
              const WorkingZone(),
            ])));
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: kInteractive,
    mouseOver: kBackgroundAccent,
    mouseDown: kBackgroundAccent,
    iconMouseOver: Colors.white,
    iconMouseDown: Colors.white);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: kInteractive,
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
