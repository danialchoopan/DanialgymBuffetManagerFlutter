import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/workout/exercise_log_entity.dart';
import '../../../domain/repositories/workout_repository.dart';

class TrackProgressUseCase {
  final WorkoutRepository _repository;

  TrackProgressUseCase(this._repository);

  Future<Either<Failure, List<ExerciseLogEntity>>> call(String memberId) async {
    return await _repository.getLogsByMemberId(memberId);
  }
}