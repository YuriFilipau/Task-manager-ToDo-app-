part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodoStarted extends TodoEvent {}

class AddTodo extends TodoEvent {
  final ToDo toDo;

  const AddTodo(this.toDo);

  @override
  List<Object?> get props => [toDo];
}

class RemoveTodo extends TodoEvent {
  final ToDo toDo;

  const RemoveTodo(this.toDo);

  @override
  List<Object?> get props => [toDo];
}

class AlterTodo extends TodoEvent {
  final int index;

  const AlterTodo(this.index);

  @override
  List<Object?> get props => [index];
}
