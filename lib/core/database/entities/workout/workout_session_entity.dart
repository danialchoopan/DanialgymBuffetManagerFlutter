import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.workoutSessionsTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['member_id'],
      parentColumns: ['id'],
      entity: MemberEntity,
    ),
    ForeignKey(
      childColumns: ['program_id'],
      parentColumns: ['id'],
      entity: WorkoutProgramEntity,
    ),
    ForeignKey(
      childColumns: ['trainer_id'],
      parentColumns: ['id'],
      entity: TrainerEntity,
    ),
  ],
)
class WorkoutSessionEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'member_id')
  final String memberId;

  @ColumnInfo(name: 'program_id')
  final String programId;

  @ColumnInfo(name: 'trainer_id')
  final String? trainerId;

  @ColumnInfo(name: 'scheduled_date')
  final DateTime scheduledDate;

  @ColumnInfo(name: 'start_time')
  final String startTime;

  @ColumnInfo(name: 'end_time')
  final String? endTime;

  @ColumnInfo(name: 'status')
  final String status;

  @ColumnInfo(name: 'notes')
  final String? notes;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  WorkoutSessionEntity({
    required this.id,
    required this.memberId,
    required this.programId,
    this.trainerId,
    required this.scheduledDate,
    required this.startTime,
    this.endTime,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  WorkoutSessionEntity copyWith({
    String? id,
    String? memberId,
    String? programId,
    String? trainerId,
    DateTime? scheduledDate,
    String? startTime,
    String? endTime,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkoutSessionEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      programId: programId ?? this.programId,
      trainerId: trainerId ?? this.trainerId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}