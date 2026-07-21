import '../../../core/database/entities/workout/workout_program_entity.dart';
import '../../../core/database/entities/workout/exercise_entity.dart';
import '../../../core/database/entities/workout/workout_session_entity.dart';
import '../../../core/database/entities/workout/exercise_log_entity.dart';

class WorkoutMapper {
  static WorkoutProgramEntity toProgramEntity(Map<String, dynamic> map) {
    return WorkoutProgramEntity(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      type: map['type'],
      difficultyLevel: map['difficulty_level'],
      durationWeeks: map['duration_weeks'],
      daysPerWeek: map['days_per_week'],
      goals: map['goals'],
      notes: map['notes'],
      isTemplate: map['is_template'] ?? false,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      isActive: map['is_active'] ?? true,
    );
  }

  static Map<String, dynamic> toProgramMap(WorkoutProgramEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'description': entity.description,
      'type': entity.type,
      'difficulty_level': entity.difficultyLevel,
      'duration_weeks': entity.durationWeeks,
      'days_per_week': entity.daysPerWeek,
      'goals': entity.goals,
      'notes': entity.notes,
      'is_template': entity.isTemplate,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt.toIso8601String(),
      'is_active': entity.isActive,
    };
  }

  static ExerciseEntity toExerciseEntity(Map<String, dynamic> map) {
    return ExerciseEntity(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      muscleGroup: map['muscle_group'],
      secondaryMuscles: map['secondary_muscles'],
      equipment: map['equipment'],
      difficultyLevel: map['difficulty_level'],
      instructions: map['instructions'],
      videoUrl: map['video_url'],
      imagePath: map['image_path'],
      isCompound: map['is_compound'] ?? false,
      createdAt: DateTime.parse(map['created_at']),
      isActive: map['is_active'] ?? true,
    );
  }

  static Map<String, dynamic> toExerciseMap(ExerciseEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'description': entity.description,
      'muscle_group': entity.muscleGroup,
      'secondary_muscles': entity.secondaryMuscles,
      'equipment': entity.equipment,
      'difficulty_level': entity.difficultyLevel,
      'instructions': entity.instructions,
      'video_url': entity.videoUrl,
      'image_path': entity.imagePath,
      'is_compound': entity.isCompound,
      'created_at': entity.createdAt.toIso8601String(),
      'is_active': entity.isActive,
    };
  }

  static WorkoutSessionEntity toSessionEntity(Map<String, dynamic> map) {
    return WorkoutSessionEntity(
      id: map['id'],
      memberId: map['member_id'],
      programId: map['program_id'],
      trainerId: map['trainer_id'],
      scheduledDate: DateTime.parse(map['scheduled_date']),
      startTime: map['start_time'],
      endTime: map['end_time'],
      status: map['status'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  static Map<String, dynamic> toSessionMap(WorkoutSessionEntity entity) {
    return {
      'id': entity.id,
      'member_id': entity.memberId,
      'program_id': entity.programId,
      'trainer_id': entity.trainerId,
      'scheduled_date': entity.scheduledDate.toIso8601String(),
      'start_time': entity.startTime,
      'end_time': entity.endTime,
      'status': entity.status,
      'notes': entity.notes,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt.toIso8601String(),
    };
  }

  static ExerciseLogEntity toLogEntity(Map<String, dynamic> map) {
    return ExerciseLogEntity(
      id: map['id'],
      memberId: map['member_id'],
      exerciseId: map['exercise_id'],
      sessionId: map['session_id'],
      sets: map['sets'],
      reps: map['reps'],
      weight: map['weight']?.toDouble(),
      durationSeconds: map['duration_seconds'],
      distanceKm: map['distance_km']?.toDouble(),
      restSeconds: map['rest_seconds'],
      notes: map['notes'],
      performedDate: DateTime.parse(map['performed_date']),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  static Map<String, dynamic> toLogMap(ExerciseLogEntity entity) {
    return {
      'id': entity.id,
      'member_id': entity.memberId,
      'exercise_id': entity.exerciseId,
      'session_id': entity.sessionId,
      'sets': entity.sets,
      'reps': entity.reps,
      'weight': entity.weight,
      'duration_seconds': entity.durationSeconds,
      'distance_km': entity.distanceKm,
      'rest_seconds': entity.restSeconds,
      'notes': entity.notes,
      'performed_date': entity.performedDate.toIso8601String(),
      'created_at': entity.createdAt.toIso8601String(),
    };
  }
}