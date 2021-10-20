import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;

  final String title;
  bool isDone;

  Todo({required this.id, required this.title, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  Todo copyWith({int? id, String? title, bool? isDone}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id, title, isDone];
}
