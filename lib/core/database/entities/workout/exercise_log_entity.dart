import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.exerciseLogsTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['member_id'],
      parentColumns: ['id'],
      entity: MemberEntity,
    ),
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['id'],
      entity: ExerciseEntity,
    ),
    ForeignKey(
      childColumns: ['session_id'],
      parentColumns: ['id'],
      entity: WorkoutSessionEntity,
    ),
  ],
)
class ExerciseLogEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'member_id')
  final String memberId;

  @ColumnInfo(name: 'exercise_id')
  final String exerciseId;

  @ColumnInfo(name: 'session_id')
  final String? sessionId;

  @ColumnInfo(name: 'sets')
  final int sets;

  @ColumnInfo(name: 'reps')
  final int reps;

  @ColumnInfo(name: 'weight')
  final double? weight;

  @ColumnInfo(name: 'duration_seconds')
  final int? durationSeconds;

  @ColumnInfo(name: 'distance_km')
  final double? distanceKm;

  @ColumnInfo(name: 'rest_seconds')
  final int? restSeconds;

  @ColumnInfo(name: 'notes')
  final String? notes;

  @ColumnInfo(name: 'performed_date')
  final DateTime performedDate;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  ExerciseLogEntity({
    required this.id,
    required this.memberId,
    required this.exerciseId,
    this.sessionId,
    required this.sets,
    required this.reps,
    this.weight,
    this.durationSeconds,
    this.distanceKm,
    this.restSeconds,
    this.notes,
    required this.performedDate,
    required this.createdAt,
  });

  double? get totalVolume => weight != null ? (sets * reps * weight!) : null;

  ExerciseLogEntity copyWith({
    String? id,
    String? memberId,
    String? exerciseId,
    String? sessionId,
    int? sets,
    int? reps,
    double? weight,
    int? durationSeconds,
    double? distanceKm,
    int? restSeconds,
    String? notes,
    DateTime? performedDate,
    DateTime? createdAt,
  }) {
    return ExerciseLogEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      exerciseId: exerciseId ?? this.exerciseId,
      sessionId: sessionId ?? this.sessionId,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      distanceKm: distanceKm ?? this.distanceKm,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes ?? this.notes,
      performedDate: performedDate ?? this.performedDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}