import 'package:my_note/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDao {
  static Database _db;
  static const String DB_NAME = 'rmahatoky.mynotedb.db';
  static const String TABLE_NOTE_NAME = "Note";

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $TABLE_NOTE_NAME('
          'id INTEGER PRIMARY KEY, '
          'title TEXT, '
          'content TEXT,'
          'cardBackgroundColor TEXT,'
          'cardForgroundColor TEXT,'
          'cardBorderColor TEXT,'
          'isLocked INTEGER,'
          'firstIconCodePoint TEXT,'
          'secondIconCodePoint TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert(
      TABLE_NOTE_NAME,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateNote(Note note) async {
    final db = await database;
    await db.update(
      TABLE_NOTE_NAME,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete(
      TABLE_NOTE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db.query(TABLE_NOTE_NAME, columns: ["*"], orderBy: "id ASC");
    return List.generate(results.length, (i) {
      return Note.fromDB(results[i]);
    });
  }
}
