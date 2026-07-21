import 'package:equatable/equatable.dart';
import '../value_objects/enums.dart';
import '../value_objects/value_objects.dart';

class TrainerEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final PhoneNumber phone;
  final EmailAddress? email;
  final List<String> specializations;
  final int experienceYears;
  final List<String> certifications;
  final Money hourlyRate;
  final List<String> workingDays;
  final String workingHours;
  final List<String> assignedMemberIds;
  final int totalSessions;
  final double memberSatisfaction; // 1-5
  final String? photoPath;
  final String? bio;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TrainerEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.email,
    required this.specializations,
    required this.experienceYears,
    this.certifications = const [],
    required this.hourlyRate,
    required this.workingDays,
    required this.workingHours,
    this.assignedMemberIds = const [],
    this.totalSessions = 0,
    this.memberSatisfaction = 5.0,
    this.photoPath,
    this.bio,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  // Computed Properties
  String get fullName => '$firstName $lastName';

  int get assignedMembersCount => assignedMemberIds.length;

  bool get isFullyBooked => assignedMembersCount >= 20;

  // Business Methods
  bool isAvailable(String day, String time) {
    if (!isActive) return false;
    if (!workingDays.contains(day)) return false;
    
    final times = workingHours.split('-');
    if (times.length != 2) return false;
    
    final start = times[0].trim();
    final end = times[1].trim();
    
    return time.compareTo(start) >= 0 && time.compareTo(end) <= 0;
  }

  List<String> getAvailableTimesForDay(String day) {
    if (!workingDays.contains(day)) return [];
    
    final times = workingHours.split('-');
    if (times.length != 2) return [];
    
    final startHour = int.parse(times[0].trim().split(':')[0]);
    final endHour = int.parse(times[1].trim().split(':')[0]);
    
    final availableTimes = <String>[];
    for (var hour = startHour; hour < endHour; hour++) {
      availableTimes.add('${hour.toString().padLeft(2, '0')}:00');
      availableTimes.add('${hour.toString().padLeft(2, '0')}:30');
    }
    
    return availableTimes;
  }

  Duration get totalHoursWorked {
    return Duration(hours: totalSessions * 2); // Assuming 2 hours per session
  }

  Money get totalEarnings {
    return hourlyRate.multiply(totalSessions.toDouble() * 2);
  }

  Money getCommission(double commissionRate) {
    return totalEarnings.multiply(commissionRate);
  }

  bool hasSpecialization(String specialization) {
    return specializations.any(
      (s) => s.toLowerCase() == specialization.toLowerCase(),
    );
  }

  bool hasCertification(String certification) {
    return certifications.any(
      (c) => c.toLowerCase() == certification.toLowerCase(),
    );
  }

  String get satisfactionRating {
    if (memberSatisfaction >= 4.5) return 'Excellent';
    if (memberSatisfaction >= 3.5) return 'Good';
    if (memberSatisfaction >= 2.5) return 'Average';
    return 'Needs Improvement';
  }

  TrainerEntity assignMember(String memberId) {
    if (assignedMemberIds.contains(memberId)) return this;
    return copyWith(
      assignedMemberIds: [...assignedMemberIds, memberId],
    );
  }

  TrainerEntity removeMember(String memberId) {
    return copyWith(
      assignedMemberIds: assignedMemberIds.where((id) => id != memberId).toList(),
    );
  }

  TrainerEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    PhoneNumber? phone,
    EmailAddress? email,
    List<String>? specializations,
    int? experienceYears,
    List<String>? certifications,
    Money? hourlyRate,
    List<String>? workingDays,
    String? workingHours,
    List<String>? assignedMemberIds,
    int? totalSessions,
    double? memberSatisfaction,
    String? photoPath,
    String? bio,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TrainerEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      specializations: specializations ?? this.specializations,
      experienceYears: experienceYears ?? this.experienceYears,
      certifications: certifications ?? this.certifications,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      workingDays: workingDays ?? this.workingDays,
      workingHours: workingHours ?? this.workingHours,
      assignedMemberIds: assignedMemberIds ?? this.assignedMemberIds,
      totalSessions: totalSessions ?? this.totalSessions,
      memberSatisfaction: memberSatisfaction ?? this.memberSatisfaction,
      photoPath: photoPath ?? this.photoPath,
      bio: bio ?? this.bio,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id, firstName, lastName, phone, email, specializations,
    experienceYears, certifications, hourlyRate, workingDays,
    workingHours, assignedMemberIds, totalSessions, memberSatisfaction,
    photoPath, bio, isActive, createdAt, updatedAt,
  ];
}

class TrainerScheduleEntity extends Equatable {
  final String id;
  final String trainerId;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final bool isAvailable;
  final int maxSessions;
  final List<String> bookedSlots;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TrainerScheduleEntity({
    required this.id,
    required this.trainerId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
    this.maxSessions = 8,
    this.bookedSlots = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  // Business Methods
  int get availableSlots => maxSessions - bookedSlots.length;

  bool get hasAvailableSlots => availableSlots > 0;

  bool isSlotAvailable(String time) {
    return isAvailable && !bookedSlots.contains(time) && hasAvailableSlots;
  }

  bool isWithinWorkingHours(String time) {
    return time.compareTo(startTime) >= 0 && time.compareTo(endTime) <= 0;
  }

  Duration get workingDuration {
    final startParts = startTime.split(':');
    final endParts = endTime.split(':');
    
    final startMinutes = int.parse(startParts[0]) * 60 + int.parse(startParts[1]);
    final endMinutes = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);
    
    return Duration(minutes: endMinutes - startMinutes);
  }

  List<String> get availableTimeSlots {
    final slots = <String>[];
    final startParts = startTime.split(':');
    final endParts = endTime.split(':');
    
    var currentHour = int.parse(startParts[0]);
    final currentMinute = int.parse(startParts[1]);
    final endHour = int.parse(endParts[0]);
    
    while (currentHour < endHour) {
      final time = '${currentHour.toString().padLeft(2, '0')}:${currentMinute.toString().padLeft(2, '0')}';
      if (!bookedSlots.contains(time)) {
        slots.add(time);
      }
      currentHour++;
    }
    
    return slots;
  }

  TrainerScheduleEntity bookSlot(String time) {
    if (!isSlotAvailable(time)) return this;
    return copyWith(bookedSlots: [...bookedSlots, time]);
  }

  TrainerScheduleEntity cancelSlot(String time) {
    return copyWith(
      bookedSlots: bookedSlots.where((s) => s != time).toList(),
    );
  }

  TrainerScheduleEntity copyWith({
    String? id,
    String? trainerId,
    String? dayOfWeek,
    String? startTime,
    String? endTime,
    bool? isAvailable,
    int? maxSessions,
    List<String>? bookedSlots,
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
      bookedSlots: bookedSlots ?? this.bookedSlots,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id, trainerId, dayOfWeek, startTime, endTime, isAvailable,
    maxSessions, bookedSlots, createdAt, updatedAt,
  ];
}