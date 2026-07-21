import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.memberProfilesTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['member_id'],
      parentColumns: ['id'],
      entity: MemberEntity,
    ),
  ],
)
class MemberProfileEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'member_id')
  final String memberId;

  @ColumnInfo(name: 'height')
  final double? height;

  @ColumnInfo(name: 'weight')
  final double? weight;

  @ColumnInfo(name: 'target_weight')
  final double? targetWeight;

  @ColumnInfo(name: 'fitness_goal')
  final String? fitnessGoal;

  @ColumnInfo(name: 'dietary_restrictions')
  final String? dietaryRestrictions;

  @ColumnInfo(name: 'medical_conditions')
  final String? medicalConditions;

  @ColumnInfo(name: 'fitness_experience')
  final String? fitnessExperience;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  MemberProfileEntity({
    this.id,
    required this.memberId,
    this.height,
    this.weight,
    this.targetWeight,
    this.fitnessGoal,
    this.dietaryRestrictions,
    this.medicalConditions,
    this.fitnessExperience,
    required this.createdAt,
    required this.updatedAt,
  });

  MemberProfileEntity copyWith({
    int? id,
    String? memberId,
    double? height,
    double? weight,
    double? targetWeight,
    String? fitnessGoal,
    String? dietaryRestrictions,
    String? medicalConditions,
    String? fitnessExperience,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MemberProfileEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      targetWeight: targetWeight ?? this.targetWeight,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      medicalConditions: medicalConditions ?? this.medicalConditions,
      fitnessExperience: fitnessExperience ?? this.fitnessExperience,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}