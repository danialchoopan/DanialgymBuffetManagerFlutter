import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/repositories/attendance_repository.dart';

class CheckOutUseCase {
  final AttendanceRepository _repository;

  CheckOutUseCase(this._repository);

  Future<Either<Failure, void>> call(String attendanceId) async {
    return await _repository.checkOut(attendanceId, DateTime.now());
  }
}