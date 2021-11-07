part of 'todo_mutation_bloc.dart';

abstract class TodoMutationEvent extends Equatable {
  const TodoMutationEvent();

  @override
  List<Object> get props => [];
}

class TodoMutationInitiated extends TodoMutationEvent {
  final Mutation mutation;
  final int listIndex;
  final Todo? todo;

  const TodoMutationInitiated(
      {required this.mutation, required this.listIndex, this.todo});

  @override
  List<Object> get props => [];
}

class TodoMutationCanceled extends TodoMutationEvent {}

class TodoMutationRequested extends TodoMutationEvent {
  final String title;

  const TodoMutationRequested({required this.title});

  @override
  List<Object> get props => [title];
}
