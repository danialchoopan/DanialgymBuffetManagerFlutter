import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import '../repositories/attendance_repository.dart';
import '../entities/attendance/attendance_entities.dart';

// Use Case: Check In Member
class CheckInMemberUseCase {
  final AttendanceRepository _repository;

  CheckInMemberUseCase(this._repository);

  Future<Either<Failure, AttendanceEntity>> call(CheckInParams params) async {
    // Check if already checked in
    final isAlreadyCheckedIn = await _repository.isAlreadyCheckedIn(params.memberId);
    return isAlreadyCheckedIn.fold(
      (failure) => Left(failure),
      (checkedIn) {
        if (checkedIn) {
          return const Left(AlreadyCheckedInFailure());
        }
        return _repository.checkInMember(params.memberId, params.method);
      },
    );
  }
}

class CheckInParams {
  final String memberId;
  final CheckInMethod method;

  const CheckInParams({
    required this.memberId,
    required this.method,
  });
}

// Use Case: Check Out Member
class CheckOutMemberUseCase {
  final AttendanceRepository _repository;

  CheckOutMemberUseCase(this._repository);

  Future<Either<Failure, AttendanceEntity>> call(String memberId) async {
    // Check if checked in
    final isCheckedIn = await _repository.isAlreadyCheckedIn(memberId);
    return isCheckedIn.fold(
      (failure) => Left(failure),
      (checkedIn) {
        if (!checkedIn) {
          return const Left(NotCheckedInFailure());
        }
        return _repository.checkOutMember(memberId);
      },
    );
  }
}

// Use Case: Get Daily Attendance
class GetDailyAttendanceUseCase {
  final AttendanceRepository _repository;

  GetDailyAttendanceUseCase(this._repository);

  Future<Either<Failure, List<AttendanceEntity>>> call(DateTime date) async {
    return await _repository.getDailyAttendance(date);
  }
}

// Use Case: Get Attendance Stats
class GetAttendanceStatsUseCase {
  final AttendanceRepository _repository;

  GetAttendanceStatsUseCase(this._repository);

  Future<Either<Failure, AttendanceStatsEntity>> call(AttendanceStatsParams params) async {
    return await _repository.getAttendanceStats(params.startDate, params.endDate);
  }
}

class AttendanceStatsParams {
  final DateTime startDate;
  final DateTime endDate;

  const AttendanceStatsParams({
    required this.startDate,
    required this.endDate,
  });
}

// Use Case: Get Member Attendance
class GetMemberAttendanceUseCase {
  final AttendanceRepository _repository;

  GetMemberAttendanceUseCase(this._repository);

  Future<Either<Failure, List<AttendanceEntity>>> call(String memberId) async {
    return await _repository.getMemberAttendance(memberId);
  }
}

// Use Case: Get Member Monthly Attendance
class GetMemberMonthlyAttendanceUseCase {
  final AttendanceRepository _repository;

  GetMemberMonthlyAttendanceUseCase(this._repository);

  Future<Either<Failure, int>> call(MemberMonthlyAttendanceParams params) async {
    return await _repository.getMemberMonthlyAttendance(
      params.memberId,
      params.month,
      params.year,
    );
  }
}

class MemberMonthlyAttendanceParams {
  final String memberId;
  final int month;
  final int year;

  const MemberMonthlyAttendanceParams({
    required this.memberId,
    required this.month,
    required this.year,
  });
}

// Use Case: Get Peak Hours
class GetPeakHoursUseCase {
  final AttendanceRepository _repository;

  GetPeakHoursUseCase(this._repository);

  Future<Either<Failure, Map<int, int>>> call(DateTime date) async {
    return await _repository.getPeakHours(date);
  }
}

// Use Case: Get Today Attendance Count
class GetTodayAttendanceCountUseCase {
  final AttendanceRepository _repository;

  GetTodayAttendanceCountUseCase(this._repository);

  Future<Either<Failure, int>> call() async {
    return await _repository.getTodayAttendanceCount();
  }
}

// Use Case: Get Active Sessions
class GetActiveSessionsUseCase {
  final AttendanceRepository _repository;

  GetActiveSessionsUseCase(this._repository);

  Future<Either<Failure, List<AttendanceEntity>>> call() async {
    return await _repository.getActiveSessions();
  }
}

// Use Case: Get Member Last Visit
class GetMemberLastVisitUseCase {
  final AttendanceRepository _repository;

  GetMemberLastVisitUseCase(this._repository);

  Future<Either<Failure, DateTime?>> call(String memberId) async {
    return await _repository.getMemberLastVisitDate(memberId);
  }
}