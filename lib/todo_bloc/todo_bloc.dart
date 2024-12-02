import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_app/todo_bloc/todo_state.dart';
import '../data/todo.dart';

part 'todo_event.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<TodoStarted>(_onStarted);
    on<AddTodo>(_onAddTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<AlterTodo>(_onAlterTodo);
  }

  void _onStarted(
      TodoStarted event,
      Emitter<TodoState> emit,
      ) {
    if (state.status == TodoStatus.success) return;
    emit(state.copyWith(
      todos: state.todos,
      status: TodoStatus.success,
    ));
  }

  void _onAddTodo(
      AddTodo event,
      Emitter<TodoState> emit,
      ) {
    emit(
      state.copyWith(
        status: TodoStatus.loading,
      ),
    );
    try {
      List<ToDo> temp = [];
      temp.addAll(state.todos);
      temp.insert(0, event.toDo);
      emit(
        TodoState(
            todos: temp,
            status: TodoStatus.success
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TodoStatus.error,
        ),
      );
    }
  }

  void _onRemoveTodo(
      RemoveTodo event,
      Emitter<TodoState> emit,
      ) {
    emit(
      state.copyWith(
        status: TodoStatus.loading,
      ),
    );
    try {
      List<ToDo> updatedTodos = List.from(state.todos);
      updatedTodos.remove(event.toDo);
      emit(
        state.copyWith(
          todos: updatedTodos,
          status: TodoStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TodoStatus.error,
        ),
      );
    }
  }

  void _onAlterTodo(
      AlterTodo event,
      Emitter<TodoState> emit,
      ) {
    emit(
      state.copyWith(status: TodoStatus.loading),
    );
    try {
      List<ToDo> updatedTodos = List.from(state.todos);
      updatedTodos[event.index] = ToDo(
        id: updatedTodos[event.index].id,
        title: updatedTodos[event.index].title,
        isDone: !updatedTodos[event.index].isDone,
      );
      emit(
        TodoState(
          todos: updatedTodos,
          status: TodoStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TodoStatus.error,
        ),
      );
    }
  }

  @override
  TodoState fromJson(Map<String, dynamic> json) {
    try {
      return TodoState.fromMap(json);
    } catch (e) {
      return const TodoState();
    }
  }

  @override
  Map<String, dynamic> toJson(TodoState state) {
    return state.toMap();
  }
}