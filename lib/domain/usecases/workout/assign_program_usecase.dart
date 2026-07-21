import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/workout/workout_session_entity.dart';
import '../../../domain/repositories/workout_repository.dart';

class AssignProgramUseCase {
  final WorkoutRepository _repository;

  AssignProgramUseCase(this._repository);

  Future<Either<Failure, void>> call(WorkoutSessionEntity session) async {
    return await _repository.addSession(session);
  }
}