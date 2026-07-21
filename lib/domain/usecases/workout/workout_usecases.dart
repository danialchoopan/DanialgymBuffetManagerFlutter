import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import '../repositories/workout_repository.dart';
import '../entities/workout/workout_entities.dart';
import '../entities/value_objects/enums.dart';

// Use Case: Create Workout Program
class CreateWorkoutProgramUseCase {
  final WorkoutRepository _repository;

  CreateWorkoutProgramUseCase(this._repository);

  Future<Either<Failure, WorkoutProgramEntity>> call(WorkoutProgramEntity program) async {
    if (program.name.isEmpty) {
      return const Left(ValidationFailure(message: 'Program name is required'));
    }
    if (program.workouts.isEmpty) {
      return const Left(ValidationFailure(message: 'Program must have at least one workout'));
    }
    return await _repository.addWorkoutProgram(program);
  }
}

// Use Case: Assign Program to Member
class AssignProgramToMemberUseCase {
  final WorkoutRepository _repository;

  AssignProgramToMemberUseCase(this._repository);

  Future<Either<Failure, void>> call(AssignProgramParams params) async {
    // Check if already assigned
    final isAssigned = await _repository.isProgramAssignedToMember(
      params.memberId,
      params.programId,
    );
    return isAssigned.fold(
      (failure) => Left(failure),
      (assigned) {
        if (assigned) {
          return const Left(ProgramAlreadyAssignedFailure());
        }
        return _repository.assignProgramToMember(params.memberId, params.programId);
      },
    );
  }
}

class AssignProgramParams {
  final String memberId;
  final String programId;

  const AssignProgramParams({
    required this.memberId,
    required this.programId,
  });
}

// Use Case: Log Exercise
class LogExerciseUseCase {
  final WorkoutRepository _repository;

  LogExerciseUseCase(this._repository);

  Future<Either<Failure, WorkoutLogEntity>> call(WorkoutLogEntity log) async {
    if (log.actualWeight < 0) {
      return const Left(ValidationFailure(message: 'Weight cannot be negative'));
    }
    if (log.actualReps <= 0) {
      return const Left(ValidationFailure(message: 'Reps must be greater than 0'));
    }
    if (log.actualSets <= 0) {
      return const Left(ValidationFailure(message: 'Sets must be greater than 0'));
    }
    return await _repository.logWorkout(log);
  }
}

// Use Case: Track Member Progress
class TrackMemberProgressUseCase {
  final WorkoutRepository _repository;

  TrackMemberProgressUseCase(this._repository);

  Future<Either<Failure, MemberProgressEntity>> call(String memberId) async {
    return await _repository.getMemberProgress(memberId);
  }
}

// Use Case: Get Exercise Library
class GetExerciseLibraryUseCase {
  final WorkoutRepository _repository;

  GetExerciseLibraryUseCase(this._repository);

  Future<Either<Failure, List<ExerciseEntity>>> call(ExerciseLibraryParams params) async {
    if (params.category != null) {
      return await _repository.getExercisesByCategory(params.category!);
    }
    if (params.muscleGroup != null) {
      return await _repository.getExercisesByMuscleGroup(params.muscleGroup!);
    }
    if (params.difficulty != null) {
      return await _repository.getExercisesByDifficulty(params.difficulty!);
    }
    if (params.query != null && params.query!.isNotEmpty) {
      return await _repository.searchExercises(params.query!);
    }
    return await _repository.getAllExercises();
  }
}

class ExerciseLibraryParams {
  final ExerciseCategory? category;
  final MuscleGroup? muscleGroup;
  final DifficultyLevel? difficulty;
  final String? query;

  const ExerciseLibraryParams({
    this.category,
    this.muscleGroup,
    this.difficulty,
    this.query,
  });
}

// Use Case: Calculate One Rep Max
class CalculateOneRepMaxUseCase {
  final WorkoutRepository _repository;

  CalculateOneRepMaxUseCase(this._repository);

  double call(CalculateOneRepMaxParams params) {
    // Epley formula: 1RM = weight × (1 + reps/30)
    if (params.reps == 1) return params.weight;
    return params.weight * (1 + params.reps / 30);
  }
}

class CalculateOneRepMaxParams {
  final double weight;
  final int reps;

  const CalculateOneRepMaxParams({
    required this.weight,
    required this.reps,
  });
}

// Use Case: Get Member Workout History
class GetMemberWorkoutHistoryUseCase {
  final WorkoutRepository _repository;

  GetMemberWorkoutHistoryUseCase(this._repository);

  Future<Either<Failure, List<WorkoutLogEntity>>> call(String memberId) async {
    return await _repository.getMemberWorkoutLogs(memberId);
  }
}

// Use Case: Generate Progress Report
class GenerateProgressReportUseCase {
  final WorkoutRepository _repository;

  GenerateProgressReportUseCase(this._repository);

  Future<Either<Failure, ProgressReport>> call(ProgressReportParams params) async {
    final progressResult = await _repository.getMemberProgressHistory(params.memberId);
    final logsResult = await _repository.getMemberWorkoutLogs(params.memberId);

    return progressResult.fold(
      (failure) => Left(failure),
      (progressHistory) => logsResult.fold(
        (failure) => Left(failure),
        (logs) {
          // Generate report data
          final report = ProgressReport(
            memberId: params.memberId,
            progressHistory: progressHistory,
            workoutLogs: logs,
            startDate: params.startDate,
            endDate: params.endDate,
          );
          return Right(report);
        },
      ),
    );
  }
}

class ProgressReportParams {
  final String memberId;
  final DateTime startDate;
  final DateTime endDate;

  const ProgressReportParams({
    required this.memberId,
    required this.startDate,
    required this.endDate,
  });
}

class ProgressReport {
  final String memberId;
  final List<MemberProgressEntity> progressHistory;
  final List<WorkoutLogEntity> workoutLogs;
  final DateTime startDate;
  final DateTime endDate;

  const ProgressReport({
    required this.memberId,
    required this.progressHistory,
    required this.workoutLogs,
    required this.startDate,
    required this.endDate,
  });

  double get totalWorkouts => workoutLogs.length.toDouble();

  double get averageWorkoutDuration {
    if (workoutLogs.isEmpty) return 0;
    // Simplified calculation
    return 45.0; // Default 45 minutes
  }

  Map<String, double> get muscleGroupDistribution {
    final distribution = <String, double>{};
    for (final log in workoutLogs) {
      final muscle = log.exercise.primaryMuscle.name;
      distribution[muscle] = (distribution[muscle] ?? 0) + 1;
    }
    return distribution;
  }
}

// Use Case: Get Programs by Goal
class GetProgramsByGoalUseCase {
  final WorkoutRepository _repository;

  GetProgramsByGoalUseCase(this._repository);

  Future<Either<Failure, List<WorkoutProgramEntity>>> call(FitnessGoal goal) async {
    return await _repository.getProgramsByGoal(goal);
  }
}

// Use Case: Get Member Assigned Programs
class GetMemberAssignedProgramsUseCase {
  final WorkoutRepository _repository;

  GetMemberAssignedProgramsUseCase(this._repository);

  Future<Either<Failure, List<WorkoutProgramEntity>>> call(String memberId) async {
    return await _repository.getMemberAssignedPrograms(memberId);
  }
}

// Use Case: Unassign Program from Member
class UnassignProgramFromMemberUseCase {
  final WorkoutRepository _repository;

  UnassignProgramFromMemberUseCase(this._repository);

  Future<Either<Failure, void>> call(UnassignProgramParams params) async {
    return await _repository.unassignProgramFromMember(params.memberId, params.programId);
  }
}

class UnassignProgramParams {
  final String memberId;
  final String programId;

  const UnassignProgramParams({
    required this.memberId,
    required this.programId,
  });
}