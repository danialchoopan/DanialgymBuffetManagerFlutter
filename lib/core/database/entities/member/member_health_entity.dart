import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.memberHealthTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['member_id'],
      parentColumns: ['id'],
      entity: MemberEntity,
    ),
  ],
)
class MemberHealthEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'member_id')
  final String memberId;

  @ColumnInfo(name: 'weight')
  final double weight;

  @ColumnInfo(name: 'body_fat_percentage')
  final double? bodyFatPercentage;

  @ColumnInfo(name: 'chest_measurement')
  final double? chestMeasurement;

  @ColumnInfo(name: 'waist_measurement')
  final double? waistMeasurement;

  @ColumnInfo(name: 'hips_measurement')
  final double? hipsMeasurement;

  @ColumnInfo(name: 'bicep_measurement')
  final double? bicepMeasurement;

  @ColumnInfo(name: 'thigh_measurement')
  final double? thighMeasurement;

  @ColumnInfo(name: 'photo_path')
  final String? photoPath;

  @ColumnInfo(name: 'notes')
  final String? notes;

  @ColumnInfo(name: 'recorded_date')
  final DateTime recordedDate;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  MemberHealthEntity({
    this.id,
    required this.memberId,
    required this.weight,
    this.bodyFatPercentage,
    this.chestMeasurement,
    this.waistMeasurement,
    this.hipsMeasurement,
    this.bicepMeasurement,
    this.thighMeasurement,
    this.photoPath,
    this.notes,
    required this.recordedDate,
    required this.createdAt,
  });

  MemberHealthEntity copyWith({
    int? id,
    String? memberId,
    double? weight,
    double? bodyFatPercentage,
    double? chestMeasurement,
    double? waistMeasurement,
    double? hipsMeasurement,
    double? bicepMeasurement,
    double? thighMeasurement,
    String? photoPath,
    String? notes,
    DateTime? recordedDate,
    DateTime? createdAt,
  }) {
    return MemberHealthEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      weight: weight ?? this.weight,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      chestMeasurement: chestMeasurement ?? this.chestMeasurement,
      waistMeasurement: waistMeasurement ?? this.waistMeasurement,
      hipsMeasurement: hipsMeasurement ?? this.hipsMeasurement,
      bicepMeasurement: bicepMeasurement ?? this.bicepMeasurement,
      thighMeasurement: thighMeasurement ?? this.thighMeasurement,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
      recordedDate: recordedDate ?? this.recordedDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}