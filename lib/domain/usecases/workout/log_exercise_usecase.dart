import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/workout/exercise_log_entity.dart';
import '../../../domain/repositories/workout_repository.dart';

class LogExerciseUseCase {
  final WorkoutRepository _repository;

  LogExerciseUseCase(this._repository);

  Future<Either<Failure, void>> call(ExerciseLogEntity log) async {
    return await _repository.addLog(log);
  }
}