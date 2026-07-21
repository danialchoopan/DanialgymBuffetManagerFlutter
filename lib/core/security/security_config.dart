// ============================================================
// DATA RETENTION & ARCHIVING POLICIES
// ============================================================
// This file defines data retention rules, archiving policies,
// and security configurations for the Gym & Buffet Management system.
// ============================================================

class DataRetentionPolicies {
  DataRetentionPolicies._();

  // ============================================================
  // RETENTION PERIODS
  // ============================================================

  static const Map<String, int> retentionDays = {
    'attendance': 730, // 2 years
    'transactions': 1825, // 5 years (legal requirement)
    'members': -1, // Indefinite (soft delete)
    'orders': 730, // 2 years
    'audit_logs': 365, // 1 year
    'workout_logs': 730, // 2 years
    'health_records': 730, // 2 years
    'inventory_transactions': 1095, // 3 years
    'invoices': 1825, // 5 years (legal requirement)
    'reports': 1095, // 3 years
    'notifications': 90, // 3 months
    'backups': 365, // 1 year
  };

  // ============================================================
  // ARCHIVING RULES
  // ============================================================

  static const Map<String, dynamic> archivingRules = {
    'attendance': {
      'archive_after_days': 730,
      'archive_to': 'attendance_archive',
      'keep_summary': true,
    },
    'orders': {
      'archive_after_days': 365,
      'archive_to': 'orders_archive',
      'keep_summary': true,
    },
    'members': {
      'archive_deleted_after_days': 30,
      'archive_to': 'members_archive',
      'keep_financial_data': true,
    },
    'transactions': {
      'archive_after_days': 1825,
      'archive_to': 'transactions_archive',
      'keep_summary': true,
    },
    'workout_logs': {
      'archive_after_days': 730,
      'archive_to': 'workout_logs_archive',
      'keep_progress_summary': true,
    },
  };

  // ============================================================
  // CLEANUP RULES
  // ============================================================

  static const Map<String, dynamic> cleanupRules = {
    'temp_files': {
      'cleanup_after_days': 7,
      'paths': ['/tmp', '/cache'],
    },
    'old_backups': {
      'keep_count': 10,
      'keep_days': 365,
    },
    'notification_history': {
      'cleanup_after_days': 90,
    },
    'audit_logs': {
      'cleanup_after_days': 365,
    },
  };
}

// ============================================================
// SECURITY CONFIGURATION
// ============================================================

class SecurityConfig {
  SecurityConfig._();

  // ============================================================
  // AUTHENTICATION SETTINGS
  // ============================================================

  static const Map<String, dynamic> authentication = {
    'password_min_length': 8,
    'password_require_uppercase': true,
    'password_require_lowercase': true,
    'password_require_numbers': true,
    'password_require_special': true,
    'max_failed_attempts': 5,
    'cooldown_minutes': 5,
    'session_timeout_minutes': 30,
    'auto_lock_minutes': 5,
    'biometric_enabled': true,
    'remember_me_enabled': true,
  };

  // ============================================================
  // PASSWORD HASHING
  // ============================================================

  static const Map<String, dynamic> passwordHashing = {
    'algorithm': 'Argon2',
    'iterations': 3,
    'memory_size_kb': 65536,
    'parallelism': 4,
    'hash_length': 32,
    'salt_length': 16,
  };

  // ============================================================
  // DATA ENCRYPTION
  // ============================================================

  static const Map<String, dynamic> encryption = {
    'algorithm': 'AES-256-CBC',
    'key_size': 256,
    'backup_encryption': true,
    'sensitive_fields': [
      'password_hash',
      'national_id',
      'credit_card_number',
    ],
  };

  // ============================================================
  // SESSION MANAGEMENT
  // ============================================================

  static const Map<String, dynamic> session = {
    'max_concurrent_sessions': 1,
    'session_timeout_minutes': 30,
    'auto_logout_enabled': true,
    'remember_duration_days': 30,
    'secure_storage': true,
  };

  // ============================================================
  // AUDIT LOGGING
  // ============================================================

  static const Map<String, dynamic> auditLogging = {
    'enabled': true,
    'log_actions': [
      'LOGIN',
      'LOGOUT',
      'CREATE',
      'UPDATE',
      'DELETE',
      'EXPORT',
      'BACKUP',
      'RESTORE',
    ],
    'log_sensitive_data': false,
    'retain_days': 365,
  };

  // ============================================================
  // BACKUP SECURITY
  // ============================================================

  static const Map<String, dynamic> backupSecurity = {
    'encryption_enabled': true,
    'password_protected': true,
    'auto_backup_enabled': true,
    'backup_interval_hours': 24,
    'max_backups': 10,
    'verify_backup_integrity': true,
  };
}

// ============================================================
// ROLE-BASED ACCESS CONTROL (RBAC)
// ============================================================

class RolePermissions {
  RolePermissions._();

  // ============================================================
  // ROLE DEFINITIONS
  // ============================================================

  static const Map<String, List<String>> roles = {
    'ADMIN': [
      'MANAGE_MEMBERS',
      'MANAGE_TRAINERS',
      'MANAGE_STAFF',
      'MANAGE_WORKOUTS',
      'MANAGE_BUFFET',
      'MANAGE_ACCOUNTING',
      'VIEW_REPORTS',
      'MANAGE_SETTINGS',
      'MANAGE_BACKUP',
      'MANAGE_ATTENDANCE',
      'EXPORT_DATA',
      'PRINT_REPORTS',
    ],
    'TRAINER': [
      'VIEW_MEMBERS',
      'MANAGE_WORKOUTS',
      'TRACK_PROGRESS',
      'VIEW_SCHEDULE',
      'LOG_WORKOUTS',
      'VIEW_ATTENDANCE',
    ],
    'ACCOUNTANT': [
      'VIEW_MEMBERS',
      'MANAGE_ACCOUNTING',
      'VIEW_REPORTS',
      'MANAGE_TRANSACTIONS',
      'MANAGE_INVOICES',
      'EXPORT_FINANCIAL_DATA',
    ],
    'RECEPTIONIST': [
      'MANAGE_MEMBERS',
      'MANAGE_ATTENDANCE',
      'MANAGE_BUFFET',
      'VIEW_MEMBERS',
      'PROCESS_PAYMENTS',
      'VIEW_ORDERS',
    ],
  };

  // ============================================================
  // MODULE PERMISSIONS
  // ============================================================

  static const Map<String, Map<String, List<String>>> modulePermissions = {
    'MEMBERS': {
      'VIEW': ['ADMIN', 'TRAINER', 'ACCOUNTANT', 'RECEPTIONIST'],
      'CREATE': ['ADMIN', 'RECEPTIONIST'],
      'UPDATE': ['ADMIN', 'RECEPTIONIST'],
      'DELETE': ['ADMIN'],
      'EXPORT': ['ADMIN', 'ACCOUNTANT'],
    },
    'ATTENDANCE': {
      'VIEW': ['ADMIN', 'TRAINER', 'RECEPTIONIST'],
      'CHECK_IN': ['ADMIN', 'RECEPTIONIST'],
      'CHECK_OUT': ['ADMIN', 'RECEPTIONIST'],
      'EXPORT': ['ADMIN', 'ACCOUNTANT'],
    },
    'WORKOUTS': {
      'VIEW': ['ADMIN', 'TRAINER', 'RECEPTIONIST'],
      'CREATE': ['ADMIN', 'TRAINER'],
      'UPDATE': ['ADMIN', 'TRAINER'],
      'DELETE': ['ADMIN'],
      'ASSIGN': ['ADMIN', 'TRAINER'],
    },
    'BUFFET': {
      'VIEW': ['ADMIN', 'RECEPTIONIST'],
      'CREATE_PRODUCT': ['ADMIN'],
      'UPDATE_PRODUCT': ['ADMIN'],
      'DELETE_PRODUCT': ['ADMIN'],
      'CREATE_ORDER': ['ADMIN', 'RECEPTIONIST'],
      'MANAGE_INVENTORY': ['ADMIN'],
    },
    'ACCOUNTING': {
      'VIEW': ['ADMIN', 'ACCOUNTANT'],
      'CREATE_TRANSACTION': ['ADMIN', 'ACCOUNTANT'],
      'UPDATE_TRANSACTION': ['ADMIN', 'ACCOUNTANT'],
      'DELETE_TRANSACTION': ['ADMIN'],
      'GENERATE_REPORT': ['ADMIN', 'ACCOUNTANT'],
      'EXPORT': ['ADMIN', 'ACCOUNTANT'],
    },
    'SETTINGS': {
      'VIEW': ['ADMIN'],
      'UPDATE': ['ADMIN'],
      'BACKUP': ['ADMIN'],
      'RESTORE': ['ADMIN'],
      'MANAGE_USERS': ['ADMIN'],
    },
  };

  // ============================================================
  // PERMISSION CHECK METHODS
  // ============================================================

  static bool hasPermission(String role, String permission) {
    final rolePermissions = roles[role];
    if (rolePermissions == null) return false;
    return rolePermissions.contains(permission);
  }

  static bool hasModulePermission(String role, String module, String action) {
    final modulePerms = modulePermissions[module];
    if (modulePerms == null) return false;

    final allowedRoles = modulePerms[action];
    if (allowedRoles == null) return false;

    return allowedRoles.contains(role);
  }

  static List<String> getRolePermissions(String role) {
    return roles[role] ?? [];
  }

  static List<String> getModuleActions(String module) {
    return modulePermissions[module]?.keys.toList() ?? [];
  }
}

// ============================================================
// SECURITY VALIDATORS
// ============================================================

class SecurityValidators {
  SecurityValidators._();

  // ============================================================
  // PASSWORD VALIDATION
  // ============================================================

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'رمز عبور الزامی است';
    }

    final config = SecurityConfig.authentication;

    if (password.length < config['password_min_length']) {
      return 'رمز عبور باید حداقل ${config['password_min_length']} کاراکتر باشد';
    }

    if (config['password_require_uppercase'] == true &&
        !password.contains(RegExp(r'[A-Z]'))) {
      return 'رمز عبور باید شامل حروف بزرگ باشد';
    }

    if (config['password_require_lowercase'] == true &&
        !password.contains(RegExp(r'[a-z]'))) {
      return 'رمز عبور باید شامل حروف کوچک باشد';
    }

    if (config['password_require_numbers'] == true &&
        !password.contains(RegExp(r'[0-9]'))) {
      return 'رمز عبور باید شامل اعداد باشد';
    }

    if (config['password_require_special'] == true &&
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'رمز عبور باید شامل کاراکترهای خاص باشد';
    }

    return null;
  }

  // ============================================================
  // USERNAME VALIDATION
  // ============================================================

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'نام کاربری الزامی است';
    }

    if (username.length < 4) {
      return 'نام کاربری باید حداقل 4 کاراکتر باشد';
    }

    if (username.length > 20) {
      return 'نام کاربری باید حداکثر 20 کاراکتر باشد';
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      return 'نام کاربری فقط شامل حروف، اعداد و زیرخط باشد';
    }

    return null;
  }

  // ============================================================
  // SESSION VALIDATION
  // ============================================================

  static bool isSessionValid(DateTime lastActivity) {
    final config = SecurityConfig.session;
    final timeout = Duration(minutes: config['session_timeout_minutes']);
    return DateTime.now().difference(lastActivity) < timeout;
  }

  static bool shouldAutoLock(DateTime lastActivity) {
    final config = SecurityConfig.authentication;
    final lockTime = Duration(minutes: config['auto_lock_minutes']);
    return DateTime.now().difference(lastActivity) >= lockTime;
  }

  // ============================================================
  // LOGIN ATTEMPT VALIDATION
  // ============================================================

  static bool isLoginAllowed(int failedAttempts, DateTime? lastFailedAttempt) {
    final config = SecurityConfig.authentication;

    if (failedAttempts < config['max_failed_attempts']) {
      return true;
    }

    if (lastFailedAttempt == null) {
      return false;
    }

    final cooldown = Duration(minutes: config['cooldown_minutes']);
    return DateTime.now().difference(lastFailedAttempt) >= cooldown;
  }

  static int getRemainingCooldownSeconds(DateTime lastFailedAttempt) {
    final config = SecurityConfig.authentication;
    final cooldown = Duration(minutes: config['cooldown_minutes']);
    final elapsed = DateTime.now().difference(lastFailedAttempt);
    final remaining = cooldown - elapsed;
    return remaining.isNegative ? 0 : remaining.inSeconds;
  }
}

// ============================================================
// SECURITY AUDIT LOG
// ============================================================

class AuditLog {
  final String id;
  final String action;
  final String entityType;
  final String? entityId;
  final Map<String, dynamic>? oldValues;
  final Map<String, dynamic>? newValues;
  final String? userId;
  final String? userName;
  final String? ipAddress;
  final DateTime createdAt;

  const AuditLog({
    required this.id,
    required this.action,
    required this.entityType,
    this.entityId,
    this.oldValues,
    this.newValues,
    this.userId,
    this.userName,
    this.ipAddress,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'action': action,
      'entity_type': entityType,
      'entity_id': entityId,
      'old_values': oldValues,
      'new_values': newValues,
      'user_id': userId,
      'user_name': userName,
      'ip_address': ipAddress,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory AuditLog.fromMap(Map<String, dynamic> map) {
    return AuditLog(
      id: map['id'],
      action: map['action'],
      entityType: map['entity_type'],
      entityId: map['entity_id'],
      oldValues: map['old_values'],
      newValues: map['new_values'],
      userId: map['user_id'],
      userName: map['user_name'],
      ipAddress: map['ip_address'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}

// ============================================================
// DATA EXPORT CONFIGURATION
// ============================================================

class ExportConfig {
  ExportConfig._();

  // ============================================================
  // EXPORT FORMATS
  // ============================================================

  static const Map<String, dynamic> formats = {
    'CSV': {
      'extension': '.csv',
      'encoding': 'UTF-8',
      'delimiter': ',',
      'supports_persian': true,
    },
    'EXCEL': {
      'extension': '.xlsx',
      'sheet_name': 'Data',
      'supports_formatting': true,
    },
    'PDF': {
      'extension': '.pdf',
      'page_size': 'A4',
      'orientation': 'portrait',
      'supports_charts': true,
    },
  };

  // ============================================================
  // EXPORTABLE DATA
  // ============================================================

  static const Map<String, List<String>> exportableData = {
    'MEMBERS': [
      'id', 'full_name', 'phone', 'email', 'gender', 'birth_date',
      'membership_status', 'membership_type', 'join_date', 'membership_expiry_date',
      'outstanding_balance', 'total_paid', 'total_visits',
    ],
    'ATTENDANCE': [
      'member_name', 'check_in_time', 'check_out_time', 'duration_minutes',
      'check_in_method',
    ],
    'ORDERS': [
      'order_number', 'customer_name', 'total_price', 'payment_status',
      'order_status', 'created_at',
    ],
    'TRANSACTIONS': [
      'transaction_number', 'transaction_type', 'category', 'amount',
      'description', 'transaction_date',
    ],
    'PRODUCTS': [
      'product_name', 'barcode', 'selling_price', 'cost_price',
      'current_stock', 'min_stock_level',
    ],
    'INVOICES': [
      'invoice_number', 'customer_name', 'total', 'invoice_status',
      'issued_date', 'due_date',
    ],
  };

  // ============================================================
  // EXPORT LIMITS
  // ============================================================

  static const Map<String, int> limits = {
    'max_rows': 10000,
    'max_file_size_mb': 50,
    'max_columns': 50,
  };
}