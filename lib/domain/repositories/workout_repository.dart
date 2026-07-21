import '../entities/workout/workout_program_entity.dart';
import '../entities/workout/exercise_entity.dart';
import '../entities/workout/workout_session_entity.dart';
import '../entities/workout/exercise_log_entity.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class WorkoutRepository {
  // Programs
  ResultFuture<List<WorkoutProgramEntity>> getAllPrograms();
  ResultFuture<WorkoutProgramEntity?> getProgramById(String id);
  ResultFuture<List<WorkoutProgramEntity>> getProgramsByType(String type);
  ResultFuture<List<WorkoutProgramEntity>> getProgramsByDifficulty(String level);
  ResultFuture<void> addProgram(WorkoutProgramEntity program);
  ResultFuture<void> updateProgram(WorkoutProgramEntity program);
  ResultFuture<void> deleteProgram(String id);

  // Exercises
  ResultFuture<List<ExerciseEntity>> getAllExercises();
  ResultFuture<ExerciseEntity?> getExerciseById(String id);
  ResultFuture<List<ExerciseEntity>> getExercisesByMuscleGroup(String muscleGroup);
  ResultFuture<List<ExerciseEntity>> getExercisesByEquipment(String equipment);
  ResultFuture<List<ExerciseEntity>> searchExercises(String query);
  ResultFuture<void> addExercise(ExerciseEntity exercise);
  ResultFuture<void> updateExercise(ExerciseEntity exercise);
  ResultFuture<void> deleteExercise(String id);

  // Sessions
  ResultFuture<List<WorkoutSessionEntity>> getSessionsByMemberId(String memberId);
  ResultFuture<List<WorkoutSessionEntity>> getSessionsByTrainerId(String trainerId);
  ResultFuture<WorkoutSessionEntity?> getSessionById(String id);
  ResultFuture<void> addSession(WorkoutSessionEntity session);
  ResultFuture<void> updateSession(WorkoutSessionEntity session);
  ResultFuture<void> deleteSession(String id);

  // Exercise Logs
  ResultFuture<List<ExerciseLogEntity>> getLogsByMemberId(String memberId);
  ResultFuture<List<ExerciseLogEntity>> getLogsByExerciseId(String exerciseId);
  ResultFuture<List<ExerciseLogEntity>> getLogsBySessionId(String sessionId);
  ResultFuture<void> addLog(ExerciseLogEntity log);
  ResultFuture<void> updateLog(ExerciseLogEntity log);
}