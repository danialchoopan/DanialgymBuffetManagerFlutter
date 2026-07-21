import 'package:equatable/equatable.dart';
import '../value_objects/value_objects.dart';

class MemberHealthEntity extends Equatable {
  final String id;
  final String memberId;
  final DateTime recordDate;
  
  // Basic Measurements
  final Weight weight;
  final Height height;
  final double bodyFatPercentage;
  final double muscleMass;
  final double boneMass;
  
  // Calculated Metrics
  final BMI bmi;
  final double bmr; // Basal Metabolic Rate
  final int bodyAge;
  
  // Body Measurements (cm)
  final double waistCircumference;
  final double hipCircumference;
  final double chestCircumference;
  final double leftArm;
  final double rightArm;
  final double leftThigh;
  final double rightThigh;
  
  // Progress Tracking
  final String? progressNotes;
  final int motivationLevel; // 1-10
  final String? progressPhotoPath;
  final String? photoType; // BEFORE, PROGRESS, AFTER

  const MemberHealthEntity({
    required this.id,
    required this.memberId,
    required this.recordDate,
    required this.weight,
    required this.height,
    required this.bodyFatPercentage,
    required this.muscleMass,
    required this.boneMass,
    required this.bmi,
    required this.bmr,
    required this.bodyAge,
    required this.waistCircumference,
    required this.hipCircumference,
    required this.chestCircumference,
    required this.leftArm,
    required this.rightArm,
    required this.leftThigh,
    required this.rightThigh,
    this.progressNotes,
    this.motivationLevel = 5,
    this.progressPhotoPath,
    this.photoType,
  });

  // Factory constructors
  factory MemberHealthEntity.create({
    required String id,
    required String memberId,
    required Weight weight,
    required Height height,
    required double bodyFatPercentage,
    required double muscleMass,
    required double boneMass,
    required double waistCircumference,
    required double hipCircumference,
    required double chestCircumference,
    required double leftArm,
    required double rightArm,
    required double leftThigh,
    required double rightThigh,
    String? progressNotes,
    int motivationLevel = 5,
    String? progressPhotoPath,
    String? photoType,
  }) {
    final bmi = BMI.calculate(weight, height);
    final bmr = _calculateBMR(weight, height, bodyFatPercentage);
    final bodyAge = _calculateBodyAge(bmr);

    return MemberHealthEntity(
      id: id,
      memberId: memberId,
      recordDate: DateTime.now(),
      weight: weight,
      height: height,
      bodyFatPercentage: bodyFatPercentage,
      muscleMass: muscleMass,
      boneMass: boneMass,
      bmi: bmi,
      bmr: bmr,
      bodyAge: bodyAge,
      waistCircumference: waistCircumference,
      hipCircumference: hipCircumference,
      chestCircumference: chestCircumference,
      leftArm: leftArm,
      rightArm: rightArm,
      leftThigh: leftThigh,
      rightThigh: rightThigh,
      progressNotes: progressNotes,
      motivationLevel: motivationLevel,
      progressPhotoPath: progressPhotoPath,
      photoType: photoType,
    );
  }

  // Static helper methods
  static double _calculateBMR(Weight weight, Height height, double bodyFat) {
    // Katch-McArdle formula (more accurate with body fat percentage)
    final leanBodyMass = weight.kilograms * (1 - bodyFat / 100);
    return 370 + (21.6 * leanBodyMass);
  }

  static int _calculateBodyAge(double bmr) {
    // Simplified body age calculation
    // Average BMR for 25-year-old is approximately 1800
    const averageBMR = 1800;
    if (bmr >= averageBMR) return 25;
    final deficit = (averageBMR - bmr) / averageBMR;
    return (25 + deficit * 20).round();
  }

  // Business Methods
  String get bmiCategory => bmi.category;
  
  bool get isWeightGoalAchieved => false; // Requires goal weight
  
  double get averageArm => (leftArm + rightArm) / 2;
  
  double get averageThigh => (leftThigh + rightThigh) / 2;
  
  double get waistToHipRatio => waistCircumference / hipCircumference;
  
  String get waistToHipCategory {
    final ratio = waistToHipRatio;
    if (ratio < 0.8) return 'Good';
    if (ratio < 0.9) return 'Average';
    return 'Above Average';
  }

  HealthProgress getProgressSinceLast(MemberHealthEntity previous) {
    return HealthProgress(
      weightChange: Weight(previous.weight.kilograms - weight.kilograms),
      bodyFatChange: previous.bodyFatPercentage - bodyFatPercentage,
      muscleMassChange: muscleMass - previous.muscleMass,
      waistChange: previous.waistCircumference - waistCircumference,
      chestChange: chestCircumference - previous.chestCircumference,
      bmrChange: bmr - previous.bmr,
    );
  }

  Weight averageWeight(List<MemberHealthEntity> recentRecords) {
    if (recentRecords.isEmpty) return weight;
    final sum = recentRecords.fold<double>(
      0,
      (sum, record) => sum + record.weight.kilograms,
    );
    return Weight(sum / recentRecords.length);
  }

  Map<String, double> getMeasurementChanges(MemberHealthEntity previous) {
    return {
      'weight': weight.kilograms - previous.weight.kilograms,
      'body_fat': bodyFatPercentage - previous.bodyFatPercentage,
      'muscle_mass': muscleMass - previous.muscleMass,
      'waist': waistCircumference - previous.waistCircumference,
      'chest': chestCircumference - previous.chestCircumference,
      'left_arm': leftArm - previous.leftArm,
      'right_arm': rightArm - previous.rightArm,
      'left_thigh': leftThigh - previous.leftThigh,
      'right_thigh': rightThigh - previous.rightThigh,
    };
  }

  MemberHealthEntity copyWith({
    String? id,
    String? memberId,
    DateTime? recordDate,
    Weight? weight,
    Height? height,
    double? bodyFatPercentage,
    double? muscleMass,
    double? boneMass,
    BMI? bmi,
    double? bmr,
    int? bodyAge,
    double? waistCircumference,
    double? hipCircumference,
    double? chestCircumference,
    double? leftArm,
    double? rightArm,
    double? leftThigh,
    double? rightThigh,
    String? progressNotes,
    int? motivationLevel,
    String? progressPhotoPath,
    String? photoType,
  }) {
    return MemberHealthEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      recordDate: recordDate ?? this.recordDate,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      muscleMass: muscleMass ?? this.muscleMass,
      boneMass: boneMass ?? this.boneMass,
      bmi: bmi ?? this.bmi,
      bmr: bmr ?? this.bmr,
      bodyAge: bodyAge ?? this.bodyAge,
      waistCircumference: waistCircumference ?? this.waistCircumference,
      hipCircumference: hipCircumference ?? this.hipCircumference,
      chestCircumference: chestCircumference ?? this.chestCircumference,
      leftArm: leftArm ?? this.leftArm,
      rightArm: rightArm ?? this.rightArm,
      leftThigh: leftThigh ?? this.leftThigh,
      rightThigh: rightThigh ?? this.rightThigh,
      progressNotes: progressNotes ?? this.progressNotes,
      motivationLevel: motivationLevel ?? this.motivationLevel,
      progressPhotoPath: progressPhotoPath ?? this.progressPhotoPath,
      photoType: photoType ?? this.photoType,
    );
  }

  @override
  List<Object?> get props => [
    id, memberId, recordDate, weight, height, bodyFatPercentage,
    muscleMass, boneMass, bmi, bmr, bodyAge, waistCircumference,
    hipCircumference, chestCircumference, leftArm, rightArm,
    leftThigh, rightThigh, progressNotes, motivationLevel,
    progressPhotoPath, photoType,
  ];
}

class HealthProgress extends Equatable {
  final Weight weightChange;
  final double bodyFatChange;
  final double muscleMassChange;
  final double waistChange;
  final double chestChange;
  final double bmrChange;

  const HealthProgress({
    required this.weightChange,
    required this.bodyFatChange,
    required this.muscleMassChange,
    required this.waistChange,
    required this.chestChange,
    required this.bmrChange,
  });

  bool get isWeightLoss => weightChange.kilograms > 0;
  bool get isFatLoss => bodyFatChange > 0;
  bool get isMuscleGain => muscleMassChange > 0;
  bool get isWaistReduction => waistChange > 0;
  bool get isChestGain => chestChange > 0;

  double get overallProgress {
    int positiveChanges = 0;
    if (isWeightLoss) positiveChanges++;
    if (isFatLoss) positiveChanges++;
    if (isMuscleGain) positiveChanges++;
    if (isWaistReduction) positiveChanges++;
    return (positiveChanges / 5) * 100;
  }

  @override
  List<Object?> get props => [
    weightChange, bodyFatChange, muscleMassChange,
    waistChange, chestChange, bmrChange,
  ];
}