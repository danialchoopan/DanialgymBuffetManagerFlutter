import 'package:equatable/equatable.dart';
import '../value_objects/enums.dart';
import '../value_objects/value_objects.dart';

class MemberEntity extends Equatable {
  final String id;
  
  // Personal Information
  final String firstName;
  final String lastName;
  final PhoneNumber phoneNumber;
  final EmailAddress? email;
  final Gender gender;
  final String? nationalId;
  final DateTime birthDate;
  
  // Address
  final String province;
  final String city;
  final String address;
  final String? postalCode;
  
  // Emergency Contact
  final String emergencyContactName;
  final PhoneNumber emergencyPhone;
  
  // Health
  final Height height;
  final Weight weight;
  final BloodType? bloodType;
  final List<String> allergies;
  final List<String> medicalConditions;
  final List<String> medications;
  
  // Fitness
  final FitnessGoal fitnessGoal;
  
  // Membership
  final DateTime joinDate;
  final MembershipStatus membershipStatus;
  final DateTime membershipExpiryDate;
  final String membershipType;
  
  // Financial
  final double totalPaid;
  final double outstandingBalance;
  
  // Profile
  final String? photoPath;
  final String? notes;
  
  // Status
  final bool isActive;
  final bool isBlocked;
  
  // Tracking
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastVisitDate;
  final int totalVisits;

  const MemberEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.email,
    required this.gender,
    this.nationalId,
    required this.birthDate,
    required this.province,
    required this.city,
    required this.address,
    this.postalCode,
    required this.emergencyContactName,
    required this.emergencyPhone,
    required this.height,
    required this.weight,
    this.bloodType,
    this.allergies = const [],
    this.medicalConditions = const [],
    this.medications = const [],
    required this.fitnessGoal,
    required this.joinDate,
    required this.membershipStatus,
    required this.membershipExpiryDate,
    required this.membershipType,
    this.totalPaid = 0,
    this.outstandingBalance = 0,
    this.photoPath,
    this.notes,
    this.isActive = true,
    this.isBlocked = false,
    required this.createdAt,
    required this.updatedAt,
    this.lastVisitDate,
    this.totalVisits = 0,
  });

  // Computed Properties
  String get fullName => '$firstName $lastName';
  
  int get age {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  BMI get bmi => BMI.calculate(weight, height);
  
  bool get isMembershipValid {
    return membershipStatus == MembershipStatus.active &&
        membershipExpiryDate.isAfter(DateTime.now());
  }
  
  int get membershipDaysRemaining {
    if (!isMembershipValid) return 0;
    return membershipExpiryDate.difference(DateTime.now()).inDays;
  }
  
  bool get canAccessGym {
    return isActive &&
        !isBlocked &&
        membershipStatus == MembershipStatus.active &&
        membershipExpiryDate.isAfter(DateTime.now());
  }
  
  PaymentStatus get paymentStatus {
    if (outstandingBalance <= 0) return PaymentStatus.paid;
    if (outstandingBalance < totalPaid * 0.5) return PaymentStatus.partial;
    if (outstandingBalance > 0 && membershipExpiryDate.isBefore(DateTime.now())) {
      return PaymentStatus.overdue;
    }
    return PaymentStatus.pending;
  }
  
  bool get hasOutstandingBalance => outstandingBalance > 0;
  
  int get remainingDaysInMonth {
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;
    return lastDayOfMonth - now.day + 1;
  }
  
  bool get isBirthday {
    final now = DateTime.now();
    return now.month == birthDate.month && now.day == birthDate.day;
  }
  
  bool get canRenewMembership {
    return !isBlocked &&
        (membershipStatus == MembershipStatus.expired ||
         membershipDaysRemaining <= 30);
  }
  
  String get memberStatus {
    if (isBlocked) return 'BLOCKED';
    if (!isActive) return 'INACTIVE';
    if (membershipStatus == MembershipStatus.expired) return 'EXPIRED';
    if (membershipStatus == MembershipStatus.suspended) return 'SUSPENDED';
    if (membershipDaysRemaining <= 7) return 'EXPIRING_SOON';
    return 'ACTIVE';
  }

  // Business Methods
  bool isMembershipValidOn(DateTime date) {
    return membershipStatus == MembershipStatus.active &&
        membershipExpiryDate.isAfter(date);
  }

  bool canAccessGymOn(DateTime date) {
    return isActive &&
        !isBlocked &&
        membershipStatus == MembershipStatus.active &&
        membershipExpiryDate.isAfter(date);
  }

  int getMembershipDaysRemainingOn(DateTime date) {
    if (!isMembershipValidOn(date)) return 0;
    return membershipExpiryDate.difference(date).inDays;
  }

  double getPaymentPercentage() {
    if (totalPaid + outstandingBalance <= 0) return 0;
    return totalPaid / (totalPaid + outstandingBalance) * 100;
  }

  MemberEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    PhoneNumber? phoneNumber,
    EmailAddress? email,
    Gender? gender,
    String? nationalId,
    DateTime? birthDate,
    String? province,
    String? city,
    String? address,
    String? postalCode,
    String? emergencyContactName,
    PhoneNumber? emergencyPhone,
    Height? height,
    Weight? weight,
    BloodType? bloodType,
    List<String>? allergies,
    List<String>? medicalConditions,
    List<String>? medications,
    FitnessGoal? fitnessGoal,
    DateTime? joinDate,
    MembershipStatus? membershipStatus,
    DateTime? membershipExpiryDate,
    String? membershipType,
    double? totalPaid,
    double? outstandingBalance,
    String? photoPath,
    String? notes,
    bool? isActive,
    bool? isBlocked,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastVisitDate,
    int? totalVisits,
  }) {
    return MemberEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      nationalId: nationalId ?? this.nationalId,
      birthDate: birthDate ?? this.birthDate,
      province: province ?? this.province,
      city: city ?? this.city,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      medicalConditions: medicalConditions ?? this.medicalConditions,
      medications: medications ?? this.medications,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      joinDate: joinDate ?? this.joinDate,
      membershipStatus: membershipStatus ?? this.membershipStatus,
      membershipExpiryDate: membershipExpiryDate ?? this.membershipExpiryDate,
      membershipType: membershipType ?? this.membershipType,
      totalPaid: totalPaid ?? this.totalPaid,
      outstandingBalance: outstandingBalance ?? this.outstandingBalance,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      isBlocked: isBlocked ?? this.isBlocked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastVisitDate: lastVisitDate ?? this.lastVisitDate,
      totalVisits: totalVisits ?? this.totalVisits,
    );
  }

  @override
  List<Object?> get props => [
    id, firstName, lastName, phoneNumber, email, gender, nationalId,
    birthDate, province, city, address, postalCode, emergencyContactName,
    emergencyPhone, height, weight, bloodType, allergies, medicalConditions,
    medications, fitnessGoal, joinDate, membershipStatus, membershipExpiryDate,
    membershipType, totalPaid, outstandingBalance, photoPath, notes,
    isActive, isBlocked, createdAt, updatedAt, lastVisitDate, totalVisits,
  ];
}