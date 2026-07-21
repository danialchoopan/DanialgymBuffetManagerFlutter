import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.trainerSchedulesTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['trainer_id'],
      parentColumns: ['id'],
      entity: TrainerEntity,
    ),
  ],
)
class TrainerScheduleEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'trainer_id')
  final String trainerId;

  @ColumnInfo(name: 'day_of_week')
  final String dayOfWeek;

  @ColumnInfo(name: 'start_time')
  final String startTime;

  @ColumnInfo(name: 'end_time')
  final String endTime;

  @ColumnInfo(name: 'is_available')
  final bool isAvailable;

  @ColumnInfo(name: 'max_sessions')
  final int maxSessions;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  TrainerScheduleEntity({
    this.id,
    required this.trainerId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
    this.maxSessions = 8,
    required this.createdAt,
    required this.updatedAt,
  });

  TrainerScheduleEntity copyWith({
    int? id,
    String? trainerId,
    String? dayOfWeek,
    String? startTime,
    String? endTime,
    bool? isAvailable,
    int? maxSessions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TrainerScheduleEntity(
      id: id ?? this.id,
      trainerId: trainerId ?? this.trainerId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAvailable: isAvailable ?? this.isAvailable,
      maxSessions: maxSessions ?? this.maxSessions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}