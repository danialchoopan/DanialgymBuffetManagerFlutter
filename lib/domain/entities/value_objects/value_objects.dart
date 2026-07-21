import 'package:equatable/equatable.dart';

class Money extends Equatable {
  final double amount;
  final String currency;

  const Money({
    required this.amount,
    this.currency = 'USD',
  }) : assert(amount >= 0, 'Money amount cannot be negative');

  const Money.zero({this.currency = 'USD'}) : amount = 0;

  Money add(Money other) {
    _validateSameCurrency(other);
    return Money(amount: amount + other.amount, currency: currency);
  }

  Money subtract(Money other) {
    _validateSameCurrency(other);
    return Money(amount: amount - other.amount, currency: currency);
  }

  Money multiply(double factor) {
    return Money(amount: amount * factor, currency: currency);
  }

  bool isGreaterThan(Money other) {
    _validateSameCurrency(other);
    return amount > other.amount;
  }

  bool isLessThan(Money other) {
    _validateSameCurrency(other);
    return amount < other.amount;
  }

  bool get isZero => amount == 0;
  bool get isPositive => amount > 0;
  bool get isNegative => amount < 0;

  Money clamp(double min, double max) {
    return Money(
      amount: amount.clamp(min, max),
      currency: currency,
    );
  }

  String format({String symbol = '\$'}) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  void _validateSameCurrency(Money other) {
    if (currency != other.currency) {
      throw ArgumentError(
        'Cannot operate on different currencies: $currency and ${other.currency}',
      );
    }
  }

  @override
  List<Object?> get props => [amount, currency];

  @override
  String toString() => format();
}

class PhoneNumber extends Equatable {
  final String value;

  const PhoneNumber._(this.value);

  factory PhoneNumber(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^\d+]'), '');
    if (cleaned.length < 10 || cleaned.length > 15) {
      throw ArgumentError('Invalid phone number: $value');
    }
    return PhoneNumber._(cleaned);
  }

  String get formatted {
    if (value.length == 10) {
      return '(${value.substring(0, 3)}) ${value.substring(3, 6)}-${value.substring(6)}';
    }
    if (value.length == 11 && value.startsWith('1')) {
      return '+1 (${value.substring(1, 4)}) ${value.substring(4, 7)}-${value.substring(7)}';
    }
    return value;
  }

  String get international => value.startsWith('+') ? value : '+$value';

  @override
  List<Object?> get props => [value];

  @override
  String toString() => formatted;
}

class EmailAddress extends Equatable {
  final String value;

  const EmailAddress._(this.value);

  factory EmailAddress(String value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      throw ArgumentError('Invalid email address: $value');
    }
    return EmailAddress._(value.toLowerCase());
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}

class Weight extends Equatable {
  final double kilograms;

  const Weight(this.kilograms)
      : assert(kilograms > 0, 'Weight must be positive');

  double get pounds => kilograms * 2.20462;

  factory Weight.fromKg(double kg) => Weight(kg);
  factory Weight.fromLbs(double lbs) => Weight(lbs / 2.20462);

  String format({bool metric = true}) {
    if (metric) {
      return '${kilograms.toStringAsFixed(1)} kg';
    }
    return '${pounds.toStringAsFixed(1)} lbs';
  }

  @override
  List<Object?> get props => [kilograms];

  @override
  String toString() => format();
}

class Height extends Equatable {
  final double centimeters;

  const Height(this.centimeters)
      : assert(centimeters > 0, 'Height must be positive');

  double get meters => centimeters / 100;
  double get inches => centimeters / 2.54;
  String get feetInches {
    final totalInches = inches;
    final feet = (totalInches / 12).floor();
    final remainingInches = (totalInches % 12).round();
    return "$feet'${remainingInches}\"";
  }

  factory Height.fromCm(double cm) => Height(cm);
  factory Height.fromMeters(double m) => Height(m * 100);
  factory Height.fromFeetInches(double feet, double inches) =>
      Height((feet * 12 + inches) * 2.54);

  String format({bool metric = true}) {
    if (metric) {
      return '${centimeters.toStringAsFixed(1)} cm';
    }
    return feetInches;
  }

  @override
  List<Object?> get props => [centimeters];

  @override
  String toString() => format();
}

class BMI extends Equatable {
  final double value;

  const BMI(this.value)
      : assert(value > 0, 'BMI must be positive');

  factory BMI.calculate(Weight weight, Height height) {
    final heightMeters = height.meters;
    return BMI(weight.kilograms / (heightMeters * heightMeters));
  }

  String get category {
    if (value < 18.5) return 'Underweight';
    if (value < 25) return 'Normal';
    if (value < 30) return 'Overweight';
    return 'Obese';
  }

  bool get isUnderweight => value < 18.5;
  bool get isNormal => value >= 18.5 && value < 25;
  bool get isOverweight => value >= 25 && value < 30;
  bool get isObese => value >= 30;

  String format() => value.toStringAsFixed(1);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => format();
}

class BodyFatPercentage extends Equatable {
  final double value;

  const BodyFatPercentage(this.value)
      : assert(value >= 0 && value <= 100, 'Body fat must be between 0 and 100');

  String get category {
    // For males
    if (value < 6) return 'Essential Fat';
    if (value < 14) return 'Athletes';
    if (value < 18) return 'Fitness';
    if (value < 25) return 'Average';
    return 'Above Average';
  }

  String format() => '${value.toStringAsFixed(1)}%';

  @override
  List<Object?> get props => [value];

  @override
  String toString() => format();
}

class Duration extends Equatable {
  final int minutes;

  const Duration(this.minutes)
      : assert(minutes >= 0, 'Duration cannot be negative');

  factory Duration.fromHours(double hours) =>
      Duration((hours * 60).round());

  int get hours => minutes ~/ 60;
  int get remainingMinutes => minutes % 60;

  String format() {
    if (hours == 0) return '${minutes}min';
    if (remainingMinutes == 0) return '${hours}h';
    return '${hours}h ${remainingMinutes}min';
  }

  Duration add(Duration other) => Duration(minutes: minutes + other.minutes);

  @override
  List<Object?> get props => [minutes];

  @override
  String toString() => format();
}