import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ToDo {
  final int id;
  final String title;
  final String subtitle;
  bool isDone;

  ToDo({
    this.id = 0,
    this.title = ' ',
    this.subtitle = ' ',
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      isDone: map['isDone'] == 1 ? true : false,
    );
  }

  Future<void> insertToDo() async {
    final Database db = await openDatabase(
      join(await getDatabasesPath(), 'todos_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, subtitle TEXT, isDone INTEGER)',
        );
      },
      version: 1,
    );

    await db.insert(
      'todos',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ToDo>> getToDos() async {
    final Database db = await openDatabase(
      join(await getDatabasesPath(), 'todos_database.db'),
    );

    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (i) {
      return ToDo.fromMap(maps[i]);
    });
  }

  @override
  String toString() {
    return '''ToDo{
    id: $id,
    title: $title,
    subtitle: $subtitle,
    isDone: $isDone,
    }''';
  }
}