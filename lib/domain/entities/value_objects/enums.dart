import 'package:equatable/equatable.dart';

class Gender extends Equatable {
  final String value;
  const Gender._(this.value);

  static const male = Gender._('MALE');
  static const female = Gender._('FEMALE');
  static const other = Gender._('OTHER');

  static const values = [male, female, other];

  factory Gender.fromString(String value) {
    switch (value.toUpperCase()) {
      case 'MALE':
        return male;
      case 'FEMALE':
        return female;
      case 'OTHER':
        return other;
      default:
        throw ArgumentError('Invalid gender: $value');
    }
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}

class MembershipStatus extends Equatable {
  final String value;
  const MembershipStatus._(this.value);

  static const active = MembershipStatus._('ACTIVE');
  static const expired = MembershipStatus._('EXPIRED');
  static const suspended = MembershipStatus._('SUSPENDED');
  static const pending = MembershipStatus._('PENDING');
  static const cancelled = MembershipStatus._('CANCELLED');

  static const values = [active, expired, suspended, pending, cancelled];

  factory MembershipStatus.fromString(String value) {
    switch (value.toUpperCase()) {
      case 'ACTIVE':
        return active;
      case 'EXPIRED':
        return expired;
      case 'SUSPENDED':
        return suspended;
      case 'PENDING':
        return pending;
      case 'CANCELLED':
        return cancelled;
      default:
        throw ArgumentError('Invalid membership status: $value');
    }
  }

  bool get canAccessGym => value == 'ACTIVE';

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}

class FitnessGoal extends Equatable {
  final String value;
  const FitnessGoal._(this.value);

  static const weightLoss = FitnessGoal._('WEIGHT_LOSS');
  static const muscleGain = FitnessGoal._('MUSCLE_GAIN');
  static const endurance = FitnessGoal._('ENDURANCE');
  static const strength = FitnessGoal._('STRENGTH');
  static const general = FitnessGoal._('GENERAL');
  static const flexibility = FitnessGoal._('FLEXIBILITY');

  static const values = [weightLoss, muscleGain, endurance, strength, general, flexibility];

  factory FitnessGoal.fromString(String value) {
    switch (value.toUpperCase()) {
      case 'WEIGHT_LOSS':
        return weightLoss;
      case 'MUSCLE_GAIN':
        return muscleGain;
      case 'ENDURANCE':
        return endurance;
      case 'STRENGTH':
        return strength;
      case 'GENERAL':
        return general;
      case 'FLEXIBILITY':
        return flexibility;
      default:
        throw ArgumentError('Invalid fitness goal: $value');
    }
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}

class PaymentStatus extends Equatable {
  final String value;
  const PaymentStatus._(this.value);

  static const paid = PaymentStatus._('PAID');
  static const partial = PaymentStatus._('PARTIAL');
  static const pending = PaymentStatus._('PENDING');
  static const overdue = PaymentStatus._('OVERDUE');
  static const cancelled = PaymentStatus._('CANCELLED');

  static const values = [paid, partial, pending, overdue, cancelled];

  factory PaymentStatus.fromString(String value) {
    switch (value.toUpperCase()) {
      case 'PAID':
        return paid;
      case 'PARTIAL':
        return partial;
      case 'PENDING':
        return pending;
      case 'OVERDUE':
        return overdue;
      case 'CANCELLED':
        return cancelled;
      default:
        throw ArgumentError('Invalid payment status: $value');
    }
  }

  bool get isFullyPaid => value == 'PAID';
  bool get hasOutstanding => value == 'PARTIAL' || value == 'PENDING';
  bool get isOverdue => value == 'OVERDUE';

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}

class PaymentMethod extends Equatable {
  final String value;
  const PaymentMethod._(this.value);

  static const cash = PaymentMethod._('CASH');
  static const card = PaymentMethod._('CARD');
  static const transfer = PaymentMethod._('TRANSFER');
  static const installment = PaymentMethod._('INSTALLMENT');
  static const free = PaymentMethod._('FREE');

  static const values = [cash, card, transfer, installment, free];

  factory PaymentMethod.fromString(String value) {
    switch (value.toUpperCase()) {
      case 'CASH':
        return cash;
      case 'CARD':
        return card;
      case 'TRANSFER':
        return transfer;
      case 'INSTALLMENT':
        return installment;
      case 'FREE':
        return free;
      default:
        throw ArgumentError('Invalid payment method: $value');
    }
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}

class PaymentType extends Equatable {
  final String value;
  const PaymentType._(this.value);

  static const membership = PaymentType._('MEMBERSHIP');
  static const service = PaymentType._('SERVICE');
  static const product = PaymentType._('PRODUCT');
  static const penalty = PaymentType._('PENALTY');
  static const other = PaymentType._('OTHER');

  static const values = [membership, service, product, penalty, other];

  factory PaymentType.fromString(String value) {
    switch (value.toUpperCase()) {
      case 'MEMBERSHIP':
        return membership;
      case 'SERVICE':
        return service;
      case 'PRODUCT':
        return product;
      case 'PENALTY':
        return penalty;
      case 'OTHER':
        return other;
      default:
        throw ArgumentError('Invalid payment type: $value');
    }
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}

class BloodType extends Equatable {
  final String value;
  const BloodType._(this.value);

  static const aPositive = BloodType._('A+');
  static const aNegative = BloodType._('A-');
  static const bPositive = BloodType._('B+');
  static const bNegative = BloodType._('B-');
  static const abPositive = BloodType._('AB+');
  static const abNegative = BloodType._('AB-');
  static const oPositive = BloodType._('O+');
  static const oNegative = BloodType._('O-');

  static const values = [
    aPositive, aNegative, bPositive, bNegative,
    abPositive, abNegative, oPositive, oNegative,
  ];

  factory BloodType.fromString(String value) {
    switch (value.toUpperCase()) {
      case 'A+': return aPositive;
      case 'A-': return aNegative;
      case 'B+': return bPositive;
      case 'B-': return bNegative;
      case 'AB+': return abPositive;
      case 'AB-': return abNegative;
      case 'O+': return oPositive;
      case 'O-': return oNegative;
      default:
        throw ArgumentError('Invalid blood type: $value');
    }
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}

class MeasurementUnit extends Equatable {
  final String value;
  const MeasurementUnit._(this.value);

  static const piece = MeasurementUnit._('PIECE');
  static const kg = MeasurementUnit._('KG');
  static const gram = MeasurementUnit._('GRAM');
  static const liter = MeasurementUnit._('LITER');
  static const bottle = MeasurementUnit._('BOTTLE');
  static const box = MeasurementUnit._('BOX');

  static const values = [piece, kg, gram, liter, bottle, box];

  factory MeasurementUnit.fromString(String value) {
    switch (value.toUpperCase()) {
      case 'PIECE': return piece;
      case 'KG': return kg;
      case 'GRAM': return gram;
      case 'LITER': return liter;
      case 'BOTTLE': return bottle;
      case 'BOX': return box;
      default:
        throw ArgumentError('Invalid measurement unit: $value');
    }
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}