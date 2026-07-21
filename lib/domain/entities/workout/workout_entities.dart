import 'package:equatable/equatable.dart';
import '../value_objects/enums.dart';
import '../value_objects/value_objects.dart';

class WorkoutProgramEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final ProgramType programType;
  final DifficultyLevel difficultyLevel;
  final int weeks;
  final int sessionsPerWeek;
  final int estimatedMinutesPerSession;
  final List<MuscleGroup> targetMuscleGroups;
  final FitnessGoal fitnessGoal;
  final List<WorkoutEntity> workouts;
  final bool isActive;
  final bool isTemplate;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WorkoutProgramEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.programType,
    required this.difficultyLevel,
    required this.weeks,
    required this.sessionsPerWeek,
    required this.estimatedMinutesPerSession,
    required this.targetMuscleGroups,
    required this.fitnessGoal,
    this.workouts = const [],
    this.isActive = true,
    this.isTemplate = false,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  // Business Methods
  int get totalExercises {
    return workouts.fold<int>(
      0,
      (sum, workout) => sum + workout.totalExercises,
    );
  }

  Duration get totalWeeklyDuration {
    final totalMinutes = sessionsPerWeek * estimatedMinutesPerSession;
    return Duration(minutes: totalMinutes);
  }

  Duration get totalProgramDuration {
    return totalWeeklyDuration * weeks;
  }

  bool get isSuitableForBeginner =>
      difficultyLevel == DifficultyLevel.beginner;

  bool get isSuitableForIntermediate =>
      difficultyLevel == DifficultyLevel.beginner ||
      difficultyLevel == DifficultyLevel.intermediate;

  Map<String, List<WorkoutEntity>> get weeklySchedule {
    final schedule = <String, List<WorkoutEntity>>{};
    for (final workout in workouts) {
      final day = workout.day;
      if (!schedule.containsKey(day)) {
        schedule[day] = [];
      }
      schedule[day]!.add(workout);
    }
    return schedule;
  }

  List<WorkoutEntity> getWorkoutsForDay(String day) {
    return workouts.where((w) => w.day == day).toList();
  }

  List<MuscleGroup> get coveredMuscleGroups {
    final groups = <MuscleGroup>{};
    for (final workout in workouts) {
      for (final exercise in workout.exercises) {
        groups.add(exercise.exercise.primaryMuscle);
      }
    }
    return groups.toList();
  }

  double get intensityScore {
    if (workouts.isEmpty) return 0;
    final totalIntensity = workouts.fold<double>(
      0,
      (sum, workout) => sum + workout.intensityScore,
    );
    return totalIntensity / workouts.length;
  }

  WorkoutProgramEntity copyWith({
    String? id,
    String? name,
    String? description,
    ProgramType? programType,
    DifficultyLevel? difficultyLevel,
    int? weeks,
    int? sessionsPerWeek,
    int? estimatedMinutesPerSession,
    List<MuscleGroup>? targetMuscleGroups,
    FitnessGoal? fitnessGoal,
    List<WorkoutEntity>? workouts,
    bool? isActive,
    bool? isTemplate,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkoutProgramEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      programType: programType ?? this.programType,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      weeks: weeks ?? this.weeks,
      sessionsPerWeek: sessionsPerWeek ?? this.sessionsPerWeek,
      estimatedMinutesPerSession: estimatedMinutesPerSession ?? this.estimatedMinutesPerSession,
      targetMuscleGroups: targetMuscleGroups ?? this.targetMuscleGroups,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      workouts: workouts ?? this.workouts,
      isActive: isActive ?? this.isActive,
      isTemplate: isTemplate ?? this.isTemplate,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id, name, description, programType, difficultyLevel, weeks,
    sessionsPerWeek, estimatedMinutesPerSession, targetMuscleGroups,
    fitnessGoal, workouts, isActive, isTemplate, createdBy,
    createdAt, updatedAt,
  ];
}

class ExerciseEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final ExerciseCategory exerciseCategory;
  final ExerciseType exerciseType;
  final DifficultyLevel difficulty;
  final List<Equipment> requiredEquipment;
  final MuscleGroup primaryMuscle;
  final List<MuscleGroup> secondaryMuscles;
  final List<String> steps;
  final List<String> tips;
  final String? demoVideoPath;
  final String? demoImagePath;
  final int defaultSets;
  final int defaultReps;
  final int defaultRestSeconds;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  const ExerciseEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.exerciseCategory,
    required this.exerciseType,
    required this.difficulty,
    required this.requiredEquipment,
    required this.primaryMuscle,
    this.secondaryMuscles = const [],
    required this.steps,
    this.tips = const [],
    this.demoVideoPath,
    this.demoImagePath,
    this.defaultSets = 3,
    this.defaultReps = 12,
    this.defaultRestSeconds = 60,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  // Business Methods
  bool get isCardio => exerciseType == ExerciseType.cardio;
  bool get isStrength => exerciseType == ExerciseType.strength;
  bool get isFlexibility => exerciseType == ExerciseType.flexibility;
  bool get isCalisthenics => exerciseType == ExerciseType.calisthenics;

  MuscleGroup get muscleGroup => primaryMuscle;

  String get equipmentList => requiredEquipment.map((e) => e.name).join(', ');

  double getCalorieEstimate(double weightKg, int durationMinutes) {
    // MET values for different exercise types
    final met = isCardio ? 8.0 : isStrength ? 5.0 : 3.0;
    return met * weightKg * (durationMinutes / 60);
  }

  bool get requiresEquipment => requiredEquipment.isNotEmpty;

  bool get isBodyweightOnly =>
      requiredEquipment.isEmpty ||
      requiredEquipment.every((e) => e == Equipment.bodyweight);

  DifficultyLevel get difficultyLevel => difficulty;

  ExerciseEntity copyWith({
    String? id,
    String? name,
    String? description,
    ExerciseCategory? exerciseCategory,
    ExerciseType? exerciseType,
    DifficultyLevel? difficulty,
    List<Equipment>? requiredEquipment,
    MuscleGroup? primaryMuscle,
    List<MuscleGroup>? secondaryMuscles,
    List<String>? steps,
    List<String>? tips,
    String? demoVideoPath,
    String? demoImagePath,
    int? defaultSets,
    int? defaultReps,
    int? defaultRestSeconds,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return ExerciseEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      exerciseCategory: exerciseCategory ?? this.exerciseCategory,
      exerciseType: exerciseType ?? this.exerciseType,
      difficulty: difficulty ?? this.difficulty,
      requiredEquipment: requiredEquipment ?? this.requiredEquipment,
      primaryMuscle: primaryMuscle ?? this.primaryMuscle,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      steps: steps ?? this.steps,
      tips: tips ?? this.tips,
      demoVideoPath: demoVideoPath ?? this.demoVideoPath,
      demoImagePath: demoImagePath ?? this.demoImagePath,
      defaultSets: defaultSets ?? this.defaultSets,
      defaultReps: defaultReps ?? this.defaultReps,
      defaultRestSeconds: defaultRestSeconds ?? this.defaultRestSeconds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
    id, name, description, exerciseCategory, exerciseType, difficulty,
    requiredEquipment, primaryMuscle, secondaryMuscles, steps, tips,
    demoVideoPath, demoImagePath, defaultSets, defaultReps,
    defaultRestSeconds, createdAt, updatedAt, isActive,
  ];
}

class WorkoutEntity extends Equatable {
  final String id;
  final String programId;
  final String day;
  final String name;
  final int order;
  final List<WorkoutExerciseEntity> exercises;
  final int estimatedDuration;
  final int warmupMinutes;
  final int cooldownMinutes;
  final String focus;

  const WorkoutEntity({
    required this.id,
    required this.programId,
    required this.day,
    required this.name,
    required this.order,
    this.exercises = const [],
    this.estimatedDuration = 45,
    this.warmupMinutes = 5,
    this.cooldownMinutes = 5,
    this.focus = '',
  });

  // Business Methods
  int get totalExercises => exercises.length;

  int get totalSets => exercises.fold<int>(
    0,
    (sum, we) => sum + we.sets,
  );

  int get totalReps => exercises.fold<int>(
    0,
    (sum, we) => sum + (we.sets * we.reps),
  );

  Duration get totalDuration {
    final exerciseTime = exercises.fold<int>(
      0,
      (sum, we) => sum + (we.sets * we.reps * 3), // ~3 seconds per rep
    );
    final restTime = exercises.fold<int>(
      0,
      (sum, we) => sum + ((we.sets - 1) * we.restSeconds),
    );
    return Duration(
      minutes: warmupMinutes + cooldownMinutes + ((exerciseTime + restTime) ~/ 60),
    );
  }

  double get intensityScore {
    if (exercises.isEmpty) return 0;
    final totalIntensity = exercises.fold<double>(
      0,
      (sum, we) => sum + we.intensity.index,
    );
    return totalIntensity / exercises.length;
  }

  List<MuscleGroup> get targetedMuscles {
    final muscles = <MuscleGroup>{};
    for (final we in exercises) {
      muscles.add(we.exercise.primaryMuscle);
    }
    return muscles.toList();
  }

  WorkoutEntity copyWith({
    String? id,
    String? programId,
    String? day,
    String? name,
    int? order,
    List<WorkoutExerciseEntity>? exercises,
    int? estimatedDuration,
    int? warmupMinutes,
    int? cooldownMinutes,
    String? focus,
  }) {
    return WorkoutEntity(
      id: id ?? this.id,
      programId: programId ?? this.programId,
      day: day ?? this.day,
      name: name ?? this.name,
      order: order ?? this.order,
      exercises: exercises ?? this.exercises,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      warmupMinutes: warmupMinutes ?? this.warmupMinutes,
      cooldownMinutes: cooldownMinutes ?? this.cooldownMinutes,
      focus: focus ?? this.focus,
    );
  }

  @override
  List<Object?> get props => [
    id, programId, day, name, order, exercises, estimatedDuration,
    warmupMinutes, cooldownMinutes, focus,
  ];
}

class WorkoutExerciseEntity extends Equatable {
  final String id;
  final String workoutId;
  final ExerciseEntity exercise;
  final int order;
  final int sets;
  final int reps;
  final double? weight;
  final int restSeconds;
  final Intensity intensity;
  final String? supersetId;
  final String? notes;

  const WorkoutExerciseEntity({
    required this.id,
    required this.workoutId,
    required this.exercise,
    required this.order,
    required this.sets,
    required this.reps,
    this.weight,
    this.restSeconds = 60,
    this.intensity = Intensity.medium,
    this.supersetId,
    this.notes,
  });

  // Business Methods
  double get totalVolume {
    if (weight == null) return 0;
    return sets * reps * weight!;
  }

  bool get isSuperset => supersetId != null;

  bool get isHeavyWeight => weight != null && weight! > 80;

  bool get isHighRep => reps >= 15;

  Duration get estimatedTime {
    final exerciseTime = sets * reps * 3; // ~3 seconds per rep
    final restTime = (sets - 1) * restSeconds;
    return Duration(seconds: exerciseTime + restTime);
  }

  WorkoutExerciseEntity copyWith({
    String? id,
    String? workoutId,
    ExerciseEntity? exercise,
    int? order,
    int? sets,
    int? reps,
    double? weight,
    int? restSeconds,
    Intensity? intensity,
    String? supersetId,
    String? notes,
  }) {
    return WorkoutExerciseEntity(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      exercise: exercise ?? this.exercise,
      order: order ?? this.order,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      restSeconds: restSeconds ?? this.restSeconds,
      intensity: intensity ?? this.intensity,
      supersetId: supersetId ?? this.supersetId,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
    id, workoutId, exercise, order, sets, reps, weight,
    restSeconds, intensity, supersetId, notes,
  ];
}

class WorkoutLogEntity extends Equatable {
  final String id;
  final String memberId;
  final String workoutId;
  final ExerciseEntity exercise;
  final DateTime logDate;
  final double actualWeight;
  final int actualReps;
  final int actualSets;
  final int? timeTaken;
  final int perceivedExertion; // 1-10
  final String? notes;
  final Feeling feeling;
  final DateTime loggedAt;

  const WorkoutLogEntity({
    required this.id,
    required this.memberId,
    required this.workoutId,
    required this.exercise,
    required this.logDate,
    required this.actualWeight,
    required this.actualReps,
    required this.actualSets,
    this.timeTaken,
    required this.perceivedExertion,
    this.notes,
    this.feeling = Feeling.good,
    required this.loggedAt,
  });

  // Business Methods
  double get volume => actualSets * actualReps * actualWeight;

  double get oneRepMax {
    // Epley formula: 1RM = weight × (1 + reps/30)
    if (actualReps == 1) return actualWeight;
    return actualWeight * (1 + actualReps / 30);
  }

  bool isImprovement(WorkoutLogEntity? previous) {
    if (previous == null) return true;
    return volume > previous.volume || actualWeight > previous.actualWeight;
  }

  double getProgressionPercentage(WorkoutLogEntity previous) {
    if (previous.volume == 0) return 0;
    return ((volume - previous.volume) / previous.volume) * 100;
  }

  WorkoutLogEntity copyWith({
    String? id,
    String? memberId,
    String? workoutId,
    ExerciseEntity? exercise,
    DateTime? logDate,
    double? actualWeight,
    int? actualReps,
    int? actualSets,
    int? timeTaken,
    int? perceivedExertion,
    String? notes,
    Feeling? feeling,
    DateTime? loggedAt,
  }) {
    return WorkoutLogEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      workoutId: workoutId ?? this.workoutId,
      exercise: exercise ?? this.exercise,
      logDate: logDate ?? this.logDate,
      actualWeight: actualWeight ?? this.actualWeight,
      actualReps: actualReps ?? this.actualReps,
      actualSets: actualSets ?? this.actualSets,
      timeTaken: timeTaken ?? this.timeTaken,
      perceivedExertion: perceivedExertion ?? this.perceivedExertion,
      notes: notes ?? this.notes,
      feeling: feeling ?? this.feeling,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  List<Object?> get props => [
    id, memberId, workoutId, exercise, logDate, actualWeight,
    actualReps, actualSets, timeTaken, perceivedExertion,
    notes, feeling, loggedAt,
  ];
}

class MemberProgressEntity extends Equatable {
  final String id;
  final String memberId;
  final DateTime progressDate;
  
  // Measurements
  final Weight weight;
  final double bodyFat;
  final double muscleMass;
  final double waist;
  final double chest;
  final double arms;
  final double thighs;
  
  // Performance
  final double? bestBench;
  final double? bestSquat;
  final double? bestDeadlift;
  final int? bestPullups;
  
  // Goals
  final double goalAchievement;
  
  // Notes
  final String? progressNotes;
  final String? achievements;
  
  // Photos
  final String? beforePhotoPath;
  final String? currentPhotoPath;

  const MemberProgressEntity({
    required this.id,
    required this.memberId,
    required this.progressDate,
    required this.weight,
    required this.bodyFat,
    required this.muscleMass,
    required this.waist,
    required this.chest,
    required this.arms,
    required this.thighs,
    this.bestBench,
    this.bestSquat,
    this.bestDeadlift,
    this.bestPullups,
    this.goalAchievement = 0,
    this.progressNotes,
    this.achievements,
    this.beforePhotoPath,
    this.currentPhotoPath,
  });

  // Business Methods
  Weight getWeightChange(MemberProgressEntity previous) {
    return Weight(previous.weight.kilograms - weight.kilograms);
  }

  double getBodyFatChange(MemberProgressEntity previous) {
    return previous.bodyFat - bodyFat;
  }

  double getMuscleMassChange(MemberProgressEntity previous) {
    return muscleMass - previous.muscleMass;
  }

  double getWaistChange(MemberProgressEntity previous) {
    return previous.waist - waist;
  }

  double getChestChange(MemberProgressEntity previous) {
    return chest - previous.chest;
  }

  double getArmsChange(MemberProgressEntity previous) {
    return arms - previous.arms;
  }

  double getThighsChange(MemberProgressEntity previous) {
    return thighs - previous.thighs;
  }

  double getOverallProgress(MemberProgressEntity previous) {
    int positiveChanges = 0;
    int totalChanges = 0;

    if (getWeightChange(previous).kilograms > 0) positiveChanges++;
    if (getBodyFatChange(previous) > 0) positiveChanges++;
    if (getMuscleMassChange(previous) > 0) positiveChanges++;
    if (getWaistChange(previous) > 0) positiveChanges++;
    if (getChestChange(previous) > 0) positiveChanges++;
    totalChanges = 5;

    return (positiveChanges / totalChanges) * 100;
  }

  bool get hasPhotos => beforePhotoPath != null && currentPhotoPath != null;

  MemberProgressEntity copyWith({
    String? id,
    String? memberId,
    DateTime? progressDate,
    Weight? weight,
    double? bodyFat,
    double? muscleMass,
    double? waist,
    double? chest,
    double? arms,
    double? thighs,
    double? bestBench,
    double? bestSquat,
    double? bestDeadlift,
    int? bestPullups,
    double? goalAchievement,
    String? progressNotes,
    String? achievements,
    String? beforePhotoPath,
    String? currentPhotoPath,
  }) {
    return MemberProgressEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      progressDate: progressDate ?? this.progressDate,
      weight: weight ?? this.weight,
      bodyFat: bodyFat ?? this.bodyFat,
      muscleMass: muscleMass ?? this.muscleMass,
      waist: waist ?? this.waist,
      chest: chest ?? this.chest,
      arms: arms ?? this.arms,
      thighs: thighs ?? this.thighs,
      bestBench: bestBench ?? this.bestBench,
      bestSquat: bestSquat ?? this.bestSquat,
      bestDeadlift: bestDeadlift ?? this.bestDeadlift,
      bestPullups: bestPullups ?? this.bestPullups,
      goalAchievement: goalAchievement ?? this.goalAchievement,
      progressNotes: progressNotes ?? this.progressNotes,
      achievements: achievements ?? this.achievements,
      beforePhotoPath: beforePhotoPath ?? this.beforePhotoPath,
      currentPhotoPath: currentPhotoPath ?? this.currentPhotoPath,
    );
  }

  @override
  List<Object?> get props => [
    id, memberId, progressDate, weight, bodyFat, muscleMass,
    waist, chest, arms, thighs, bestBench, bestSquat, bestDeadlift,
    bestPullups, goalAchievement, progressNotes, achievements,
    beforePhotoPath, currentPhotoPath,
  ];
}

// Enums for workout entities
enum ProgramType { strength, cardio, hiit, yoga, crossfit, flexibility, general }
enum DifficultyLevel { beginner, intermediate, advanced }
enum MuscleGroup { chest, back, legs, shoulders, arms, core, fullBody }
enum ExerciseCategory { chest, back, legs, shoulders, arms, core, cardio, fullBody }
enum ExerciseType { strength, cardio, flexibility, plyometric, calisthenics }
enum Equipment { dumbbell, barbell, kettlebell, band, bench, machine, cable, bodyweight, other }
enum Intensity { low, medium, high }
enum Feeling { great, good, ok, tired, sore }