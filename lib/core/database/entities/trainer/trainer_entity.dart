import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(tableName: DbConstants.trainersTable)
class TrainerEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'first_name')
  final String firstName;

  @ColumnInfo(name: 'last_name')
  final String lastName;

  @ColumnInfo(name: 'email')
  final String email;

  @ColumnInfo(name: 'phone')
  final String phone;

  @ColumnInfo(name: 'specialization')
  final String specialization;

  @ColumnInfo(name: 'certifications')
  final String? certifications;

  @ColumnInfo(name: 'experience_years')
  final int? experienceYears;

  @ColumnInfo(name: 'bio')
  final String? bio;

  @ColumnInfo(name: 'photo_path')
  final String? photoPath;

  @ColumnInfo(name: 'hourly_rate')
  final double? hourlyRate;

  @ColumnInfo(name: 'commission_rate')
  final double? commissionRate;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  @ColumnInfo(name: DbConstants.isActiveColumn)
  final bool isActive;

  TrainerEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.specialization,
    this.certifications,
    this.experienceYears,
    this.bio,
    this.photoPath,
    this.hourlyRate,
    this.commissionRate,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  String get fullName => '$firstName $lastName';

  TrainerEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? specialization,
    String? certifications,
    int? experienceYears,
    String? bio,
    String? photoPath,
    double? hourlyRate,
    double? commissionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return TrainerEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      specialization: specialization ?? this.specialization,
      certifications: certifications ?? this.certifications,
      experienceYears: experienceYears ?? this.experienceYears,
      bio: bio ?? this.bio,
      photoPath: photoPath ?? this.photoPath,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      commissionRate: commissionRate ?? this.commissionRate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}