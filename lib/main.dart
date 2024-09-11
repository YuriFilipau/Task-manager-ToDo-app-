import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/todo_bloc/todo_bloc.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Colors.black,
          onBackground: Colors.white54,
          primary: Color(0xFF2C2C2C),
          onPrimary: Colors.white54,
          secondary: Colors.black12,
          onSecondary: Colors.white54,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Todo app',
      home: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc()
          ..add(
            TodoStarted(),
          ),
        child: const HomeScreen(),
      ),
    );
  }
}
