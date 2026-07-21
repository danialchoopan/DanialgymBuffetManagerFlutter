import 'package:floor/floor.dart';
import 'database_manager.dart';

class MigrationManager {
  static final MigrationManager _instance = MigrationManager._();
  factory MigrationManager() => _instance;
  MigrationManager._();

  // Define migrations here
  // Example:
  // static final migration1to2 = Migration(1, 2, (database) async {
  //   await database.execute('ALTER TABLE members ADD COLUMN notes TEXT');
  // });

  // static final migration2to3 = Migration(2, 3, (database) async {
  //   await database.execute('CREATE TABLE new_table (id TEXT PRIMARY KEY)');
  // });

  static List<Migration> get migrations => [
    // Add migrations here as the database evolves
    // migration1to2,
    // migration2to3,
  ];

  static Future<void> runMigrations(AppDatabase database) async {
    // Migrations are handled automatically by Floor
    // when you add them to the database builder
  }
}