// ============================================================
// NOTIFICATION SYSTEM
// ============================================================
// This file defines all notification rules, triggers, and
// scheduling for the Gym & Buffet Management system.
// ============================================================

class NotificationSystem {
  NotificationSystem._();

  // ============================================================
  // NOTIFICATION TYPES
  // ============================================================
  static const String membershipExpiry = 'MEMBERSHIP_EXPIRY';
  static const String paymentReminder = 'PAYMENT_REMINDER';
  static const String paymentOverdue = 'PAYMENT_OVERDUE';
  static const String lowStockAlert = 'LOW_STOCK_ALERT';
  static const String outOfStock = 'OUT_OF_STOCK';
  static const String inactivityReminder = 'INACTIVITY_REMINDER';
  static const String birthdayWish = 'BIRTHDAY_WISH';
  static const String dailyReport = 'DAILY_REPORT';
  static const String backupComplete = 'BACKUP_COMPLETE';
  static const String orderStatusUpdate = 'ORDER_STATUS_UPDATE';

  // ============================================================
  // MEMBERSHIP EXPIRY NOTIFICATIONS
  // ============================================================

  static const Map<String, dynamic> membershipExpiryNotifications = {
    'trigger_days_before': [30, 15, 7, 3, 1, 0],
    'messages': {
      30: '۳۰ روز تا انقضای عضویت {memberName}',
      15: '۱۵ روز تا انقضای عضویت {memberName}',
      7: '۷ روز تا انقضای عضویت {memberName}',
      3: '۳ روز تا انقضای عضویت {memberName}',
      1: 'فردا عضویت {memberName} منقضی می‌شود',
      0: 'امروز عضویت {memberName} منقضی شد',
    },
    'actions': [
      'نمایش در داشبورد',
      'ارسال یادآوری به عضو',
      'پیشنهاد تمدید',
    ],
  };

  // ============================================================
  // PAYMENT REMINDER NOTIFICATIONS
  // ============================================================

  static const Map<String, dynamic> paymentReminderNotifications = {
    'trigger_days_before': [7, 3, 1, 0],
    'messages': {
      7: '۷ روز تا سررسید پرداخت {memberName}',
      3: '۳ روز تا سررسید پرداخت {memberName}',
      1: 'فردا سررسید پرداخت {memberName}',
      0: 'امروز سررسید پرداخت {memberName}',
    },
    'overdue_messages': {
      1: 'پرداخت {memberName} یک روز معوق است',
      3: 'پرداخت {memberName} ۳ روز معوق است',
      7: 'پرداخت {memberName} یک هفته معوق است',
      30: 'پرداخت {memberName} یک ماه معوق است',
    },
    'actions': [
      'نمایش در لیست پرداخت‌های معوق',
      'ارسال یادآوری پرداخت',
      'اعلام به مدیر',
    ],
  };

  // ============================================================
  // STOCK ALERT NOTIFICATIONS
  // ============================================================

  static const Map<String, dynamic> stockAlertNotifications = {
    'low_stock_threshold': 10,
    'messages': {
      'low_stock': 'موجودی {productName} کم است (موجودی: {stock})',
      'out_of_stock': 'محصول {productName} تمام شد',
      'restock_needed': 'نیاز به شارژ موجودی {productName}',
    },
    'actions': [
      'نمایش در داشبورد',
      'اعلام به مدیر بوفه',
      'پیشنهاد سفارش مجدد',
    ],
  };

  // ============================================================
  // ATTENDANCE NOTIFICATIONS
  // ============================================================

  static const Map<String, dynamic> attendanceNotifications = {
    'inactivity_days': 7,
    'messages': {
      'inactivity': 'عضو {memberName} به مدت {days} روز مراجعه نکرده است',
      'frequent_visitor': '{memberName} این هفته {count} بار مراجعه کرده',
      'milestone_100': '{memberName} به {count} بار مراجعه رسید',
    },
    'actions': [
      'نمایش در داشبورد',
      'ارسال پیام خوش‌آمدگویی',
      'پیشنهاد برنامه تمرینی',
    ],
  };

  // ============================================================
  // BIRTHDAY NOTIFICATIONS
  // ============================================================

  static const Map<String, dynamic> birthdayNotifications = {
    'trigger_days_before': [1, 0],
    'messages': {
      1: 'فردا تولد {memberName} است',
      0: 'امروز تولد {memberName} است',
    },
    'actions': [
      'نمایش در داشبورد',
      'پیام تبریک',
      'پیشنهاد تخفیف ویژه',
    ],
  };

  // ============================================================
  // SYSTEM NOTIFICATIONS
  // ============================================================

  static const Map<String, dynamic> systemNotifications = {
    'daily_report': {
      'trigger_time': '23:59',
      'message': 'گزارش روزانه تولید شد',
      'action': 'نمایش گزارش',
    },
    'backup_complete': {
      'trigger': 'auto_backup',
      'message': 'پشتیبان‌گیری با موفقیت انجام شد',
      'action': 'نمایش جزئیات',
    },
    'expiring_memberships': {
      'trigger_time': '08:00',
      'message': 'تعداد {count} عضویت در حال انقضا دارند',
      'action': 'نمایش لیست',
    },
    'overdue_payments': {
      'trigger_time': '08:00',
      'message': 'تعداد {count} پرداخت معوق وجود دارد',
      'action': 'نمایش لیست',
    },
  };
}

// ============================================================
// NOTIFICATION SCHEDULER
// ============================================================

class NotificationScheduler {
  NotificationScheduler._();

  // ============================================================
  // SCHEDULE DEFINITIONS
  // ============================================================

  static const Map<String, dynamic> schedules = {
    'daily_check': {
      'time': '08:00',
      'tasks': [
        'check_membership_expiry',
        'check_payment_reminders',
        'check_overdue_payments',
        'check_low_stock',
        'check_inactivity',
        'check_birthdays',
      ],
    },
    'daily_report': {
      'time': '23:59',
      'tasks': [
        'generate_daily_report',
        'send_report_notification',
      ],
    },
    'weekly_backup': {
      'day': 'friday',
      'time': '02:00',
      'tasks': [
        'auto_backup_database',
      ],
    },
    'monthly_cleanup': {
      'day': 1,
      'time': '03:00',
      'tasks': [
        'archive_old_records',
        'cleanup_temp_files',
      ],
    },
  };

  // ============================================================
  // NOTIFICATION PREFERENCES
  // ============================================================

  static const Map<String, dynamic> defaultPreferences = {
    'membership_expiry': {
      'enabled': true,
      'days_before': [30, 7, 3, 1],
      'push_notification': true,
      'in_app': true,
    },
    'payment_reminders': {
      'enabled': true,
      'days_before': [7, 3, 1],
      'push_notification': true,
      'in_app': true,
    },
    'stock_alerts': {
      'enabled': true,
      'threshold': 10,
      'push_notification': true,
      'in_app': true,
    },
    'attendance_reminders': {
      'enabled': true,
      'inactivity_days': 7,
      'push_notification': false,
      'in_app': true,
    },
    'birthday_wishes': {
      'enabled': true,
      'push_notification': true,
      'in_app': true,
    },
    'daily_reports': {
      'enabled': true,
      'push_notification': false,
      'in_app': true,
    },
  };
}

// ============================================================
// NOTIFICATION MESSAGES TEMPLATES
// ============================================================

class NotificationTemplates {
  NotificationTemplates._();

  // ============================================================
  // MEMBER NOTIFICATIONS
  // ============================================================

  static String membershipExpiryReminder(String memberName, int daysLeft) {
    if (daysLeft == 0) return 'امروز عضویت $memberName منقضی شد';
    if (daysLeft == 1) return 'فردا عضویت $memberName منقضی می‌شود';
    return '$daysLeft روز تا انقضای عضویت $memberName';
  }

  static String paymentReminder(String memberName, int daysUntilDue) {
    if (daysUntilDue == 0) return 'امروز سررسید پرداخت $memberName';
    if (daysUntilDue == 1) return 'فردا سررسید پرداخت $memberName';
    return '$daysUntilDue روز تا سررسید پرداخت $memberName';
  }

  static String paymentOverdue(String memberName, int daysOverdue) {
    if (daysOverdue == 1) return 'پرداخت $memberName یک روز معوق است';
    if (daysOverdue < 7) return 'پرداخت $memberName $daysOverdue روز معوق است';
    if (daysOverdue < 30) {
      final weeks = daysOverdue ~/ 7;
      return 'پرداخت $memberName $weeks هفته معوق است';
    }
    final months = daysOverdue ~/ 30;
    return 'پرداخت $memberName $months ماه معوق است';
  }

  static String inactivityReminder(String memberName, int daysSinceLastVisit) {
    if (daysSinceLastVisit == 7) {
      return 'عضو $memberName یک هفته مراجعه نکرده است';
    }
    if (daysSinceLastVisit == 14) {
      return 'عضو $memberName دو هفته مراجعه نکرده است';
    }
    return 'عضو $memberName به مدت $daysSinceLastVisit روز مراجعه نکرده است';
  }

  static String birthdayWish(String memberName) {
    return 'تولدت مبارک $memberName! 🎂';
  }

  // ============================================================
  // BUFFET NOTIFICATIONS
  // ============================================================

  static String lowStockAlert(String productName, int currentStock) {
    return 'موجودی $productName کم است (موجودی: $currentStock)';
  }

  static String outOfStockAlert(String productName) {
    return 'محصول $productName تمام شد';
  }

  static String orderStatusUpdate(String orderNumber, String status) {
    final statusText = _getStatusText(status);
    return 'وضعیت سفارش $orderNumber به $statusText تغییر کرد';
  }

  static String _getStatusText(String status) {
    switch (status) {
      case 'PENDING':
        return 'در انتظار';
      case 'PREPARING':
        return 'در حال آماده‌سازی';
      case 'READY':
        return 'آماده تحویل';
      case 'COMPLETED':
        return 'تکمیل شده';
      case 'CANCELLED':
        return 'لغو شده';
      default:
        return status;
    }
  }

  // ============================================================
  // SYSTEM NOTIFICATIONS
  // ============================================================

  static String dailyReportReady() {
    return 'گزارش روزانه تولید شد';
  }

  static String backupComplete(int backupSizeKB) {
    return 'پشتیبان‌گیری با موفقیت انجام شد (${backupSizeKB}KB)';
  }

  static String expiringMembershipsAlert(int count) {
    return 'تعداد $count عضویت در حال انقضا دارند';
  }

  static String overduePaymentsAlert(int count) {
    return 'تعداد $count پرداخت معوق وجود دارد';
  }

  static String lowStockAlertCount(int count) {
    return 'تعداد $count محصول موجودی کم دارند';
  }

  static String newMemberWelcome(String memberName) {
    return 'خوش آمدید $memberName! عضویت شما با موفقیت فعال شد';
  }

  static String paymentReceived(String memberName, double amount) {
    return 'پرداخت $amount تومان از $memberName دریافت شد';
  }

  static String checkInSuccess(String memberName) {
    return '$memberName با موفقیت ورود زد';
  }

  static String checkOutSuccess(String memberName, int durationMinutes) {
    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;
    String duration = '';
    if (hours > 0) duration += '$hours ساعت';
    if (minutes > 0) duration += ' $minutes دقیقه';
    return '$memberName با موفقیت خروج زد ($duration)';
  }
}