import 'package:simple_notes/data/model/notes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  NotesDatabase();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');

    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database!;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${NoteFields.id} $idType, 
  ${NoteFields.title} $textType,
  ${NoteFields.category} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.date} $textType
  )
''');
  }

  Future<NoteModel> create(NoteModel note) async {
    final db = await NotesDatabase().database;

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  // Future<NoteModel> readNote(int id) async {
  //   final db = await NotesDatabase().database;

  //   final maps = await db.query(
  //     tableNotes,
  //     columns: NoteFields.values,
  //     where: '${NoteFields.id} = ?',
  //     whereArgs: [id],
  //   );

  //   if (maps.isNotEmpty) {
  //     return NoteModel.fromJson(maps.first);
  //   } else {
  //     throw Exception('ID $id not found');
  //   }
  // }

  Future<List<NoteModel>> readAllNotes() async {
    final db = await NotesDatabase().database;

    const orderBy = '${NoteFields.date} ASC';

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => NoteModel.fromJson(json)).toList();
  }

  Future<int> update(NoteModel note) async {
    final db = await NotesDatabase().database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await NotesDatabase().database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await NotesDatabase().database;

    db.close();
  }
}
