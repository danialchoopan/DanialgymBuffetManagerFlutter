import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/attendance/attendance_entities.dart';

// ============================================================
// ATTENDANCE STATES
// ============================================================

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {
  const AttendanceInitial();
}

class AttendanceLoading extends AttendanceState {
  final String? message;

  const AttendanceLoading({this.message});

  @override
  List<Object?> get props => [message];
}

class ActiveSessionsLoaded extends AttendanceState {
  final List<AttendanceEntity> activeSessions;
  final int totalCheckedIn;

  const ActiveSessionsLoaded({
    required this.activeSessions,
    required this.totalCheckedIn,
  });

  @override
  List<Object?> get props => [activeSessions, totalCheckedIn];
}

class DailyAttendanceLoaded extends AttendanceState {
  final List<AttendanceEntity> attendance;
  final int totalCount;
  final DateTime date;

  const DailyAttendanceLoaded({
    required this.attendance,
    required this.totalCount,
    required this.date,
  });

  @override
  List<Object?> get props => [attendance, totalCount, date];
}

class MemberAttendanceLoaded extends AttendanceState {
  final String memberId;
  final List<AttendanceEntity> attendance;
  final int totalVisits;
  final double averageDuration;

  const MemberAttendanceLoaded({
    required this.memberId,
    required this.attendance,
    required this.totalVisits,
    required this.averageDuration,
  });

  @override
  List<Object?> get props => [memberId, attendance, totalVisits, averageDuration];
}

class AttendanceStatsLoaded extends AttendanceState {
  final AttendanceStatsEntity stats;
  final Map<int, int> peakHours;
  final Map<String, int> dailyDistribution;

  const AttendanceStatsLoaded({
    required this.stats,
    required this.peakHours,
    required this.dailyDistribution,
  });

  @override
  List<Object?> get props => [stats, peakHours, dailyDistribution];
}

class CheckInSuccess extends AttendanceState {
  final AttendanceEntity attendance;
  final String memberName;

  const CheckInSuccess({
    required this.attendance,
    required this.memberName,
  });

  @override
  List<Object?> get props => [attendance, memberName];
}

class CheckOutSuccess extends AttendanceState {
  final AttendanceEntity attendance;
  final int durationMinutes;

  const CheckOutSuccess({
    required this.attendance,
    required this.durationMinutes,
  });

  @override
  List<Object?> get props => [attendance, durationMinutes];
}

class AttendanceError extends AttendanceState {
  final String message;
  final String? code;

  const AttendanceError({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

class AttendanceOperationSuccess extends AttendanceState {
  final String message;

  const AttendanceOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

// ============================================================
// ATTENDANCE EVENTS
// ============================================================

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class CheckInMemberRequested extends AttendanceEvent {
  final String memberId;
  final CheckInMethod method;

  const CheckInMemberRequested({
    required this.memberId,
    this.method = CheckInMethod.manual,
  });

  @override
  List<Object?> get props => [memberId, method];
}

class CheckOutMemberRequested extends AttendanceEvent {
  final String memberId;

  const CheckOutMemberRequested({required this.memberId});

  @override
  List<Object?> get props => [memberId];
}

class FetchActiveSessionsRequested extends AttendanceEvent {
  const FetchActiveSessionsRequested();
}

class FetchDailyAttendanceRequested extends AttendanceEvent {
  final DateTime date;

  const FetchDailyAttendanceRequested({required this.date});

  @override
  List<Object?> get props => [date];
}

class FetchMemberAttendanceRequested extends AttendanceEvent {
  final String memberId;

  const FetchMemberAttendanceRequested({required this.memberId});

  @override
  List<Object?> get props => [memberId];
}

class FetchAttendanceStatsRequested extends AttendanceEvent {
  final DateTime startDate;
  final DateTime endDate;

  const FetchAttendanceStatsRequested({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}

class RefreshAttendanceRequested extends AttendanceEvent {
  const RefreshAttendanceRequested();
}

class GenerateAttendanceReportRequested extends AttendanceEvent {
  final DateTime startDate;
  final DateTime endDate;
  final String format;

  const GenerateAttendanceReportRequested({
    required this.startDate,
    required this.endDate,
    required this.format,
  });

  @override
  List<Object?> get props => [startDate, endDate, format];
}

class ScanQRCodeRequested extends AttendanceEvent {
  final String qrData;

  const ScanQRCodeRequested({required this.qrData});

  @override
  List<Object?> get props => [qrData];
}

// ============================================================
// ATTENDANCE BLOC
// ============================================================

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  // Dependencies would be injected via constructor
  // final AttendanceRepository _attendanceRepository;
  // final MemberRepository _memberRepository;

  AttendanceBloc() : super(const AttendanceInitial()) {
    on<CheckInMemberRequested>(_onCheckInMember);
    on<CheckOutMemberRequested>(_onCheckOutMember);
    on<FetchActiveSessionsRequested>(_onFetchActiveSessions);
    on<FetchDailyAttendanceRequested>(_onFetchDailyAttendance);
    on<FetchMemberAttendanceRequested>(_onFetchMemberAttendance);
    on<FetchAttendanceStatsRequested>(_onFetchAttendanceStats);
    on<RefreshAttendanceRequested>(_onRefreshAttendance);
    on<GenerateAttendanceReportRequested>(_onGenerateReport);
    on<ScanQRCodeRequested>(_onScanQRCode);
  }

  // ============================================================
  // EVENT HANDLERS
  // ============================================================

  Future<void> _onCheckInMember(
    CheckInMemberRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading(message: 'در حال ثبت ورود...'));

    try {
      // Validate member exists and is active
      final member = await _getMemberById(event.memberId);
      if (member == null) {
        emit(const AttendanceError(
          message: 'عضو مورد نظر یافت نشد.',
          code: 'MEMBER_NOT_FOUND',
        ));
        return;
      }

      // Check if membership is valid
      if (!member.canAccessGym) {
        emit(AttendanceError(
          message: member.membershipStatus.toString() == 'EXPIRED'
              ? 'عضویت منقضی شده است.'
              : 'عضویت فعال نیست.',
          code: 'MEMBERSHIP_INVALID',
        ));
        return;
      }

      // Check if already checked in
      final isCheckedIn = await _isAlreadyCheckedIn(event.memberId);
      if (isCheckedIn) {
        emit(const AttendanceError(
          message: 'عضو قبلاً ورود زده است.',
          code: 'ALREADY_CHECKED_IN',
        ));
        return;
      }

      // Check gym capacity
      final currentCount = await _getCurrentCheckedInCount();
      const maxCapacity = 100; // Configurable
      if (currentCount >= maxCapacity) {
        emit(const AttendanceError(
          message: 'ظرفیت سالن تکمیل است.',
          code: 'GYM_FULL',
        ));
        return;
      }

      // Create attendance record
      final attendance = AttendanceEntity(
        id: _generateAttendanceId(),
        memberId: event.memberId,
        memberName: member.fullName,
        checkInTime: DateTime.now(),
        checkInMethod: event.method,
        createdAt: DateTime.now(),
      );

      // Save to repository
      await _saveAttendance(attendance);

      // Update member's visit count
      await _updateMemberVisits(event.memberId);

      emit(CheckInSuccess(
        attendance: attendance,
        memberName: member.fullName,
      ));
    } catch (e) {
      emit(AttendanceError(
        message: 'خطا در ثبت ورود.',
        code: 'CHECK_IN_ERROR',
      ));
    }
  }

  Future<void> _onCheckOutMember(
    CheckOutMemberRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading(message: 'در حال ثبت خروج...'));

    try {
      // Find active session
      final activeSession = await _getActiveSession(event.memberId);
      if (activeSession == null) {
        emit(const AttendanceError(
          message: 'ورودی فعالی برای این عضو یافت نشد.',
          code: 'NO_ACTIVE_SESSION',
        ));
        return;
      }

      // Calculate duration
      final checkOutTime = DateTime.now();
      final durationMinutes = checkOutTime.difference(activeSession.checkInTime).inMinutes;

      // Update attendance record
      final updatedAttendance = activeSession.copyWith(
        checkOutTime: checkOutTime,
      );

      await _updateAttendance(updatedAttendance);

      emit(CheckOutSuccess(
        attendance: updatedAttendance,
        durationMinutes: durationMinutes,
      ));
    } catch (e) {
      emit(AttendanceError(
        message: 'خطا در ثبت خروج.',
        code: 'CHECK_OUT_ERROR',
      ));
    }
  }

  Future<void> _onFetchActiveSessions(
    FetchActiveSessionsRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading(message: 'در حال بارگذاری...'));

    try {
      final activeSessions = await _getActiveSessions();

      emit(ActiveSessionsLoaded(
        activeSessions: activeSessions,
        totalCheckedIn: activeSessions.length,
      ));
    } catch (e) {
      emit(AttendanceError(
        message: 'خطا در بارگذاری.',
        code: 'FETCH_ACTIVE_ERROR',
      ));
    }
  }

  Future<void> _onFetchDailyAttendance(
    FetchDailyAttendanceRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading(message: 'در حال بارگذاری...'));

    try {
      final attendance = await _getDailyAttendance(event.date);

      emit(DailyAttendanceLoaded(
        attendance: attendance,
        totalCount: attendance.length,
        date: event.date,
      ));
    } catch (e) {
      emit(AttendanceError(
        message: 'خطا در بارگذاری.',
        code: 'FETCH_DAILY_ERROR',
      ));
    }
  }

  Future<void> _onFetchMemberAttendance(
    FetchMemberAttendanceRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading(message: 'در حال بارگذاری تاریخچه حضور...'));

    try {
      final attendance = await _getMemberAttendance(event.memberId);
      final totalVisits = attendance.length;
      final totalDuration = attendance
          .where((a) => a.durationMinutes != null)
          .fold<int>(0, (sum, a) => sum + a.durationMinutes!);
      final averageDuration = totalVisits > 0 ? totalDuration / totalVisits : 0.0;

      emit(MemberAttendanceLoaded(
        memberId: event.memberId,
        attendance: attendance,
        totalVisits: totalVisits,
        averageDuration: averageDuration,
      ));
    } catch (e) {
      emit(AttendanceError(
        message: 'خطا در بارگذاری تاریخچه حضور.',
        code: 'FETCH_MEMBER_ATTENDANCE_ERROR',
      ));
    }
  }

  Future<void> _onFetchAttendanceStats(
    FetchAttendanceStatsRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading(message: 'در حال بارگذاری آمار...'));

    try {
      final stats = await _getAttendanceStats(event.startDate, event.endDate);
      final peakHours = await _getPeakHours(event.startDate, event.endDate);
      final dailyDistribution = await _getDailyDistribution(event.startDate, event.endDate);

      emit(AttendanceStatsLoaded(
        stats: stats,
        peakHours: peakHours,
        dailyDistribution: dailyDistribution,
      ));
    } catch (e) {
      emit(AttendanceError(
        message: 'خطا در بارگذاری آمار.',
        code: 'FETCH_STATS_ERROR',
      ));
    }
  }

  Future<void> _onRefreshAttendance(
    RefreshAttendanceRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    add(const FetchActiveSessionsRequested());
  }

  Future<void> _onGenerateReport(
    GenerateAttendanceReportRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading(message: 'در حال تولید گزارش...'));

    try {
      // Generate report based on format
      if (event.format == 'PDF') {
        await _generatePDFReport(event.startDate, event.endDate);
      } else if (event.format == 'CSV') {
        await _generateCSVReport(event.startDate, event.endDate);
      }

      emit(const AttendanceOperationSuccess(
        message: 'گزارش با موفقیت تولید شد.',
      ));
    } catch (e) {
      emit(AttendanceError(
        message: 'خطا در تولید گزارش.',
        code: 'GENERATE_REPORT_ERROR',
      ));
    }
  }

  Future<void> _onScanQRCode(
    ScanQRCodeRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const AttendanceLoading(message: 'در حال پردازش...'));

    try {
      // Parse QR data to get member ID
      final memberId = _parseQRData(event.qrData);

      if (memberId == null) {
        emit(const AttendanceError(
          message: 'کد QR نامعتبر است.',
          code: 'INVALID_QR_CODE',
        ));
        return;
      }

      // Check if member is already checked in
      final isCheckedIn = await _isAlreadyCheckedIn(memberId);

      if (isCheckedIn) {
        // Check out
        add(CheckOutMemberRequested(memberId: memberId));
      } else {
        // Check in
        add(CheckInMemberRequested(
          memberId: memberId,
          method: CheckInMethod.qrCode,
        ));
      }
    } catch (e) {
      emit(AttendanceError(
        message: 'خطا در پردازش کد QR.',
        code: 'QR_SCAN_ERROR',
      ));
    }
  }

  // ============================================================
  // PRIVATE HELPER METHODS
  // ============================================================

  String _generateAttendanceId() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final timePart = '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
    return 'ATT$datePart$timePart';
  }

  String? _parseQRData(String qrData) {
    // Parse QR data format: GYM:MEMBER_ID
    if (qrData.startsWith('GYM:')) {
      return qrData.substring(4);
    }
    return null;
  }

  // Placeholder methods - would use actual repositories
  Future<dynamic> _getMemberById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return null;
  }

  Future<bool> _isAlreadyCheckedIn(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return false;
  }

  Future<int> _getCurrentCheckedInCount() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return 0;
  }

  Future<void> _saveAttendance(AttendanceEntity attendance) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _updateMemberVisits(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<AttendanceEntity?> _getActiveSession(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return null;
  }

  Future<void> _updateAttendance(AttendanceEntity attendance) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<List<AttendanceEntity>> _getActiveSessions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  Future<List<AttendanceEntity>> _getDailyAttendance(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  Future<List<AttendanceEntity>> _getMemberAttendance(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  Future<AttendanceStatsEntity> _getAttendanceStats(DateTime start, DateTime end) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return AttendanceStatsEntity(
      startDate: start,
      endDate: end,
      totalCheckIns: 0,
      uniqueMembers: 0,
      averageDuration: 0,
      peakHours: {},
      dailyDistribution: {},
      averageDailyAttendance: 0,
    );
  }

  Future<Map<int, int>> _getPeakHours(DateTime start, DateTime end) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return {};
  }

  Future<Map<String, int>> _getDailyDistribution(DateTime start, DateTime end) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return {};
  }

  Future<void> _generatePDFReport(DateTime start, DateTime end) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _generateCSVReport(DateTime start, DateTime end) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}