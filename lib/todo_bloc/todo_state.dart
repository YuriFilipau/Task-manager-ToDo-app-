import 'package:equatable/equatable.dart';

import '../data/todo.dart';

enum TodoStatus { initial, loading, success, error }

class TodoState extends Equatable {
  final List<ToDo> todos;
  final TodoStatus status;

  const TodoState({
    this.todos = const <ToDo>[],
    this.status = TodoStatus.initial,
  });

  TodoState copyWith({
    TodoStatus? status,
    List<ToDo>? todos,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }

  factory TodoState.fromMap(Map<String, dynamic> map) {
    try {
      var listOfTodos = (map['todos'] as List<dynamic>)
          .map((e) => ToDo.fromMap(e as Map<String, dynamic>))
          .toList();
      return TodoState(
          todos: listOfTodos,
          status: TodoStatus.values.firstWhere(
                  (element) => element.toString() == map['status']));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'todos': todos.map((todo) => todo.toMap()).toList(),
      'status': status.toString(),
    };
  }

  @override
  List<Object?> get props => [todos, status];
}