import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(tableName: DbConstants.membersTable)
class MemberEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: DbConstants.firstNameColumn)
  final String firstName;

  @ColumnInfo(name: DbConstants.lastNameColumn)
  final String lastName;

  @ColumnInfo(name: DbConstants.emailColumn)
  final String email;

  @ColumnInfo(name: DbConstants.phoneColumn)
  final String phone;

  @ColumnInfo(name: DbConstants.dateOfBirthColumn)
  final DateTime dateOfBirth;

  @ColumnInfo(name: DbConstants.genderColumn)
  final String gender;

  @ColumnInfo(name: DbConstants.addressColumn)
  final String? address;

  @ColumnInfo(name: DbConstants.emergencyContactColumn)
  final String? emergencyContact;

  @ColumnInfo(name: DbConstants.photoPathColumn)
  final String? photoPath;

  @ColumnInfo(name: DbConstants.membershipTypeColumn)
  final String membershipType;

  @ColumnInfo(name: DbConstants.membershipStartDateColumn)
  final DateTime membershipStartDate;

  @ColumnInfo(name: DbConstants.membershipEndDateColumn)
  final DateTime membershipEndDate;

  @ColumnInfo(name: DbConstants.membershipStatusColumn)
  final String membershipStatus;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  @ColumnInfo(name: DbConstants.isActiveColumn)
  final bool isActive;

  MemberEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    this.address,
    this.emergencyContact,
    this.photoPath,
    required this.membershipType,
    required this.membershipStartDate,
    required this.membershipEndDate,
    required this.membershipStatus,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  String get fullName => '$firstName $lastName';

  bool get isMembershipActive =>
      membershipStatus == 'active' && membershipEndDate.isAfter(DateTime.now());

  MemberEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    DateTime? dateOfBirth,
    String? gender,
    String? address,
    String? emergencyContact,
    String? photoPath,
    String? membershipType,
    DateTime? membershipStartDate,
    DateTime? membershipEndDate,
    String? membershipStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return MemberEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      photoPath: photoPath ?? this.photoPath,
      membershipType: membershipType ?? this.membershipType,
      membershipStartDate: membershipStartDate ?? this.membershipStartDate,
      membershipEndDate: membershipEndDate ?? this.membershipEndDate,
      membershipStatus: membershipStatus ?? this.membershipStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}