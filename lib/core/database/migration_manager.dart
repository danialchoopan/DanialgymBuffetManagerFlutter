import 'package:sqflite/sqflite.dart';

class MigrationManager {
  static Future<void> runMigrations(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Example migration pattern:
    // if (oldVersion < 2) {
    //   await _migrate1to2(db);
    // }
    // if (oldVersion < 3) {
    //   await _migrate2to3(db);
    // }

    // Add migrations as the database evolves
  }

  // Migration from version 1 to 2
  static Future<void> _migrate1to2(Database db) async {
    // Example: Add new column to members table
    // await db.execute('ALTER TABLE members ADD COLUMN new_column TEXT');

    // Example: Create new table
    // await db.execute('''
    //   CREATE TABLE IF NOT EXISTS new_table (
    //     id TEXT PRIMARY KEY NOT NULL,
    //     name TEXT NOT NULL,
    //     created_at TEXT NOT NULL
    //   )
    // ''');
  }

  // Migration from version 2 to 3
  static Future<void> _migrate2to3(Database db) async {
    // Add migration logic here
  }

  // ============================================================
  // HELPER METHODS
  // ============================================================

  static Future<void> addColumn(
    Database db,
    String table,
    String column,
    String type, {
    String? defaultValue,
  }) async {
    final sql = defaultValue != null
        ? 'ALTER TABLE $table ADD COLUMN $column $type DEFAULT $defaultValue'
        : 'ALTER TABLE $table ADD COLUMN $column $type';
    await db.execute(sql);
  }

  static Future<void> createTableIfNotExists(
    Database db,
    String tableName,
    String createSQL,
  ) async {
    await db.execute(createSQL);
  }

  static Future<void> dropTableIfExists(
    Database db,
    String tableName,
  ) async {
    await db.execute('DROP TABLE IF EXISTS $tableName');
  }

  static Future<void> createIndex(
    Database db,
    String indexName,
    String tableName,
    List<String> columns, {
    bool unique = false,
  }) async {
    final uniqueStr = unique ? 'UNIQUE ' : '';
    final columnsStr = columns.join(', ');
    await db.execute(
      'CREATE ${uniqueStr}INDEX IF NOT EXISTS $indexName ON $tableName($columnsStr)',
    );
  }

  static Future<void> dropIndex(
    Database db,
    String indexName,
  ) async {
    await db.execute('DROP INDEX IF EXISTS $indexName');
  }

  // ============================================================
  // DATA MIGRATION HELPERS
  // ============================================================

  static Future<void> copyTableData(
    Database db,
    String sourceTable,
    String targetTable,
    List<String> columns,
  ) async {
    final columnsStr = columns.join(', ');
    await db.execute('''
      INSERT INTO $targetTable ($columnsStr)
      SELECT $columnsStr FROM $sourceTable
    ''');
  }

  static Future<void> updateColumnValues(
    Database db,
    String table,
    Map<String, dynamic> values,
    String where,
    List<dynamic> whereArgs,
  ) async {
    final setClause = values.keys.map((k) => '$k = ?').join(', ');
    final setValues = values.values.toList();
    await db.rawUpdate(
      'UPDATE $table SET $setClause WHERE $where',
      [...setValues, ...whereArgs],
    );
  }

  // ============================================================
  // VALIDATION HELPERS
  // ============================================================

  static Future<bool> tableExists(
    Database db,
    String tableName,
  ) async {
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );
    return result.isNotEmpty;
  }

  static Future<bool> columnExists(
    Database db,
    String tableName,
    String columnName,
  ) async {
    final result = await db.rawQuery("PRAGMA table_info($tableName)");
    return result.any((column) => column['name'] == columnName);
  }

  static Future<List<String>> getTableColumns(
    Database db,
    String tableName,
  ) async {
    final result = await db.rawQuery("PRAGMA table_info($tableName)");
    return result.map((column) => column['name'] as String).toList();
  }

  static Future<int> getTableCount(
    Database db,
    String tableName,
  ) async {
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM $tableName');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}