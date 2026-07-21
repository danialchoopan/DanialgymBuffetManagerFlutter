import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(tableName: DbConstants.exercisesTable)
class ExerciseEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'muscle_group')
  final String muscleGroup;

  @ColumnInfo(name: 'secondary_muscles')
  final String? secondaryMuscles;

  @ColumnInfo(name: 'equipment')
  final String equipment;

  @ColumnInfo(name: 'difficulty_level')
  final String difficultyLevel;

  @ColumnInfo(name: 'instructions')
  final String? instructions;

  @ColumnInfo(name: 'video_url')
  final String? videoUrl;

  @ColumnInfo(name: 'image_path')
  final String? imagePath;

  @ColumnInfo(name: 'is_compound')
  final bool isCompound;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.isActiveColumn)
  final bool isActive;

  ExerciseEntity({
    required this.id,
    required this.name,
    this.description,
    required this.muscleGroup,
    this.secondaryMuscles,
    required this.equipment,
    required this.difficultyLevel,
    this.instructions,
    this.videoUrl,
    this.imagePath,
    this.isCompound = false,
    required this.createdAt,
    this.isActive = true,
  });

  ExerciseEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? muscleGroup,
    String? secondaryMuscles,
    String? equipment,
    String? difficultyLevel,
    String? instructions,
    String? videoUrl,
    String? imagePath,
    bool? isCompound,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return ExerciseEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      equipment: equipment ?? this.equipment,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      instructions: instructions ?? this.instructions,
      videoUrl: videoUrl ?? this.videoUrl,
      imagePath: imagePath ?? this.imagePath,
      isCompound: isCompound ?? this.isCompound,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}