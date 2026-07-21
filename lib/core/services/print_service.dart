import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintService {
  static final PrintService _instance = PrintService._();
  factory PrintService() => _instance;
  PrintService._();

  Future<void> printDocument(pw.Document document) async {
    await Printing.layoutPdf(
      onLayout: (format) => document.save(),
      name: 'Gym Buffet Manager',
    );
  }

  Future<void> printHTML(String html) async {
    await Printing.shareHtml(html: html);
  }

  Future<void> printPdfBytes(List<int> bytes) async {
    await Printing.layoutPdf(
      onLayout: (format) => bytes,
      name: 'Gym Buffet Manager',
    );
  }

  Future<List<PdfPrinter>> getAvailablePrinters() async {
    return await Printing.listRpc();
  }

  Future<void> printToPrinter(String printerName, pw.Document document) async {
    await Printing.directPrintPdf(
      printer: printerName,
      onLayout: (format) => document.save(),
      name: 'Gym Buffet Manager',
    );
  }

  pw.Document createDocument({
    required String title,
    required List<pw.Widget> children,
    PdfPageFormat? pageFormat,
  }) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormat ?? PdfPageFormat.a4,
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
        footer: (context) => pw.Column(
          children: [
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Gym Buffet Manager',
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
          ],
        ),
        build: (context) => children,
      ),
    );

    return pdf;
  }
}