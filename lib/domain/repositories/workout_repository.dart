import 'package:dartz/dartz.dart';
import '../entities/workout/workout_entities.dart';
import '../entities/value_objects/enums.dart';
import '../errors/failures.dart';

abstract class WorkoutRepository {
  // Exercise Operations
  Future<Either<Failure, ExerciseEntity>> addExercise(ExerciseEntity exercise);
  Future<Either<Failure, ExerciseEntity>> updateExercise(ExerciseEntity exercise);
  Future<Either<Failure, void>> deleteExercise(String id);
  Future<Either<Failure, ExerciseEntity?>> getExerciseById(String id);
  Future<Either<Failure, List<ExerciseEntity>>> getAllExercises();
  Future<Either<Failure, List<ExerciseEntity>>> getExercisesByCategory(ExerciseCategory category);
  Future<Either<Failure, List<ExerciseEntity>>> getExercisesByType(ExerciseType type);
  Future<Either<Failure, List<ExerciseEntity>>> getExercisesByDifficulty(DifficultyLevel difficulty);
  Future<Either<Failure, List<ExerciseEntity>>> getExercisesByMuscleGroup(MuscleGroup muscleGroup);
  Future<Either<Failure, List<ExerciseEntity>>> searchExercises(String query);
  Future<Either<Failure, List<ExerciseEntity>>> getExercisesByEquipment(Equipment equipment);
  Future<Either<Failure, List<ExerciseEntity>>> getBodyweightExercises();
  
  // Program Operations
  Future<Either<Failure, WorkoutProgramEntity>> addWorkoutProgram(WorkoutProgramEntity program);
  Future<Either<Failure, WorkoutProgramEntity>> updateWorkoutProgram(WorkoutProgramEntity program);
  Future<Either<Failure, void>> deleteWorkoutProgram(String id);
  Future<Either<Failure, WorkoutProgramEntity?>> getWorkoutProgramById(String id);
  Future<Either<Failure, List<WorkoutProgramEntity>>> getAllPrograms();
  Future<Either<Failure, List<WorkoutProgramEntity>>> getProgramsByType(ProgramType type);
  Future<Either<Failure, List<WorkoutProgramEntity>>> getProgramsByGoal(FitnessGoal goal);
  Future<Either<Failure, List<WorkoutProgramEntity>>> getProgramsByDifficulty(DifficultyLevel difficulty);
  Future<Either<Failure, List<WorkoutProgramEntity>>> getProgramsByDuration(int weeks);
  Future<Either<Failure, List<WorkoutProgramEntity>>> getTemplatePrograms();
  Future<Either<Failure, List<WorkoutProgramEntity>>> searchPrograms(String query);
  
  // Program Assignment
  Future<Either<Failure, void>> assignProgramToMember(String memberId, String programId);
  Future<Either<Failure, void>> unassignProgramFromMember(String memberId, String programId);
  Future<Either<Failure, List<WorkoutProgramEntity>>> getMemberAssignedPrograms(String memberId);
  Future<Either<Failure, bool>> isProgramAssignedToMember(String memberId, String programId);
  
  // Workout Log Operations
  Future<Either<Failure, WorkoutLogEntity>> logWorkout(WorkoutLogEntity log);
  Future<Either<Failure, WorkoutLogEntity>> updateWorkoutLog(WorkoutLogEntity log);
  Future<Either<Failure, void>> deleteWorkoutLog(String logId);
  Future<Either<Failure, List<WorkoutLogEntity>>> getMemberWorkoutLogs(String memberId);
  Future<Either<Failure, List<WorkoutLogEntity>>> getMemberWorkoutLogsByDateRange(
    String memberId,
    DateTime start,
    DateTime end,
  );
  Future<Either<Failure, List<WorkoutLogEntity>>> getMemberRecentWorkouts(String memberId, int limit);
  Future<Either<Failure, List<WorkoutLogEntity>>> getWorkoutLogsByExercise(String exerciseId);
  Future<Either<Failure, List<WorkoutLogEntity>>> getWorkoutLogsByDate(DateTime date);
  
  // Progress Operations
  Future<Either<Failure, MemberProgressEntity>> getMemberProgress(String memberId);
  Future<Either<Failure, MemberProgressEntity>> updateMemberProgress(MemberProgressEntity progress);
  Future<Either<Failure, List<MemberProgressEntity>>> getMemberProgressHistory(String memberId);
  Future<Either<Failure, MemberProgressEntity?>> getLatestProgress(String memberId);
  Future<Either<Failure, List<MemberProgressEntity>>> getProgressByDateRange(
    String memberId,
    DateTime start,
    DateTime end,
  );
  
  // Statistics
  Future<Either<Failure, int>> getExerciseCount();
  Future<Either<Failure, int>> getProgramCount();
  Future<Either<Failure, Map<String, int>>> getExerciseCountByCategory();
  Future<Either<Failure, Map<String, int>>> getProgramCountByType();
  Future<Either<Failure, List<ExerciseEntity>>> getMostUsedExercises(int limit);
  Future<Either<Failure, List<WorkoutProgramEntity>>> getMostPopularPrograms(int limit);
  Future<Either<Failure, double>> getAverageWorkoutDuration(String memberId);
  Future<Either<Failure, int>> getMemberWorkoutFrequency(String memberId);
}