// ============================================================
// REPORT GENERATOR SERVICE
// ============================================================
// This file contains the service for generating reports in
// various formats (PDF, CSV, Excel).
// ============================================================

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'report_models.dart';
import 'analytics_calculator.dart';

class ReportGeneratorService {
  static final ReportGeneratorService _instance = ReportGeneratorService._();
  factory ReportGeneratorService() => _instance;
  ReportGeneratorService._();

  // ============================================================
  // REPORT GENERATION
  // ============================================================

  Future<String> generateDailyReport({
    required DateTime date,
    required MemberReportData memberData,
    required AttendanceReportData attendanceData,
    required BuffetReportData buffetData,
    required FinancialReportData financialData,
  }) async {
    final metadata = ReportMetadata(
      id: _generateReportId(),
      title: 'گزارش روزانه ${_formatDate(date)}',
      type: ReportType.combined,
      period: ReportPeriod.daily,
      startDate: date,
      endDate: date,
      generatedAt: DateTime.now(),
    );

    final report = DailyReportData(
      metadata: metadata,
      memberData: memberData,
      attendanceData: attendanceData,
      buffetData: buffetData,
      financialData: financialData,
      alerts: _generateAlerts(
        memberData: memberData,
        buffetData: buffetData,
        financialData: financialData,
      ),
    );

    final filePath = await _saveReportToFile(report);
    return filePath;
  }

  Future<String> generateMemberReport({
    required DateTime startDate,
    required DateTime endDate,
    required MemberReportData data,
  }) async {
    final metadata = ReportMetadata(
      id: _generateReportId(),
      title: 'گزارش اعضا ${_formatDateRange(startDate, endDate)}',
      type: ReportType.member,
      period: ReportPeriod.custom,
      startDate: startDate,
      endDate: endDate,
      generatedAt: DateTime.now(),
    );

    // Generate report content
    final content = _generateMemberReportContent(metadata, data);
    final filePath = await _saveReportContent(content, 'member_report');
    return filePath;
  }

  Future<String> generateAttendanceReport({
    required DateTime startDate,
    required DateTime endDate,
    required AttendanceReportData data,
  }) async {
    final metadata = ReportMetadata(
      id: _generateReportId(),
      title: 'گزارش حضور و غیاب ${_formatDateRange(startDate, endDate)}',
      type: ReportType.attendance,
      period: ReportPeriod.custom,
      startDate: startDate,
      endDate: endDate,
      generatedAt: DateTime.now(),
    );

    final content = _generateAttendanceReportContent(metadata, data);
    final filePath = await _saveReportContent(content, 'attendance_report');
    return filePath;
  }

  Future<String> generateBuffetReport({
    required DateTime startDate,
    required DateTime endDate,
    required BuffetReportData data,
  }) async {
    final metadata = ReportMetadata(
      id: _generateReportId(),
      title: 'گزارش بوفه ${_formatDateRange(startDate, endDate)}',
      type: ReportType.buffet,
      period: ReportPeriod.custom,
      startDate: startDate,
      endDate: endDate,
      generatedAt: DateTime.now(),
    );

    final content = _generateBuffetReportContent(metadata, data);
    final filePath = await _saveReportContent(content, 'buffet_report');
    return filePath;
  }

  Future<String> generateFinancialReport({
    required DateTime startDate,
    required DateTime endDate,
    required FinancialReportData data,
  }) async {
    final metadata = ReportMetadata(
      id: _generateReportId(),
      title: 'گزارش مالی ${_formatDateRange(startDate, endDate)}',
      type: ReportType.financial,
      period: ReportPeriod.custom,
      startDate: startDate,
      endDate: endDate,
      generatedAt: DateTime.now(),
    );

    final content = _generateFinancialReportContent(metadata, data);
    final filePath = await _saveReportContent(content, 'financial_report');
    return filePath;
  }

  // ============================================================
  // CSV EXPORT
  // ============================================================

  Future<String> exportToCSV({
    required String fileName,
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
    final directory = await _getExportDirectory();
    final file = File('${directory.path}/$fileName.csv');

    final buffer = StringBuffer();
    buffer.writeln(headers.join(','));
    for (final row in rows) {
      buffer.writeln(row.map((cell) => '"$cell"').join(','));
    }

    await file.writeAsString(buffer.toString());
    return file.path;
  }

  Future<String> exportMembersToCSV({
    required List<Map<String, dynamic>> members,
  }) async {
    final headers = [
      'ID',
      'نام کامل',
      'تلفن',
      'ایمیل',
      'جنسیت',
      'تاریخ تولد',
      'وضعیت عضویت',
      'نوع عضویت',
      'تاریخ انقضا',
      'مبلغ باقیمانده',
      'کل پرداختی',
      'تعداد مراجعات',
    ];

    final rows = members.map((member) {
      return [
        member['id'] ?? '',
        member['full_name'] ?? '',
        member['phone'] ?? '',
        member['email'] ?? '',
        member['gender'] ?? '',
        member['birth_date'] ?? '',
        _translateStatus(member['membership_status'] ?? ''),
        _translateMembershipType(member['membership_type'] ?? ''),
        member['membership_expiry_date'] ?? '',
        (member['outstanding_balance'] ?? 0).toString(),
        (member['total_paid'] ?? 0).toString(),
        (member['total_visits'] ?? 0).toString(),
      ];
    }).toList();

    return exportToCSV(
      fileName: 'members_${_formatDateForFile(DateTime.now())}',
      headers: headers,
      rows: rows,
    );
  }

  Future<String> exportAttendanceToCSV({
    required List<Map<String, dynamic>> attendance,
  }) async {
    final headers = [
      'ID',
      'نام عضو',
      'زمان ورود',
      'زمان خروج',
      'مدت زمان (دقیقه)',
      'روش ورود',
    ];

    final rows = attendance.map((record) {
      return [
        record['id'] ?? '',
        record['member_name'] ?? '',
        record['check_in_time'] ?? '',
        record['check_out_time'] ?? '',
        (record['duration_minutes'] ?? 0).toString(),
        _translateCheckInMethod(record['check_in_method'] ?? ''),
      ];
    }).toList();

    return exportToCSV(
      fileName: 'attendance_${_formatDateForFile(DateTime.now())}',
      headers: headers,
      rows: rows,
    );
  }

  Future<String> exportTransactionsToCSV({
    required List<Map<String, dynamic>> transactions,
  }) async {
    final headers = [
      'شماره تراکنش',
      'نوع',
      'دسته‌بندی',
      'مبلغ',
      'توضیحات',
      'تاریخ',
    ];

    final rows = transactions.map((transaction) {
      return [
        transaction['transaction_number'] ?? '',
        _translateTransactionType(transaction['transaction_type'] ?? ''),
        transaction['category'] ?? '',
        (transaction['amount'] ?? 0).toString(),
        transaction['description'] ?? '',
        transaction['transaction_date'] ?? '',
      ];
    }).toList();

    return exportToCSV(
      fileName: 'transactions_${_formatDateForFile(DateTime.now())}',
      headers: headers,
      rows: rows,
    );
  }

  // ============================================================
  // REPORT CONTENT GENERATORS
  // ============================================================

  String _generateMemberReportContent(
    ReportMetadata metadata,
    MemberReportData data,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('=== گزارش اعضا ===');
    buffer.writeln('تاریخ: ${_formatDate(metadata.generatedAt)}');
    buffer.writeln('');
    buffer.writeln('--- خلاصه ---');
    buffer.writeln('کل اعضا: ${data.totalMembers}');
    buffer.writeln('اعضای فعال: ${data.activeMembers}');
    buffer.writeln('اعضای منقضی: ${data.expiredMembers}');
    buffer.writeln('اعضای جدید: ${data.newMembersInPeriod}');
    buffer.writeln('نرخ حفظ: ${data.retentionRate.toStringAsFixed(1)}%');
    buffer.writeln('');
    buffer.writeln('--- توزیع جنسیت ---');
    data.genderDistribution.forEach((key, value) {
      buffer.writeln('$key: $value%');
    });
    return buffer.toString();
  }

  String _generateAttendanceReportContent(
    ReportMetadata metadata,
    AttendanceReportData data,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('=== گزارش حضور و غیاب ===');
    buffer.writeln('تاریخ: ${_formatDate(metadata.generatedAt)}');
    buffer.writeln('');
    buffer.writeln('--- خلاصه ---');
    buffer.writeln('کل ورودها: ${data.totalCheckIns}');
    buffer.writeln('اعضای یکتا: ${data.uniqueMembers}');
    buffer.writeln('میانگین مدت زمان: ${data.averageDurationFormatted}');
    buffer.writeln('ساعات پیک: ${data.peakHour}:00');
    buffer.writeln('');
    buffer.writeln('--- توزیص روزانه ---');
    data.dailyDistribution.forEach((key, value) {
      buffer.writeln('$key: $value');
    });
    return buffer.toString();
  }

  String _generateBuffetReportContent(
    ReportMetadata metadata,
    BuffetReportData data,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('=== گزارش بوفه ===');
    buffer.writeln('تاریخ: ${_formatDate(metadata.generatedAt)}');
    buffer.writeln('');
    buffer.writeln('--- خلاصه ---');
    buffer.writeln('کل سفارشات: ${data.totalOrders}');
    buffer.writeln('کل درآمد: ${data.totalRevenue.toStringAsFixed(0)} تومان');
    buffer.writeln('کل سود: ${data.totalProfit.toStringAsFixed(0)} تومان');
    buffer.writeln('میانگین ارزش سفارش: ${data.averageOrderValue.toStringAsFixed(0)} تومان');
    buffer.writeln('');
    buffer.writeln('--- محصولات پرفروش ---');
    for (final product in data.topProducts) {
      buffer.writeln('${product.rank}. ${product.productName}: ${product.quantitySold} عدد');
    }
    return buffer.toString();
  }

  String _generateFinancialReportContent(
    ReportMetadata metadata,
    FinancialReportData data,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('=== گزارش مالی ===');
    buffer.writeln('تاریخ: ${_formatDate(metadata.generatedAt)}');
    buffer.writeln('');
    buffer.writeln('--- خلاصه ---');
    buffer.writeln('کل درآمد: ${data.totalIncome.toStringAsFixed(0)} تومان');
    buffer.writeln('کل هزینه‌ها: ${data.totalExpenses.toStringAsFixed(0)} تومان');
    buffer.writeln('سود خالص: ${data.netProfit.toStringAsFixed(0)} تومان');
    buffer.writeln('حاشیه سود: ${data.profitMargin.toStringAsFixed(1)}%');
    buffer.writeln('');
    buffer.writeln('--- درآمد بر اساس دسته‌بندی ---');
    data.incomeByCategory.forEach((key, value) {
      buffer.writeln('$key: ${value.toStringAsFixed(0)} تومان');
    });
    buffer.writeln('');
    buffer.writeln('--- هزینه‌ها بر اساس دسته‌بندی ---');
    data.expensesByCategory.forEach((key, value) {
      buffer.writeln('$key: ${value.toStringAsFixed(0)} تومان');
    });
    return buffer.toString();
  }

  // ============================================================
  // HELPER METHODS
  // ============================================================

  String _generateReportId() {
    final now = DateTime.now();
    return 'RPT${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  String _formatDateRange(DateTime start, DateTime end) {
    return '${_formatDate(start)} - ${_formatDate(end)}';
  }

  String _formatDateForFile(DateTime date) {
    return '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
  }

  String _translateStatus(String status) {
    switch (status) {
      case 'ACTIVE':
        return 'فعال';
      case 'EXPIRED':
        return 'منقضی';
      case 'SUSPENDED':
        return 'تعلیق';
      case 'PENDING':
        return 'در انتظار';
      default:
        return status;
    }
  }

  String _translateMembershipType(String type) {
    switch (type) {
      case 'MONTHLY':
        return 'ماهانه';
      case 'QUARTERLY':
        return 'سه‌ماهه';
      case 'ANNUAL':
        return 'سالانه';
      case 'LIFETIME':
        return 'ابدی';
      default:
        return type;
    }
  }

  String _translateTransactionType(String type) {
    switch (type) {
      case 'INCOME':
        return 'درآمد';
      case 'EXPENSE':
        return 'هزینه';
      default:
        return type;
    }
  }

  String _translateCheckInMethod(String method) {
    switch (method) {
      case 'MANUAL':
        return 'دستی';
      case 'QR_CODE':
        return 'کد QR';
      case 'FINGERPRINT':
        return 'اثر انگشت';
      default:
        return method;
    }
  }

  Future<Directory> _getExportDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final exportDir = Directory('${directory.path}/exports');
    if (!await exportDir.exists()) {
      await exportDir.create(recursive: true);
    }
    return exportDir;
  }

  Future<String> _saveReportToFile(DailyReportData report) async {
    final directory = await _getExportDirectory();
    final fileName = 'daily_report_${_formatDateForFile(report.metadata.startDate)}.txt';
    final file = File('${directory.path}/$fileName');

    final content = StringBuffer();
    content.writeln('========================================');
    content.writeln('گزارش روزانه باشگاه');
    content.writeln('تاریخ: ${_formatDate(report.metadata.startDate)}');
    content.writeln('========================================');
    content.writeln('');

    // Member Section
    content.writeln('--- بخش اعضا ---');
    content.writeln('کل اعضا: ${report.memberData.totalMembers}');
    content.writeln('اعضای فعال: ${report.memberData.activeMembers}');
    content.writeln('اعضای جدید: ${report.memberData.newMembersInPeriod}');
    content.writeln('');

    // Attendance Section
    content.writeln('--- بخش حضور و غیاب ---');
    content.writeln('کل ورودها: ${report.attendanceData.totalCheckIns}');
    content.writeln('اعضای یکتا: ${report.attendanceData.uniqueMembers}');
    content.writeln('');

    // Buffet Section
    content.writeln('--- بخش بوفه ---');
    content.writeln('کل سفارشات: ${report.buffetData.totalOrders}');
    content.writeln('کل درآمد: ${report.buffetData.totalRevenue.toStringAsFixed(0)} تومان');
    content.writeln('');

    // Financial Section
    content.writeln('--- بخش مالی ---');
    content.writeln('کل درآمد: ${report.financialData.totalIncome.toStringAsFixed(0)} تومان');
    content.writeln('کل هزینه‌ها: ${report.financialData.totalExpenses.toStringAsFixed(0)} تومان');
    content.writeln('سود خالص: ${report.financialData.netProfit.toStringAsFixed(0)} تومان');

    await file.writeAsString(content.toString());
    return file.path;
  }

  Future<String> _saveReportContent(String content, String prefix) async {
    final directory = await _getExportDirectory();
    final fileName = '${prefix}_${_formatDateForFile(DateTime.now())}.txt';
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(content);
    return file.path;
  }

  List<AlertItem> _generateAlerts({
    required MemberReportData memberData,
    required BuffetReportData buffetData,
    required FinancialReportData financialData,
  }) {
    final alerts = <AlertItem>[];

    // Expiring memberships
    if (memberData.expiringMembers.isNotEmpty) {
      alerts.add(AlertItem(
        type: 'EXPIRING_MEMBERSHIP',
        title: 'عضویت در حال انقضا',
        message: '${memberData.expiringMembers.length} عضویت تا 7 روز آینده منقضی می‌شود',
        severity: 'MEDIUM',
        createdAt: DateTime.now(),
      ));
    }

    // Overdue payments
    if (memberData.overdueMembers.isNotEmpty) {
      alerts.add(AlertItem(
        type: 'OVERDUE_PAYMENT',
        title: 'پرداخت معوق',
        message: '${memberData.overdueMembers.length} عضو پرداخت معوق دارند',
        severity: 'HIGH',
        createdAt: DateTime.now(),
      ));
    }

    // Low stock
    if (buffetData.lowStockItems.isNotEmpty) {
      alerts.add(AlertItem(
        type: 'LOW_STOCK',
        title: 'موجودی کم',
        message: '${buffetData.lowStockItems.length} محصول موجودی کم دارند',
        severity: 'MEDIUM',
        createdAt: DateTime.now(),
      ));
    }

    // Low profit margin
    if (financialData.profitMargin < 10 && financialData.totalIncome > 0) {
      alerts.add(AlertItem(
        type: 'LOW_PROFIT_MARGIN',
        title: 'حاشیه سود پایین',
        message: 'حاشیه سود فعلی ${financialData.profitMargin.toStringAsFixed(1)}% است',
        severity: 'HIGH',
        createdAt: DateTime.now(),
      ));
    }

    return alerts;
  }
}