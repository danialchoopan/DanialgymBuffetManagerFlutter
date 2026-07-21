// ============================================================
// JALALI (SHAMSI) CALENDAR UTILITIES
// ============================================================
// Complete Jalali calendar implementation for Persian date support
// ============================================================

import 'package:intl/intl.dart';

class JalaliCalendar {
  JalaliCalendar._();

  // ============================================================
  // MONTH NAMES
  // ============================================================
  static const List<String> monthNames = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  static const List<String> monthNamesShort = [
    'فرو',
    'ارد',
    'خرد',
    'تیر',
    'مرد',
    'شهر',
    'مهر',
    'آبا',
    'آذر',
    'دی',
    'بهم',
    'اسف',
  ];

  // ============================================================
  // DAY NAMES
  // ============================================================
  static const List<String> dayNames = [
    'شنبه',
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنجشنبه',
    'جمعه',
  ];

  static const List<String> dayNamesShort = [
    'شنب',
    'یکش',
    'دوش',
    'سهج',
    'چها',
    'پنج',
    'جمع',
  ];

  // ============================================================
  // GREGORIAN TO JALALI CONVERSION
  // ============================================================

  static List<int> gregorianToJalali(int year, int month, int day) {
    final gregorianDate = DateTime(year, month, day);
    final jalaliDate = _calculateJalali(gregorianDate);
    return jalaliDate;
  }

  static List<int> _calculateJalali(DateTime gregorianDate) {
    final gDay = gregorianDate.day;
    final gMonth = gregorianDate.month;
    final gYear = gregorianDate.year;

    final marchDay = _gregorianDayOfYear(gYear, gMonth, gDay);
    final y1 = gYear - 1;

    final daysInGregorianYear = _isGregorianLeapYear(gYear) ? 366 : 365;
    final daysInPreviousGregorianYear = _isGregorianLeapYear(y1) ? 366 : 365;

    final totalDays = (365 * y1) + (_div(y1, 4)) - (_div(y1, 100)) + (_div(y1, 400)) + marchDay;
    
    final jDayOfYear = (totalDays - 79) % 12790 % 365;
    final jalaliYear = _div(totalDays - 120, 365) + 1;
    
    final daysInJalaliYear = _isJalaliLeapYear(jalaliYear) ? 366 : 365;
    
    int jalaliMonth;
    int jalaliDay;
    
    if (jDayOfYear < 186) {
      jalaliMonth = _div(jDayOfYear, 31) + 1;
      jalaliDay = (jDayOfYear % 31) + 1;
    } else {
      final remainingDays = jDayOfYear - 186;
      jalaliMonth = _div(remainingDays, 30) + 7;
      jalaliDay = (remainingDays % 30) + 1;
    }

    return [jalaliYear, jalaliMonth, jalaliDay];
  }

  static int _gregorianDayOfYear(int year, int month, int day) {
    final daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    int dayOfYear = day;
    for (int i = 1; i < month; i++) {
      dayOfYear += daysInMonth[i];
    }
    if (month > 2 && _isGregorianLeapYear(year)) {
      dayOfYear++;
    }
    return dayOfYear;
  }

  static bool _isGregorianLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  static bool _isJalaliLeapYear(int year) {
    final rem = (((year - 474) % 2820) + 2820) % 2820;
    return (((rem + 38) * 25) % 1024) < 31;
  }

  static int _div(int a, int b) {
    return (a / b).floor();
  }

  // ============================================================
  // JALALI TO GREGORIAN CONVERSION
  // ============================================================

  static List<int> jalaliToGregorian(int jYear, int jMonth, int jDay) {
    final daysInJalaliMonth = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];
    
    if (jMonth > 6 && _isJalaliLeapYear(jYear)) {
      daysInJalaliMonth[11] = 30;
    }

    int dayOfYear = 0;
    for (int i = 0; i < jMonth - 1; i++) {
      dayOfYear += daysInJalaliMonth[i];
    }
    dayOfYear += jDay - 1;

    final jalaliYear = jYear + 1584;
    final marchDay = dayOfYear + 79;

    int gDay;
    int gMonth;
    int gYear = jalaliYear;

    if (marchDay > 365) {
      gYear++;
      if (marchDay > 366 && _isGregorianLeapYear(gYear)) {
        final adjustedDay = marchDay - 366;
        gMonth = _getGregorianMonth(adjustedDay, true);
        gDay = _getGregorianDay(adjustedDay, gMonth, true);
      } else {
        final adjustedDay = marchDay - 365;
        gMonth = _getGregorianMonth(adjustedDay, false);
        gDay = _getGregorianDay(adjustedDay, gMonth, false);
      }
    } else {
      gMonth = _getGregorianMonth(marchDay, false);
      gDay = _getGregorianDay(marchDay, gMonth, false);
    }

    return [gYear, gMonth, gDay];
  }

  static int _getGregorianMonth(int dayOfYear, bool isLeap) {
    final daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (isLeap) daysInMonth[2] = 29;

    int month = 1;
    int remaining = dayOfYear;
    while (month < 12 && remaining > daysInMonth[month]) {
      remaining -= daysInMonth[month];
      month++;
    }
    return month;
  }

  static int _getGregorianDay(int dayOfYear, int month, bool isLeap) {
    final daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (isLeap) daysInMonth[2] = 29;

    int dayOfYearStart = 0;
    for (int i = 1; i < month; i++) {
      dayOfYearStart += daysInMonth[i];
    }
    return dayOfYear - dayOfYearStart;
  }

  // ============================================================
  // DATE CONVERSION HELPERS
  // ============================================================

  static DateTime jalaliToDateTime(int jYear, int jMonth, int jDay) {
    final gregorian = jalaliToGregorian(jYear, jMonth, jDay);
    return DateTime(gregorian[0], gregorian[1], gregorian[2]);
  }

  static List<int> dateTimeToJalali(DateTime date) {
    return gregorianToJalali(date.year, date.month, date.day);
  }

  // ============================================================
  // DATE FORMATTING
  // ============================================================

  static String formatJalali(int year, int month, int day) {
    return '${year.toPersianDigits()}/${month.toString().padLeft(2, '0').toPersianDigits()}/${day.toString().padLeft(2, '0').toPersianDigits()}';
  }

  static String formatDateTime(DateTime date) {
    final jalali = dateTimeToJalali(date);
    final time = DateFormat('HH:mm').format(date);
    return '${formatJalali(jalali[0], jalali[1], jalali[2])} $time';
  }

  static String formatDate(DateTime date) {
    final jalali = dateTimeToJalali(date);
    return formatJalali(jalali[0], jalali[1], jalali[2]);
  }

  static String formatFullDate(DateTime date) {
    final jalali = dateTimeToJalali(date);
    final dayName = dayNames[date.weekday % 7 == 6 ? 6 : date.weekday % 7];
    return '$dayName، ${formatJalali(jalali[0], jalali[1], jalali[2])}';
  }

  static String formatMonthYear(int year, int month) {
    return '${monthNames[month - 1]} ${year.toPersianDigits()}';
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  // ============================================================
  // DATE CALCULATIONS
  // ============================================================

  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    final jalaliBirth = dateTimeToJalali(birthDate);
    final jalaliNow = dateTimeToJalali(now);

    int age = jalaliNow[0] - jalaliBirth[0];
    if (jalaliNow[1] < jalaliBirth[1] ||
        (jalaliNow[1] == jalaliBirth[1] && jalaliNow[2] < jalaliBirth[2])) {
      age--;
    }
    return age;
  }

  static int daysUntilExpiry(DateTime expiryDate) {
    final now = DateTime.now();
    final difference = expiryDate.difference(now).inDays;
    return difference < 0 ? 0 : difference;
  }

  static int monthsBetween(DateTime from, DateTime to) {
    final jalaliFrom = dateTimeToJalali(from);
    final jalaliTo = dateTimeToJalali(to);
    return (jalaliTo[0] - jalaliFrom[0]) * 12 + (jalaliTo[1] - jalaliFrom[1]);
  }

  // ============================================================
  // RELATIVE TIME
  // ============================================================

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} سال پیش';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} ماه پیش';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} روز پیش';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ساعت پیش';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} دقیقه پیش';
    } else {
      return 'همین الان';
    }
  }

  // ============================================================
  // QUICK DATE RANGES
  // ============================================================

  static DateTime get today => DateTime.now();
  static DateTime get yesterday => DateTime.now().subtract(const Duration(days: 1));
  static DateTime get lastWeek => DateTime.now().subtract(const Duration(days: 7));
  static DateTime get lastMonth => DateTime.now().subtract(const Duration(days: 30));
  static DateTime get startOfMonth => DateTime(DateTime.now().year, DateTime.now().month, 1);
  static DateTime get endOfMonth => DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  static DateTime get startOfYear => DateTime(DateTime.now().year, 1, 1);
  static DateTime get endOfYear => DateTime(DateTime.now().year, 12, 31);
}