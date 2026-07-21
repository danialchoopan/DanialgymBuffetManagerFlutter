import 'package:floor/floor.dart';

import '../constants/db_constants.dart';

@Entity(
  tableName: DbConstants.attendanceTable,
  foreignKeys: [
    ForeignKey(
      childColumns: ['member_id'],
      parentColumns: ['id'],
      entity: MemberEntity,
    ),
  ],
)
class AttendanceEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'member_id')
  final String memberId;

  @ColumnInfo(name: 'member_name')
  final String memberName;

  @ColumnInfo(name: 'check_in_time')
  final DateTime checkInTime;

  @ColumnInfo(name: 'check_out_time')
  final DateTime? checkOutTime;

  @ColumnInfo(name: 'duration_minutes')
  final int? durationMinutes;

  @ColumnInfo(name: 'notes')
  final String? notes;

  @ColumnInfo(name: DbConstants.createdAtColumn)
  final DateTime createdAt;

  AttendanceEntity({
    required this.id,
    required this.memberId,
    required this.memberName,
    required this.checkInTime,
    this.checkOutTime,
    this.durationMinutes,
    this.notes,
    required this.createdAt,
  });

  bool get isCheckedOut => checkOutTime != null;

  int? get calculatedDuration {
    if (checkOutTime == null) return null;
    return checkOutTime!.difference(checkInTime).inMinutes;
  }

  AttendanceEntity copyWith({
    String? id,
    String? memberId,
    String? memberName,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    int? durationMinutes,
    String? notes,
    DateTime? createdAt,
  }) {
    return AttendanceEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      memberName: memberName ?? this.memberName,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}