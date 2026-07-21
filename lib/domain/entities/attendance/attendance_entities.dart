import 'package:equatable/equatable.dart';
import '../value_objects/enums.dart';

class AttendanceEntity extends Equatable {
  final String id;
  final String memberId;
  final String memberName;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final CheckInMethod checkInMethod;
  final String? notes;
  final DateTime createdAt;

  const AttendanceEntity({
    required this.id,
    required this.memberId,
    required this.memberName,
    required this.checkInTime,
    this.checkOutTime,
    this.checkInMethod = CheckInMethod.manual,
    this.notes,
    required this.createdAt,
  });

  // Business Methods
  bool get isCheckedOut => checkOutTime != null;

  bool get isActive => !isCheckedOut;

  int? get durationMinutes {
    if (checkOutTime == null) return null;
    return checkOutTime!.difference(checkInTime).inMinutes;
  }

  Duration? get duration {
    if (checkOutTime == null) return null;
    return checkOutTime!.difference(checkInTime);
  }

  String get durationFormatted {
    if (duration == null) return 'In progress';
    final hours = duration!.inHours;
    final minutes = duration!.inMinutes % 60;
    if (hours == 0) return '${minutes}min';
    return '${hours}h ${minutes}min';
  }

  String get checkInTimeFormatted {
    return '${checkInTime.hour.toString().padLeft(2, '0')}:${checkInTime.minute.toString().padLeft(2, '0')}';
  }

  String? get checkOutTimeFormatted {
    if (checkOutTime == null) return null;
    return '${checkOutTime!.hour.toString().padLeft(2, '0')}:${checkOutTime!.minute.toString().padLeft(2, '0')}';
  }

  bool get isLateCheckIn {
    // Assuming gym opens at 6:00 AM
    return checkInTime.hour < 6;
  }

  bool get isExtendedSession {
    // Sessions longer than 2 hours are considered extended
    return durationMinutes != null && durationMinutes! > 120;
  }

  bool get isShortSession {
    // Sessions shorter than 30 minutes are considered short
    return durationMinutes != null && durationMinutes! < 30;
  }

  String get sessionType {
    final hour = checkInTime.hour;
    if (hour >= 5 && hour < 10) return 'Morning';
    if (hour >= 10 && hour < 14) return 'Midday';
    if (hour >= 14 && hour < 18) return 'Afternoon';
    return 'Evening';
  }

  AttendanceEntity checkOut() {
    return copyWith(checkOutTime: DateTime.now());
  }

  AttendanceEntity checkOutAt(DateTime time) {
    return copyWith(checkOutTime: time);
  }

  AttendanceEntity copyWith({
    String? id,
    String? memberId,
    String? memberName,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    CheckInMethod? checkInMethod,
    String? notes,
    DateTime? createdAt,
  }) {
    return AttendanceEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      memberName: memberName ?? this.memberName,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      checkInMethod: checkInMethod ?? this.checkInMethod,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id, memberId, memberName, checkInTime, checkOutTime,
    checkInMethod, notes, createdAt,
  ];
}

class AttendanceStatsEntity extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final int totalCheckIns;
  final int uniqueMembers;
  final double averageDuration;
  final Map<int, int> peakHours;
  final Map<String, int> dailyDistribution;
  final int averageDailyAttendance;

  const AttendanceStatsEntity({
    required this.startDate,
    required this.endDate,
    required this.totalCheckIns,
    required this.uniqueMembers,
    required this.averageDuration,
    required this.peakHours,
    required this.dailyDistribution,
    required this.averageDailyAttendance,
  });

  // Business Methods
  int get totalDays => endDate.difference(startDate).inDays + 1;

  double get averageDailyCheckIns => totalCheckIns / totalDays;

  int get peakHour {
    if (peakHours.isEmpty) return 0;
    return peakHours.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  String get peakHourFormatted {
    final hour = peakHour;
    return '${hour.toString().padLeft(2, '0')}:00';
  }

  String get peakDay {
    if (dailyDistribution.isEmpty) return 'N/A';
    return dailyDistribution.entries
        .reduce((a, b) => a.value > b.value ? a, b)
        .key;
  }

  Map<String, int> get checkInByMethod {
    // This would be calculated from actual data
    return {};
  }

  AttendanceStatsEntity copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? totalCheckIns,
    int? uniqueMembers,
    double? averageDuration,
    Map<int, int>? peakHours,
    Map<String, int>? dailyDistribution,
    int? averageDailyAttendance,
  }) {
    return AttendanceStatsEntity(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalCheckIns: totalCheckIns ?? this.totalCheckIns,
      uniqueMembers: uniqueMembers ?? this.uniqueMembers,
      averageDuration: averageDuration ?? this.averageDuration,
      peakHours: peakHours ?? this.peakHours,
      dailyDistribution: dailyDistribution ?? this.dailyDistribution,
      averageDailyAttendance: averageDailyAttendance ?? this.averageDailyAttendance,
    );
  }

  @override
  List<Object?> get props => [
    startDate, endDate, totalCheckIns, uniqueMembers, averageDuration,
    peakHours, dailyDistribution, averageDailyAttendance,
  ];
}

enum CheckInMethod { manual, qrCode, fingerprint, faceId }