part of 'todo_bloc.dart';

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

  @override
  factory TodoState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfTodos = (json['todo'] as List<dynamic>)
          .map((e) => ToDo.fromJson(e as Map<String, dynamic>))
          .toList();
      return TodoState(
          todos: listOfTodos,
          status: TodoStatus.values.firstWhere(
              (element) => element.name.toString() == json['status']));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'todo': todos,
      'status': status.name,
    };
  }
  @override
  List<Object?> get props => [todos, status];
}
