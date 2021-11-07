part of 'todo_mutation_bloc.dart';

abstract class TodoMutationState extends Equatable {
  const TodoMutationState();

  @override
  List<Object> get props => [];
}

abstract class TodoMutationStateInitialized extends TodoMutationState {
  final Mutation mutation;
  final Todo todo;

  const TodoMutationStateInitialized(
      {required this.todo, this.mutation = Mutation.insert});

  @override
  List<Object> get props => [todo, mutation];
}

class TodoMutationInitial extends TodoMutationState {}

class TodoMutationInitialized extends TodoMutationStateInitialized {
  final int listIndex;

  const TodoMutationInitialized(
      {required this.listIndex, required todo, mutation = Mutation.insert})
      : super(todo: todo, mutation: mutation);

  @override
  List<Object> get props => [todo, mutation];
}

class TodoMutationValidationError extends TodoMutationStateInitialized {
  final String errorMessage;

  const TodoMutationValidationError(
      {required Todo todo,
      required Mutation mutation,
      required this.errorMessage})
      : super(todo: todo, mutation: mutation);
}
