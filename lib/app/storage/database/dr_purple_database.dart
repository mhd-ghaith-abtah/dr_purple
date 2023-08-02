import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DrPurpleDatabase {
  static final DrPurpleDatabase _instance = DrPurpleDatabase.internal();

  factory DrPurpleDatabase() => _instance;

  DrPurpleDatabase.internal();

  static Database? _db;

  int _versionDb = 1;

  int get versionDb => _versionDb;

  set versionDb(int? value) => _versionDb = value!;

  Future<Database?> createDb() async {
    if (_db == null) {
      String path = join(await getDatabasesPath(), "dr_purple.db");
      _db = await openDatabase(
        path,
        version: versionDb,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure,
      );
    }
    return _db;
  }

  FutureOr<void> _onConfigure(Database db) async =>
      await db.execute('PRAGMA foreign_keys = ON');

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      await db
          .execute("ALTER TABLE foo ADD COLUMN new_column INTEGER DEFAULT 0");
    }
  }

  FutureOr<void> _onCreate(Database db, int version) async {}

  Future<int?> deleteMyDatabase() async =>
      await createDb().then((value) => null);
}
