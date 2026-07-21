import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(tableName: DbConstants.workoutProgramsTable)
class WorkoutProgramEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'type')
  final String type;

  @ColumnInfo(name: 'difficulty_level')
  final String difficultyLevel;

  @ColumnInfo(name: 'duration_weeks')
  final int durationWeeks;

  @ColumnInfo(name: 'days_per_week')
  final int daysPerWeek;

  @ColumnInfo(name: 'goals')
  final String? goals;

  @ColumnInfo(name: 'notes')
  final String? notes;

  @ColumnInfo(name: 'is_template')
  final bool isTemplate;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  @ColumnInfo(name: DbConstants.isActiveColumn)
  final bool isActive;

  WorkoutProgramEntity({
    required this.id,
    required this.name,
    this.description,
    required this.type,
    required this.difficultyLevel,
    required this.durationWeeks,
    required this.daysPerWeek,
    this.goals,
    this.notes,
    this.isTemplate = false,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  WorkoutProgramEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? type,
    String? difficultyLevel,
    int? durationWeeks,
    int? daysPerWeek,
    String? goals,
    String? notes,
    bool? isTemplate,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return WorkoutProgramEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      durationWeeks: durationWeeks ?? this.durationWeeks,
      daysPerWeek: daysPerWeek ?? this.daysPerWeek,
      goals: goals ?? this.goals,
      notes: notes ?? this.notes,
      isTemplate: isTemplate ?? this.isTemplate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}