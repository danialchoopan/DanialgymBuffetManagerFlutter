import '../entities/attendance/attendance_entity.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AttendanceRepository {
  ResultFuture<List<AttendanceEntity>> getAllAttendance();
  ResultFuture<AttendanceEntity?> getAttendanceById(String id);
  ResultFuture<List<AttendanceEntity>> getAttendanceByMemberId(String memberId);
  ResultFuture<List<AttendanceEntity>> getAttendanceByDate(DateTime date);
  ResultFuture<AttendanceEntity?> getTodayAttendance(String memberId, DateTime date);
  ResultFuture<void> checkIn(AttendanceEntity attendance);
  ResultFuture<void> checkOut(String attendanceId, DateTime checkOutTime);
  ResultFuture<int> getMemberAttendanceCount(String memberId, DateTime startDate, DateTime endDate);
  ResultFuture<int> getDailyAttendanceCount(DateTime date);
  ResultFuture<List<Map<String, dynamic>>> getAttendanceReport(DateTime startDate, DateTime endDate);
}