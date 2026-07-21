import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class BackupService {
  static final BackupService _instance = BackupService._();
  factory BackupService() => _instance;
  BackupService._();

  Future<String> getBackupDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${directory.path}/backups');
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return backupDir.path;
  }

  Future<String> createBackup(String databasePath) async {
    final backupDir = await getBackupDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final backupFile = File('$backupDir/gym_backup_$timestamp.db');

    final databaseFile = File(databasePath);
    if (await databaseFile.exists()) {
      await databaseFile.copy(backupFile.path);
      return backupFile.path;
    }

    throw Exception('Database file not found');
  }

  Future<bool> restoreBackup(String backupPath) async {
    final backupFile = File(backupPath);
    if (!await backupFile.exists()) {
      return false;
    }

    // Note: Actual restoration requires copying the backup to the database location
    // This should be done carefully to avoid data loss
    return true;
  }

  Future<List<BackupInfo>> getAvailableBackups() async {
    final backupDir = await getBackupDirectory();
    final directory = Directory(backupDir);
    final backups = <BackupInfo>[];

    if (await directory.exists()) {
      final files = await directory.list().toList();
      for (final file in files) {
        if (file is File && file.path.endsWith('.db')) {
          final stat = await file.stat();
          backups.add(BackupInfo(
            path: file.path,
            fileName: file.path.split('/').last,
            createdAt: stat.modified,
            size: stat.size,
          ));
        }
      }
    }

    backups.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return backups;
  }

  Future<bool> deleteBackup(String backupPath) async {
    final file = File(backupPath);
    if (await file.exists()) {
      await file.delete();
      return true;
    }
    return false;
  }

  Future<String> exportToCSV(String data, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final exportDir = Directory('${directory.path}/exports');
    if (!await exportDir.exists()) {
      await exportDir.create(recursive: true);
    }

    final file = File('${exportDir.path}/$fileName');
    await file.writeAsString(data);
    return file.path;
  }
}

class BackupInfo {
  final String path;
  final String fileName;
  final DateTime createdAt;
  final int size;

  BackupInfo({
    required this.path,
    required this.fileName,
    required this.createdAt,
    required this.size,
  });

  String get sizeFormatted {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}