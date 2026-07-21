import 'package:dartz/dartz.dart';
import '../entities/attendance/attendance_entities.dart';
import '../errors/failures.dart';

abstract class AttendanceRepository {
  // Check-in/Check-out Operations
  Future<Either<Failure, AttendanceEntity>> checkInMember(String memberId, CheckInMethod method);
  Future<Either<Failure, AttendanceEntity>> checkOutMember(String memberId);
  Future<Either<Failure, AttendanceEntity>> checkInMemberWithNotes(String memberId, CheckInMethod method, String? notes);
  Future<Either<Failure, AttendanceEntity>> checkOutMemberWithNotes(String memberId, String? notes);
  
  // Query Operations
  Future<Either<Failure, AttendanceEntity?>> getActiveSession(String memberId);
  Future<Either<Failure, List<AttendanceEntity>>> getActiveSessions();
  Future<Either<Failure, AttendanceEntity?>> getAttendanceById(String id);
  Future<Either<Failure, List<AttendanceEntity>>> getMemberAttendance(String memberId);
  Future<Either<Failure, List<AttendanceEntity>>> getMemberAttendanceByDateRange(
    String memberId,
    DateTime start,
    DateTime end,
  );
  Future<Either<Failure, List<AttendanceEntity>>> getDailyAttendance(DateTime date);
  Future<Either<Failure, List<AttendanceEntity>>> getAttendanceByDateRange(DateTime start, DateTime end);
  
  // Statistics
  Future<Either<Failure, int>> getTodayAttendanceCount();
  Future<Either<Failure, int>> getMemberMonthlyAttendance(String memberId, int month, int year);
  Future<Either<Failure, int>> getMemberTotalVisits(String memberId);
  Future<Either<Failure, DateTime?>> getMemberLastVisitDate(String memberId);
  Future<Either<Failure, Map<int, int>>> getPeakHours(DateTime date);
  Future<Either<Failure, Map<String, int>>> getDailyAttendanceDistribution(DateTime start, DateTime end);
  Future<Either<Failure, double>> getAverageSessionDuration(DateTime start, DateTime end);
  Future<Either<Failure, int>> getUniqueMembersToday();
  Future<Either<Failure, int>> getUniqueMembersByDateRange(DateTime start, DateTime end);
  
  // Reports
  Future<Either<Failure, AttendanceStatsEntity>> getAttendanceStats(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, dynamic>>> getAttendanceReport(DateTime start, DateTime end);
  Future<Either<Failure, List<Map<String, dynamic>>>> getMemberAttendanceSummary(String memberId);
  Future<Either<Failure, Map<String, int>>> getAttendanceByDayOfWeek(DateTime start, DateTime end);
  Future<Either<Failure, Map<String, int>>> getAttendanceByMonth(int year);
  
  // Validation
  Future<Either<Failure, bool>> canCheckIn(String memberId);
  Future<Either<Failure, bool>> isAlreadyCheckedIn(String memberId);
  Future<Either<Failure, AttendanceEntity?>> getTodayCheckIn(String memberId);
}