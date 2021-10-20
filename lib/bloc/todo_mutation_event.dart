part of 'todo_mutation_bloc.dart';

abstract class TodoMutationEvent extends Equatable {
  const TodoMutationEvent();

  @override
  List<Object> get props => [];
}

class TodoMutationInitiated extends TodoMutationEvent {
  final Mutation mutation;
  final Todo? todo;

  const TodoMutationInitiated({required this.mutation, this.todo});

  @override
  List<Object> get props => [];
}

class TodoMutationCanceled extends TodoMutationEvent {}

class TodoMutationRequested extends TodoMutationEvent {
  final String title;

  const TodoMutationRequested(this.title);

  @override
  List<Object> get props => [title];
}
