import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'note_model.dart';

class DBHelper {
  // These lines make DBHelper a Singleton.
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'notes.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE notes('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title TEXT, '
              'description TEXT)',
        );
      },
    );
  }

  Future<int> insertNote(Note note) async {
    final db = await database;
    return db.insert('notes', note.toMap());
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final maps = await db.query('notes');

    return List.generate(maps.length, (index) {
      return Note.fromMap(maps[index]);
    });
  }

  Future<int> updateNote(Note note) async {
    final db = await database;

    return db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;

    return db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}