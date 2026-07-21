class WorkoutConstants {
  WorkoutConstants._();

  // Muscle Groups
  static const String chest = 'chest';
  static const String back = 'back';
  static const String shoulders = 'shoulders';
  static const String biceps = 'biceps';
  static const String triceps = 'triceps';
  static const String legs = 'legs';
  static const String glutes = 'glutes';
  static const String core = 'core';
  static const String cardio = 'cardio';
  static const String fullBody = 'full_body';

  static const Map<String, String> muscleGroupDisplayNames = {
    chest: 'Chest',
    back: 'Back',
    shoulders: 'Shoulders',
    biceps: 'Biceps',
    triceps: 'Triceps',
    legs: 'Legs',
    glutes: 'Glutes',
    core: 'Core',
    cardio: 'Cardio',
    fullBody: 'Full Body',
  };

  // Equipment Types
  static const String barbell = 'barbell';
  static const String dumbbell = 'dumbbell';
  static const String machine = 'machine';
  static const String cable = 'cable';
  static const String bodyweight = 'bodyweight';
  static const String resistance = 'resistance_band';
  static const String kettlebell = 'kettlebell';
  static const String other = 'other';

  static const Map<String, String> equipmentDisplayNames = {
    barbell: 'Barbell',
    dumbbell: 'Dumbbell',
    machine: 'Machine',
    cable: 'Cable',
    bodyweight: 'Bodyweight',
    resistance: 'Resistance Band',
    kettlebell: 'Kettlebell',
    other: 'Other',
  };

  // Difficulty Levels
  static const String beginner = 'beginner';
  static const String intermediate = 'intermediate';
  static const String advanced = 'advanced';

  static const Map<String, String> difficultyDisplayNames = {
    beginner: 'Beginner',
    intermediate: 'Intermediate',
    advanced: 'Advanced',
  };

  // Program Types
  static const String weightLoss = 'weight_loss';
  static const String muscleGain = 'muscle_gain';
  static const String strength = 'strength';
  static const String endurance = 'endurance';
  static const String flexibility = 'flexibility';
  static const String general = 'general';

  static const Map<String, String> programTypeDisplayNames = {
    weightLoss: 'Weight Loss',
    muscleGain: 'Muscle Gain',
    strength: 'Strength',
    endurance: 'Endurance',
    flexibility: 'Flexibility',
    general: 'General Fitness',
  };

  // Workout Days
  static const Map<int, String> weekDays = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };
}