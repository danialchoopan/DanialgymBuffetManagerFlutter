import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/attendance/attendance_entity.dart';
import '../../../domain/repositories/attendance_repository.dart';

class CheckInUseCase {
  final AttendanceRepository _repository;

  CheckInUseCase(this._repository);

  Future<Either<Failure, void>> call(AttendanceEntity attendance) async {
    return await _repository.checkIn(attendance);
  }
}