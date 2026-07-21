import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(tableName: DbConstants.staffTable)
class StaffEntity {
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

  @ColumnInfo(name: 'role')
  final String role;

  @ColumnInfo(name: 'username')
  final String username;

  @ColumnInfo(name: 'password_hash')
  final String passwordHash;

  @ColumnInfo(name: 'salary')
  final double? salary;

  @ColumnInfo(name: 'commission_rate')
  final double? commissionRate;

  @ColumnInfo(name: 'hire_date')
  final DateTime hireDate;

  @ColumnInfo(name: 'photo_path')
  final String? photoPath;

  @ColumnInfo(name: 'is_active')
  final bool isActive;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  @ColumnInfo(name: DbConstants.updatedAtColumn)
  final DateTime updatedAt;

  StaffEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.username,
    required this.passwordHash,
    this.salary,
    this.commissionRate,
    required this.hireDate,
    this.photoPath,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  bool get isAdmin => role == 'admin';
  bool get isTrainer => role == 'trainer';
  bool get isAccountant => role == 'accountant';
  bool get isReceptionist => role == 'receptionist';

  StaffEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    String? username,
    String? passwordHash,
    double? salary,
    double? commissionRate,
    DateTime? hireDate,
    String? photoPath,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StaffEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      salary: salary ?? this.salary,
      commissionRate: commissionRate ?? this.commissionRate,
      hireDate: hireDate ?? this.hireDate,
      photoPath: photoPath ?? this.photoPath,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}