import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart';

class ExportService {
  static final ExportService _instance = ExportService._();
  factory ExportService() => _instance;
  ExportService._();

  Future<String> getExportDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final exportDir = Directory('${directory.path}/exports');
    if (!await exportDir.exists()) {
      await exportDir.create(recursive: true);
    }
    return exportDir.path;
  }

  Future<String> exportToCSV({
    required String fileName,
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
    final exportDir = await getExportDirectory();
    final file = File('$exportDir/$fileName.csv');

    final buffer = StringBuffer();
    buffer.writeln(headers.join(','));
    for (final row in rows) {
      buffer.writeln(row.map((cell) => '"$cell"').join(','));
    }

    await file.writeAsString(buffer.toString());
    return file.path;
  }

  Future<String> exportToExcel({
    required String fileName,
    required String sheetName,
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
    final exportDir = await getExportDirectory();
    final file = File('$exportDir/$fileName.xlsx');

    final excel = Excel.createExcel();
    final sheet = excel[sheetName];

    // Add headers
    for (var col = 0; col < headers.length; col++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
        ..value = headers[col]
        ..cellStyle = CellStyle(
          bold: true,
          backgroundColorHex: ExcelColor.fromHexString('#4472C4'),
          fontColorHex: ExcelColor.white,
        );
    }

    // Add data rows
    for (var row = 0; row < rows.length; row++) {
      for (var col = 0; col < rows[row].length; col++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row + 1))
          ..value = rows[row][col];
      }
    }

    // Auto-fit columns
    for (var col = 0; col < headers.length; col++) {
      sheet.setColumnWidth(col, 20);
    }

    final fileBytes = excel.save();
    if (fileBytes != null) {
      await file.writeAsBytes(fileBytes);
      return file.path;
    }

    throw Exception('Failed to export Excel file');
  }

  Future<String> exportToPDF({
    required String fileName,
    required String title,
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
    final exportDir = await getExportDirectory();
    final file = File('$exportDir/$fileName.pdf');

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => pw.Column(
          children: [
            pw.Text(
              title,
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Generated on ${DateTime.now().toString()}',
              style: const pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey700,
              ),
            ),
            pw.Divider(),
          ],
        ),
        build: (context) => [
          pw.TableHelper.fromTextArray(
            headers: headers,
            data: rows,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 10),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColor.fromInt(0x4472C4),
            ),
            headerTextStyle: const pw.TextStyle(color: PdfColors.white),
          ),
        ],
      ),
    );

    final bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<List<ExportInfo>> getAvailableExports() async {
    final exportDir = await getExportDirectory();
    final directory = Directory(exportDir);
    final exports = <ExportInfo>[];

    if (await directory.exists()) {
      final files = await directory.list().toList();
      for (final file in files) {
        if (file is File) {
          final stat = await file.stat();
          exports.add(ExportInfo(
            path: file.path,
            fileName: file.path.split('/').last,
            createdAt: stat.modified,
            size: stat.size,
          ));
        }
      }
    }

    exports.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return exports;
  }

  Future<bool> deleteExport(String exportPath) async {
    final file = File(exportPath);
    if (await file.exists()) {
      await file.delete();
      return true;
    }
    return false;
  }
}

class ExportInfo {
  final String path;
  final String fileName;
  final DateTime createdAt;
  final int size;

  ExportInfo({
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

  String get fileType {
    final extension = fileName.split('.').last.toLowerCase();
    return extension.toUpperCase();
  }
}