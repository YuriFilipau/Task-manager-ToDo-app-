import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/todo_bloc/todo_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  addTodo(ToDo todo) {
    context.read<TodoBloc>().add(
          AddTodo(todo),
        );
  }

  removeTodo(ToDo todo) {
    context.read<TodoBloc>().add(
          RemoveTodo(todo),
        );
  }

  alterTodo(int index) {
    context.read<TodoBloc>().add(
          AlterTodo(index),
        );
  }

  alertDialog(
      TextEditingController controller1, TextEditingController controller2) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        'New Task',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller1,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            decoration: InputDecoration(
              hintText: 'Title...',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: controller2,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            decoration: InputDecoration(
              hintText: 'Description...',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          createTodoBtn(controller1, controller2),
        ],
      ),
    );
  }

  newTodoBtn() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final TextEditingController controller1 = TextEditingController();
            final TextEditingController controller2 = TextEditingController();
            return alertDialog(controller1, controller2);
          },
        );
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: const Icon(
        Icons.add,
        color: Colors.white54,
      ),
    );
  }

  createTodoBtn(
      TextEditingController controller1, TextEditingController controller2) {
    return TextButton(
      onPressed: () {
        addTodo(
          ToDo(
            title: controller1.text,
            subtitle: controller2.text,
          ),
        );
        controller1.text = '';
        controller2.text = '';
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Icon(
          Icons.create_rounded,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: newTodoBtn(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state.status == TodoStatus.success) {
                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, int i) {
                    return Card(
                      color: Theme.of(context).colorScheme.primary,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Slidable(
                        key: const ValueKey(0),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                removeTodo(
                                  state.todos[i],
                                );
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete_outline,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            state.todos[i].title,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 24
                            ),
                          ),
                          subtitle: Text(
                            state.todos[i].subtitle,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          trailing: Checkbox(
                            checkColor: Colors.green,
                            value: state.todos[i].isDone,
                            onChanged: (value) {
                              alterTodo(i);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state.status == TodoStatus.initial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
